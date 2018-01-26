//
//  LocalHelper.h
//  HybridApp
//
//  Created by lzhang@juicyshare.cc on 2018/1/22.
//  Copyright © 2018年 Juicyshare Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "City.h"

@interface LocalHelper : NSObject

+ (LocalHelper*) sharedInstance;

//UserDefaults
-(NSString*)getValueFromUserDefaultsWithKey:(NSString *)key;
-(void)removeFromUserDefaultsWithKey:(NSString *)key;
-(void)saveValueToUserDefaultsWithKey:(id)value key:(NSString *)key;

/*
 * 获取省、市、区
 */
- (NSMutableArray*) getProvinces;
- (NSMutableArray*) getCities:(NSString*) provinceName;
- (NSMutableArray*) getAreas:(NSString*) cityName;

- (NSString*) getProvince:(NSString*) postId;
- (NSString*) getCity:(NSString*) postId;
- (NSString*) getArea:(NSString*) postId;

- (NSString*) getProvincePostIdWithName:(NSString*) name;
- (NSString*) getCityPostIdWithName:(NSString*) name;
- (NSString*) getAreaPostIdWithName:(NSString*) name;

@end
