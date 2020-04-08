//
//  MovieListViewController.m
//  single-view-demo
//
//  Created by muyun on 2020/3/22.
//  Copyright © 2020 muyun. All rights reserved.
//

#import "MovieListViewController.h"
#import "MovieController.h"
#import "MovieTableViewCell.h"
#import "Movie.h"

@interface MovieListViewController () <UITableViewDelegate, UITableViewDataSource> {
    MovieController *movieController;
}

@property(weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MovieListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    movieController = [[MovieController alloc] initWithMovieUrl:@"https://douban.uieee.com/v2/movie/top250"];

    //dataSource和delegate可以在storyboard通过拖拽指定
    self.tableView.dataSource = self;
    self.tableView.delegate = self;

    //代码的方式注册自定义TableViewCell
    //[self.tableView registerClass:[MovieTableViewCell class] forCellReuseIdentifier:@"movieTableViewCell"];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieTableViewCell *movieTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"movieTableViewCell"];
    //这种方式适用于系统本身的UITableViewCell或者在代码中添加控件的自定义TableViewCell
//    if (!movieTableViewCell) {
//        movieTableViewCell = [[MovieTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"movieTableViewCell"];
//    }
    Movie *movie = [movieController getMovie:indexPath.row];
    [movieTableViewCell initFromMovie:movie];
    movieTableViewCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return movieTableViewCell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [movieController count];
}

@end
