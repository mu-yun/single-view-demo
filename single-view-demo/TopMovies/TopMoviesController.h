//
//  TopMoviesController.h
//  single-view-demo
//
//  Created by muyun on 2020/3/22.
//  Copyright © 2020 muyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class TopMovie;


@interface TopMoviesController : NSObject

- (instancetype)initWithMovieUrl:(NSString *)movieUrl;

- (TopMovie *)getMovie:(NSUInteger)index;

- (NSInteger)count;

@end
