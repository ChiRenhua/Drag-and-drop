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

@end

@implementation DADCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [self addSubview:self.imageView];
    }
    return self;
}

- (void)setContentImage:(UIImage *)image {
    self.imageView.image = image;
    [self setNeedsLayout];
}

@end
