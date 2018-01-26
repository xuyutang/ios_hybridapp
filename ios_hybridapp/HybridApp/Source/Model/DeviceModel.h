//
//  DeviceModel.h
//  SalesManager
//
//  Created by iOS-Dev on 2017/12/27.
//  Copyright © 2017年 yutang xu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeviceModel : NSObject
@property (nonatomic,retain) NSString *sdk;
@property (nonatomic,retain) NSString *version;
@property (nonatomic,retain) NSString *display;
@property (nonatomic,retain) NSString *model;
@property (nonatomic,retain) NSString *id;

@end
