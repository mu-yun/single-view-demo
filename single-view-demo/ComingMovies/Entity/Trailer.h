//
//  Trailer.h
//  glns-movie
//
//  Created by muyun on 2020/4/1.
//  Copyright © 2020 glns-movie. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Trailer : NSObject

@property(strong, nonatomic) NSString *name;
@property(strong, nonatomic) NSString *title;
@property(strong, nonatomic) NSString *image;
@property(strong, nonatomic) NSString *link;

- (instancetype)initWithName:(NSString *)name title:(NSString *)title image:(NSString *)image link:(NSString *)link;

+ (instancetype)trailerWithName:(NSString *)name title:(NSString *)title image:(NSString *)image link:(NSString *)link;

@end

NS_ASSUME_NONNULL_END
