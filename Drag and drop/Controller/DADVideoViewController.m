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

- (id)initWithTitleName:(NSString *)titleName {
    if (self = [super init]) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.navigationItem.title = titleName;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // openSearchImage
    DADPosterImageView *openSearchImage = [[DADPosterImageView alloc] initWithImage:[UIImage imageNamed:@"chuqiao"]];
    openSearchImage.frame = CGRectMake((self.view.bounds.size.width / 2 - 219) / 2 , (self.view.bounds.size.height - 307) / 2, 219, 307);
    openSearchImage.movieName = @"楚乔传";
    UIDragInteraction *searchImageDragInteraction = [[UIDragInteraction alloc] initWithDelegate:self];
    [openSearchImage addInteraction:searchImageDragInteraction];
    openSearchImage.userInteractionEnabled = YES;
    openSearchImage.layer.cornerRadius = 15.0f;
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
    openMovieDetailImage.layer.cornerRadius = 15.0f;
    openMovieDetailImage.layer.masksToBounds = YES;
    [self.view addSubview:openMovieDetailImage];
}

- (NSArray<UIDragItem *> *)dragInteraction:(UIDragInteraction *)interaction itemsForBeginningSession:(id<UIDragSession>)session {
    return [self dragInteraction:interaction];
}

- (nullable UITargetedDragPreview *)dragInteraction:(UIDragInteraction *)interaction previewForLiftingItem:(UIDragItem *)item session:(id<UIDragSession>)session {
    interaction.view.alpha = 0.5;
    
    
    DADPosterPreView *preView = [[DADPosterPreView alloc] initWithFrame:CGRectMake(0, 0, 175.2, 286.72)];
    [preView setImage:interaction.view];
    
    UIDragPreviewTarget *previewTarget = [[UIDragPreviewTarget alloc] initWithContainer:interaction.view center:CGPointMake(interaction.view.bounds.size.width / 2, interaction.view.bounds.size.height / 2)];
    
    UITargetedDragPreview *dragPreview = [[UITargetedDragPreview alloc] initWithView:preView parameters:[UIDragPreviewParameters new] target:previewTarget];
    return dragPreview;
}

// 这个方法会在drag操作执行完，且动画也都执行完时调用
- (void)dragInteraction:(UIDragInteraction *)interaction session:(id<UIDragSession>)session didEndWithOperation:(UIDropOperation)operation {
    interaction.view.alpha = 1.0;
}

// 在drop端全部收到数据后会回调
- (void)dragInteraction:(UIDragInteraction *)interaction sessionDidTransferItems:(id<UIDragSession>)session {
    interaction.view.alpha = 1.0;
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
