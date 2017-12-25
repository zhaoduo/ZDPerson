//
//  DMCommunityDetailHeaderView.m
//  DMRice
//
//  Created by zdd. on 17/4/10.
//  Copyright zdd. All rights reserved.
//

#import "ZDPersonHeaderView.h"
@interface ZDPersonHeaderView ()
{
    BOOL testHits;
}

@property (nonatomic, strong)UILabel            *nameLabel;

//- (BOOL)isPassthroughView:(UIView *)view;

@end

@implementation ZDPersonHeaderView


- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.backgroundImageView];
        [self addSubview:self.nameLabel];
        [self addSubview:self.selectMenuView];
    }
    return self;
}

-(void)setSelectIndex:(NSInteger)selectIndex{
    _selectIndex = selectIndex;
    [self.selectMenuView switchSelectButtonWithIndex:selectIndex];
}
//重写view的touch事件
-(UIView*) hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    if(testHits){
        return nil;
    }
    
    if(!self.passthroughViews
       || (self.passthroughViews && self.passthroughViews.count == 0)){
        return self;
    } else {
        
        UIView *hitView = [super hitTest:point withEvent:event];
        
        if (hitView == self) {
            //Test whether any of the passthrough views would handle this touch
            testHits = YES;
            CGPoint superPoint = [self.superview convertPoint:point fromView:self];
            UIView *superHitView = [self.superview hitTest:superPoint withEvent:event];
            testHits = NO;
            
            if ([self isPassthroughView:superHitView]) {
                hitView = superHitView;
            }
        }
        return hitView;
    }
}
//是否获取到当前view的穿透视图
- (BOOL)isPassthroughView:(UIView *)view {
    
    if (view == nil) {
        return NO;
    }
    
    if ([self.passthroughViews containsObject:view]) {
        return YES;
    }
    
    return [self isPassthroughView:view.superview];
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
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 40, 20)];
        _nameLabel.font = [UIFont systemFontOfSize:20.0f];
        _nameLabel.textColor = [UIColor whiteColor];
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
