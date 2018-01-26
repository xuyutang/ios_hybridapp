//
//  TopRightMenuModel.h
//  SalesManager
//
//  Created by iOS-Dev on 2017/12/13.
//  Copyright © 2017年 yutang xu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopRightMenuModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *callback;


-(id)initWithDict:(NSDictionary *)dict;
+(id)menuWithDict:(NSDictionary *)dict;

@end
