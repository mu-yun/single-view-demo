//
//  ComingMovieCollectionViewCell.m
//  glns-movie
//
//  Created by muyun on 2020/3/26.
//  Copyright © 2020 glns-movie. All rights reserved.
//

#import <SDAnimatedImageView+WebCache.h>
#import "ComingMovieCollectionViewCell.h"
#import "View+MASAdditions.h"
#import <UIImageView+WebCache.h>
#import "ComingMovie.h"
#import "MovieCellProtocol.h"

@implementation ComingMovieCollectionViewCell {
    UILabel *likesDescLabel;
    UILabel *typeDescLabel;
    UILabel *actorDescLabel;
    MASConstraint *actorDescLabelTopConstraint;
}


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configure];
    }

    return self;
}

- (void)configure {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"littlewomen"]];
    imageView.layer.cornerRadius = 2;
    imageView.layer.masksToBounds = YES;
    self.imageView = imageView;
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView);
        make.top.and.bottom.equalTo(self.contentView).with.inset(10);
        make.width.equalTo(@80);
    }];

    UIButton *likeButton = [[UIButton alloc] init];
    [likeButton setTitle:@"想看" forState:UIControlStateNormal];
    likeButton.titleLabel.font = [UIFont systemFontOfSize:14];
    likeButton.backgroundColor = [UIColor orangeColor];
    likeButton.tintColor = [UIColor whiteColor];//TODO ?
    likeButton.layer.cornerRadius = 14;
    likeButton.layer.masksToBounds = YES;
    self.likeButton = likeButton;
    [self addSubview:likeButton];
    [likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(imageView);
        make.trailing.equalTo(self.contentView);
        make.width.equalTo(@60);
    }];

    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.text = @"小妇人";
    nameLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightMedium];
    self.nameLabel = nameLabel;
    [self addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView).with.inset(5);
        make.leading.equalTo(imageView.mas_trailing).with.inset(10);
        make.trailing.equalTo(likeButton.mas_leading).with.inset(10);
    }];

    UILabel *likesLabel = [[UILabel alloc] init];
    likesLabel.text = @"28927";
    likesLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
    likesLabel.textColor = [UIColor orangeColor];
    self.likesLabel = likesLabel;
    [self addSubview:likesLabel];
    [likesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(nameLabel);
        make.top.equalTo(nameLabel.mas_bottom).equalTo(@12);
    }];

    likesDescLabel = [self getDescLabel:@"人想看"];
    [self addSubview:likesDescLabel];
    [likesDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(likesLabel.mas_trailing).equalTo(@2);
        make.top.equalTo(likesLabel);
        make.trailing.lessThanOrEqualTo(nameLabel);
    }];

    typeDescLabel = [self getDescLabel:@"类型:"];
    [self addSubview:typeDescLabel];
    [typeDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(nameLabel);
        make.top.equalTo(likesLabel.mas_bottom).with.inset(12);
    }];
    [typeDescLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh + 1 forAxis:UILayoutConstraintAxisHorizontal];

    UILabel *typeLabel = [self getDescLabel:@"剧情,爱情"];
    self.typeLabel = typeLabel;
    [self addSubview:typeLabel];
    [typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(typeDescLabel);
        make.leading.equalTo(typeDescLabel.mas_trailing);
        make.trailing.lessThanOrEqualTo(nameLabel);
    }];

    actorDescLabel = [self getDescLabel:@"主演:"];
    [self addSubview:actorDescLabel];
    [actorDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(nameLabel);
        actorDescLabelTopConstraint = make.top.equalTo(typeLabel.mas_bottom).equalTo(@12);
    }];
    [actorDescLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh + 1 forAxis:UILayoutConstraintAxisHorizontal];

    UILabel *actorLabel = [self getDescLabel:@"西尔莎·罗南,艾玛·沃森,佛罗伦斯·珀"];
    self.actorLabel = actorLabel;
    [self addSubview:actorLabel];
    [actorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(actorDescLabel);
        make.leading.equalTo(actorDescLabel.mas_trailing);
        make.trailing.lessThanOrEqualTo(nameLabel);
    }];

    [likeButton addTarget:self action:@selector(likeButtonClick:) forControlEvents:UIControlEventTouchDown];
}

- (UILabel *)getDescLabel:(NSString *)desc {
    UILabel *descLabel = [[UILabel alloc] init];
    descLabel.text = desc;
    descLabel.textColor = [UIColor grayColor];
    descLabel.font = [UIFont systemFontOfSize:14];
    return descLabel;
}

- (void)likeButtonClick:(UIButton *)button {
    self.movie.like = !self.movie.like;

    [self refreshLikeButton];

    if (self.delegate) {
        [self.delegate likeButtonClick:self.movie.like];
    }
}

- (void)setData:(ComingMovie *)movie {
    self.movie = movie;
    [self refresh];
}

- (void)refresh {
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.movie.image]];
    self.nameLabel.text = self.movie.name;
    self.likesLabel.text = [self.movie.likes stringValue];

    [self refreshLikeButton];

    if (self.movie.types != nil && self.movie.types.count > 0) {
        self.typeLabel.text = [self.movie.types componentsJoinedByString:@","];
        [self updateActorDescConstraint:typeDescLabel];
        typeDescLabel.hidden = NO;
        self.typeLabel.hidden = NO;
    } else {
        [self updateActorDescConstraint:self.likesLabel];
        typeDescLabel.hidden = YES;
        self.typeLabel.hidden = YES;
    }

    if (self.movie.actors != nil && self.movie.actors.count > 0) {
        self.actorLabel.text = [self.movie.actors componentsJoinedByString:@","];
        actorDescLabel.hidden = NO;
        self.actorLabel.hidden = NO;
    } else {
        actorDescLabel.hidden = YES;
        self.actorLabel.hidden = YES;
    }
}

- (void)updateActorDescConstraint:(UILabel *)label {
    [actorDescLabelTopConstraint uninstall];
    [actorDescLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        actorDescLabelTopConstraint = make.top.equalTo(label.mas_bottom).with.inset(12);
    }];
}

- (void)refreshLikeButton {
    if (self.movie.like) {
        self.likeButton.backgroundColor = [UIColor whiteColor];
        [self.likeButton setTitle:@"已想看" forState:UIControlStateNormal];
        [self.likeButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//    self.likeButton.tintColor = [UIColor grayColor];//TODO ?不能使用这种方式，why？
        self.likeButton.layer.borderWidth = 1;
        self.likeButton.layer.borderColor = [UIColor colorWithWhite:0.9 alpha:0.5].CGColor;
    } else {
        [self.likeButton setTitle:@"想看" forState:UIControlStateNormal];
        self.likeButton.backgroundColor = [UIColor orangeColor];
        [self.likeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}


@end
