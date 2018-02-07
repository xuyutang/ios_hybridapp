//
//  LocationHelper.h
//  JSAPP
//
//  Created by lzhang@juicyshare.cc on 2018/1/21.
//  Copyright © 2018年 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kUpdateLocationNotification @"update_location"

@class LocationModel;
@interface LocationHelper : NSObject

+ (LocationHelper *)sharedInstance;

//初始化
- (void)startWithBaiduKey:(NSString*)baiduKey;
//开启用户定位
- (void)trunOnUserLocationService;
//关闭用户定位
- (void)trunOffUserLocationService;
//刷新用户定位
- (void)refreshUserLocation;
//打开定位配置
- (void)openLocationSetting;

@property(readonly, nonatomic) LocationModel *locationModel;

@end
