//
//  DADCollectionViewCell.m
//  Drag and drop
//
//  Created by Renhuachi on 2017/7/6.
//  Copyright © 2017年 迟人华. All rights reserved.
//

#import "DADCollectionViewCell.h"

@interface DADCollectionViewCell ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIActivityIndicatorView *loadingView;

@end

@implementation DADCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor grayColor];
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [self addSubview:self.imageView];
    }
    return self;
}

- (void)setContentImage:(UIImage *)image {
    self.imageView.image = image;
    [self.loadingView stopAnimating];
    [self setNeedsLayout];
}

- (void)startLoading {
    self.loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    self.loadingView.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    [self addSubview:self.loadingView];
    [self.loadingView startAnimating];
    [self setNeedsLayout];
}

@end
