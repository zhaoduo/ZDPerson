//
//  DMCommunityDetailHeaderView.h
//  DMRice
//
//  Created by zdd. on 17/4/10.
//  Copyright © zdd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZDSelectMenuView.h"

@class ZDPersonHeaderView;
@protocol ZDPersonHeaderViewDelegate <NSObject>
//点击菜单
-(void)personHeaderView:(ZDPersonHeaderView *)communityDetailHeaderView didSelectItemAtIndex:(NSInteger)index;

@end

@interface ZDPersonHeaderView : UIView

@property (nonatomic, strong)ZDSelectMenuView   *selectMenuView;//菜单

@property (nonatomic, weak)id <ZDPersonHeaderViewDelegate> delegate;

//@property (nonatomic, strong)DMCommunity            *community;

@property (nonatomic, strong)UIImageView            *backgroundImageView;

@property (nonatomic, strong)UIImageView            *iconImageView;

@property (nonatomic, assign)NSInteger              selectIndex; //菜单下表


//-1未关注 0正常关注 1绑定社区 2社区黑名单 3管理员
@property (nonatomic, assign)NSInteger              isJoin;
@end
