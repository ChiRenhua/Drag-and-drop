//
//  DADCollectionViewController.m
//  Drag and drop
//
//  Created by Renhuachi on 2017/7/4.
//  Copyright © 2017年 迟人华. All rights reserved.
//

#import "DADCollectionViewController.h"

@interface DADCollectionViewController ()

@end

@implementation DADCollectionViewController

- (id)initWithTitleName:(NSString *)titleName {
    if (self = [super init]) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.navigationItem.title = titleName;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

@end
