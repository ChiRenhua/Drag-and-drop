//
//  DADTableViewModel.m
//  Drag and drop
//
//  Created by Renhuachi on 2017/6/30.
//  Copyright © 2017年 迟人华. All rights reserved.
//

#import "DADTableViewModel.h"

@interface DADTableViewModel ()
@property (nonatomic, copy) NSArray *tableViewDataArray;
@end

@implementation DADTableViewModel

+ (instancetype)sharedInstance
{
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
    self.tableViewDataArray = [[NSArray alloc] initWithObjects:@"腾讯大厦", @"松日鼎盛", @"深圳湾", @"宝安机场" , @"香港" , @"澳门" , nil];
}

- (NSArray *)getTableViewData {
    if (self.tableViewDataArray.count) {
        return self.tableViewDataArray;
    }else {
        [self creatTableViewData];
        return self.tableViewDataArray;
    }
}

@end
