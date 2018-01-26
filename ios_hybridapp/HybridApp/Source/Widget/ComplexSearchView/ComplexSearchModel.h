//
//  ComplexSearchModel.h
//  SalesManager
//
//  Created by iOS-Dev on 2017/12/21.
//  Copyright © 2017年 yutang xu. All rights reserved.
//

#import <Foundation/Foundation.h>

//条件类型
typedef NS_ENUM(NSInteger,SearchType) {
    TEXT = 0,
    DIGITAL = 1,
    DATE = 2,
    RADIO = 3,
    CHECKBOX = 4,
    CUSTOMER = 5
};
@interface ComplexSearchModel : NSObject

@property (nonatomic ,assign) SearchType TYPE;

@property (nonatomic, copy) NSString* label;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *type;
@property (nonatomic, assign)int sn;
@property (nonatomic, assign)BOOL allowNull;

@property (nonatomic, copy)NSString *textString;
@property (nonatomic, copy)NSString *signTime;

@end
