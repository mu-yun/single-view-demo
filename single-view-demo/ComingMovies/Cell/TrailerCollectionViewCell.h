//
//  TrailerCollectionViewCell.h
//  glns-movie
//
//  Created by muyun on 2020/3/26.
//  Copyright © 2020 glns-movie. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Trailer;
@protocol TrailerCellProtocol;

NS_ASSUME_NONNULL_BEGIN

@interface TrailerCollectionViewCell : UICollectionViewCell

@property(strong, nonatomic) IBOutlet UILabel *nameLabel;
@property(strong, nonatomic) IBOutlet UILabel *titleLabel;
@property(strong, nonatomic) IBOutlet UIImageView *imageView;
@property(weak, nonatomic) Trailer *trailer;
@property(weak, nonatomic) id <TrailerCellProtocol> delegate;

- (void)setData:(Trailer *)trailer;

@end

NS_ASSUME_NONNULL_END
