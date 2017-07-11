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

- (id)initWithTitleName:(NSString *)titleName {
    if (self = [super init]) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.navigationItem.title = titleName;
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

#pragma mark - UITableViewDragDelegate
- (NSArray<UIDragItem *> *)tableView:(UITableView *)tableView itemsForBeginningDragSession:(id<UIDragSession>)session atIndexPath:(NSIndexPath *)indexPath {
    NSString *data = [[DADTableViewModel sharedInstance] getTableViewData] [indexPath.row];
    NSItemProvider *itemProvider = [[NSItemProvider alloc] initWithObject:data];
    UIDragItem *dragItem = [[UIDragItem alloc] initWithItemProvider:itemProvider];
    return @[dragItem];
}

#pragma mark - UITableViewDropDelegate
- (UITableViewDropProposal *)tableView:(UITableView *)tableView dropSessionDidUpdate:(id<UIDropSession>)session withDestinationIndexPath:(NSIndexPath *)destinationIndexPath {
    if (tableView.hasActiveDrag) {
        if (session.items.count > 1) {
            return [[UITableViewDropProposal alloc] initWithDropOperation:UIDropOperationCancel];
        } else {
          return [[UITableViewDropProposal alloc] initWithDropOperation:UIDropOperationMove intent:UITableViewDropIntentInsertAtDestinationIndexPath];
        }
    } else {
        return [[UITableViewDropProposal alloc] initWithDropOperation:UIDropOperationCopy intent:UITableViewDropIntentInsertAtDestinationIndexPath];
    }
}

- (void)tableView:(UITableView *)tableView performDropWithCoordinator:(id<UITableViewDropCoordinator>)coordinator {
    __block NSIndexPath *destinationIndexPath = coordinator.destinationIndexPath;
    __block NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
    
    if (!destinationIndexPath) {
        NSUInteger section = tableView.numberOfSections - 1;
        NSUInteger row = [tableView numberOfRowsInSection:tableView.numberOfSections - 1];
        destinationIndexPath = [NSIndexPath indexPathForRow:row inSection:section];
    }
    
    [coordinator.session loadObjectsOfClass:[NSString class] completion:^(NSArray<__kindof id<NSItemProviderReading>> * _Nonnull objects) {
        NSArray *array = (NSArray *)objects;
        
        for (int i = 0; i < array.count; i++) {
            NSString *str = array[i];
            
            NSUInteger section = destinationIndexPath.section;
            NSUInteger row = destinationIndexPath.row + i;
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
            [[DADTableViewModel sharedInstance] addItem:str atIndex:indexPath.row];
            [indexPaths addObject:indexPath];
        }
        [tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[DADTableViewModel sharedInstance] getTableViewData].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:@"DADTableViewCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DADTableViewCell"];
    } else {
        cell.textLabel.text = @"";
    }
    
    cell.textLabel.text = [[DADTableViewModel sharedInstance] getTableViewData][indexPath.row];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    [[DADTableViewModel sharedInstance] replaceItemAtIndex:sourceIndexPath.row toIndex:destinationIndexPath.row];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
