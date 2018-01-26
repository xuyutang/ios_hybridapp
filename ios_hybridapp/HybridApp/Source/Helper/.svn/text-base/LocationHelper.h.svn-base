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

- (void)startWithBaiduKey:(NSString*)baiduKey;
- (void)startUserLocationService;
- (void)stopUserLocationService;

- (void)refreshUserLocation;
@property(readonly, nonatomic) LocationModel *locationModel;

@end
