//
//  TopMovieTableViewCell.h
//  single-view-demo
//
//  Created by muyun on 2020/3/22.
//  Copyright © 2020 muyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TopMovie;

NS_ASSUME_NONNULL_BEGIN

@interface TopMovieTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *movieImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

- (void)initFromMovie:(TopMovie *)movie;

@end

NS_ASSUME_NONNULL_END
