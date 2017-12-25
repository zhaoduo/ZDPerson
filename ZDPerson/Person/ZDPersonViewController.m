//
//  ZDPersonViewController.m
//  ZDPerson
//
//  Created by zdd. on 2017/8/26.
//  Copyright © 2017年 zdd. All rights reserved.
//

#import "ZDPersonViewController.h"
#import "ZDTableViewController.h"
#import "ZDFirstViewController.h"
#import "ZDSecondViewController.h"
#import "ZDThreeViewController.h"
#import "ZDPersonHeaderView.h"
@interface ZDPersonViewController ()
<
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    ZDTableViewDelegate,
    ZDPersonHeaderViewDelegate,
    UIScrollViewDelegate
>
{
    ZDFirstViewController       *_vc1;
    ZDSecondViewController      *_vc2;
    ZDThreeViewController       *_vc3;
    NSInteger                   _selectedTag;
    UILabel                     *_titleLabel;
}

@property (nonatomic, strong)UICollectionView       *collectionView;

@property (nonatomic, strong)ZDPersonHeaderView     *headerView;

@property (nonatomic, strong)UINavigationBar       *navigationView;

@property (nonatomic, strong)UIImageView            *bgImageView;

@end
static NSString *identifer = @"CELL";
@implementation ZDPersonViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor whiteColor];
    
    _vc1 = [[ZDFirstViewController alloc] init];
    
    _vc1.scrollViewDelegate = self;
    
    _vc2 = [[ZDSecondViewController alloc] init];
    
    _vc2.scrollViewDelegate = self;
    
    _vc3 = [[ZDThreeViewController alloc] init];
    
    _vc3.scrollViewDelegate =self;
    
    
    _selectedTag = _vc1.tableView.tag;
    
    [self addChildViewController:_vc1];
    
    [self addChildViewController:_vc2];
    
    [self addChildViewController:_vc3];
    
    [self.view addSubview:self.collectionView];
    
    [self.view addSubview:self.headerView];
    
    [self.view addSubview:self.navigationView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}
#pragma mark - ZDPersonHeaderViewDelegate
-(void)personHeaderView:(ZDPersonHeaderView *)communityDetailHeaderView didSelectItemAtIndex:(NSInteger)index{
    _selectedTag = 1000 + index;
    
     [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    CGFloat offetX = scrollView.contentOffset.x;
    if (scrollView == self.collectionView) {
        
        NSLog(@"__________拖拽结束________%f",offetX);
        
        if (offetX == 0) {
            
            self.headerView.selectIndex = 0;
            
            
        }else if(offetX == SCREEN_WIDTH){
            
            self.headerView.selectIndex = 1;
            
        }else{
            self.headerView.selectIndex = 2;
        }
        
        _selectedTag = self.headerView.selectIndex + 1000;
    }
}

#pragma mark - ZDTableViewDelegate
- (void)tableViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView.tag != _selectedTag) {
        return;
    }
    
    CGFloat offetY = scrollView.contentOffset.y;
    NSLog(@"_________偏移量——————————%f******  -%ld",offetY,scrollView.tag);
    
    [_vc1 setContentOffset:offetY withTag:scrollView.tag];
    
    [_vc2 setContentOffset:offetY withTag:scrollView.tag];
    
    [_vc3 setContentOffset:offetY withTag:scrollView.tag];
    
    
    CGFloat tempHeight = HEADERVIEW_HEIGHT - 64 - 44;
    
    //上移
    if(offetY <= tempHeight){
        CGRect frame = self.headerView.frame;
        CGFloat y = -scrollView.contentOffset.y;
        frame.origin.y = y;
        self.headerView.frame = frame;
    }else{
        
        CGRect frame = self.headerView.frame;
        CGFloat y = -tempHeight;
        frame.origin.y = y;
        self.headerView.frame = frame;
        
    }
    
    if(offetY >= tempHeight){
        
        self.bgImageView.hidden = NO;
        _titleLabel.text = @"麦卡特尼";
        
    }else{
        
        self.bgImageView.hidden = YES;
        _titleLabel.text = @"";
        
    }
    
    //小于0时下拉放大
    if (offetY < 0) {
        //刷新头部
        CGRect rect = self.headerView.backgroundImageView.frame;;
        rect.origin.y = offetY;
        rect.size.height = -offetY + HEADERVIEW_HEIGHT;
        
        self.headerView.backgroundImageView.frame = rect;
    }

}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return [[self childViewControllers] count];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifer forIndexPath:indexPath];
    if (!cell) {
        cell = [[UICollectionViewCell alloc] init];
    }
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    ZDTableViewController *vc = self.childViewControllers[indexPath.row];
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    [cell.contentView addSubview:vc.view];
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}
#pragma mark -懒加载
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout =[[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:layout];

        _collectionView.backgroundColor = [UIColor whiteColor];
        layout.itemSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
        _collectionView.pagingEnabled = YES;
        _collectionView.delegate = self;
        _collectionView.dataSource =self;
        _collectionView.bounces = NO;
        _collectionView.allowsSelection = NO;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identifer];
    }
    return _collectionView;
}
-(ZDPersonHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[ZDPersonHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEADERVIEW_HEIGHT)];
        _headerView.delegate = self;
        //获取穿透view的数量
        _headerView.passthroughViews = [NSArray arrayWithObject:self.collectionView];
    }
    return _headerView;
}
-(UINavigationBar *)navigationView{
    if (!_navigationView) {
        _navigationView = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
        
        [_navigationView addSubview:self.bgImageView];
        [_navigationView setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        _navigationView.shadowImage = [UIImage new];
        
        UINavigationItem *item = [[UINavigationItem alloc] init];
        item.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
        
        item.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
        
        _navigationView.tintColor = [UIColor whiteColor];
        //标题
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 20, SCREEN_WIDTH - 40 * 2, 44)];
        titleLabel.font = [UIFont systemFontOfSize:17];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [UIColor whiteColor];
        
        _titleLabel = titleLabel;
        [_navigationView addSubview:titleLabel];
        _navigationView.items = @[item];
    }
    return _navigationView;
}
-(UIImageView *)bgImageView{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
        _bgImageView.backgroundColor = [UIColor blueColor];
        _bgImageView.hidden = YES;
    }
    return _bgImageView;
}

@end
