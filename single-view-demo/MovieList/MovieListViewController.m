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
#import "Movie.h"

@interface MovieListViewController () <UITableViewDelegate>

@property(weak, nonatomic) IBOutlet UITableView *tableView;

@property MovieViewModel *viewModel;

@end

@implementation MovieListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.viewModel = [[MovieViewModel alloc] initWithMovieUrl:@"https://douban.uieee.com/v2/movie/top250"];

    //dataSource和delegate可以在storyboard通过拖拽指定
    self.tableView.dataSource = self.viewModel;
    self.tableView.delegate = self;

    //代码的方式注册自定义TableViewCell，针对xib文件
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

@end
