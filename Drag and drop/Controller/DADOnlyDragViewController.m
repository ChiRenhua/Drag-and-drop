//
//  DADOnlyDragViewController.m
//  Drag and drop
//
//  Created by 迟人华 on 2017/6/17.
//  Copyright © 2017年 迟人华. All rights reserved.
//

#import "DADOnlyDragViewController.h"
#import "DADDeleteView.h"

#define imageWidth 150
#define imageHeight 150

@interface DADOnlyDragViewController () <UIDragInteractionDelegate, UIDropInteractionDelegate>

@property (nonatomic, strong) DADDeleteView *deleteView;

@end

@implementation DADOnlyDragViewController

- (id)initWithTitleName:(NSString *)titleName {
    if (self = [super init]) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.navigationItem.title = titleName;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // ImageView
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"butterfly"]];
    imageView.frame = CGRectMake((self.view.bounds.size.width / 2 - 150) / 2 , (self.view.bounds.size.height - 150) / 2, 150, 150);
    
    UIDragInteraction *imageDragInteraction = [[UIDragInteraction alloc] initWithDelegate:self];
    [imageView addInteraction:imageDragInteraction];
    imageView.userInteractionEnabled = YES;
    
    [self.view addSubview:imageView];
    
    // Label
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((self.view.bounds.size.width / 2 - self.view.bounds.size.width / 3) / 2, self.view.bounds.size.height / 4, self.view.bounds.size.width / 3, 30)];
    label.text = @"来呀来呀拖我呀～～";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    
    UIDragInteraction *LabelDragInteraction = [[UIDragInteraction alloc] initWithDelegate:self];
    [label addInteraction:LabelDragInteraction];
    label.userInteractionEnabled = YES;
    
    [self.view addSubview:label];
}

#pragma mark - UIDragInteractionDelegate
- (NSArray<UIDragItem *> *)dragInteraction:(UIDragInteraction *)interaction itemsForBeginningSession:(id<UIDragSession>)session {
    NSLog(@"itemsForBeginningSession");
    return [self dragInteraction:interaction];
}

- (nullable UITargetedDragPreview *)dragInteraction:(UIDragInteraction *)interaction previewForLiftingItem:(UIDragItem *)item session:(id<UIDragSession>)session {
    NSLog(@"previewForLiftingItem");
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, interaction.view.bounds.size.width, interaction.view.bounds.size.height)];
    imageView.backgroundColor = [UIColor redColor];
    
    UIDragPreviewTarget *previewTarget = [[UIDragPreviewTarget alloc] initWithContainer:interaction.view center:CGPointMake(interaction.view.bounds.size.width / 2, interaction.view.bounds.size.height / 2)];
    
    UITargetedDragPreview *dragPreview = [[UITargetedDragPreview alloc] initWithView:imageView parameters:[[UIDragPreviewParameters alloc] init] target:previewTarget];
    return dragPreview;
}

- (void)dragInteraction:(UIDragInteraction *)interaction willAnimateLiftWithAnimator:(id<UIDragAnimating>)animator session:(id<UIDragSession>)session {
    NSLog(@"willAnimateLiftWithAnimator");
}

- (void)dragInteraction:(UIDragInteraction *)interaction sessionWillBegin:(id<UIDragSession>)session {
    NSLog(@"sessionWillBegin");
}

- (BOOL)dragInteraction:(UIDragInteraction *)interaction sessionAllowsMoveOperation:(id<UIDragSession>)session {
    NSLog(@"sessionAllowsMoveOperation");
    return NO;
}

- (BOOL)dragInteraction:(UIDragInteraction *)interaction sessionIsRestrictedToDraggingApplication:(id<UIDragSession>)session {
    NSLog(@"sessionIsRestrictedToDraggingApplication");
    return NO;
}

- (BOOL)dragInteraction:(UIDragInteraction *)interaction prefersFullSizePreviewsForSession:(id<UIDragSession>)session {
    NSLog(@"prefersFullSizePreviewsForSession");
    return YES;
}

- (void)dragInteraction:(UIDragInteraction *)interaction sessionDidMove:(id<UIDragSession>)session {
    NSLog(@"sessionDidMove");
}

- (void)dragInteraction:(UIDragInteraction *)interaction session:(id<UIDragSession>)session willEndWithOperation:(UIDropOperation)operation {
    NSLog(@"willEndWithOperation");
}

- (void)dragInteraction:(UIDragInteraction *)interaction session:(id<UIDragSession>)session didEndWithOperation:(UIDropOperation)operation {
    NSLog(@"didEndWithOperation");
}

- (void)dragInteraction:(UIDragInteraction *)interaction sessionDidTransferItems:(id<UIDragSession>)session {
    NSLog(@"sessionDidTransferItems");
}

- (NSArray<UIDragItem *> *)dragInteraction:(UIDragInteraction *)interaction itemsForAddingToSession:(id<UIDragSession>)session withTouchAtPoint:(CGPoint)point {
    NSLog(@"itemsForAddingToSession");
    return [self dragInteraction:interaction];
}

- (nullable id<UIDragSession>)dragInteraction:(UIDragInteraction *)interaction sessionForAddingItems:(NSArray<id<UIDragSession>> *)sessions withTouchAtPoint:(CGPoint)point {
    NSLog(@"sessionForAddingItems");
    return [sessions firstObject];
}

- (void)dragInteraction:(UIDragInteraction *)interaction session:(id<UIDragSession>)session willAddItems:(NSArray<UIDragItem *> *)items forInteraction:(UIDragInteraction *)addingInteraction {
    NSLog(@"willAddItems");
}

- (nullable UITargetedDragPreview *)dragInteraction:(UIDragInteraction *)interaction previewForCancellingItem:(UIDragItem *)item withDefault:(UITargetedDragPreview *)defaultPreview {
    NSLog(@"previewForCancellingItem");

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, interaction.view.bounds.size.width, interaction.view.bounds.size.height)];
    imageView.backgroundColor = [UIColor blueColor];
    imageView.alpha = 0.3;

    UIDragPreviewTarget *previewTarget = [[UIDragPreviewTarget alloc] initWithContainer:interaction.view center:CGPointMake(interaction.view.bounds.size.width / 2, interaction.view.bounds.size.height / 2)];

    UITargetedDragPreview *dragPreview = [[UITargetedDragPreview alloc] initWithView:imageView parameters:[UIDragPreviewParameters new] target:previewTarget];
    return dragPreview;
}

- (void)dragInteraction:(UIDragInteraction *)interaction item:(UIDragItem *)item willAnimateCancelWithAnimator:(id<UIDragAnimating>)animator {
    NSLog(@"willAnimateCancelWithAnimator");
}

#pragma mark - Helper Method
- (NSArray<UIDragItem *> *)dragInteraction:(UIDragInteraction *)interaction {
    NSItemProvider *itemProvider;
    
    if ([interaction.view isKindOfClass:[UIImageView class]]) {
        UIImageView *imageView = (UIImageView *)interaction.view;
        UIImage *image = imageView.image;
        
        if (!image) {
            return nil;
        }
        
        itemProvider = [[NSItemProvider alloc] initWithObject:image];
    } else if ([interaction.view isKindOfClass:[UILabel class]]) {
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
