//
//  AnticipatedMovie.h
//  glns-movie
//
//  Created by muyun on 2020/4/1.
//  Copyright © 2020 glns-movie. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AnticipatedMovie : NSObject

@property(strong, nonatomic) NSString *image;
@property(strong, nonatomic) NSString *name;
@property(strong, nonatomic) NSString *date;
@property(strong, nonatomic) NSNumber *likes;
@property(nonatomic) BOOL like;

- (instancetype)initWithImage:(NSString *)image name:(NSString *)name date:(NSString *)date likes:(NSNumber *)likes like:(BOOL)like;

+ (instancetype)movieWithImage:(NSString *)image name:(NSString *)name date:(NSString *)date likes:(NSNumber *)likes like:(BOOL)like;


@end

NS_ASSUME_NONNULL_END
