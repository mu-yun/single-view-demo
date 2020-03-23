//
//  MovieViewModel.h
//  single-view-demo
//
//  Created by muyun on 2020/3/22.
//  Copyright © 2020 muyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class Movie;


@interface MovieViewModel : NSObject<UITableViewDataSource>

- (instancetype)initWithMovieUrl:(NSString *)movieUrl;

@end
