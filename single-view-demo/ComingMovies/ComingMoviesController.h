//
//  ComingMoviesController.h
//  glns-movie
//
//  Created by muyun on 2020/4/1.
//  Copyright © 2020 glns-movie. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AnticipatedMovie;
@class ComingMovie;
@class Trailer;


@interface ComingMoviesController : NSObject

- (NSArray<AnticipatedMovie *> *)getAnticipatedMovie:(NSInteger)page;

- (NSArray<ComingMovie *> *)getMovie:(NSInteger)page;

- (NSArray<Trailer *> *)getTrailer:(NSInteger)page;

- (NSArray<NSString *> *)getDate:(NSInteger)page;

- (void)loadMovie:(NSInteger)page completion:(void (^)(NSInteger page))completion;

- (void)loadAnticipatedMovie:(NSInteger)page completion:(void (^)(NSInteger page))completion;

@end
