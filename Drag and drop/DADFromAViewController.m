//
//  DADFromAViewController.m
//  Drag and drop
//
//  Created by 迟人华 on 2017/6/17.
//  Copyright © 2017年 迟人华. All rights reserved.
//

#import "DADFromAViewController.h"

#define imageWidth 150
#define imageHeight 150

@interface DADFromAViewController () <UIDragInteractionDelegate>

@property (nonatomic, strong)UIImageView *tipsView;

@end

@implementation DADFromAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    // imageView
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"butterfly"]];
    imageView.frame = CGRectMake((self.view.bounds.size.width / 2 - imageWidth) / 2, (self.view.bounds.size.height - imageHeight) / 2, imageWidth, imageHeight);
    
    UIDragInteraction *imageDragInteraction = [[UIDragInteraction alloc] initWithDelegate:self];
    [imageView addInteraction:imageDragInteraction];
    imageView.userInteractionEnabled = YES;
    
    [self.view addSubview:imageView];
    
    // label
    UIDragInteraction *LabelDragInteraction = [[UIDragInteraction alloc] initWithDelegate:self];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, self.view.bounds.size.width / 2, 30)];
    label.text = @"来呀来呀拖我呀～～";
    label.textColor = [UIColor blackColor];
    label.userInteractionEnabled = YES;
    [label addInteraction:LabelDragInteraction];
    [self.view addSubview:label];
    
    // tipsView
    self.tipsView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tips"]];
    self.tipsView.frame = CGRectMake((self.view.bounds.size.width / 2 - imageWidth) / 2, (self.view.bounds.size.height - imageHeight) / 8, imageWidth * 2, imageHeight);
    self.tipsView.alpha = 0;
    [self.view addSubview:self.tipsView];
}

- (NSArray<UIDragItem *> *)dragInteraction:(UIDragInteraction *)interaction itemsForBeginningSession:(id<UIDragSession>)session {
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

//- (nullable UITargetedDragPreview *)dragInteraction:(UIDragInteraction *)interaction previewForLiftingItem:(UIDragItem *)item session:(id<UIDragSession>)session {
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, interaction.view.bounds.size.width, interaction.view.bounds.size.height)];
//    imageView.backgroundColor = [UIColor redColor];
//    imageView.alpha = 0.3;
//
//    UIDragPreviewTarget *previewTarget = [[UIDragPreviewTarget alloc] initWithContainer:interaction.view center:CGPointMake(interaction.view.bounds.size.width / 2, interaction.view.bounds.size.height / 2)];
//
//    UITargetedDragPreview *dragPreview = [[UITargetedDragPreview alloc] initWithView:imageView parameters:[UIDragPreviewParameters new] target:previewTarget];
//    return dragPreview;
//}

- (void)dragInteraction:(UIDragInteraction *)interaction willAnimateLiftWithAnimator:(id<UIDragAnimating>)animator session:(id<UIDragSession>)session {
    [animator addAnimations:^{
        self.tipsView.alpha = 1;
    }];
}

- (void)dragInteraction:(UIDragInteraction *)interaction sessionWillBegin:(id<UIDragSession>)session {
    
}

- (BOOL)dragInteraction:(UIDragInteraction *)interaction sessionAllowsMoveOperation:(id<UIDragSession>)session {
    return NO;
}

// 是否允许其它app相应当前的drag操作，NO代表可以相应，YES表示不可以相应
- (BOOL)dragInteraction:(UIDragInteraction *)interaction sessionIsRestrictedToDraggingApplication:(id<UIDragSession>)session {
    return NO;
}

- (BOOL)dragInteraction:(UIDragInteraction *)interaction prefersFullSizePreviewsForSession:(id<UIDragSession>)session {
    return YES;
}

- (void)dragInteraction:(UIDragInteraction *)interaction sessionDidMove:(id<UIDragSession>)session {
    
}

// 这个方法会在drag操作将要完成时执行
- (void)dragInteraction:(UIDragInteraction *)interaction session:(id<UIDragSession>)session willEndWithOperation:(UIDropOperation)operation {
    
}

// 这个方法会在drag操作执行完，且动画也都执行完时调用
- (void)dragInteraction:(UIDragInteraction *)interaction session:(id<UIDragSession>)session didEndWithOperation:(UIDropOperation)operation {
    
}

// 在drop端全部收到数据后会回调
- (void)dragInteraction:(UIDragInteraction *)interaction sessionDidTransferItems:(id<UIDragSession>)session {
    
}

// 支持添加dragItem
- (NSArray<UIDragItem *> *)dragInteraction:(UIDragInteraction *)interaction itemsForAddingToSession:(id<UIDragSession>)session withTouchAtPoint:(CGPoint)point {
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

- (nullable id<UIDragSession>)dragInteraction:(UIDragInteraction *)interaction sessionForAddingItems:(NSArray<id<UIDragSession>> *)sessions withTouchAtPoint:(CGPoint)point {
    
}

@end
