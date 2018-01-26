//
//  DeviceConstant.h
//  HybridApp
//
//  Created by lzhang@juicyshare.cc on 2018/1/22.
//  Copyright © 2018年 Juicyshare Co.,Ltd. All rights reserved.
//

#ifndef DeviceConstant_h
#define DeviceConstant_h
#import "UIColor+hex.h"
#import "LocalHelper.h"

#define MainColor [UIColor colorWithHexString:@"#EC290B"];
#define BackgroundColor [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.75]

#define AVATAR_SIZE CGSizeMake(300, 300)

#define APPDELEGATE ((AppDelegate*)[[UIApplication sharedApplication] delegate])
#define SCREENHEIGHT [[UIScreen mainScreen] bounds].size.height
#define SCREENWIDTH [[UIScreen mainScreen] bounds].size.width

//#define STATEBARHEIGHT  64

#define IS_IPHONE5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125,2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define STATEBARHEIGHT  (iPhoneX ? 88:64)

#define MAINHEIGHT SCREENHEIGHT - STATEBARHEIGHT

#define MAINWIDTH SCREENWIDTH
#define tabBarHeight 45
#define webViewY STATEBARHEIGHT + tabBarHeight

#define TABLEVIEWHEADERHEIGHT 3.f

#define FONT_SIZE 13.0f

#define PATH_OF_DOCUMENT    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define APPDELEGATE ((AppDelegate*)[[UIApplication sharedApplication] delegate])

#define TIME_OUT 30
#define MAIN_COLOR  @"#EC290B"
#define LOCALMANAGER [LocalHelper sharedInstance]

#define CURRENT_OS_VERSION  [[[UIDevice currentDevice] systemVersion] floatValue]
#define IOS7  7.0
#define IOS8  8.0
#define IOS9  9.0
#define IOS10 10.0

//中文字体
#define CHINESE_FONT_NAME  @"Heiti SC"
#define CHINESE_SYSTEM(x) [UIFont fontWithName:CHINESE_FONT_NAME size:x]

#endif /* DeviceConstant_h */
