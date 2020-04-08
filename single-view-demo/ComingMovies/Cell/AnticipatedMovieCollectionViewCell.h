//
//  AnticipatedMovieCollectionViewCell.h
//  glns-movie
//
//  Created by muyun on 2020/3/26.
//  Copyright © 2020 glns-movie. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MovieCellProtocol;
@class AnticipatedMovie;

NS_ASSUME_NONNULL_BEGIN

@interface AnticipatedMovieCollectionViewCell : UICollectionViewCell

@property(strong, nonatomic) IBOutlet UIImageView *imageView;
@property(strong, nonatomic) IBOutlet UILabel *nameLabel;
@property(strong, nonatomic) IBOutlet UILabel *dateLabel;
@property(strong, nonatomic) IBOutlet UILabel *likesLabel;
@property(strong, nonatomic) IBOutlet UIButton *likeButton;
@property(weak, nonatomic) id <MovieCellProtocol> delegate;
@property(weak, nonatomic) AnticipatedMovie *movie;

- (void)setData:(AnticipatedMovie *)movie;

@end

NS_ASSUME_NONNULL_END
