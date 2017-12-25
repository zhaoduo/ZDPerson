//
//  ZDSecondViewController.m
//  ZDPerson
//
//  Created by zdd. on 2017/8/26.
//  Copyright © 2017年 zdd. All rights reserved.
//

#import "ZDSecondViewController.h"

@interface ZDSecondViewController ()

@end

@implementation ZDSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.tag = 1001;
    
}
-(void)setContentOffset:(CGFloat)Offset withTag:(NSInteger)tag{
    if (tag != self.tableView.tag) {
        [self.tableView setContentOffset:CGPointMake(0, Offset) animated:YES];
        if (Offset > HEADERVIEW_HEIGHT - 64 - 44) {
            [self.tableView setContentOffset:CGPointMake(0, HEADERVIEW_HEIGHT - 64 - 44) animated:YES];
        }
        if (Offset <= 0) {
            [self.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifer = @"CELL";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"黄%ld",indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
