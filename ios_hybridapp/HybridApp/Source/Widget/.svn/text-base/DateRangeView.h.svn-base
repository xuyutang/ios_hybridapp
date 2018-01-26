//
//  DateRangeView.h
//  WPEducation
//
//  Created by iOS-Dev on 2018/1/3.
//  Copyright © 2018年 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DateRangeViewDelegate <NSObject>

-(void)choseStartTime;

-(void)choseEndTime;

-(void)submitWithStartDate:(NSString*)startDate andEndDate:(NSString*)endDate;

-(void)cancel;
@end

@interface DateRangeView : UIView

@property(nonatomic,assign) id<DateRangeViewDelegate> delegate;

@property (nonatomic ,strong) UILabel *startTimeLab;

@property (nonatomic ,strong) UILabel *endTimeLab;

@end
