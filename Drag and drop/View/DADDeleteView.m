//
//  DADDeleteView.m
//  Drag and drop
//
//  Created by Renhuachi on 2017/6/28.
//  Copyright © 2017年 迟人华. All rights reserved.
//

#import "DADDeleteView.h"

@interface DADDeleteView ()
@property (nonatomic, strong) UIImageView *deleteImageView;
@end

@implementation DADDeleteView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.frame = frame;
        self.layer.cornerRadius = frame.size.height / 4;
        [self loadUI];
    }
    return self;
}

- (void)loadUI {
    self.backgroundColor = [UIColor redColor];
    
    self.deleteImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"delete"]];
    [self addSubview:self.deleteImageView];
}

- (void)layoutSubviews {
    self.deleteImageView.frame = CGRectMake((self.frame.size.width - 30) / 2, 10, 30, 30);
}

@end
