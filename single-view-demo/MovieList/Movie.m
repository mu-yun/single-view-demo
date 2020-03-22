//
//  Movie.m
//  single-view-demo
//
//  Created by muyun on 2020/3/22.
//  Copyright © 2020 muyun. All rights reserved.
//

#import "Movie.h"


@implementation Movie {

}

- (instancetype)initWithTitle:(NSString *)title imageUrl:(NSString *)imageUrl detail:(NSString *)detail duration:(int)duration {
    self = [super init];
    if (self) {
        _title = title;
        _imageUrl = imageUrl;
        _detail = detail;
        _duration = duration;
    }

    return self;
}

+ (instancetype)movieWithTitle:(NSString *)title imageUrl:(NSString *)imageUrl detail:(NSString *)detail duration:(int)duration {
    return [[self alloc] initWithTitle:title imageUrl:imageUrl detail:detail duration:duration];
}



@end