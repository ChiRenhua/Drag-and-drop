//
//  DADMainViewController.m
//  Drag and drop
//
//  Created by 迟人华 on 2017/6/17.
//  Copyright © 2017年 迟人华. All rights reserved.
//

#import "DADMainViewController.h"
#import "DADFromAViewController.h"
#import "DADFromSelfViewController.h"

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
    
    self.cellArr = [[NSArray alloc] initWithObjects:@"only drag", @"drag and drop", @"第三个", @"第四个", @"第五个", @"第六个", @"第七个", nil];
    
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
            DADFromAViewController *fromeAVC = [[DADFromAViewController alloc] init];
            [self.navigationController pushViewController:fromeAVC animated:YES];
        }
            
            break;
        case 1: {
            DADFromSelfViewController *fromeAVC = [[DADFromSelfViewController alloc] init];
            [self.navigationController pushViewController:fromeAVC animated:YES];
        }
            
            break;
        case 2: {
            
        }
            
            break;
        case 3: {
            
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
