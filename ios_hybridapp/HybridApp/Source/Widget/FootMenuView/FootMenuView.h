//
//  FootMenuView.h
//  SalesManager
//
//  Created by iOS-Dev on 2017/12/14.
//  Copyright © 2017年 yutang xu. All rights reserved.
//

#import <UIKit/UIKit.h>
#define WT_BLACK [UIColor blackColor]
#define WT_RED [UIColor redColor]

@protocol FootMenuViewDelegate <NSObject>

-(void) FootMenuViewClickBtn:(int) index current:(int) current;

@end

@interface FootMenuView : UIView
//搜索导航控件

@property (nonatomic,assign) int currentIndex;

@property (nonatomic,retain) NSArray* defaultIcons;
@property (nonatomic,retain) NSArray* activeIcons;

@property (nonatomic,retain) NSArray* titles;

@property (nonatomic,retain) NSMutableArray* buttons;
@property (nonatomic,retain) NSMutableArray* lables;

@property (nonatomic,assign) NSInteger badgeIndex;
@property (nonatomic,assign) NSInteger badgeNumber;
@property (nonatomic,strong)  UILabel *bagesLabel;
@property (nonatomic,assign) id<FootMenuViewDelegate> delegate;

-(void)setColor:(int) index;

-(instancetype)initWithFrame:(CGRect)frame titleArray:(NSMutableArray*)titleArray anddefaultImagArray:(NSMutableArray*)defaultImagArray andActive:(NSMutableArray *)activeImaArray delegate:(id)delegate;

-(void)setbadge;

@end

