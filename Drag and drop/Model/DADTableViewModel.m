//
//  DADTableViewModel.m
//  Drag and drop
//
//  Created by Renhuachi on 2017/6/30.
//  Copyright © 2017年 迟人华. All rights reserved.
//

#import "DADTableViewModel.h"

@interface DADTableViewModel ()
@property (nonatomic, strong) NSMutableArray *tableViewDataArray;
@end

@implementation DADTableViewModel

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
        [self creatTableViewData];
    }
    return self;
}

- (void)creatTableViewData {
    self.tableViewDataArray = [[NSMutableArray alloc] initWithObjects:@"腾讯大厦", @"松日鼎盛", @"深圳湾", @"宝安机场" , @"香港" , @"澳门" , nil];
}

- (NSArray *)getTableViewData {
    if (self.tableViewDataArray.count) {
        return self.tableViewDataArray;
    }else {
        [self creatTableViewData];
        return self.tableViewDataArray;
    }
}

- (void)addItem:(NSString *)item atIndex:(NSInteger)index {
    [self.tableViewDataArray insertObject:item atIndex:index];
}

- (void)replaceItemAtIndex:(NSInteger)sourceIndex toIndex:(NSInteger)toIndex {
    if (sourceIndex == toIndex) {
        return;
    }
    
    NSString *tempStr = self.tableViewDataArray[sourceIndex];
    [self.tableViewDataArray removeObjectAtIndex:sourceIndex];
    [self.tableViewDataArray insertObject:tempStr atIndex:toIndex];
}

@end
