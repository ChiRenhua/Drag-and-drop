//
//  DADPosterPreView.m
//  Drag and drop
//
//  Created by Renhuachi on 2017/6/29.
//  Copyright © 2017年 迟人华. All rights reserved.
//

#import "DADPosterPreView.h"
#import "DADPosterImageView.h"

@interface DADPosterPreView ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *label;
@end

@implementation DADPosterPreView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.frame = frame;
        self.layer.cornerRadius = 15.0f;
        self.layer.masksToBounds = YES;
        [self loadUI];
    }
    return self;
}

- (void)loadUI {
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height * 6 / 7)];
    [self addSubview:self.imageView];
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height * 6 / 7, self.frame.size.width, self.frame.size.height / 7)];
    self.label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.label];
}

- (void)setImage:(DADPosterImageView *)imageView {
    self.imageView.image = imageView.image;
    self.label.text = imageView.movieName;
}

@end
