//
//  MBProgressHUD+Util.m
//  HybridApp
//
//  Created by lzhang@juicyshare.cc on 2018/1/22.
//  Copyright © 2018年 Juicyshare Co.,Ltd. All rights reserved.
//

#import "MBProgressHUD+Util.h"
#import "DeviceConstant.h"

#define kHUDSize CGSizeMake(120.f, 100.f)

@implementation MBProgressHUD (Util)

#pragma mark 显示错误信息
+ (void)showError:(NSString *)error ToView:(UIView *)view{
    [self showCustomIcon:@"MBHUD_Error" Title:error ToView:view];
}

+ (void)showSuccess:(NSString *)success ToView:(UIView *)view
{
    [self showCustomIcon:@"MBHUD_Success" Title:success ToView:view];
}

+ (void)showInfo:(NSString *)Info ToView:(UIView *)view
{
    [self showCustomIcon:@"MBHUD_Info" Title:Info ToView:view];
}

+ (void)showWarn:(NSString *)Warn ToView:(UIView *)view
{
    [self showCustomIcon:@"MBHUD_Warn" Title:Warn ToView:view];
}

#pragma mark 显示一些信息
+ (MBProgressHUD *)showMessage:(NSString *)message ToView:(UIView *)view {
    if (view == nil) view = (UIView*)[UIApplication sharedApplication].delegate.window;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode=MBProgressHUDModeIndeterminate;
    // 设置背景框的背景颜色和透明度， 设置背景颜色之后opacity属性的设置将会失效
    hud.bezelView.color = [UIColor blackColor];
    hud.bezelView.color = [hud.bezelView.color colorWithAlphaComponent:1.0];
    // 设置背景框的圆角值，默认是10
    //hud.cornerRadius = 20.0;
    hud.label.text=message;
    hud.label.font=CHINESE_SYSTEM(15);
    hud.label.textColor = [UIColor whiteColor];
    hud.minSize = kHUDSize;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    //代表需要蒙版效果
    
    hud.dimBackground = YES;
    
    //设置菊花框为白色
    [UIActivityIndicatorView appearanceWhenContainedIn:[MBProgressHUD class], nil].color = [UIColor whiteColor];
    
    return hud;
}

//加载视图
+(void)showLoadToView:(UIView *)view{
    [self showMessage:@"" ToView:view];
}


/**
 *  进度条View
 */
+ (MBProgressHUD *)showProgressToView:(UIView *)view Text:(NSString *)text{
    if (view == nil) view = (UIView*)[UIApplication sharedApplication].delegate.window;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text=text;
    hud.label.font=CHINESE_SYSTEM(15);
    // 代表需要蒙版效果
    hud.dimBackground = YES;
    return hud;
}


//快速显示一条提示信息
+ (void)showAutoMessage:(NSString *)message{
    
    [self showAutoMessage:message ToView:nil];
}


//自动消失提示，无图
+ (void)showAutoMessage:(NSString *)message ToView:(UIView *)view{
    [self showMessage:message ToView:view RemainTime:1 Model:MBProgressHUDModeText Offset:CGPointMake(0.f,0.f)  userInteractionEnabled:YES];
}

//自定义停留时间，有图
+(void)showIconMessage:(NSString *)message ToView:(UIView *)view RemainTime:(CGFloat)time{
    [self showMessage:message ToView:view RemainTime:time Model:MBProgressHUDModeIndeterminate Offset:CGPointMake(0.f,0.f) userInteractionEnabled:YES];
}

//自定义停留时间，无图
+(void)showMessage:(NSString *)message ToView:(UIView *)view RemainTime:(CGFloat)time{
    [self showMessage:message ToView:view RemainTime:time Model:MBProgressHUDModeText Offset:CGPointMake(0.f,0.f) userInteractionEnabled:YES];
}

//自定义停留时间，无图，底部显示
+(void)showTextMessage:(NSString *)message ToView:(UIView *)view RemainTime:(CGFloat)time{
    [self showMessage:message ToView:view RemainTime:time Model:MBProgressHUDModeText Offset:CGPointMake(0.f, MBProgressMaxOffset) userInteractionEnabled:YES];
}

//无图，非模态
+(void)showMessageWithNoModel:(NSString *)message RemainTime:(CGFloat)time{
    [self showMessage:message ToView:nil RemainTime:time Model:MBProgressHUDModeText Offset:CGPointMake(0.f,0.f) userInteractionEnabled:NO];
}

+(void)showMessage:(NSString *)message ToView:(UIView *)view RemainTime:(CGFloat)time Model:(MBProgressHUDMode)model Offset:(CGPoint) offset userInteractionEnabled:(BOOL)userInteractionEnabled{
    
    if (view == nil) view = (UIView*)[UIApplication sharedApplication].delegate.window;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    hud.bezelView.color = [UIColor blackColor];
    hud.bezelView.color = [hud.bezelView.color colorWithAlphaComponent:1.0];
    
    hud.detailsLabel.text=message;
    hud.detailsLabel.font=CHINESE_SYSTEM(15);
    hud.detailsLabel.textColor = [UIColor redColor];
    hud.detailsLabel.textAlignment = 0;
    hud.contentColor = [UIColor whiteColor];
    //模式
    hud.mode = model;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // 代表需要蒙版效果
    hud.dimBackground = YES;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // 判读位置
    if (!CGPointEqualToPoint(offset, CGPointMake(0.f,0.f))) {
        hud.offset = offset;
    }
    hud.minSize = kHUDSize;
    if (!userInteractionEnabled)
        hud.userInteractionEnabled = NO;
    // X秒之后再消失
    [hud hideAnimated:YES afterDelay:time];
    
}

+ (void)showCustomIcon:(NSString *)iconName Title:(NSString *)title ToView:(UIView *)view
{
    if (view == nil) view = (UIView*)[UIApplication sharedApplication].delegate.window;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text=title;
    hud.label.font=CHINESE_SYSTEM(15);
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:iconName]];
    
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 代表需要蒙版效果
    hud.dimBackground = YES;
    
    // 3秒之后再消失
    [hud hideAnimated:YES afterDelay:1];
}


+ (void)hideHUDForView:(UIView *)view
{
    if (view == nil) view = (UIView*)[UIApplication sharedApplication].delegate.window;
    [self hideHUDForView:view animated:YES];
}

+ (void)hideHUD
{
    [self hideHUDForView:nil];
}


@end
