//
//  DADOnlyDragViewController.m
//  Drag and drop
//
//  Created by 迟人华 on 2017/6/17.
//  Copyright © 2017年 迟人华. All rights reserved.
//

#import "DADOnlyDragViewController.h"

#define imageWidth 150
#define imageHeight 150

@interface DADOnlyDragViewController () <UIDragInteractionDelegate>

@property (nonatomic, strong)UIImageView *tipsView;

@end

@implementation DADOnlyDragViewController

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
    
    // tipsView
    self.tipsView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tips"]];
    self.tipsView.frame = CGRectMake((self.view.bounds.size.width / 2 - imageWidth) / 2, 70, imageWidth, imageHeight / 2);
    self.tipsView.alpha = 0;
    [self.view addSubview:self.tipsView];
}

- (NSArray<UIDragItem *> *)dragInteraction:(UIDragInteraction *)interaction itemsForBeginningSession:(id<UIDragSession>)session {
    return [self dragInteraction:interaction];
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
    self.tipsView.alpha = 0;
}

// 支持添加dragItem
- (NSArray<UIDragItem *> *)dragInteraction:(UIDragInteraction *)interaction itemsForAddingToSession:(id<UIDragSession>)session withTouchAtPoint:(CGPoint)point {
    return [self dragInteraction:interaction];
}

// 数据想要加到哪个session里，这里有个bug，第一次不会调用到这里
- (nullable id<UIDragSession>)dragInteraction:(UIDragInteraction *)interaction sessionForAddingItems:(NSArray<id<UIDragSession>> *)sessions withTouchAtPoint:(CGPoint)point {
    __block id localContext;
    if ([interaction.view isKindOfClass:[UIImageView class]]) {
        localContext = [UIImage class];
    }else if([interaction.view isKindOfClass:[UILabel class]]) {
        localContext = [NSString class];
    }
    
    __block id<UIDragSession> session;
    [sessions enumerateObjectsUsingBlock:^(id<UIDragSession>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.localContext == localContext) {
            session = obj;
        }
    }];
    return session;
}

- (void)dragInteraction:(UIDragInteraction *)interaction session:(id<UIDragSession>)session willAddItems:(NSArray<UIDragItem *> *)items forInteraction:(UIDragInteraction *)addingInteraction {
    
}

// drag操作取消时需要展示的view
//- (nullable UITargetedDragPreview *)dragInteraction:(UIDragInteraction *)interaction previewForCancellingItem:(UIDragItem *)item withDefault:(UITargetedDragPreview *)defaultPreview {
//        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, interaction.view.bounds.size.width, interaction.view.bounds.size.height)];
//        imageView.backgroundColor = [UIColor redColor];
//        imageView.alpha = 0.3;
//
//        UIDragPreviewTarget *previewTarget = [[UIDragPreviewTarget alloc] initWithContainer:interaction.view center:CGPointMake(interaction.view.bounds.size.width / 2, interaction.view.bounds.size.height / 2)];
//
//        UITargetedDragPreview *dragPreview = [[UITargetedDragPreview alloc] initWithView:imageView parameters:[UIDragPreviewParameters new] target:previewTarget];
//        return dragPreview;
//}

// drag操作取消需要执行的动画
- (void)dragInteraction:(UIDragInteraction *)interaction item:(UIDragItem *)item willAnimateCancelWithAnimator:(id<UIDragAnimating>)animator {
    [animator addAnimations:^{
        self.tipsView.alpha = 0;
    }];
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

@end
