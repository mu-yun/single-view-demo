//
//  TrailerCollectionViewCell.m
//  glns-movie
//
//  Created by muyun on 2020/3/26.
//  Copyright © 2020 glns-movie. All rights reserved.
//

#import <Masonry/View+MASAdditions.h>
#import <UIImageView+WebCache.h>
#import "TrailerCollectionViewCell.h"
#import "Trailer.h"
#import "TrailerCellProtocol.h"

@implementation TrailerCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configure];
    }
    return self;
}


- (void)configure {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"trailer"]];
    imageView.layer.cornerRadius = 2;
    imageView.layer.masksToBounds = YES;
    self.imageView = imageView;
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];

    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"定档2021大年初一 开启华语新乐坛奇幻大门";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightLight];
    self.titleLabel = titleLabel;
    [imageView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(imageView).with.inset(10);
        make.trailing.equalTo(imageView).with.inset(40);
        make.bottom.equalTo(imageView).with.inset(10);
    }];

    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.text = @"刺杀小说家";
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.font = [UIFont systemFontOfSize:18];
    self.nameLabel = nameLabel;
    [imageView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.and.trailing.equalTo(titleLabel);
        make.bottom.equalTo(titleLabel.mas_top).with.inset(5);
    }];

    UIImageView *playIcon = [[UIImageView alloc] initWithImage:[UIImage systemImageNamed:@"play.circle.fill"]];
    playIcon.tintColor = [UIColor whiteColor];
    [self.imageView addSubview:playIcon];
    [playIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.and.width.equalTo(@25);
        make.bottom.equalTo(titleLabel);
        make.leading.equalTo(titleLabel.mas_trailing).inset(5);
    }];

    //给imageview添加事件
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClick)];
    [imageView addGestureRecognizer:tapGesture];
    imageView.userInteractionEnabled = YES;
}

- (void)setData:(Trailer *)trailer {
    self.trailer = trailer;
    [self refresh];
}

- (void)refresh {
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.trailer.image]];
    self.nameLabel.text = self.trailer.name;
    self.titleLabel.text = self.trailer.title;
}

- (void)imageClick {
    if (self.delegate && self.trailer && self.trailer.link) {
        [self.delegate playVideo:self.trailer.link];
    }
}


@end
