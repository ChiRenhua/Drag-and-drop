//
//  DADCollectionViewModel.h
//  Drag and drop
//
//  Created by 迟人华 on 2017/7/6.
//  Copyright © 2017年 迟人华. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DADCollectionViewModel : NSObject

+ (instancetype)sharedInstance;

- (NSArray *)getCollectionViewData;

- (void)addImage:(UIImage *)image atIndex:(NSInteger)index;

- (void)replaceImageAtIndex:(NSInteger)sourceIndex toIndex:(NSInteger)toIndex;

@end
