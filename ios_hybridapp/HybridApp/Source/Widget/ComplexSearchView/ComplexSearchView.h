//
//  ComplexSearchView.h
//  SalesManager
//  此类位复合类型条件查询 ，自定义展示

//  Created by iOS-Dev on 2017/12/21.
//  Copyright © 2017年 yutang xu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PGDatePicker.h"

@protocol ComplexSearchDelegate <NSObject>


-(void)seacrchWithJsonArr:(NSMutableArray*)jsonMuarry;

@end

@interface ComplexSearchView : UIView<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,PGDatePickerDelegate>

//条件数据

@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)NSMutableArray *complexArray;
@property(nonatomic,assign) id<ComplexSearchDelegate> delegate;

-(instancetype)initWithFrame:(CGRect)frame WithArray:(NSMutableArray*)dataArray;

@end
