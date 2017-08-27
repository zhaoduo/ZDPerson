//
//  ZDMianViewController.m
//  ZDPerson
//
//  Created by zdd. on 2017/8/26.
//  Copyright © 2017年 zdd. All rights reserved.
//

#import "ZDMianViewController.h"
#import "ZDPersonViewController.h"
@interface ZDMianViewController ()

@end

@implementation ZDMianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
    
    [btn setTitle:@"个人主页" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
    [btn sizeToFit];
    btn.center = CGPointMake(SCREEN_WIDTH * 0.5, SCREEN_HEIGHT * 0.5);
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
}
- (void)click{
    
    ZDPersonViewController *personVC = [[ZDPersonViewController alloc] init];
    [self.navigationController pushViewController:personVC animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
