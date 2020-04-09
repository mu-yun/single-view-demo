//
//  ComingMoviesViewController.m
//  glns-movie
//
//  Created by muyun on 2020/3/26.
//  Copyright © 2020 glns-movie. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import "ComingMoviesViewController.h"
#import "SectionHeaderCollectionReusableView.h"
#import "TrailerCollectionViewCell.h"
#import "AnticipatedMovieCollectionViewCell.h"
#import "ComingMovieCollectionViewCell.h"
#import "MovieCellProtocol.h"
#import "ComingMoviesController.h"
#import "ComingMovie.h"
#import "TrailerCellProtocol.h"
#import "View+MASAdditions.h"


@interface ComingMoviesViewController () <UICollectionViewDelegate, MovieCellProtocol, TrailerCellProtocol>

@property UICollectionViewDiffableDataSource *dataSource;

@property NSDiffableDataSourceSnapshot<NSString *, id> *snapshot;

@property UIActivityIndicatorView *indicatorView;

@property UIRefreshControl *refreshControl;

@property MBProgressHUD *progressHUD;

@property AVPlayerViewController *avPlayerViewController;

@end

@implementation ComingMoviesViewController {
    ComingMoviesController *moviesController;
    NSMutableArray *dates;
}

static NSInteger const TrailerSection = 0;
static NSInteger const AnticipatedMovieSection = 1;
static NSString *const TrailerCellIdentifier = @"trailerCollectionViewCell";
static NSString *const AnticipatedCellIdentifier = @"anticipatedMovieCollectionViewCell";
static NSString *const MovieCellIdentifier = @"movieCollectionViewCell";
static NSString *const SectionHeaderIdentifier = @"sectionHeader";
static NSString *const TrailerSectionIdentifier = @"TrailerSection";
static NSString *const AnticipatedMovieSectionIdentifier = @"AnticipatedMovieSection";


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    //large title
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    self.navigationItem.title = @"待映";

    [self configureCollectionView];
    [self configureDataSource];
    [self configureRefreshControl];
    [self configureIndicatorView];
    [self configureProgressHUD];

    self.collectionView.dataSource = self.dataSource;
    self.collectionView.refreshControl = self.refreshControl;
    self.collectionView.delegate = self;
    //视频播放
    self.avPlayerViewController = [[AVPlayerViewController alloc] init];

    moviesController = [[ComingMoviesController alloc] init];
    dates = [[NSMutableArray alloc] init];

    [self.indicatorView startAnimating];
    [self refresh];
}


- (void)refresh {
    //trailer
    NSDiffableDataSourceSnapshot<NSString *, id> *snapshot = [[NSDiffableDataSourceSnapshot alloc] init];
    [snapshot appendSectionsWithIdentifiers:@[TrailerSectionIdentifier]];
    [snapshot appendItemsWithIdentifiers:[moviesController getTrailer:1]];

    __block typeof(self) blockSelf = self;
    //anticipated movie
    [snapshot appendSectionsWithIdentifiers:@[AnticipatedMovieSectionIdentifier]];
    [moviesController loadAnticipatedMovie:1 completion:^(NSInteger page) {
        [snapshot appendItemsWithIdentifiers:[blockSelf->moviesController getAnticipatedMovie:page] intoSectionWithIdentifier:AnticipatedMovieSectionIdentifier];

        dispatch_async(dispatch_get_main_queue(), ^{
            [blockSelf.dataSource applySnapshot:snapshot animatingDifferences:YES];

            if (blockSelf.indicatorView.animating) {
                [blockSelf.indicatorView stopAnimating];
            }

            if (blockSelf.refreshControl.refreshing) {
                [blockSelf.refreshControl endRefreshing];
            }
        });
    }];
    //movie
    [moviesController loadMovie:1 completion:^(NSInteger page) {
        NSArray *dateArray = [blockSelf->moviesController getDate:page];
        [blockSelf->dates addObjectsFromArray:dateArray];
        [snapshot appendSectionsWithIdentifiers:dateArray];

        NSArray<ComingMovie *> *movies = [blockSelf->moviesController getMovie:page];
        for (ComingMovie *movie in movies) {
            [snapshot appendItemsWithIdentifiers:@[movie] intoSectionWithIdentifier:movie.date];
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            [blockSelf.dataSource applySnapshot:snapshot animatingDifferences:YES];
        });
    }];

    self.snapshot = snapshot;
}


- (UICollectionViewCompositionalLayout *)createLayout {
    __weak typeof(self) weakSelf = self;
    UICollectionViewCompositionalLayoutSectionProvider sectionProvider = ^NSCollectionLayoutSection *(NSInteger section, id <NSCollectionLayoutEnvironment> layoutEnvironment) {
        if (section == TrailerSection) {
            return [weakSelf createTrailerSection:layoutEnvironment];
        }
        if (section == AnticipatedMovieSection) {
            return [weakSelf createAnticipatedMovieSection:layoutEnvironment];
        }
        return [weakSelf createComingMovieSection:layoutEnvironment];
    };

    return [[UICollectionViewCompositionalLayout alloc] initWithSectionProvider:sectionProvider];
}

- (UICollectionView *)configureCollectionView {
    UICollectionView *collectionView = self.collectionView;
    collectionView.collectionViewLayout = [self createLayout];

    [collectionView registerClass:[TrailerCollectionViewCell class] forCellWithReuseIdentifier:TrailerCellIdentifier];
    [collectionView registerClass:[AnticipatedMovieCollectionViewCell class] forCellWithReuseIdentifier:AnticipatedCellIdentifier];
    [collectionView registerClass:[ComingMovieCollectionViewCell class] forCellWithReuseIdentifier:MovieCellIdentifier];
    [collectionView registerClass:[SectionHeaderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:SectionHeaderIdentifier];

    return collectionView;
}

- (UICollectionViewDiffableDataSource *)configureDataSource {
    //dataSourceCellProvider
    __weak typeof(self) weakSelf = self;
    UICollectionViewDiffableDataSourceCellProvider dataSourceCellProvider = ^UICollectionViewCell *(UICollectionView *collectionView, NSIndexPath *indexPath, id data) {
        if (indexPath.section == TrailerSection) {
            TrailerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:TrailerCellIdentifier forIndexPath:indexPath];
            cell.delegate = weakSelf;
            [cell setData:data];
            return cell;
        }
        if (indexPath.section == AnticipatedMovieSection) {
            AnticipatedMovieCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:AnticipatedCellIdentifier forIndexPath:indexPath];
            cell.delegate = weakSelf;
            [cell setData:data];
            return cell;
        }
        ComingMovieCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MovieCellIdentifier forIndexPath:indexPath];
        cell.delegate = weakSelf;
        [cell setData:data];
        return cell;
    };

    //init dataSource
    UICollectionViewDiffableDataSource *dataSource = [[UICollectionViewDiffableDataSource alloc] initWithCollectionView:self.collectionView
                                                                                                           cellProvider:dataSourceCellProvider];
    //supplementaryViewProvider
    dataSource.supplementaryViewProvider = ^UICollectionReusableView *(UICollectionView *collectionView, NSString *kind, NSIndexPath *indexPath) {
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            SectionHeaderCollectionReusableView *sectionHeader = [weakSelf.collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                                                             withReuseIdentifier:SectionHeaderIdentifier
                                                                                                                    forIndexPath:indexPath];
            NSString *headerText;
            if (indexPath.section == TrailerSection) {
                headerText = @"预告片推荐";
            } else if (indexPath.section == AnticipatedMovieSection) {
                headerText = @"近期最受期待";
            } else {
                headerText = [self->dates objectAtIndex:indexPath.section - 2];//TODO
            }
            sectionHeader.headerLabel.text = headerText;
            return sectionHeader;
        }
        return nil;
    };

    self.dataSource = dataSource;
    return dataSource;
}

- (UIRefreshControl *)configureRefreshControl {
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
//    refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Loading..."];
    self.refreshControl = refreshControl;
    [refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    return refreshControl;
}

- (UIActivityIndicatorView *)configureIndicatorView {
    UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleMedium];
    self.indicatorView = indicatorView;
    [self.collectionView addSubview:indicatorView];
    [indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.and.centerX.equalTo(self.collectionView);
    }];
    return indicatorView;
}

- (MBProgressHUD *)configureProgressHUD {
    MBProgressHUD *progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
    progressHUD.mode = MBProgressHUDModeText;
    progressHUD.contentColor = [UIColor whiteColor];
    progressHUD.label.text = @"✓";
    progressHUD.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    progressHUD.bezelView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.8];
    progressHUD.bezelView.layer.cornerRadius = 20;
    progressHUD.userInteractionEnabled = NO;
    self.progressHUD = progressHUD;
    [self.view addSubview:progressHUD];
    return progressHUD;
}

- (NSArray<NSCollectionLayoutBoundarySupplementaryItem *> *)getSupplementaryItems {
    NSCollectionLayoutSize *headerSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:1.0]
                                                                        heightDimension:[NSCollectionLayoutDimension estimatedDimension:50.0]];
    NSCollectionLayoutBoundarySupplementaryItem *headerSupplementary = [NSCollectionLayoutBoundarySupplementaryItem
            boundarySupplementaryItemWithLayoutSize:headerSize
                                        elementKind:UICollectionElementKindSectionHeader
                                          alignment:NSRectAlignmentTop];
    headerSupplementary.pinToVisibleBounds = YES; //TODO bug
//    headerSupplementary.zIndex = 2;
    return @[headerSupplementary];
}

- (NSCollectionLayoutSection *)createTrailerSection:(id <NSCollectionLayoutEnvironment>)layoutEnvironment {
    //item
    NSCollectionLayoutSize *itemSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:1.0]
                                                                      heightDimension:[NSCollectionLayoutDimension fractionalHeightDimension:1.0]];
    NSCollectionLayoutItem *item = [NSCollectionLayoutItem itemWithLayoutSize:itemSize];
//    layoutItem.contentInsets = NSDirectionalEdgeInsetsMake(0.0, 16.0, 0.0, 16.0);
    //group
    NSCollectionLayoutSize *groupSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension absoluteDimension:240]
                                                                       heightDimension:[NSCollectionLayoutDimension absoluteDimension:120]];
    NSCollectionLayoutGroup *group = [NSCollectionLayoutGroup horizontalGroupWithLayoutSize:groupSize subitems:@[item]];
    //section
    NSCollectionLayoutSection *section = [NSCollectionLayoutSection sectionWithGroup:group];

    section.interGroupSpacing = 10;
    section.supplementariesFollowContentInsets = false;
    section.contentInsets = NSDirectionalEdgeInsetsMake(0.0, 20.0, 0.0, 20.0);
    section.orthogonalScrollingBehavior = UICollectionLayoutSectionOrthogonalScrollingBehaviorContinuousGroupLeadingBoundary;
    section.boundarySupplementaryItems = [self getSupplementaryItems];

    return section;
}


- (NSCollectionLayoutSection *)createAnticipatedMovieSection:(id <NSCollectionLayoutEnvironment>)layoutEnvironment {
    //item
    NSCollectionLayoutSize *itemSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:1.0]
                                                                      heightDimension:[NSCollectionLayoutDimension fractionalHeightDimension:1.0]];
    NSCollectionLayoutItem *item = [NSCollectionLayoutItem itemWithLayoutSize:itemSize];
//    layoutItem.contentInsets = NSDirectionalEdgeInsetsMake(0.0, 16.0, 0.0, 16.0);
    //group

    NSCollectionLayoutSize *groupSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension absoluteDimension:100]
                                                                       heightDimension:[NSCollectionLayoutDimension absoluteDimension:200]];
    NSCollectionLayoutGroup *group = [NSCollectionLayoutGroup horizontalGroupWithLayoutSize:groupSize subitems:@[item]];
    //section
    NSCollectionLayoutSection *section = [NSCollectionLayoutSection sectionWithGroup:group];

    section.interGroupSpacing = 5;
    section.supplementariesFollowContentInsets = false;
    section.contentInsets = NSDirectionalEdgeInsetsMake(0.0, 20.0, 0.0, 20.0);
    section.orthogonalScrollingBehavior = UICollectionLayoutSectionOrthogonalScrollingBehaviorContinuousGroupLeadingBoundary;
    section.boundarySupplementaryItems = [self getSupplementaryItems];

    return section;
}

- (NSCollectionLayoutSection *)createComingMovieSection:(id <NSCollectionLayoutEnvironment>)layoutEnvironment {
    //item
    NSCollectionLayoutSize *itemSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:1.0]
                                                                      heightDimension:[NSCollectionLayoutDimension fractionalHeightDimension:1.0]];
    NSCollectionLayoutItem *item = [NSCollectionLayoutItem itemWithLayoutSize:itemSize];
//    layoutItem.contentInsets = NSDirectionalEdgeInsetsMake(0.0, 16.0, 0.0, 16.0);
    //group
    CGFloat groupFractionalWidth = 1.0;
    NSCollectionLayoutSize *groupSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:groupFractionalWidth]
                                                                       heightDimension:[NSCollectionLayoutDimension absoluteDimension:140]];
    NSCollectionLayoutGroup *group = [NSCollectionLayoutGroup horizontalGroupWithLayoutSize:groupSize subitems:@[item]];
    //section
    NSCollectionLayoutSection *section = [NSCollectionLayoutSection sectionWithGroup:group];

    section.interGroupSpacing = 1;
    section.supplementariesFollowContentInsets = false;
    section.contentInsets = NSDirectionalEdgeInsetsMake(0.0, 20.0, 0.0, 20.0);
    section.boundarySupplementaryItems = [self getSupplementaryItems];
    return section;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)likeButtonClick:(BOOL)like {
    self.progressHUD.detailsLabel.text = like ? @"已标记想看" : @"已取消想看";
    [self.progressHUD showAnimated:YES];
    [self.progressHUD hideAnimated:YES afterDelay:1.5];

//    //原生 UIAlertController
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"√"
//                                                                   message:like ? @"已标记想看" : @"已取消想看"
//                                                            preferredStyle:UIAlertControllerStyleAlert];
//
//    [self presentViewController:alert animated:YES completion:nil];
    //自动取消显示
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
//        [alert dismissViewControllerAnimated:YES completion:nil];
//    });
}


- (void)playVideo:(NSString *)url {
    NSURL *webVideoUrl = [NSURL URLWithString:url];
    //创建AVPlayer
    AVPlayer *avPlayer = [AVPlayer playerWithURL:webVideoUrl];
    //使用AVPlayer创建AVPlayerViewController，并跳转播放界面
    self.avPlayerViewController.player = avPlayer;

    [self presentViewController:self.avPlayerViewController animated:YES completion:^{
        //自动播放
        [avPlayer play];
    }];
}

@end

