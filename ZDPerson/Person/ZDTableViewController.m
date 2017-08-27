//
//  ZDTableViewController.m
//  ZDPerson
//
//  Created by zdd. on 2017/8/26.
//  Copyright © 2017年 zdd. All rights reserved.
//

#import "ZDTableViewController.h"

@interface ZDTableViewController ()

@end

@implementation ZDTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    
    //每一个tableView头部初始化一个占位view
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEADERVIEW_HEIGHT)];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setContentOffset:(CGFloat)Offset withTag:(NSInteger)tag{
    
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if([self.scrollViewDelegate respondsToSelector:@selector(tableViewDidScroll:)])
    {
        [self.scrollViewDelegate tableViewDidScroll:scrollView];
    }
}

@end
