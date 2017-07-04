//
//  DADMainViewController.m
//  Drag and drop
//
//  Created by 迟人华 on 2017/6/17.
//  Copyright © 2017年 迟人华. All rights reserved.
//

#import "DADMainViewController.h"
#import "DADOnlyDragViewController.h"
#import "DADInSameAppViewController.h"
#import "DADVideoViewController.h"
#import "DADTableViewViewController.h"

@interface DADMainViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *cellArr;

@end

@implementation DADMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"Demo";
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 100;
    
    self.cellArr = [[NSArray alloc] initWithObjects:@"Only drag", @"Drag and drop in same application", @"Drag and drop in tableView", @"TenVideo Test", @"第五个", @"第六个", @"第七个", nil];
    
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    cell.textLabel.text = self.cellArr[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cellArr.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0: {
            DADOnlyDragViewController *onlyDragVC = [[DADOnlyDragViewController alloc] initWithTitleName:self.cellArr[indexPath.row]];
            [self.navigationController pushViewController:onlyDragVC animated:YES];
        }
            
            break;
        case 1: {
            DADInSameAppViewController *oneAppVC = [[DADInSameAppViewController alloc] initWithTitleName:self.cellArr[indexPath.row]];
            [self.navigationController pushViewController:oneAppVC animated:YES];
        }
            
            break;
        case 2: {
            DADTableViewViewController *tableViewController = [[DADTableViewViewController alloc] initWithTitleName:self.cellArr[indexPath.row]];
            [self.navigationController pushViewController:tableViewController animated:YES];
        }
            
            break;
        case 3: {
            DADVideoViewController *videoVC = [[DADVideoViewController alloc] initWithTitleName:self.cellArr[indexPath.row]];
            [self.navigationController pushViewController:videoVC animated:YES];
        }
            
            break;
        case 4: {
            
        }
            
            break;
        case 5: {
            
        }
            
            break;
        case 6: {
            
        }
            
            break;
        default:
            break;
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
