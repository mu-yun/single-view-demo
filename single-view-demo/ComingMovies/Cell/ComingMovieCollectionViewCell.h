//
//  ComingMovieCollectionViewCell.h
//  glns-movie
//
//  Created by muyun on 2020/3/26.
//  Copyright © 2020 glns-movie. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MovieCellProtocol;
@class ComingMovie;

NS_ASSUME_NONNULL_BEGIN

@interface ComingMovieCollectionViewCell : UICollectionViewCell

@property(strong, nonatomic) IBOutlet UIImageView *imageView;
@property(strong, nonatomic) IBOutlet UILabel *nameLabel;
@property(strong, nonatomic) IBOutlet UILabel *typeLabel;
@property(strong, nonatomic) IBOutlet UILabel *actorLabel;
@property(strong, nonatomic) IBOutlet UILabel *likesLabel;
@property(strong, nonatomic) IBOutlet UIButton *likeButton;
@property(weak, nonatomic) id <MovieCellProtocol> delegate;
@property(weak, nonatomic) ComingMovie *movie;

- (void)setData:(ComingMovie *)movie;

@end

NS_ASSUME_NONNULL_END
