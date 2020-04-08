//
//  TopMovie.m
//  single-view-demo
//
//  Created by muyun on 2020/3/22.
//  Copyright © 2020 muyun. All rights reserved.
//

#import "TopMovie.h"


@implementation TopMovie {

}

- (instancetype)initWithTitle:(NSString *)title imageUrl:(NSString *)imageUrl detail:(NSString *)detail duration:(NSInteger)duration {
    self = [super init];
    if (self) {
        _title = title;
        _imageUrl = imageUrl;
        _detail = detail;
        _duration = duration;
    }

    return self;
}

+ (instancetype)movieWithTitle:(NSString *)title imageUrl:(NSString *)imageUrl detail:(NSString *)detail duration:(NSInteger)duration {
    return [[self alloc] initWithTitle:title imageUrl:imageUrl detail:detail duration:duration];
}


@end