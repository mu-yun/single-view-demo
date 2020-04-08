//
//  SectionHeaderCollectionReusableView.m
//  glns-movie
//
//  Created by muyun on 2020/3/27.
//  Copyright © 2020 glns-movie. All rights reserved.
//

#import <View+MASAdditions.h>
#import "SectionHeaderCollectionReusableView.h"

@implementation SectionHeaderCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configure];
    }

    return self;
}

- (void)configure {
    UILabel *headerLabel = [[UILabel alloc] init];
    self.headerLabel = headerLabel;
    [self addSubview:headerLabel];
    [headerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.and.leading.equalTo(self);
    }];
}


@end
