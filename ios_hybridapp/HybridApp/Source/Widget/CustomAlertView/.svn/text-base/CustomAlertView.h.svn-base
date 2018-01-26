//
//  CustomAlertView.h
//  JSAndApp
//
//  Created by DiorSama on 2017/7/5.
//  Copyright © 2017年 Shane. All rights reserved.
//
#define ViewMaxY(v) CGRectGetMaxY(v.frame)

#import <UIKit/UIKit.h>

@protocol ConfirmSureBtnDelegate <NSObject>

-(void)confirmSureBtBtnClickWithBlock:(NSString*)block withTag:(NSInteger)tag;

@end

typedef void(^btnClickBlock)(NSInteger index,NSString * callback);

@interface CustomAlertView : UIView

- (instancetype) initWithFrame:(CGRect)frame WithData:(id)data isAlert:(BOOL)isAlert;
@property (nonatomic,copy) btnClickBlock block;
@property (nonatomic,weak)id<ConfirmSureBtnDelegate>delegate;

-(void)aletBtnClickWithBlock:(btnClickBlock)block;

@end
