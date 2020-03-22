//
//  Movie.h
//  single-view-demo
//
//  Created by muyun on 2020/3/22.
//  Copyright © 2020 muyun. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Movie : NSObject

@property(nonatomic, readonly) NSString *title;
@property(nonatomic, readonly) NSString *imageUrl;
@property(nonatomic, readonly) NSString *detail;
@property(nonatomic, readonly) int duration;

- (instancetype)initWithTitle:(NSString *)title imageUrl:(NSString *)imageUrl detail:(NSString *)detail duration:(int)duration;

+ (instancetype)movieWithTitle:(NSString *)title imageUrl:(NSString *)imageUrl detail:(NSString *)detail duration:(int)duration;


@end