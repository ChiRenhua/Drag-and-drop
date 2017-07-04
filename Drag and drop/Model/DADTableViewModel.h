//
//  DADTableViewModel.h
//  Drag and drop
//
//  Created by Renhuachi on 2017/6/30.
//  Copyright © 2017年 迟人华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DADTableViewModel : NSObject

+ (instancetype)sharedInstance;

- (NSArray *)getTableViewData;

- (void)addItem:(NSString *)item atIndex:(NSInteger)index;

- (void)replaceItemAtIndex:(NSInteger)sourceIndex toIndex:(NSInteger)toIndex;

@end
