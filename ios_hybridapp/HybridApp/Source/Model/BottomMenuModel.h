//
//  BottomMenuModel.h
//  SalesManager
//
//  Created by iOS-Dev on 2017/12/14.
//  Copyright © 2017年 yutang xu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BottomMenuModel : NSObject

@property (nonatomic,retain) NSString *activeIcon;

@property (nonatomic,retain) NSString *defaultIcon;

@property (nonatomic,retain) NSString *name;

@property (nonatomic,retain) NSString *url;

-(id)initWithDict:(NSDictionary *)dict;
+(id)menuWithDict:(NSDictionary *)dict;
@end
