//
//  DADTableViewViewController.m
//  Drag and drop
//
//  Created by Renhuachi on 2017/6/30.
//  Copyright © 2017年 迟人华. All rights reserved.
//

#import "DADTableViewViewController.h"
#import "DADTableViewModel.h"

@interface DADTableViewViewController () <UITableViewDelegate, UITableViewDataSource, UITableViewDragDelegate, UITableViewDropDelegate>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation DADTableViewViewController

- (id)init {
    if (self = [super init]) {
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.dragDelegate = self;
    self.tableView.dropDelegate = self;
    self.tableView.rowHeight = 50;
    [self.view addSubview:self.tableView];
}

#pragma mark - dragDelegate
- (NSArray<UIDragItem *> *)tableView:(UITableView *)tableView itemsForBeginningDragSession:(id<UIDragSession>)session atIndexPath:(NSIndexPath *)indexPath {
    NSString *data = [[DADTableViewModel sharedInstance] getTableViewData][indexPath.row];
    NSItemProvider *itemProvider = [[NSItemProvider alloc] initWithObject:data];
    UIDragItem *dragItem = [[UIDragItem alloc] initWithItemProvider:itemProvider];
    return @[dragItem];
}

#pragma mark - dropDelegate
- (UITableViewDropProposal *)tableView:(UITableView *)tableView dropSessionDidUpdate:(id<UIDropSession>)session withDestinationIndexPath:(NSIndexPath *)destinationIndexPath {
    if (tableView.hasActiveDrag) {
        if (session.items.count > 1) {
            return [[UITableViewDropProposal alloc] initWithDropOperation:UIDropOperationCancel];
        } else {
          return [[UITableViewDropProposal alloc] initWithDropOperation:UIDropOperationMove];
        }
    }else {
        return [[UITableViewDropProposal alloc] initWithDropOperation:UIDropOperationCopy];
    }
}

- (void)tableView:(UITableView *)tableView performDropWithCoordinator:(id<UITableViewDropCoordinator>)coordinator {
    NSLog(@"%@",coordinator.destinationIndexPath);
}

#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[DADTableViewModel sharedInstance] getTableViewData].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:@"DADTableViewCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DADTableViewCell"];
    }else {
        cell.textLabel.text = @"";
    }
    
    cell.textLabel.text = [[DADTableViewModel sharedInstance] getTableViewData][indexPath.row];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

//- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {
//
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
