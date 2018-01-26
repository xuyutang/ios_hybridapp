//
//  ControllerFactory.m
//  Potato
//
//  Created by lzhang@juicyshare.cc on 2017/10/26.
//  Copyright © 2017年 Juicyshare Co.,Ltd. All rights reserved.
//

#import "ControllerFactory.h"
#import "MJExtension.h"
#import "PromotionPageViewController.h"
#import "NewfeatureViewController.h"
#import "DeprecatedWebViewController.h"
#import "PromotionModel.h"
#import "PromotationHelper.h"

@implementation ControllerFactory

+ (ControllerFactory*)sharedInstance{
    static ControllerFactory* sharedInstance = nil;
    static dispatch_once_t pred;
    
    dispatch_once(&pred, ^{
        sharedInstance = [[ControllerFactory alloc] init];
    });
    
    return sharedInstance;
}

- (id)init{
    homeNavigationController = nil;
    self = [super init];
    return self;
}

- (void)chooseRootViewController {
    //NSString *versionkey = (__bridge NSString *)kCFBundleVersionKey;
    NSString *versionkey = @"CFBundleShortVersionString";
    
    // 从沙盒中取出上次存储的软件版本号（取出上次的使用记录）
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [defaults objectForKey:versionkey];
    
    // 获得当前打开软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[versionkey];
    
    BOOL isNewVersion = ![currentVersion isEqualToString:lastVersion];
    BOOL showNewFeature = ![currentVersion isEqualToString:lastVersion];
    if (isNewVersion) {
        // 存储这次使用的软件版本
        [defaults setObject:currentVersion forKey:versionkey];
        [defaults synchronize];
    }
    
    // 是否显示引导页
    //BOOL showNewFeature = !lastVersion || ([ControllerFactory compareVersion:lastVersion oldVersion:@"1.0.0" ] < 0);

    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (!showNewFeature) {
        PromotationHelper* promotationHelper = [[PromotationHelper alloc] init];
        [promotationHelper loadPromotionPageData];
        PromotionModel *item = [promotationHelper getPromotionItem];
        // 判断是否加载广告
        if (item) {
            PromotionPageViewController *vc = [[PromotionPageViewController alloc] init];
            vc.item = item;
            window.rootViewController = vc;
        } else {
            [self setupHomeViewController];
        }
    } else {
        NewfeatureViewController *vc = [[NewfeatureViewController alloc] init];
        window.rootViewController = vc;
    }
}

- (void)setupHomeViewController{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    DeprecatedWebViewController *vc = [[DeprecatedWebViewController alloc] init];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"start" ofType:@"html" inDirectory:@"assets"];
    NSURL*Url = [NSURL fileURLWithPath:path];
    vc.urlString = [Url absoluteString];;
    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:vc];
    homeNavigationController = navi;
    [window setRootViewController:navi];
    window.backgroundColor = [UIColor whiteColor];
    [window makeKeyAndVisible];
}

+ (NSInteger)compareVersion:(NSString *)lastVersion oldVersion:(NSString *)oldVersion {
    NSArray *leftPartitions = [lastVersion componentsSeparatedByString:@"."];
    NSArray *rightPartitions = [oldVersion componentsSeparatedByString:@"."];
    for (int i = 0; i < leftPartitions.count && i < rightPartitions.count; i++) {
        NSString *leftPartition = [leftPartitions objectAtIndex:i];
        NSString *rightPartition = [rightPartitions objectAtIndex:i];
        if (leftPartition.integerValue != rightPartition.integerValue) {
            return leftPartition.integerValue - rightPartition.integerValue;
        }
    }
    return 0;
}

@end
