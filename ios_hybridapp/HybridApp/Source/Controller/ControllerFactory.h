//
//  ControllerFactory.h
//  Potato
//
//  Created by lzhang@juicyshare.cc on 2017/10/26.
//  Copyright © 2017年 Juicyshare Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ControllerFactory : NSObject{
    UINavigationController *homeNavigationController;
}

+ (ControllerFactory*) sharedInstance;
/**
 *  选择根控制器
 */
- (void)chooseRootViewController;
- (void)setupHomeViewController;

@end
