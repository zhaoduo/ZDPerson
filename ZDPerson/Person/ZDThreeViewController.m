//
//  ZDThreeViewController.m
//  ZDPerson
//
//  Created by zdd. on 2017/8/26.
//  Copyright © 2017年 zdd. All rights reserved.
//

#import "ZDThreeViewController.h"

@interface ZDThreeViewController ()

@end

@implementation ZDThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView.tag = 1002;
}
-(void)setContentOffset:(CGFloat)Offset withTag:(NSInteger)tag{
    if (tag != self.tableView.tag) {
        
        CGFloat currentOffetY = self.tableView.contentOffset.y;
        
        if (Offset > HEADERVIEW_HEIGHT - 64 - 44) {
            
            if (currentOffetY < HEADERVIEW_HEIGHT - 64 - 44) {
                
                [self.tableView setContentOffset:CGPointMake(0, HEADERVIEW_HEIGHT - 64 - 44) animated:YES];
            }
            
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
    cell.textLabel.text = [NSString stringWithFormat:@"蓝%ld",indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
