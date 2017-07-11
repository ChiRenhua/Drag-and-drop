//
//  DADInSameAppViewController.m
//  Drag and drop
//
//  Created by Renhuachi on 2017/6/28.
//  Copyright © 2017年 迟人华. All rights reserved.
//

#import "DADInSameAppViewController.h"
#import "DADDeleteView.h"

#define imageWidth 150
#define imageHeight 150

@interface DADInSameAppViewController () <UIDragInteractionDelegate, UIDropInteractionDelegate>
@property (nonatomic, strong) DADDeleteView *deleteView;
@end

@implementation DADInSameAppViewController

- (id)initWithTitleName:(NSString *)titleName {
    if (self = [super init]) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.navigationItem.title = titleName;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // imageView
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"butterfly"]];
    imageView.frame = CGRectMake((self.view.bounds.size.width / 2 - 150) / 2 , (self.view.bounds.size.height - 150) / 2, 150, 150);
    imageView.layer.cornerRadius = imageView.frame.size.height / 4;
    
    UIDragInteraction *imageDragInteraction = [[UIDragInteraction alloc] initWithDelegate:self];
    [imageView addInteraction:imageDragInteraction];
    imageView.userInteractionEnabled = YES;
    
    [self.view addSubview:imageView];
    
    // copyImageView
    UIImageView *copyImageView = [[UIImageView alloc] init];
    copyImageView.frame = CGRectMake((self.view.bounds.size.width * 3 / 4 - 75) , (self.view.bounds.size.height - 150) / 2, 150, 150);
    copyImageView.backgroundColor = [UIColor lightGrayColor];
    copyImageView.layer.cornerRadius = copyImageView.frame.size.height / 4;
    
    UIDropInteraction *copyImageDropInteraction = [[UIDropInteraction alloc] initWithDelegate:self];
    [copyImageView addInteraction:copyImageDropInteraction];
    copyImageView.userInteractionEnabled = YES;
    
    [self.view addSubview:copyImageView];
    
    // label
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((self.view.bounds.size.width / 2 - self.view.bounds.size.width / 3) / 2, self.view.bounds.size.height / 4, self.view.bounds.size.width / 3, 30)];
    label.text = @"来呀来呀拖我呀～～";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    label.layer.cornerRadius = label.frame.size.height / 4;
    label.clipsToBounds = YES;
    
    UIDragInteraction *labelDragInteraction = [[UIDragInteraction alloc] initWithDelegate:self];
    [label addInteraction:labelDragInteraction];
    label.userInteractionEnabled = YES;
    
    [self.view addSubview:label];
    
    // copyLabel
    UILabel *copyLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.view.bounds.size.width * 3 / 4 - self.view.bounds.size.width / 6), self.view.bounds.size.height / 4, self.view.bounds.size.width / 3, 30)];
    copyLabel.backgroundColor = [UIColor lightGrayColor];
    copyLabel.textAlignment = NSTextAlignmentCenter;
    copyLabel.textColor = [UIColor blackColor];
    copyLabel.layer.cornerRadius = copyLabel.frame.size.height / 4;
    copyLabel.clipsToBounds = YES;
    
    UIDropInteraction *copyLabelDropInteraction = [[UIDropInteraction alloc] initWithDelegate:self];
    [copyLabel addInteraction:copyLabelDropInteraction];
    copyLabel.userInteractionEnabled = YES;
    
    [self.view addSubview:copyLabel];
    
    // deleteView
    self.deleteView = [[DADDeleteView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width / 4, self.view.bounds.size.height + 50, self.view.bounds.size.width / 2, 50)];
    
    UIDropInteraction *deleteViewDropInteraction = [[UIDropInteraction alloc] initWithDelegate:self];
    [self.deleteView addInteraction:deleteViewDropInteraction];
    
    [self.view addSubview:self.deleteView];
}

#pragma mark - drag
- (NSArray<UIDragItem *> *)dragInteraction:(UIDragInteraction *)interaction itemsForBeginningSession:(id<UIDragSession>)session {
    return [self dragInteraction:interaction session:session];
}

// 支持添加dragItem
- (NSArray<UIDragItem *> *)dragInteraction:(UIDragInteraction *)interaction itemsForAddingToSession:(id<UIDragSession>)session withTouchAtPoint:(CGPoint)point {
    return [self dragInteraction:interaction session:session];
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

- (void)dragInteraction:(UIDragInteraction *)interaction sessionDidTransferItems:(id<UIDragSession>)session {
    if ([interaction.view isKindOfClass:[UIImageView class]]) {
        UIImageView *imageView = (UIImageView *)interaction.view;
        imageView.image = nil;
        
    }else if([interaction.view isKindOfClass:[UILabel class]]) {
        UILabel *label = (UILabel *)interaction.view;
        label.text = nil;
    }
}

#pragma mark - drop
- (UIDropProposal *)dropInteraction:(UIDropInteraction *)interaction sessionDidUpdate:(id<UIDropSession>)session {
    UIDropOperation dropOperation = UIDropOperationForbidden;
    
    if ([interaction.view isKindOfClass:[UIImageView class]]) {
        if ([session canLoadObjectsOfClass:[UIImage class]]) {
            dropOperation = UIDropOperationMove;
        }else {
            dropOperation = UIDropOperationForbidden;
        }
    }
    
    if ([interaction.view isKindOfClass:[UILabel class]]) {
        if ([session canLoadObjectsOfClass:[NSString class]]) {
            dropOperation = UIDropOperationMove;
        }else {
            dropOperation = UIDropOperationForbidden;
        }
    }
    
    if ([interaction.view isKindOfClass:[DADDeleteView class]]) {
        dropOperation = UIDropOperationMove;
    }
    
    return [[UIDropProposal alloc] initWithDropOperation:dropOperation];
}

- (void)dropInteraction:(UIDropInteraction *)interaction performDrop:(id<UIDropSession>)session {
    if (![interaction.view isKindOfClass:[DADDeleteView class]]) {
        if ([interaction.view isKindOfClass:[UIImageView class]]) {
            [session loadObjectsOfClass:[UIImage class] completion:^(NSArray<__kindof id<NSItemProviderReading>> * _Nonnull objects) {
                if (objects.count) {
                    UIImage *image = [objects firstObject];
                    UIImageView *imageView = (UIImageView *)interaction.view;
                    imageView.image = image;
                }
            }];
        }
        
        if ([interaction.view isKindOfClass:[UILabel class]]) {
            [session loadObjectsOfClass:[NSString class] completion:^(NSArray<__kindof id<NSItemProviderReading>> * _Nonnull objects) {
                if (objects.count) {
                    NSString *str = [objects firstObject];
                    UILabel *label = (UILabel *)interaction.view;
                    label.text = str;
                }
            }];
        }
    }
    
    __typeof(&*self) __weak weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf hideDeleteView];
    });
}

#pragma mark - help
- (NSArray<UIDragItem *> *)dragInteraction:(UIDragInteraction *)interaction session:(id<UIDragSession>)session{
    __block BOOL isRepeat = NO;
    [session.items enumerateObjectsUsingBlock:^(UIDragItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.localObject == interaction.view) {
            isRepeat = YES;
        }
    }];
    
    if (isRepeat) {
        return nil;
    }
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
    item.localObject = interaction.view;
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
