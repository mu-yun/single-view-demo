//
//  Trailer.m
//  glns-movie
//
//  Created by muyun on 2020/4/1.
//  Copyright © 2020 glns-movie. All rights reserved.
//

#import "Trailer.h"

@implementation Trailer

- (instancetype)initWithName:(NSString *)name title:(NSString *)title image:(NSString *)image link:(NSString *)link {
    self = [super init];
    if (self) {
        self.name = name;
        self.title = title;
        self.image = image;
        self.link = link;
    }

    return self;
}

+ (instancetype)trailerWithName:(NSString *)name title:(NSString *)title image:(NSString *)image link:(NSString *)link {
    return [[self alloc] initWithName:name title:title image:image link:link];
}

@end
