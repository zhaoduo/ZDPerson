//
//  DMCommunityDetailHeaderView.m
//  DMRice
//
//  Created by zdd. on 17/4/10.
//  Copyright zdd. All rights reserved.
//

#import "ZDPersonHeaderView.h"
@interface ZDPersonHeaderView ()

@property (nonatomic, strong)UILabel            *nameLabel;

@end

@implementation ZDPersonHeaderView


- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
//        self.clipsToBounds = YES;
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.backgroundImageView];
        
//        [self addSubview:self.iconImageView];
    
        [self addSubview:self.nameLabel];
        
        
        [self addSubview:self.selectMenuView];
        
    }
    return self;
}

-(void)setSelectIndex:(NSInteger)selectIndex{
    _selectIndex = selectIndex;
    
    [self.selectMenuView switchSelectButtonWithIndex:selectIndex];
}
#pragma mark - Setter and getter
-(UIImageView *)backgroundImageView{
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.height)];
        _backgroundImageView.clipsToBounds = YES;
        _backgroundImageView.contentMode = UIViewContentModeScaleToFill;
        _backgroundImageView.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:0.50];
        _backgroundImageView.image = [UIImage imageNamed:@"header.jpg"];

    }
    return _backgroundImageView ;
}

- (UIImageView *)iconImageView{
    if (!_iconImageView) {
        
        CGFloat leftMargin = 20 ;
        CGFloat topMargin = 15;
        
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(leftMargin , topMargin, 70, 70)];
        _iconImageView.backgroundColor = [UIColor redColor];
        _iconImageView.layer.cornerRadius = 2;
        _iconImageView.layer.masksToBounds = YES;
    }
    return _iconImageView;
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.iconImageView.maxX + 20, self.iconImageView.y, SCREEN_WIDTH - self.iconImageView.maxX - 20 - 20, 20)];
        _nameLabel.font = [UIFont systemFontOfSize:20.0f];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.numberOfLines = 0;
        _nameLabel.center = self.center;
        _nameLabel.text = @"麦卡特尼";
    }
    return _nameLabel;
}
-(ZDSelectMenuView *)selectMenuView{
    if (!_selectMenuView) {
        _selectMenuView = [[ZDSelectMenuView alloc] initWithFrame:CGRectMake(0, self.height - 44, SCREEN_WIDTH, 44) titleArr:@[@"最热",@"最新",@"最时尚"] imageArr:nil];
        _selectMenuView.lineHeight = 4;
//        _selectMenuView.centerX = self.centerX;
        _selectMenuView.showShadowLabelHidde = YES;
        __weak typeof(self) weakSelf = self;
        [_selectMenuView selectBtn:^(NSInteger index) {
            if ([weakSelf.delegate respondsToSelector:@selector(personHeaderView:didSelectItemAtIndex:)]) {
                [weakSelf.delegate personHeaderView:weakSelf didSelectItemAtIndex:index];
            }
        }];
    }
    return _selectMenuView;
}
@end
