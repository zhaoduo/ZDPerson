//
//  LXSelectMenuView.h
//  CFZhaoduo
//
//  Created by zdd. on 16/10/12.
//  Copyright © 2016年 zdd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZDSelectMenuView : UIView

- (instancetype)initWithFrame:(CGRect)frame titleArr:(NSArray *)titleArr imageArr:(NSArray *)imageArr;
//点击回调
- (void)selectBtn:(void(^)(NSInteger index))callBackBtn;

//设置
- (void)switchSelectButtonWithIndex:(NSInteger) selectIndex;

@property (nonatomic,assign) NSInteger selectIndex;
//

//底部滚动线的高度
@property (nonatomic, assign)CGFloat        lineHeight;

//底部滚动线的颜色
@property (nonatomic, strong)UIColor        *lineColor;

//底部线的显隐性
@property (nonatomic, assign)BOOL           showShadowLabelHidde;

//文字选中色
@property (nonatomic, strong)UIColor        *selectTextColor;

//文字未选中色
@property (nonatomic, strong)UIColor        *unSelectTextColor;

//设置底部线的隐藏
@property (nonatomic, assign)BOOL           showLineHidde;

//从新赋值标题
@property (nonatomic, strong)NSArray        *titleArr;

//滚动线的宽度
@property (nonatomic, assign)CGFloat        lineWidth;
@end
