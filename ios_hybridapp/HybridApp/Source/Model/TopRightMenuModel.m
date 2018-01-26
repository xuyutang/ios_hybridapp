//
//  TopRightMenuModel.m
//  SalesManager
//
//  Created by iOS-Dev on 2017/12/13.
//  Copyright © 2017年 yutang xu. All rights reserved.
//

#import "TopRightMenuModel.h"

@implementation TopRightMenuModel

-(id)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+(id)menuWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}
@end
