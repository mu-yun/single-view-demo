//
//  MovieListViewController.m
//  single-view-demo
//
//  Created by muyun on 2020/3/22.
//  Copyright © 2020 muyun. All rights reserved.
//

#import "MovieListViewController.h"
#import "MovieViewModel.h"
#import "MovieTableViewCell.h"

@interface MovieListViewController () <UITableViewDataSource, UITableViewDelegate>

@property(weak, nonatomic) IBOutlet UITableView *tableView;

@property MovieViewModel *viewModel;

@end

@implementation MovieListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.viewModel = [[MovieViewModel alloc] initWithMovieUrl:@"https://douban.uieee.com/v2/movie/top250"];
    // Do any additional setup after loading the view.
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieTableViewCell *movieTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"movieTableViewCell"];
    if (!movieTableViewCell) {
        movieTableViewCell = [[MovieTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"movieTableViewCell"];
    }
    Movie *movie = [self.viewModel.movies objectAtIndex:[indexPath row]];
    [movieTableViewCell initFromMovie:movie];
    return movieTableViewCell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel.movies count];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
