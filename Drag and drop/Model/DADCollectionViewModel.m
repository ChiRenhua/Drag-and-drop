//
//  DADCollectionViewModel.m
//  Drag and drop
//
//  Created by 迟人华 on 2017/7/6.
//  Copyright © 2017年 迟人华. All rights reserved.
//

#import "DADCollectionViewModel.h"

@interface DADCollectionViewModel ()

@property (nonatomic, strong) __block NSMutableArray *collectionViewDataArray;

@end

@implementation DADCollectionViewModel

+ (instancetype)sharedInstance {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init {
    if (self = [super init]) {
        [self creatCollectionViewData];
    }
    return self;
}

- (void)creatCollectionViewData {
    NSArray *imageNameArray = [NSArray arrayWithObjects:@"pic1", @"pic2", @"pic3", @"pic4", @"pic5", @"pic6", nil];
    self.collectionViewDataArray = [[NSMutableArray alloc] init];
    
    [imageNameArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImage *image = [UIImage imageNamed:obj];
        [self.collectionViewDataArray addObject:image];
    }];
}

- (NSArray *)getCollectionViewData {
    if (!self.collectionViewDataArray) {
        [self creatCollectionViewData];
    }
    return self.collectionViewDataArray;
}

- (void)replaceImageAtIndex:(NSInteger)sourceIndex toIndex:(NSInteger)toIndex {
    if (sourceIndex == toIndex) {
        return;
    }
    
    NSString *tempStr = self.collectionViewDataArray[sourceIndex];
    [self.collectionViewDataArray removeObjectAtIndex:sourceIndex];
    [self.collectionViewDataArray insertObject:tempStr atIndex:toIndex];
}

- (void)addImage:(id)image atIndex:(NSInteger)index {
    [self.collectionViewDataArray insertObject:image atIndex:index];
}

@end
