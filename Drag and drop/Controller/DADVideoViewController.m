//
//  DADVideoViewController.m
//  Drag and drop
//
//  Created by Renhuachi on 2017/6/29.
//  Copyright © 2017年 迟人华. All rights reserved.
//

#import "DADVideoViewController.h"
#import "DADPosterImageView.h"
#import "DADPosterPreView.h"

@interface DADVideoViewController ()<UIDragInteractionDelegate>

@end

@implementation DADVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    // openSearchImage
    DADPosterImageView *openSearchImage = [[DADPosterImageView alloc] initWithImage:[UIImage imageNamed:@"chuqiao"]];
    openSearchImage.frame = CGRectMake((self.view.bounds.size.width / 2 - 219) / 2 , (self.view.bounds.size.height - 307) / 2, 219, 307);
    openSearchImage.movieName = @"楚乔传";
    UIDragInteraction *searchImageDragInteraction = [[UIDragInteraction alloc] initWithDelegate:self];
    [openSearchImage addInteraction:searchImageDragInteraction];
    openSearchImage.userInteractionEnabled = YES;
    openSearchImage.layer.cornerRadius = 10.0f;
    openSearchImage.layer.masksToBounds = YES;
    [self.view addSubview:openSearchImage];
    
    // openMovieDetailImage
    DADPosterImageView *openMovieDetailImage = [[DADPosterImageView alloc] initWithImage:[UIImage imageNamed:@"naiba"]];
    openMovieDetailImage.frame = CGRectMake((self.view.bounds.size.width * 3 / 4 - 109.5) , (self.view.bounds.size.height - 307) / 2, 219, 307);
    openMovieDetailImage.movieName = @"神偷奶爸";
    openMovieDetailImage.movieURL = @"txvideo://v.qq.com/VideoDetailActivity?cid=oylsefopm3zevpj&vid=j0013tua8os";
    UIDragInteraction *movieDetailImageDragInteraction = [[UIDragInteraction alloc] initWithDelegate:self];
    [openMovieDetailImage addInteraction:movieDetailImageDragInteraction];
    openMovieDetailImage.userInteractionEnabled = YES;
    openMovieDetailImage.layer.cornerRadius = 10.0f;
    openMovieDetailImage.layer.masksToBounds = YES;
    [self.view addSubview:openMovieDetailImage];
}

- (NSArray<UIDragItem *> *)dragInteraction:(UIDragInteraction *)interaction itemsForBeginningSession:(id<UIDragSession>)session {
    return [self dragInteraction:interaction];
}

- (nullable UITargetedDragPreview *)dragInteraction:(UIDragInteraction *)interaction previewForLiftingItem:(UIDragItem *)item session:(id<UIDragSession>)session {
    interaction.view.alpha = 0.5;
    
    
    DADPosterPreView *preView = [[DADPosterPreView alloc] initWithFrame:CGRectMake(0, 0, 219, 358.4)];
    [preView setImage:interaction.view];
    
    UIDragPreviewTarget *previewTarget = [[UIDragPreviewTarget alloc] initWithContainer:interaction.view center:CGPointMake(interaction.view.bounds.size.width / 2, interaction.view.bounds.size.height / 2)];
    
    UITargetedDragPreview *dragPreview = [[UITargetedDragPreview alloc] initWithView:preView parameters:[UIDragPreviewParameters new] target:previewTarget];
    return dragPreview;
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
    interaction.view.alpha = 1.0;
}

// 在drop端全部收到数据后会回调
- (void)dragInteraction:(UIDragInteraction *)interaction sessionDidTransferItems:(id<UIDragSession>)session {
    interaction.view.alpha = 1.0;
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

// drag操作取消需要执行的动画
- (void)dragInteraction:(UIDragInteraction *)interaction item:(UIDragItem *)item willAnimateCancelWithAnimator:(id<UIDragAnimating>)animator {
    interaction.view.alpha = 1.0;
}

#pragma mark - help
- (NSArray<UIDragItem *> *)dragInteraction:(UIDragInteraction *)interaction {
    NSItemProvider *itemProvider;
    if ([interaction.view isKindOfClass:[DADPosterImageView class]]) {
        DADPosterImageView *imageView = (DADPosterImageView *)interaction.view;
        
        if (imageView.movieURL.length) {
            itemProvider = [[NSItemProvider alloc] initWithObject:imageView.movieURL];
        }else if (imageView.movieName.length) {
            itemProvider = [[NSItemProvider alloc] initWithObject:imageView.movieName];
        }else {
            return nil;
        }
    }
    
    UIDragItem *item = [[UIDragItem alloc] initWithItemProvider:itemProvider];
    return @[item];
}

@end
