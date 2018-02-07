//
//  LocalHelper.m
//  HybridApp
//
//  Created by lzhang@juicyshare.cc on 2018/1/22.
//  Copyright © 2018年 Juicyshare Co.,Ltd. All rights reserved.
//

#import "LocalHelper.h"
#import "NSString+Util.h"
#import "DeviceConstant.h"
#import "SAMKeychain.h"
#import "UIDevice+Util.h"

#define kKeychainServiceName                 @"9MZ9ZQG82C.cc.juicyshare.salesmanager"
#define kDeviceId                            @"DeviceID"

@interface LocalHelper(){
    NSString *_dbPath;
}

@end

@implementation LocalHelper

+(LocalHelper*)sharedInstance
{
    
    static LocalHelper* sharedInstance = nil;
    static dispatch_once_t pred;
    
    dispatch_once(&pred, ^{
        sharedInstance = [[LocalHelper alloc] init];
    });
    
    return sharedInstance;
}

-(id)init
{
    NSString* doc = PATH_OF_DOCUMENT;
    NSString* path = [doc stringByAppendingPathComponent:@"WTDB_V4.sqlite"];
    _dbPath = [[NSString alloc] initWithString:path];

    /*
     //首次创建数据文件时 清空已缓存的 NSUserDefaults
    NSFileManager *mgr = [[NSFileManager alloc] init];
    if (![mgr fileExistsAtPath:path]) {
        NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
        [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    }*/
    self = [super init];
    return self;
}

-(NSString*)getValueFromUserDefaultsWithKey:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *string = [defaults objectForKey:key];
    return string;
}

-(void)removeFromUserDefaultsWithKey:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:key];
    [defaults synchronize];
}

-(void)saveValueToUserDefaultsWithKey:(id)value key:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults] ;
    [defaults setObject:value forKey:key];
    [defaults synchronize];
}

-(NSString*)getValueFromKeychainWithKey:(NSString *)key{
    return [SAMKeychain passwordForService:kKeychainServiceName account:key];
}

-(void)removeFromKeychainWithKey:(NSString *)key{
    [SAMKeychain deletePasswordForService:kKeychainServiceName account:key];
}

-(void)saveValueToKeychainWithKey:(id)value key:(NSString *)key{
    [SAMKeychain setPassword:value forService:kKeychainServiceName account:key];
}

-(NSString*)getDeviceUUID{
    if (![self getValueFromKeychainWithKey:kDeviceId]){
        [self saveValueToKeychainWithKey:[UIDevice deviceId] key:kDeviceId];
    }
    
    NSString* deviceid = [self getValueFromKeychainWithKey:kDeviceId];
    return deviceid;
}

- (NSMutableArray*) getProvinces{
    NSMutableArray* result = [[NSMutableArray alloc]init];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"city_v2" ofType:@"db"];

    FMDatabase* db = [FMDatabase databaseWithPath:path];
    if ([db open])
    {
        NSString* sql = @"select substr(POS_ID,1,5) as id,PROVINCE from city group by PROVINCE order by POS_ID";
        FMResultSet * rs = [db executeQuery:sql];
        while ([rs next])
        {
            Province* p = [[Province alloc] init];
            p.id = [rs intForColumn:@"id"];
            p.name = [rs stringForColumn:@"PROVINCE"];
            
            [result addObject:p];
        }
        [rs close];
        [db close];
        return result;
    }
    else
    {
        NSLog(@"error when query province.");
    }
    return result;
}

- (NSString*) getProvince:(NSString*) postId{
    NSString* result = @"";
    NSString *path = [[NSBundle mainBundle] pathForResource:@"city_v2" ofType:@"db"];

    FMDatabase* db = [FMDatabase databaseWithPath:path];
    if ([db open])
    {
        NSString* sql = [NSString stringWithFormat:@"select substr(POS_ID,1,5) as id,PROVINCE from city where id = '%@' group by PROVINCE order by POS_ID",postId];
        FMResultSet * rs = [db executeQuery:sql];
        while ([rs next])
        {
            result = [rs stringForColumn:@"PROVINCE"];
        }
        [rs close];
        [db close];
        return result;
    }
    else
    {
        NSLog(@"error when query province.");
    }
    return result;
}

- (NSMutableArray*) getCities:(NSString*) provinceName{
    NSMutableArray* result = [[NSMutableArray alloc]init];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"city_v2" ofType:@"db"];

    FMDatabase* db = [FMDatabase databaseWithPath:path];
    if ([db open])
    {
        NSString* sql = [NSString stringWithFormat:@"select substr(POS_ID,1,5) as id,PROVINCE,CITY,POS_ID from city WHERE PROVINCE='%@' group by CITY order by POS_ID",provinceName];
        FMResultSet * rs = [db executeQuery:sql];
        while ([rs next])
        {
            City* c = [[City alloc] init];
            c.id = [rs intForColumn:@"POS_ID"];
            c.name = [rs stringForColumn:@"CITY"];
            c.provinceId = [rs intForColumn:@"id"];
            
            [result addObject:c];
        }
        [rs close];
        [db close];
        return result;
    }
    else
    {
        NSLog(@"error when query city.");
    }
    return result;
}

- (NSString*) getCity:(NSString*) postId{
    NSString* result = @"";
    NSString *path = [[NSBundle mainBundle] pathForResource:@"city_v2" ofType:@"db"];

    FMDatabase* db = [FMDatabase databaseWithPath:path];
    if ([db open])
    {
        NSString* sql = [NSString stringWithFormat:@"select POS_ID,CITY from city where POS_ID = '%@' group by PROVINCE order by POS_ID",postId];
        FMResultSet * rs = [db executeQuery:sql];
        while ([rs next])
        {
            result = [rs stringForColumn:@"CITY"];
        }
        [rs close];
        [db close];
        return result;
    }
    else
    {
        NSLog(@"error when query province.");
    }
    return result;
}

- (NSMutableArray*) getAreas:(NSString*) cityName{
    NSMutableArray* result = [[NSMutableArray alloc]init];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"city_v2" ofType:@"db"];

    FMDatabase* db = [FMDatabase databaseWithPath:path];
    if ([db open])
    {
        NSString* sql = [NSString stringWithFormat:@"select substr(POS_ID,1,5) as id,PROVINCE,CITY,COUNTY,POS_ID from city WHERE CITY='%@' order by POS_ID",cityName];
        FMResultSet * rs = [db executeQuery:sql];
        while ([rs next])
        {
            Area* a = [[Area alloc] init];
            a.id = [rs intForColumn:@"POS_ID"];
            a.name = [rs stringForColumn:@"COUNTY"];
            a.provinceId = [rs intForColumn:@"id"];
            
            [result addObject:a];
        }
        [rs close];
        [db close];
        return result;
    }
    else
    {
        NSLog(@"error when query city.");
    }
    return result;
}

- (NSString*) getArea:(NSString*) postId{
    NSString* result = @"";
    NSString *path = [[NSBundle mainBundle] pathForResource:@"city_v2" ofType:@"db"];

    FMDatabase* db = [FMDatabase databaseWithPath:path];
    if ([db open])
    {
        NSString* sql = [NSString stringWithFormat:@"select POS_ID,COUNTY from city where POS_ID = '%@' group by PROVINCE order by POS_ID",postId];
        FMResultSet * rs = [db executeQuery:sql];
        while ([rs next])
        {
            result = [rs stringForColumn:@"COUNTY"];
        }
        [rs close];
        [db close];
        return result;
    }
    else
    {
        NSLog(@"error when query province.");
    }
    return result;
}

- (NSString*) getProvincePostIdWithName:(NSString*) name{
    NSString* result = @"10122";
    NSString *path = [[NSBundle mainBundle] pathForResource:@"city_v2" ofType:@"db"];

    FMDatabase* db = [FMDatabase databaseWithPath:path];
    if ([db open])
    {
        NSString* sql = [NSString stringWithFormat:@"select substr(POS_ID,1,5) as id,PROVINCE from city where PROVINCE = '%@' group by PROVINCE order by POS_ID",name];
        FMResultSet * rs = [db executeQuery:sql];
        while ([rs next])
        {
            result = [rs stringForColumn:@"id"];
        }
        [rs close];
        [db close];
        return result;
    }
    else
    {
        NSLog(@"error when query province.");
    }
    return result;
    
}

- (NSString*) getCityPostIdWithName:(NSString*) name{
    NSString* result = @"";
    NSString *path = [[NSBundle mainBundle] pathForResource:@"city_v2" ofType:@"db"];

    FMDatabase* db = [FMDatabase databaseWithPath:path];
    if ([db open])
    {
        NSString* sql = [NSString stringWithFormat:@"select POS_ID,CITY from city where COUNTY = '%@' union select POS_ID,CITY from city where CITY = '%@' order by POS_ID asc limit 0,1",name,name];
        FMResultSet * rs = [db executeQuery:sql];
        while ([rs next])
        {
            result = [rs stringForColumn:@"POS_ID"];
        }
        
        [rs close];
        [db close];
        return result;
    }
    else
    {
        NSLog(@"error when query province.");
    }
    return result;
}

- (NSString*) getAreaPostIdWithName:(NSString*) name{
    NSString* result = @"";
    NSString *path = [[NSBundle mainBundle] pathForResource:@"city_v2" ofType:@"db"];

    FMDatabase* db = [FMDatabase databaseWithPath:path];
    if ([db open])
    {
        NSString* sql = [NSString stringWithFormat:@"select name,POS_ID from city where COUNTY = '%@' group by CITY order by POS_ID",name];
        FMResultSet * rs = [db executeQuery:sql];
        while ([rs next])
        {
            result = [rs stringForColumn:@"POS_ID"];
        }
        [rs close];
        [db close];
        return result;
    }
    else
    {
        NSLog(@"error when query province.");
    }
    return result;
}

@end
