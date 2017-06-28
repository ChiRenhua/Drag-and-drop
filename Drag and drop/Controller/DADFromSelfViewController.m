//
//  DADFromSelfViewController.m
//  Drag and drop
//
//  Created by Renhuachi on 2017/6/28.
//  Copyright © 2017年 迟人华. All rights reserved.
//

#import "DADFromSelfViewController.h"
#import "DADDeleteView.h"

#define imageWidth 150
#define imageHeight 150

@interface DADFromSelfViewController () <UIDragInteractionDelegate, UIDropInteractionDelegate>
@property (nonatomic, strong) DADDeleteView *deleteView;
@end

@implementation DADFromSelfViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    // imageView
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"butterfly"]];
    imageView.frame = CGRectMake((self.view.bounds.size.width / 2 - 150) / 2 , (self.view.bounds.size.height - 150) / 2, 150, 150);
    
    UIDragInteraction *imageDragInteraction = [[UIDragInteraction alloc] initWithDelegate:self];
    [imageView addInteraction:imageDragInteraction];
    imageView.userInteractionEnabled = YES;
    
    [self.view addSubview:imageView];
    
    // label
    UIDragInteraction *LabelDragInteraction = [[UIDragInteraction alloc] initWithDelegate:self];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((self.view.bounds.size.width / 2 - self.view.bounds.size.width / 3) / 2, self.view.bounds.size.height / 4, self.view.bounds.size.width / 3, 30)];
    label.text = @"来呀来呀拖我呀～～";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    label.userInteractionEnabled = YES;
    [label addInteraction:LabelDragInteraction];
    [self.view addSubview:label];
    
    // deleteView
    UIDropInteraction *deleteViewDropInteraction = [[UIDropInteraction alloc] initWithDelegate:self];
    self.deleteView = [[DADDeleteView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width / 4, self.view.bounds.size.height + 50, self.view.bounds.size.width / 2, 50)];
    [self.deleteView addInteraction:deleteViewDropInteraction];
    [self.view addSubview:self.deleteView];
}

#pragma mark - drag
- (NSArray<UIDragItem *> *)dragInteraction:(UIDragInteraction *)interaction itemsForBeginningSession:(id<UIDragSession>)session {
    return [self dragInteraction:interaction];
}

// 支持添加dragItem
- (NSArray<UIDragItem *> *)dragInteraction:(UIDragInteraction *)interaction itemsForAddingToSession:(id<UIDragSession>)session withTouchAtPoint:(CGPoint)point {
    return [self dragInteraction:interaction];
}

- (void)dragInteraction:(UIDragInteraction *)interaction willAnimateLiftWithAnimator:(id<UIDragAnimating>)animator session:(id<UIDragSession>)session {
    [animator addAnimations:^{
        self.deleteView.frame = CGRectMake(self.view.bounds.size.width / 4, self.view.bounds.size.height - 60, self.view.bounds.size.width / 2, 50);
    }];
}

- (BOOL)dragInteraction:(UIDragInteraction *)interaction sessionAllowsMoveOperation:(id<UIDragSession>)session {
    return YES;
}

// 是否允许其它app相应当前的drag操作，NO代表可以相应，YES表示不可以相应
- (BOOL)dragInteraction:(UIDragInteraction *)interaction sessionIsRestrictedToDraggingApplication:(id<UIDragSession>)session {
    return YES;
}

- (void)dragInteraction:(UIDragInteraction *)interaction item:(UIDragItem *)item willAnimateCancelWithAnimator:(id<UIDragAnimating>)animator {
    [animator addAnimations:^{
        self.deleteView.frame = CGRectMake(self.view.bounds.size.width / 4, self.view.bounds.size.height + 60, self.view.bounds.size.width / 2, 50);
    }];
}

#pragma mark - drop

- (UIDropProposal *)dropInteraction:(UIDropInteraction *)interaction sessionDidUpdate:(id<UIDropSession>)session {
    UIDropOperation dropOperation;
    dropOperation = UIDropOperationMove;
    
    return [[UIDropProposal alloc] initWithDropOperation:dropOperation];
}

- (void)dropInteraction:(UIDropInteraction *)interaction performDrop:(id<UIDropSession>)session {
    [session loadObjectsOfClass:[UIImage class] completion:^(NSArray<__kindof id<NSItemProviderReading>> * _Nonnull objects) {
        UIImage *image = (UIImage *)[objects firstObject];
        image = nil;
    }];
    
    [session loadObjectsOfClass:[NSString class] completion:^(NSArray<__kindof id<NSItemProviderReading>> * _Nonnull objects) {
        NSString *str = (NSString *)[objects firstObject];
        str = nil;
    }];
    
    __typeof(&*self) __weak weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf hideDeleteView];
    });
}

#pragma mark - help
- (NSArray<UIDragItem *> *)dragInteraction:(UIDragInteraction *)interaction {
    NSItemProvider *itemProvider;
    if ([interaction.view isKindOfClass:[UIImageView class]]) {
        UIImageView *imageView = (UIImageView *)interaction.view;
        UIImage *image = imageView.image;
        
        if (!image) {
            return nil;
        }
        itemProvider = [[NSItemProvider alloc] initWithObject:image];
    }else if([interaction.view isKindOfClass:[UILabel class]]) {
        UILabel *label = (UILabel *)interaction.view;
        NSString *text = label.text;
        
        if (!text) {
            return nil;
        }
        itemProvider = [[NSItemProvider alloc] initWithObject:text];
    }
    
    UIDragItem *item = [[UIDragItem alloc] initWithItemProvider:itemProvider];
    return @[item];
}

- (void)hideDeleteView {
    [UIView animateWithDuration:0.5 animations:^{
        self.deleteView.frame = CGRectMake(self.view.bounds.size.width / 4, self.view.bounds.size.height + 60, self.view.bounds.size.width / 2, 50);
    } completion:^(BOOL finished) {
        self.deleteView.frame = CGRectMake(self.view.bounds.size.width / 4, self.view.bounds.size.height + 60, self.view.bounds.size.width / 2, 50);
    }];
}

@end
