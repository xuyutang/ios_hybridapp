//
//  ComplexSearchView.m
//  SalesManager
//
//  Created by iOS-Dev on 2017/12/21.
//  Copyright © 2017 yutang xu. All rights reserved.
//

#import "ComplexSearchView.h"
#import "DeviceConstant.h"
#import "TextViewCell.h"
#import "TextFieldCell.h"
#import "ComplexSearchModel.h"
#import "JSmodel.h"
#import "MJExtension.h"
#import "UIView+CNKit.h"


#define BackgroundColor [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.75]

@implementation ComplexSearchView {
    UITableView *tableView ;
    TextViewCell *textTextViewCell;
    TextViewCell *textDigtViewCell;
    TextFieldCell *dateSelectCell;
    int timeInt;
    int distance;
    NSString *dateType;

}

-(instancetype)initWithFrame:(CGRect)frame WithArray:(NSMutableArray*)dataArray {
 self =  [super initWithFrame:frame];
    if (self) {
        _dataArray = dataArray;
        [self CreateUI];
    }
    return self;
}

-(void)CreateUI {
    
    //测试数据
    NSMutableArray *array = [[NSMutableArray alloc]init];
    [array addObjectsFromArray:@[@{@"id":@1,@"name":@"文本  项",@"type":@"TEXT",@"sn":@1,@"allowNull":@false},
                                 
                                @{@"id":@7,@"name":@"数字",@"type":@"DIGITAL",@"sn":@"7",@"allowNull":@true},
                                 @{@"id":@8,@"name":@"日期",@"type":@"DATE",@"sn":@"8",@"allowNull":@true}
                                 ]];
    
    
    _complexArray = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in _dataArray) {
        ComplexSearchModel *model = [[ComplexSearchModel alloc] init];
        model.label = [dic objectForKey:@"label"] ;
        model.name = [dic objectForKey:@"name"];
       // model.sn = [[dic objectForKey:@"sn"] intValue];
        model.type = [dic objectForKey:@"type"];
        [_complexArray addObject:model];
    }
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAINWIDTH, MAINHEIGHT)];
    backgroundView.backgroundColor = BackgroundColor;

    [self addSubview:backgroundView];
    
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MAINWIDTH, _complexArray.count *70 + 20) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [backgroundView addSubview:tableView];
    
    //底部按钮
    //不超过屏幕的情况在表格下面  表格超过屏幕的高度 按钮在最底部
    CGFloat Y;
    CGFloat phoneHeight ;
    if (iPhoneX) {
        phoneHeight = SCREENHEIGHT - 64 - 64 -44;
    }else {
        phoneHeight = SCREENHEIGHT - 64;

    }
    if (_complexArray.count*70 > phoneHeight - 45 - 40 ) {
        Y = MAINHEIGHT - 45 - 40;
        tableView.height = MAINHEIGHT - 85;
        NSLog(@"11111");
    }else {
        Y = tableView.bottom;
        NSLog(@"2222");

    }
    UIButton *resetBut = [UIButton buttonWithType:UIButtonTypeCustom];
    resetBut.frame =CGRectMake(0, Y, MAINWIDTH/2, 45);
    resetBut.backgroundColor = [UIColor colorWithHexString:@"#c0c0c0"];
    resetBut.titleLabel.font = [UIFont systemFontOfSize:15];
    [resetBut setTitle:@"重置" forState:UIControlStateNormal];
    [resetBut setTintColor:[UIColor whiteColor]];
    [resetBut addTarget:self action:@selector(resetAction) forControlEvents:UIControlEventTouchUpInside];
            [backgroundView addSubview:resetBut];
    
   UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeSystem];
   searchBtn.frame =CGRectMake(MAINWIDTH/2, Y, MAINWIDTH/2, 45);
   searchBtn.backgroundColor = [UIColor colorWithHexString:MAIN_COLOR];
   [searchBtn setTitle:@"查询" forState:UIControlStateNormal];
   searchBtn.titleLabel.font = [UIFont systemFontOfSize:15];
   [searchBtn setTintColor:[UIColor whiteColor]];
   [searchBtn addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    
    [backgroundView addSubview:searchBtn];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _complexArray.count;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ComplexSearchModel* model  = _complexArray[indexPath.section];
    if ([model.type isEqualToString:@"TEXT"] ) {
        textTextViewCell = [[TextViewCell alloc] init];
        textTextViewCell.textView.tag = indexPath.section+1000;
        textTextViewCell.textView.delegate = self;
        textTextViewCell.textView.frame = CGRectMake(15, 0, MAINWIDTH -30 , 30);
        textTextViewCell.textView.textColor = [UIColor grayColor];
        textTextViewCell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        
        if (textTextViewCell != nil && model.textString.length != 0) {
            textTextViewCell.textView.text =  model.textString ;
        }
        [textTextViewCell addSubview:[self setView]];
        return textTextViewCell;
    }
    
    //数字类型
    if ([model.type isEqualToString:@"DIGITAL"]) {
        textDigtViewCell = [[TextViewCell alloc] init];
        textDigtViewCell.textView.delegate = self;
        textDigtViewCell.textView.scrollEnabled = NO;
        textDigtViewCell.textView.tag = indexPath.section + 1000;
        textDigtViewCell.textView.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        textDigtViewCell.selectionStyle=UITableViewCellSelectionStyleNone;
        textDigtViewCell.textView.frame =  CGRectMake(15, 0, MAINWIDTH - 30,30);
        textDigtViewCell.textView.textColor = [UIColor grayColor];
        
        if (textDigtViewCell != nil && model.textString.length != 0) {
            textDigtViewCell.textView.text = model.textString;
        }
        [textDigtViewCell addSubview:[self setView]];
        return textDigtViewCell;
    }
    
    //时间选择类型
    if ([model.type isEqualToString:@"DATE"]) {
        
        dateSelectCell = (TextFieldCell *)[tableView dequeueReusableCellWithIdentifier:@"TextFieldCell"];
        if (dateSelectCell == nil) {
            NSArray *nib=[[NSBundle mainBundle] loadNibNamed:@"TextFieldCell" owner:self options:nil];
            for (id oneObject in nib) {
                if ([oneObject isKindOfClass:[TextFieldCell class]]) {
                    dateSelectCell = (TextFieldCell *)oneObject;
                }
            }
            
            dateSelectCell.txtField.editable = NO;
            dateSelectCell.selectionStyle = UITableViewCellSelectionStyleNone;
            dateSelectCell.tag = 1000 + indexPath.section;
            dateSelectCell.txtField.delegate = self;
            UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
            [tapGesture1 setNumberOfTapsRequired:1];
            dateSelectCell.userInteractionEnabled = YES;
            [dateSelectCell addGestureRecognizer:tapGesture1];
           // dateSelectCell.txtField.text = @"长按选择框可以清空";
            dateSelectCell.txtField.font = [UIFont systemFontOfSize:10];
            dateSelectCell.txtField.textColor = [UIColor grayColor];
            dateSelectCell.title.frame = CGRectMake(20, 0, MAINWIDTH, 30);
            dateSelectCell.title.textColor = [UIColor grayColor];
            dateSelectCell.title.font = [UIFont systemFontOfSize:12];
            
            UILongPressGestureRecognizer * longPressGr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressDate:)];
            longPressGr.minimumPressDuration = 1.0;
            dateSelectCell.userInteractionEnabled = YES;
            [dateSelectCell addGestureRecognizer:longPressGr];
            
            [dateSelectCell.txtField setFrame:CGRectMake(15, 25, MAINWIDTH, 30)];
        }
        
        if ( dateSelectCell != nil && model.signTime.length != 0){
            dateSelectCell.title.text  = model.signTime;
        }else {
            dateSelectCell.title.text  = @"";

        }
        
        [dateSelectCell addSubview:[self setDateView]];
        return dateSelectCell;
    }
    
    return nil;
    
}

#pragma mark heightForHeaderInSection
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectio {
    return 30;
}

#pragma mark viewForHeaderInSection
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ComplexSearchModel *model = _complexArray[section];
    UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MAINWIDTH, 30)];
    contentView.backgroundColor = [UIColor whiteColor];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 1, MAINWIDTH, 29)];
    titleLabel.text =[NSString stringWithFormat:@"    %@",model.label];
    titleLabel.font = [UIFont systemFontOfSize:14];
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 1, MAINWIDTH, 0.5)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [contentView addSubview:titleLabel];
    //[contentView addSubview:lineView];
    return contentView;
}

-(void)backgroundViewTap {
    [self removeFromSuperview];

}

-(void)resetAction {
    
    [_complexArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ComplexSearchModel *model = [[ComplexSearchModel alloc] init];
        model = _complexArray[idx];
        model.signTime = @"";
        model.textString = @"";
    }];
    [tableView reloadData];
    
}

-(void)searchAction {
    [self removeFromSuperview];
    //json 数据组装
    NSMutableArray *complexJonnArray = [[NSMutableArray alloc] init];
    [_complexArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ComplexSearchModel *complexModel = _complexArray[idx];
        JSmodel *model = [[JSmodel alloc] init];
        model.fieldLabel = complexModel.label;
        model.fieldName = complexModel.name;
        if ([complexModel.type isEqualToString:@"DATE"]) {
            model.value = complexModel.signTime;
       } else {
            model.value = complexModel.textString;

        }
        if (model.value.length) {
           [complexJonnArray addObject:[model mj_JSONObject]];

        }
    }];
    NSLog(@"%@++++++++",complexJonnArray);

    if (self.delegate && [self.delegate respondsToSelector:@selector(seacrchWithJsonArr:)]) {
        [self.delegate seacrchWithJsonArr:complexJonnArray];
    }
    
}

#pragma mark 时间选择
-(void)tapAction:(UITapGestureRecognizer*)tap {
    [self endEditing:YES];
    timeInt = tap.view.tag - 1000;
    PGDatePicker *datePicker = [[PGDatePicker alloc]init];
    datePicker.delegate = self;
    [datePicker show];
    datePicker.datePickerType = PGPickerViewType3;
    datePicker.isHiddenMiddleText = false;
    datePicker.datePickerMode = [self selectDateType];
    
    datePicker.minimumDate = [NSDate setYear:2015 month:9 day:30];
    datePicker.maximumDate = [NSDate setYear:2027 month:10 day:2];
}

#pragma mark 时间选择器类型
-(PGDatePickerMode)selectDateType {
    //年月日
    if ([dateType isEqualToString:@"yyyy-MM-dd"] || [dateType isEqualToString:@"yyyy/MM/dd"]) {
        NSLog(@"年月日");
        return  PGDatePickerModeDate;
    }
    //年月
    if ([dateType isEqualToString:@"yyyy-MM"] || [dateType isEqualToString:@"yyyy/MM"] ) {
        NSLog(@"年月");
        return PGDatePickerModeDate;
    }
    //年月日时分
    if ([dateType isEqualToString:@"yyyy-MM-dd HH:mm"] || [dateType isEqualToString:@"yyyy/MM/dd HH:mm"] ) {
        NSLog(@"年月日时分");
        return PGDatePickerModeDateHourMinute;
    }
    //月日
    if ([dateType isEqualToString:@"MM-dd"] || [dateType isEqualToString:@"MM/dd"] ) {
        NSLog(@"月日");
        return PGDatePickerModeDate;
    }
    
    //月日时分
    if ([dateType isEqualToString:@"MM-dd HH:mm"] || [dateType isEqualToString:@"MM/dd HH:mm"] ) {
        NSLog(@"月日时分");
        return PGDatePickerModeDateHourMinute;
    }
    //时分
    if ([dateType isEqualToString:@"HH:mm"]) {
        NSLog(@"时分");
        return PGDatePickerModeTime;
    }
    
    
    return PGDatePickerModeDateHourMinute;
}

#pragma mark PGDatePickerdelegate
-(void)datePicker:(PGDatePicker *)datePicker didSelectDate:(NSDateComponents *)dateComponents {
    NSLog(@"dateComponents ====== %@",dateComponents);
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSDate * date = [calendar dateFromComponents:dateComponents];
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    //默认格式
    dateType = @"yyyy-MM-dd HH:mm";
    formatter.dateFormat = dateType;
    NSString * selectDateString = [formatter stringFromDate:date];
    ComplexSearchModel * model = _complexArray[timeInt];
    model.signTime = selectDateString;
    
    [tableView reloadData];
}

#pragma mark 长按删除已选择时间
-(void)longPressDate:(UILongPressGestureRecognizer*)tap {
    ComplexSearchModel *model = _complexArray[tap.view.tag - 1000];
    model.signTime = nil;
    [tableView reloadData];
    
}

-(UIView*)setView {
    UIView *contView = [[UIView alloc] initWithFrame:CGRectMake(0, 14, MAINWIDTH - 100, 20)];
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(20, 10, 0.5, 5)];
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(20, 15, MAINWIDTH - 40, 0.4)];
    UIView *view3 = [[UIView alloc]initWithFrame:CGRectMake(MAINWIDTH - 20 - 0.5, 10, 0.5, 5)];
    view1.backgroundColor = [UIColor grayColor];
    view2.backgroundColor = [UIColor grayColor];
    view3.backgroundColor = [UIColor grayColor];
    [contView addSubview:view1];
    [contView addSubview:view2];
    [contView addSubview:view3];
    contView.userInteractionEnabled = NO;
    return contView;
}

-(UIView*)setDateView {
    UIView *contView = [[UIView alloc] initWithFrame:CGRectMake(0, 14, MAINWIDTH - 100, 40)];
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(20, 10, 0.5, 5)];
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(20, 15, MAINWIDTH - 40, 0.4)];
    UIView *view3 = [[UIView alloc]initWithFrame:CGRectMake(MAINWIDTH - 20 - 0.5, 10, 0.5, 5)];
    view1.backgroundColor = [UIColor grayColor];
    view2.backgroundColor = [UIColor grayColor];
    view3.backgroundColor = [UIColor grayColor];
    
    [contView addSubview:view1];
    [contView addSubview:view2];
    [contView addSubview:view3];
    return contView;
}

#pragma mark  ---- textViewDelegate
-(void)textViewDidBeginEditing:(UITextView *)textView {
    
}

-(void)textViewDidEndEditing:(UITextView *)textView {
    ComplexSearchModel *model = _complexArray[textView.tag - 1000];
    if (textView.text.length) {
        model.textString = textView.text;
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
