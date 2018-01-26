//
//  DateRangeView.m
//  WPEducation
//
//  Created by iOS-Dev on 2018/1/3.
//  Copyright © 2018年 Administrator. All rights reserved.
//

#import "DateRangeView.h"
#import "DeviceConstant.h"
#import "UIView+CNKit.h"


@implementation DateRangeView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshUI:) name:@"refshSelectTime" object:nil];
        [self CreateUI];
    }
    return self;
}

-(void)refreshUI:(NSNotification*)noti {
    if ([[noti.object objectForKey:@"tag"] intValue] == 1000) {
        _startTimeLab.text = [noti.object objectForKey:@"selectDate"];

    }else {
        _endTimeLab.text = [noti.object objectForKey:@"selectDate"];

    }
    
}

#pragma mark CreateUI
-(void)CreateUI {
    UIView *contentView = [[UIView alloc] initWithFrame:self.frame];
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:contentView];
    
    UILabel *startLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 25, 65, 40)];
    startLabel.text = @"开始日期";
    startLabel.font = [UIFont systemFontOfSize:15];
    [contentView addSubview:startLabel];
    
    _startTimeLab = [[UILabel alloc] initWithFrame:CGRectMake(startLabel.x + startLabel.width, 25, self.width - startLabel.x - startLabel.width - 20, 30)];
    _startTimeLab.textAlignment = 1;
    [contentView addSubview:_startTimeLab];
    _startTimeLab.userInteractionEnabled = YES;
    [_startTimeLab addActionWithTarget:self action:@selector(choseStartTime)];
    [contentView addSubview:[self lineViewWithHeight:_startTimeLab.bottom]]
    ;
    
     UILabel* endLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, startLabel.bottom + 20, 65, 40)];
    endLabel.text = @"结束日期";
    endLabel.font = [UIFont systemFontOfSize:15];

    [contentView addSubview:endLabel];
    
    
    _endTimeLab = [[UILabel alloc] initWithFrame:CGRectMake(startLabel.x + startLabel.width, endLabel.y, self.width - startLabel.x - startLabel.width - 20, 30)];
    _endTimeLab.textAlignment = 1;
    _endTimeLab.userInteractionEnabled = YES;

    [_endTimeLab addActionWithTarget:self action:@selector(choseEndTime)];
    [contentView addSubview:_endTimeLab];
    
    [contentView addSubview:[self lineViewWithHeight:_endTimeLab.bottom]];

    //底部按钮
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(-15, contentView.height - 50, self.width, 50)];
    bottomView.backgroundColor = [UIColor redColor];
    [contentView addSubview:bottomView];
    
    UIButton *resetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    resetBtn.frame = CGRectMake(0, contentView.y, bottomView.width/2, bottomView.height);
    [resetBtn setTitle:@"取消" forState:UIControlStateNormal];
    resetBtn.backgroundColor = [UIColor lightGrayColor];
    [resetBtn addTarget:self action:@selector(reset) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:resetBtn];
    
    UIButton *selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    selectBtn.frame = CGRectMake(bottomView.width/2, contentView.y, bottomView.width/2, bottomView.height);
    [selectBtn setTitle:@"确定" forState:UIControlStateNormal];
    selectBtn.backgroundColor = MainColor;
    [selectBtn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:selectBtn];
    
    
}

-(void)choseStartTime {
    NSLog(@"选择开始时间");
    if([self.delegate respondsToSelector:@selector(choseStartTime)]){
        [self.delegate choseStartTime];
    }
    
}

-(void)choseEndTime {
    NSLog(@"选择结束时间");
    if([self.delegate respondsToSelector:@selector(choseEndTime)]){
        [self.delegate choseEndTime];
    }
    
}

-(void)reset {
    if ([self.delegate respondsToSelector:@selector(cancel)]) {
        [self.delegate cancel];
    }
//    _startTimeLab.text = @"";
//    _endTimeLab.text = @"";
    
}

-(void)submit {
    if([self.delegate respondsToSelector:@selector(submitWithStartDate:andEndDate:)]){
        [self.delegate submitWithStartDate:[NSString stringWithFormat:@"%@",_startTimeLab.text] andEndDate:[NSString stringWithFormat:@"%@",_endTimeLab.text]];
    }
    
}

-(UIView*)lineViewWithHeight:(CGFloat)height {
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(80, height, self.width - 80 - 30, 1)];
    lineView.backgroundColor = [UIColor grayColor];
    
    return lineView;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}


@end
