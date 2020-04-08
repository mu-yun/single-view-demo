//
//  ComingMovie.m
//  glns-movie
//
//  Created by muyun on 2020/4/1.
//  Copyright © 2020 glns-movie. All rights reserved.
//

#import "ComingMovie.h"

@implementation ComingMovie

- (instancetype)initWithImage:(NSString *)image name:(NSString *)name types:(NSArray<NSString *> *)types actors:(NSArray<NSString *> *)actors date:(NSString *)date likes:(NSNumber *)likes like:(BOOL)like {
    self = [super init];
    if (self) {
        self.image = image;
        self.name = name;
        self.types = types;
        self.actors = actors;
        self.date = date;
        self.likes = likes;
        self.like = like;
    }

    return self;
}

+ (instancetype)movieWithImage:(NSString *)image name:(NSString *)name types:(NSArray<NSString *> *)types actors:(NSArray<NSString *> *)actors date:(NSString *)date likes:(NSNumber *)likes like:(BOOL)like {
    return [[self alloc] initWithImage:image name:name types:types actors:actors date:date likes:likes like:like];
}


@end
