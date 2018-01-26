//
//  DropMenu.h
//  SalesManager
//
//  Created by liuxueyan on 15-5-19.
//  Copyright (c) 2015年 liu xueyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SingleDropMenuDelegate <NSObject>

@optional

-(void)selectedSingleDropMenu:(NSObject*)obj;

@end

@interface SingleDropMenu : UIView<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,retain) NSMutableArray *dataList;
@property(nonatomic,retain) UITableView *listView;

@property(nonatomic,assign) id<SingleDropMenuDelegate> delegate;

-(void)initMenu;
@end

