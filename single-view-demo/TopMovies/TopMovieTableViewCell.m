//
//  TopMovieTableViewCell.m
//  single-view-demo
//
//  Created by muyun on 2020/3/22.
//  Copyright © 2020 muyun. All rights reserved.
//

#import <SDWebImage/SDAnimatedImageView+WebCache.h>
#import "TopMovieTableViewCell.h"
#import "TopMovie.h"

@implementation TopMovieTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)initFromMovie:(TopMovie *)movie {
    self.titleLabel.text = movie.title;
    self.detailLabel.text = movie.detail;
    // 1,根据URL 通过URLsession 下载 data
    // 2，data 转化成 image
    // 3， image 加载到 imageView
    [(SDAnimatedImageView *) self.movieImageView sd_setImageWithURL:[NSURL URLWithString:movie.imageUrl]];
}

@end
