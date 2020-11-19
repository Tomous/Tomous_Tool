//
//  DCBaseTableViewController.m
//  Tomous_Tool
//
//  Created by Tomous on 2020/11/19.
//

#import "DCBaseTableViewController.h"

@interface DCBaseTableViewController ()

@end

@implementation DCBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = DCCommonBgColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(35, 0, 0, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
}

@end
