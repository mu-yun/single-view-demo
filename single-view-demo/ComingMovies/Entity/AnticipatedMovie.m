//
//  AnticipatedMovie.m
//  glns-movie
//
//  Created by muyun on 2020/4/1.
//  Copyright © 2020 glns-movie. All rights reserved.
//

#import "AnticipatedMovie.h"

@implementation AnticipatedMovie

- (instancetype)initWithImage:(NSString *)image name:(NSString *)name date:(NSString *)date likes:(NSNumber *)likes like:(BOOL)like {
    self = [super init];
    if (self) {
        self.image = image;
        self.name = name;
        self.date = date;
        self.likes = likes;
        self.like = like;
    }

    return self;
}

+ (instancetype)movieWithImage:(NSString *)image name:(NSString *)name date:(NSString *)date likes:(NSNumber *)likes like:(BOOL)like {
    return [[self alloc] initWithImage:image name:name date:date likes:likes like:like];
}


@end
