//
//  AppDelegate.m
//  HybridApp
//
//  Created by lzhang@juicyshare.cc on 2018/1/22.
//  Copyright © 2018年 Juicyshare Co.,Ltd. All rights reserved.
//

#import "AppDelegate.h"
#import <Bugly/Bugly.h>
#import <UserNotifications/UserNotifications.h>

#import "ProductConstant.h"
#import "DeviceConstant.h"
#import "UIDevice+Util.h"
#import "LocationHelper.h"
#import "ControllerFactory.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [Bugly startWithAppId:BUGLY_KEY];
    [Bugly setUserIdentifier:[UIDevice deviceId]];
    
    [[LocationHelper sharedInstance] startWithBaiduKey:BAIDU_KEY];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self regiestLocalNotification:application];
    
    // 设置窗口的根控制器
    [self.window makeKeyAndVisible];
    
    [[ControllerFactory sharedInstance] chooseRootViewController];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [[LocationHelper sharedInstance] stopUserLocationService];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    [[LocationHelper sharedInstance] startUserLocationService];

}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    /*if (appBeComeActiveDelegate != nil && [appBeComeActiveDelegate respondsToSelector:@selector(appBeComeActive)]) {
        [appBeComeActiveDelegate appBeComeActive];
    }*/
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"network_change" object:nil];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//IOS8
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings{
    //register to receive notifications
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    NSString *sDeviceToken = [[[NSString stringWithFormat:@"%@",deviceToken] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""];;
    
    
    NSLog(@"deviceToken: %@", sDeviceToken);
    //把deviceToken 发送给自己的服务器
}

- (void) application:(UIApplication *)application didReceiveRemoteNotification:(nonnull NSDictionary *)userInfo fetchCompletionHandler:(nonnull void (^)(UIBackgroundFetchResult))completionHandler{
    NSLog(@"Receive remote userInfo :%@",userInfo);
    if (application.applicationState == UIApplicationStateActive){
        
    }
    if (application.applicationState == UIApplicationStateBackground){
        
    }
}

- (void)regiestLocalNotification:(UIApplication *)application{
    if (CURRENT_OS_VERSION < IOS8) {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
    }else if ((CURRENT_OS_VERSION < IOS10)&& (CURRENT_OS_VERSION > IOS8)){
        UIUserNotificationType apn_type = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:apn_type categories:nil];
        [application registerUserNotificationSettings:settings];
    }else{
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (!error) {
                NSLog(@"succeeded!");
            }
        }];
    }
}

@end
