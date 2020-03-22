//
//  MovieViewModel.h
//  single-view-demo
//
//  Created by muyun on 2020/3/22.
//  Copyright © 2020 muyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Movie;


@interface MovieViewModel : NSObject

@property (nonatomic) NSMutableArray<Movie *> *movies;

- (instancetype)initWithMovieUrl:(NSString *)movieUrl;

@end
