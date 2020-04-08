//
//  AnticipatedMovieCollectionViewCell.m
//  glns-movie
//
//  Created by muyun on 2020/3/26.
//  Copyright © 2020 glns-movie. All rights reserved.
//

#import <Masonry/View+MASAdditions.h>
#import <SDWebImage/SDAnimatedImageView+WebCache.h>
#import "AnticipatedMovieCollectionViewCell.h"
#import "AnticipatedMovie.h"
#import "MovieCellProtocol.h"

@implementation AnticipatedMovieCollectionViewCell

static NSInteger const LikeIconTag = 1;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configure];
    }

    return self;
}

- (void)configure {

    UILabel *dateLabel = [[UILabel alloc] init];
    dateLabel.text = @"4月30日";
    dateLabel.textColor = [UIColor grayColor];
    dateLabel.font = [UIFont systemFontOfSize:14];
    self.dateLabel = dateLabel;
    [self addSubview:dateLabel];
    [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.and.trailing.and.bottom.equalTo(self.contentView).with.inset(2);
    }];

    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.text = @"小妇人";
    nameLabel.font = [UIFont systemFontOfSize:15];
    self.nameLabel = nameLabel;
    [self addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.and.trailing.equalTo(self.contentView).with.inset(2);
        make.bottom.equalTo(dateLabel.mas_top).with.inset(5);
    }];

    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"littlewomen"]];
    imageView.layer.cornerRadius = 4;
    imageView.layer.masksToBounds = YES;
    self.imageView = imageView;
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.leading.and.trailing.equalTo(self.contentView);
        make.bottom.equalTo(nameLabel.mas_top).with.inset(5);
    }];

    UILabel *likesLabel = [[UILabel alloc] init];
    likesLabel.text = @"28927想看";
    likesLabel.textColor = [UIColor whiteColor];
    likesLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightBold];
    self.likesLabel = likesLabel;
    [imageView addSubview:likesLabel];
    [likesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        //TODO
        make.centerX.equalTo(imageView);
        make.bottom.equalTo(imageView).inset(5);
    }];

    UIButton *likeButton = [[UIButton alloc] init];
    //背景透明
    likeButton.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    self.likeButton = likeButton;

    UIImageView *likeIcon = [[UIImageView alloc] initWithImage:[UIImage systemImageNamed:@"suit.heart.fill"]];
    likeIcon.tag = LikeIconTag;
    [likeButton addSubview:likeIcon];
    [likeIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.and.centerY.equalTo(self.likeButton);
    }];

    likeButton.tintColor = [UIColor whiteColor];
    likeButton.layer.cornerRadius = 2;
    likeButton.layer.masksToBounds = YES;
    [imageView addSubview:likeButton];
    [likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.trailing.equalTo(imageView);
        make.width.and.height.equalTo(@30);
    }];

    //因为button在imageView中，所以点击事件不生效，需要设置该属性为YES
    imageView.userInteractionEnabled = YES;
    [likeButton addTarget:self action:@selector(likeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)likeButtonClick:(UIButton *)button {
    self.movie.like = !self.movie.like;
    [self refreshLikeButton];

    if (self.delegate) {
        [self.delegate likeButtonClick:self.movie.like];
    }

}

- (void)setData:(AnticipatedMovie *)movie {
    self.movie = movie;
    [self refresh];
}

- (void)refresh {
    [(SDAnimatedImageView *) self.imageView sd_setImageWithURL:[NSURL URLWithString:self.movie.image] placeholderImage:[UIImage imageNamed:@"littlewomen"]];
    self.nameLabel.text = self.movie.name;
    self.dateLabel.text = self.movie.date;
    self.likesLabel.text = [[self.movie.likes stringValue] stringByAppendingString:@"想看"];
    [self refreshLikeButton];
}

- (void)refreshLikeButton {
    self.likeButton.tintColor = self.movie.like ? [UIColor orangeColor] : [UIColor whiteColor];
}


@end
