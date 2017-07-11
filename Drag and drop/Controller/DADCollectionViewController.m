//
//  DADCollectionViewController.m
//  Drag and drop
//
//  Created by Renhuachi on 2017/7/4.
//  Copyright © 2017年 迟人华. All rights reserved.
//

#import "DADCollectionViewController.h"
#import "DADCollectionViewCell.h"
#import "DADCollectionViewModel.h"

#define CELL_WIDTH 300
#define CELL_HEIGHT 200

@interface DADCollectionViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDragDelegate, UICollectionViewDropDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation DADCollectionViewController

- (id)initWithTitleName:(NSString *)titleName {
    if (self = [super init]) {
        self.navigationItem.title = titleName;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatCollectionView];
}

- (void)creatCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.dragDelegate = self;
    self.collectionView.dropDelegate = self;
    self.collectionView.alwaysBounceVertical = YES;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[DADCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([DADCollectionViewCell class])];
    
    [self.view addSubview:self.collectionView];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[DADCollectionViewModel sharedInstance] getCollectionViewData].count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DADCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([DADCollectionViewCell class]) forIndexPath:indexPath];
    
    UIImage *image = [[DADCollectionViewModel sharedInstance] getCollectionViewData] [indexPath.row];
    [cell setContentImage:image];
    
    return cell;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    [[DADCollectionViewModel sharedInstance] replaceImageAtIndex:sourceIndexPath.row toIndex:destinationIndexPath.row];
}

#pragma mark - UICollectionViewDelegate

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(CELL_WIDTH, CELL_HEIGHT);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    NSInteger gap = [self cellGap];
    return UIEdgeInsetsMake(gap, gap, gap, gap);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return [self cellGap];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return [self cellGap];
}

#pragma mark - UICollectionViewDragDelegate
- (NSArray<UIDragItem *> *)collectionView:(UICollectionView *)collectionView itemsForBeginningDragSession:(id<UIDragSession>)session atIndexPath:(NSIndexPath *)indexPath {
    UIImage *image = [[DADCollectionViewModel sharedInstance] getCollectionViewData] [indexPath.row];
    NSItemProvider *itemProvider = [[NSItemProvider alloc] initWithObject:image];
    UIDragItem *dragItem = [[UIDragItem alloc] initWithItemProvider:itemProvider];
    return @[dragItem];
}

#pragma mark - UICollectionViewDropDelegate

- (UICollectionViewDropProposal *)collectionView:(UICollectionView *)collectionView dropSessionDidUpdate:(id<UIDropSession>)session withDestinationIndexPath:(NSIndexPath *)destinationIndexPath {
    if (collectionView.hasActiveDrag) {
        if (session.items.count > 1) {
            return [[UICollectionViewDropProposal alloc] initWithDropOperation:UIDropOperationCancel];
        } else {
            return [[UICollectionViewDropProposal alloc] initWithDropOperation:UIDropOperationMove intent:UICollectionViewDropIntentInsertAtDestinationIndexPath];
        }
    }else {
        return [[UICollectionViewDropProposal alloc] initWithDropOperation:UIDropOperationCopy intent:UICollectionViewDropIntentInsertAtDestinationIndexPath];
    }
}

- (void)collectionView:(UICollectionView *)collectionView performDropWithCoordinator:(id<UICollectionViewDropCoordinator>)coordinator {
    __block NSIndexPath *destinationIndexPath = coordinator.destinationIndexPath;
    __block NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
    
    if (!destinationIndexPath) {
        NSUInteger section = collectionView.numberOfSections - 1;
        NSUInteger row = [collectionView numberOfItemsInSection:collectionView.numberOfSections - 1];
        destinationIndexPath = [NSIndexPath indexPathForRow:row inSection:section];
    }
    
    [coordinator.session loadObjectsOfClass:[UIImage class] completion:^(NSArray<__kindof id<NSItemProviderReading>> * _Nonnull objects) {
        NSArray *array = (NSArray *)objects;
        
        for (int i = 0; i < array.count; i++) {
            UIImage *image = array[i];
            
            NSUInteger section = destinationIndexPath.section;
            NSUInteger row = destinationIndexPath.row + i;
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
            [[DADCollectionViewModel sharedInstance] addImage:image atIndex:indexPath.row];
            [indexPaths addObject:indexPath];
        }
        [collectionView insertItemsAtIndexPaths:indexPaths];
    }];
}

#pragma mark - Helper
- (NSInteger)cellGap {
    return (self.view.bounds.size.width - CELL_WIDTH * 3) / 4;
}

@end

