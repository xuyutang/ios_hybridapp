//
//  DeprecatedWebViewController.m
//  HybridApp
//
//  Created by lzhang@juicyshare.cc on 2018/1/22.
//  Copyright © 2018年 Juicyshare Co.,Ltd. All rights reserved.
//

#import "DeprecatedWebViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import <ALBBQuPaiPlugin/ALBBQuPaiPluginPluginServiceProtocol.h>
#import <TAESDK/TAESDK.h>
#import <AVFoundation/AVFoundation.h>
#import "NSString+Util.h"
#import "DeviceModel.h"
#import "MJExtension.h"
#import "UIDevice+Util.h"
#import "BSLCalendar.h"
#import "CustomAlertView.h"
#import "KLCPopup.h"
#import "UIView+CNKit.h"
#import "CropImageViewController.h"
#import "UIView+Util.h"
#import "DateRangeView.h"
#import "KLCPopup.h"
#import "PGDatePicker.h"
#import "JSmodel.h"
#import "VideoModel.h"
#import "FileHelper.h"
#import "PlayVideViewController.h"
#import "XLImageViewer.h"
#import "HeaderSearchBar.h"
#import "DropMenu.h"
#import "SingleDropMenu.h"
#import "ComplexSearchView.h"
#import "UIButton+WebCache.h"
#import "Reachability.h"
#import "HttpRequestHelper.h"
#import "LocationHelper.h"
#import "CustomerModel.h"
#import "DeviceConstant.h"
#import "MJRefresh.h"
#import "MBProgressHUD.h"
#import "LocalHelper.h"
#import "TopRightMenuModel.h"
#import "LocationModel.h"
#import "JSBridge.h"
#import "JGPopView.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD+Util.h"

#define kAuthToken     @"authToken"
#define kObjectKey     @"value"
#define kDeviceId      @"deviceid"

@interface DeprecatedWebViewController ()<UIWebViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIScrollViewDelegate,ConfirmSureBtnDelegate,UIAlertViewDelegate,CropImageViewControllerDelegate,DateRangeViewDelegate,PGDatePickerDelegate,QupaiSDKDelegate,MPMoviePlayerPlayDelegate,HeaderSearchBarDelegate,DropMenuDelegate,SingleDropMenuDelegate,ComplexSearchDelegate,NSURLConnectionDelegate,HttpRequestDelegate,JSBridgeProtocol,selectIndexPathDelegate>{
    
    NSMutableDictionary *_dictCallback;
    NSMutableArray *_topMenus;
    NSMutableArray *_searchViews;
    NSMutableArray *_topMenuCallBacks;
    NSMutableArray *_checkDepartments;
    NSInteger _btnIndex;
    BOOL _hasNavBar;
    BOOL _hasTopMenu;
    BOOL _hasbottomMenu;
    BOOL _isNeedCrop;
    BOOL _isNeedRefresh;
    
    NSString *_imagePath;
    NSString *_updateUrlString;
    NSString *_dateType;
    CGSize _cropSize;
    CGRect _menuFrame;
    
    UIView *_rightView;
    UIButton *_navRightButton;
    CustomAlertView *_alertView;
    HeaderSearchBar *_headerBar;
    UILabel *_lblFunctionName;
    KLCPopup *_dateRangePopView;
    UIViewController *_pickerView;
    
    NSURLConnection* _connection;
    Reachability *_hostReach;
    NSArray *_provinces, *_cities, *_areas;
    DropMenu *_reginMenu;
    NSMutableArray *_moretopMenuArray;
}

@end

@implementation DeprecatedWebViewController

#pragma mark - 初始化界面和参数
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initParameters];
    [self setupSubViews];
    [self setupWebView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshLocation) name:kUpdateLocationNotification object:nil];
    _hostReach = [Reachability reachabilityForInternetConnection];
    [[NSNotificationCenter defaultCenter]addObserver:self  selector:@selector(netStatusChange:) name:kReachabilityChangedNotification object:nil];
    [_hostReach startNotifier];
    // Do any additional setup after loading the view.
    [self loadRequestWithURLString:_urlString];
}

- (void) initParameters{
    _dictCallback = [[NSMutableDictionary alloc] init] ;
    _topMenus = [[NSMutableArray alloc] init];
    _hasNavBar = NO;
}

- (void) setupSubViews {
    self.navigationController.navigationBar.hidden = YES;
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:MAIN_COLOR];
    
    UIView* leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    UIImageView* leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 13, 11.6, 18.8)];
    [leftImageView setImage:[UIImage imageNamed:@"newback"]];
    [leftView addSubview:leftImageView];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickLeftButton:)];
    [tapGesture setNumberOfTapsRequired:1];
    [leftImageView addGestureRecognizer:tapGesture];
    self.view.userInteractionEnabled = YES;
    
    int funcNamewidth;
    if (iPhoneX) {
        funcNamewidth = 200 + 55;
    }else {
        funcNamewidth = 200 ;
        
    }
    _lblFunctionName = [[UILabel alloc] initWithFrame:CGRectMake(25, 0, funcNamewidth, 44)];
    _lblFunctionName.textColor = [UIColor whiteColor];
    _lblFunctionName.font = [UIFont systemFontOfSize:18];
    [_lblFunctionName setBackgroundColor:[UIColor clearColor]];
    _lblFunctionName.textAlignment = NSTextAlignmentLeft;
    [leftView addSubview:_lblFunctionName];
    leftImageView.image = [UIImage imageNamed:@"newback"];
    [leftView addSubview:leftImageView];;
    [leftView addGestureRecognizer:tapGesture];
    
    UIBarButtonItem *btLogo = [[UIBarButtonItem alloc] initWithCustomView:leftView];
    self.navigationItem.leftBarButtonItem = btLogo;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
}

- (void)setupWebView{
    if (iPhoneX) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,0,MAINWIDTH, SCREENHEIGHT +44)];
    }else{
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,0,MAINWIDTH, MAINHEIGHT)];
    }
    _webView.delegate = self;
    _webView.backgroundColor = [UIColor whiteColor];
    _webView.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
    [self.view addSubview:_webView];
    _header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    _header.lastUpdatedTimeLabel.hidden = YES;
    _header.arrowView.hidden = YES;
    _webView.scrollView.mj_header = _header;
    _webView.scrollView.delegate = self;
    _webView.scrollView.showsHorizontalScrollIndicator = NO;
    _webView.scrollView.showsVerticalScrollIndicator = NO;
}

#pragma mark - 窗体滑动操作和导航按钮
//点击返回按钮
-(void)clickLeftButton:(id)sender {
    [self close:nil];
}

//导航右侧按钮
-(void)rightBtnClick:(id)sender {
    UIButton *btn = (UIButton*)sender;
    NSLog(@"btn tag === %ld",btn.tag);
    TopRightMenuModel *model = _topMenus [_topMenus.count - 1 -(btn.tag - 1000)];
    [self executeCallback:model.callback params:nil];
}

//下拉刷新
- (void)headerRefresh {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.urlString) {
            [self loadRequestWithURLString:self.urlString];
        }
    });
}

//结束下拉刷新和上拉加载
- (void)endRefresh {
    [_webView.scrollView.mj_header endRefreshing];
    [_webView.scrollView.mj_footer endRefreshing];
}

//HeaderSearchBar点击
-(void)HeaderSearchBarClickBtn:(int)index current:(int)current {
    _btnIndex = index;
    NSLog(@"indexTTTTTT = %d",index);
    if (current == index) {
        [UIView removeViewFormSubViews:-1 views:_searchViews ];
        return;
        
    }else{
        [UIView addSubViewToSuperView:self.view subView:_searchViews[index]];
        [UIView removeViewFormSubViews:index views:_searchViews];
    }
    
}

#pragma mark - WebView代理方法
-(void)webViewDidStartLoad:(UIWebView *)webView{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD showLoadToView:self.view];
    });
    [self addCustomActions];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    [self addCustomActions];
    if (![webView.request.URL.absoluteString containsString:@"error"] ) {
        self.urlString = webView.request.URL.absoluteString;
        DLog(@"Save current url:%@",webView.request.URL.absoluteString);
    }
    [self executeCallback:@"onPageFinished" params:nil];
    if(_header){
        [self endRefresh];
        [_webView.scrollView.mj_header endRefreshing];
    }
    //[MBProgressHUD hideHUD];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    CGFloat y = 0;
    CGFloat height = 0;
    if (_hasNavBar) {
        y = 0;
        height = SCREENHEIGHT;
    }else {
        if (iPhoneX) {
            y = -44;
            height = SCREENHEIGHT + 44;
        }else {
            y = -20;
            height = SCREENHEIGHT + 20;
        }
        
    }
    
    if (_hasTopMenu && _hasbottomMenu) {
        _webView.frame = CGRectMake(0, webViewY, MAINWIDTH, MAINHEIGHT - 90);
        
    } else if (_hasTopMenu && !_hasbottomMenu) {
        _webView.frame = CGRectMake(0, webViewY, MAINWIDTH, MAINHEIGHT - 45);
        
    } else if (!_hasTopMenu && _hasbottomMenu) {
        _webView.frame = CGRectMake(STATEBARHEIGHT, 0, MAINWIDTH, MAINHEIGHT - 45);
        
    } else {
        _webView.frame = CGRectMake(0, y, MAINWIDTH, height);
    }
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"%@",error);
    [self endRefresh];
    
    [MBProgressHUD hideHUD];
    [MBProgressHUD hideHUDForView:self.view];
}

#pragma mark - JavaScript调用ios方法
//注册JavaScript
-(void)addCustomActions{
    JSContext *context = [_webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    [context setExceptionHandler:^(JSContext *ctx, JSValue *expectValue) {
        NSLog(@"%@", expectValue);
    }];
    _context = context;
    //_context[@"app"] = self;
    _context[@"app"] = [[JSBridge alloc] initWithDelegate:self];
}
//关闭窗体
- (void)close:(id)data {
    DLog(@"---关闭窗口---");
    DLog(@"&&&&%lu",self.navigationController.viewControllers.count);
    dispatch_async(dispatch_get_main_queue(), ^{
        //通过是否有设置标题的方法，是否显示导航栏
        JSValue *funcValue = _parentController.context[@"onPageFinished"];
        if (![[funcValue toString] containsString:@"setTitle"]) {
            self.navigationController.navigationBar.hidden = YES;
            _hasNavBar = NO;
        }else {
            self.navigationController.navigationBar.hidden = NO;
            _hasNavBar = YES;
        }
        CATransition *transition = [CATransition animation];
        transition.duration = 0.4f;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
        transition.type = @"oglApplicationSuspend";
        transition.subtype = kCATransitionFromBottom;
        [self.navigationController.view.layer addAnimation:transition forKey:nil];
        [self.navigationController popViewControllerAnimated:YES];
    });
}

//打开新窗体
-(void)openNew:(id)data {
    NSLog(@"打开窗口 === %@",data);
    if (data) {
        if ([data isKindOfClass:[NSString class]]) {
            [self goToNewPageWithUrlString:data params:nil];
        }else if ([data isKindOfClass:[NSDictionary class]]){
            [self goToNewPageWithUrlString:data[@"url"] params:nil];
        }
    }
}

//关闭窗体并回传参数
-(void)closeForResult:(id)data {
    [self close:nil];
    
    NSDictionary *dic = [data toArrayOrNSDictionary];
    NSDictionary *paramsDict = [dic objectForKey:@"params"];
    CustomerModel *model = [[CustomerModel alloc] init];
    model.customerId = [paramsDict objectForKey:@"customerId"];
    model.customerName = [paramsDict objectForKey:@"customerName"];
    JSValue *funcValue = _parentController.context[@"onPageResult"];
    [funcValue callWithArguments:@[[model mj_JSONObject]]];
}

//从本机获取数据
-(NSString*)get:(id)data {
    return [[LocalHelper sharedInstance] getValueFromUserDefaultsWithKey:kAuthToken];
}

//从本机删除数据
-(void)remove:(id)data {
    [[LocalHelper sharedInstance] removeFromUserDefaultsWithKey:kAuthToken];
    
    //退出登录的时候
    //StartViewController *VC = [[StartViewController alloc] init];
    //UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:VC];
    //APPDELEGATE.window.rootViewController = nav;
}

//将数据保存至本机
-(void)put:(id)data {
    [[LocalHelper sharedInstance] saveValueToUserDefaultsWithKey:[data objectForKey:kObjectKey] key:kAuthToken];
}

- (void)prompt:(id)data {
    NSLog(@"++++++%@++++++++",data);
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD showMessage:data ToView:nil RemainTime:3.0];
    });
}

//base64数据
-(NSString*)base64File:(id)data {
    NSData *imageData = [NSData dataWithContentsOfFile:data];
    NSString *encodedImageStr = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return encodedImageStr;
    
}

//选择照片
-(void)selectImage:(id)data {
    NSDictionary *dataDic =  [self dictionaryWithJsonString:data];
    NSDictionary *paramsDic = [dataDic objectForKey:@"params"];
    
    _dictCallback[@"setImage"] = dataDic[@"callback"];
    NSString *srcType = [paramsDic objectForKey:@"srcType"];
    
    _cropSize = CGSizeMake([[paramsDic objectForKey:@"cropWith"] floatValue] , [[paramsDic objectForKey:@"cropHeight"] floatValue]);
    if ([[paramsDic objectForKey:@"autoCrop"] isEqualToString:@"true"]) {
        _isNeedCrop = YES;
    } else {
        _isNeedCrop = NO;
    }
    [MBProgressHUD showMessage:@"加载中..." ToView:self.view];
    if ([srcType isEqualToString:@"Grallery"]) {
        [self takeAPhotoWithAlbum];
    }else {
        [self takeAPhotoWithCamera];
    }
    [MBProgressHUD hideHUDForView:self.view];
}

//设置导航栏标题
-(void)setTitle:(id)data {
    _hasNavBar = YES;
    self.navigationController.navigationBar.hidden = NO;
    dispatch_async(dispatch_get_main_queue(), ^{
        _lblFunctionName.text = data;
    });
}

//设置导航栏上面的按钮
- (void)setTopMenu:(id)data {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (data) {
            [_topMenus removeAllObjects];
            NSMutableArray *theMenus = @[].mutableCopy;
            
            theMenus = [data toArrayOrNSDictionary];
            
            if (theMenus.count) {
                [theMenus enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    TopRightMenuModel *menu = [TopRightMenuModel menuWithDict:obj];
                    menu.icon = obj[@"icon"];
                    menu.name = obj[@"name"];
                    menu.callback = obj[@"callback"];
                    [_topMenus addObject:menu];
                }];
                
                //_rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 110, 60)];
                CGFloat btnWidth = 40;
                CGFloat btnHeight = 25;
                CGFloat space = 15;
                _moretopMenuArray = [[NSMutableArray alloc] init];
                NSMutableArray *navRightButtonItemMuarry = [[NSMutableArray alloc] init];
                if (_topMenus.count) {
                    [_topMenus enumerateObjectsUsingBlock:^(TopRightMenuModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        _navRightButton = [[UIButton alloc] initWithFrame:CGRectMake(130 -space - btnWidth - space*idx -  btnWidth *idx , 12, btnWidth, btnHeight)];
                        TopRightMenuModel * btnModel = _topMenus[idx];
                        
                        if (btnModel.icon) {
                            if ([btnModel.icon hasPrefix:@"http"] || [btnModel.icon hasPrefix:@"https"]) {
                                if (_topMenus.count < 3) {
                                    UIImageView *iconImageView = [[UIImageView alloc] init];
                                    [iconImageView sd_setImageWithURL:[NSURL URLWithString:btnModel.icon]];
                                    
                                    UIBarButtonItem *navRightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:iconImageView];
                                    navRightButtonItem.tag = idx + 1000;
                                    [navRightButtonItemMuarry addObject:navRightButtonItem];
                                }else {
                                    if (IS_IPHONE5) {
                                        _lblFunctionName.width = 100;
                                    }
                                    if (idx < 2) {
                                        UIImageView *iconImageView = [[UIImageView alloc] init];
                                        [iconImageView sd_setImageWithURL:[NSURL URLWithString:btnModel.icon]];
                                        
                                        UIBarButtonItem *navRightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:iconImageView];
                                        navRightButtonItem.tag = idx + 1000;
                                        [navRightButtonItemMuarry addObject:navRightButtonItem];
                                        
                                    }else {
                                        UIBarButtonItem *beyondnavRightButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"set"] style:UIBarButtonItemStylePlain target:self action:@selector(showDropMenu:)];
                                        beyondnavRightButtonItem.tintColor = [UIColor whiteColor];
                                        beyondnavRightButtonItem.tag = idx + 10000;
                                        [_moretopMenuArray addObject:btnModel];
                                        [navRightButtonItemMuarry addObject:beyondnavRightButtonItem];
                                        
                                    }
                                    
                                }
                               
                                if (_topMenus.count != 0) {
                                    self.navigationItem.rightBarButtonItems = (NSMutableArray *)[[navRightButtonItemMuarry reverseObjectEnumerator] allObjects];;
                                    
                                }
                            }else {
                                [_navRightButton setImage:[UIImage imageNamed:btnModel.icon] forState:UIControlStateNormal];
                            }
                            
                        }else {
                            //文字
                            if (_topMenus.count < 3) {
                                UIBarButtonItem *navRightButtonItem = [[UIBarButtonItem alloc] initWithTitle:btnModel.name style:UIBarButtonItemStylePlain target:self action:@selector(navRightButtonItemClick:)];
                                navRightButtonItem.tag = idx + 1000;
                                navRightButtonItem.tintColor = [UIColor whiteColor];
                                [navRightButtonItemMuarry addObject:navRightButtonItem];
                                
                             } else {
                                if (IS_IPHONE5) {
                                    _lblFunctionName.width = 100;
                                }
                                if (idx < 2) {
                                    UIBarButtonItem *navRightButtonItem = [[UIBarButtonItem alloc] initWithTitle:btnModel.name style:UIBarButtonItemStylePlain target:self action:@selector(navRightButtonItemClick:)];
                                    navRightButtonItem.tag = idx + 1000;
                                    navRightButtonItem.tintColor = [UIColor whiteColor];
                                    
                                    [navRightButtonItemMuarry addObject:navRightButtonItem];
                                    
                                }else {
                                    UIBarButtonItem *beyondnavRightButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"set"] style:UIBarButtonItemStylePlain target:self action:@selector(showDropMenu:)];
                                    beyondnavRightButtonItem.tintColor = [UIColor whiteColor];
                                    beyondnavRightButtonItem.tag = idx + 10000;
                                    [_moretopMenuArray addObject:btnModel];
                                    [navRightButtonItemMuarry addObject:beyondnavRightButtonItem];
                                    
                                    [_navRightButton setTitle:btnModel.name forState:UIControlStateNormal];
                                    
                                }
                                
                            }
                            
                        }
                    }];
                }
              if (_topMenus.count != 0) {
                    self.navigationItem.rightBarButtonItems = (NSMutableArray *)[[navRightButtonItemMuarry reverseObjectEnumerator] allObjects];;
                    
                }
            }
        }
        
    });
}

//右侧导航栏按钮点击
-(void)navRightButtonItemClick:(id)sender {
    UIButton *btn = (UIButton*)sender;
    NSLog(@"btn tag === %ld",btn.tag);
    TopRightMenuModel *model = _topMenus [(btn.tag - 1000)];
    [self executeCallback:model.callback params:nil];}


//顶部导航栏超过个数用下拉框展示
-(void)showDropMenu:(id)sender {
    CGPoint point = CGPointMake(MAINWIDTH -25,STATEBARHEIGHT);
    JGPopView *view2 = [[JGPopView alloc] initWithOrigin:point Width:100 Height:40 * _moretopMenuArray.count Type:JGTypeOfUpRight Color:[UIColor colorWithHexString:MAIN_COLOR]];
    NSMutableArray *menuNameArray = [[NSMutableArray alloc] init];
    [_moretopMenuArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [menuNameArray addObject:((TopRightMenuModel*)obj).name];
    }];
   // view2.images = nil;
    view2.dataArray = menuNameArray;
    view2.fontSize = 15;
    view2.row_height = 40;
    view2.titleTextColor = [UIColor whiteColor];
    view2.delegate = self;
    [view2 popView];
}

//顶部菜单下拉框
- (void)selectIndexPathRow:(NSInteger)index{
    [self executeCallback:((TopRightMenuModel*)_moretopMenuArray[index]).callback params:nil];
}

//alert
- (void)alert:(id)data {
    dispatch_async(dispatch_get_main_queue(), ^{
        CustomAlertView * alertView = [[CustomAlertView alloc]initWithFrame:CGRectMake(60, 200, MAINWIDTH-120, 160)WithData:data isAlert:YES];
        [alertView aletBtnClickWithBlock:^(NSInteger index, NSString *callback) {
            [alertView dismissPresentingPopup];
            
        }];
        
        KLCPopup * popView = [KLCPopup popupWithContentView:alertView showType:KLCPopupShowTypeGrowIn dismissType:KLCPopupDismissTypeGrowOut maskType:KLCPopupMaskTypeDimmed dismissOnBackgroundTouch:YES dismissOnContentTouch:NO isNoAllView:NO];
        [popView showAtCenter:CGPointMake(self.view.centerX, 160+32) inView:self.view];
        popView.didFinishDismissingCompletion = ^{
            
        };
    });
}

//回调父窗体
- (void)callParent:(id)data {
    NSString *param = data[@"params"];
    
    JSValue *funcValue = _parentController.context[data[@"callback"]];
    [funcValue callWithArguments:@[param]];
}

//getUrl
-(NSString*) getUrl {
    [self headerRefresh];
    return _urlString;
}

//是否确定操作
- (void)confirm:(id)data {
    NSDictionary *dict = [data toArrayOrNSDictionary];
    NSDictionary *params = dict[@"params"];
    dispatch_async(dispatch_get_main_queue(), ^{
        _alertView = [[CustomAlertView alloc]initWithFrame:CGRectMake(60, 200, MAINWIDTH-120, 160)WithData:dict isAlert:NO];
        [_alertView aletBtnClickWithBlock:^(NSInteger index, NSString *callback) {
            [_alertView dismissPresentingPopup];
            if(index == 1){
                [self executeCallback:callback params:params];
            }
        }];
        
        _alertView.delegate = self;
        
        KLCPopup * popView = [KLCPopup popupWithContentView:_alertView showType:KLCPopupShowTypeGrowIn dismissType:KLCPopupDismissTypeGrowOut maskType:KLCPopupMaskTypeDimmed dismissOnBackgroundTouch:YES dismissOnContentTouch:NO isNoAllView:NO];
        [popView showAtCenter:CGPointMake(self.view.centerX, SCREENHEIGHT/2) inView:self.view];
        popView.didFinishDismissingCompletion = ^{
            
        };
    });
    
}

//打电话
- (void)dial:(id)data {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",data];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    });
}

//删除文件
-(void)deleteFile:(id)data {
    NSFileManager* fileManager=[NSFileManager defaultManager];
    BOOL blHave=[[NSFileManager defaultManager] fileExistsAtPath:data];
    if (!blHave) {
        NSLog(@"no  have");
        return ;
    }else {
        NSLog(@" have");
        BOOL blDele= [fileManager removeItemAtPath:data error:nil];
        if (blDele) {
            NSLog(@"dele success");
        }else {
            NSLog(@"dele fail");
        }
    }
}

//下拉刷新
- (void)dragRefresh:(id)data {
    _isNeedRefresh = YES;
    dispatch_async(dispatch_get_main_queue(), ^{
        [_header removeFromSuperview];
        _header = nil;
        if(!_header){
            _header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
        }
        _header.lastUpdatedTimeLabel.hidden = YES;
        _header.stateLabel.hidden = YES;
        _webView.scrollView.mj_header = _header;
        _webView.scrollView.delegate = self;
    });
}

//获取位置信息
- (void)getLocation:(id)data {
    [[LocationHelper sharedInstance] refreshUserLocation];
}

//位置刷新
-(void)refreshLocation {
    JSValue *funcValue = _context[@"getLocation"];
    if (![[funcValue toString] isEqualToString:@"undefined"]) {
        [self executeCallback:@"setLocation" params:[[LocationHelper sharedInstance].locationModel mj_JSONString] ];
    }
}

//数据保存
- (void)postData:(id)url :(id)requestMapping :(id)callback :(id)content :(id)files {
    HttpRequestHelper *help = [[HttpRequestHelper alloc] init];
    help.delegate = self;
    [help postDataWithUrl:url withRequestMapping:requestMapping andCallBack:callback andContent:content withFiles:files];
}

//刷新父窗体
- (void)refreshParent:(id)data {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if(_parentController.header){
            if (!_parentController.webView.scrollView.mj_header.isRefreshing) {
                [_parentController.webView.scrollView.mj_header beginRefreshing];
            }
        }
        else{
            [_parentController.webView reload];
            
        }
    });
}

//选择日历
- (void)selectCalendar:(id)data {
    dispatch_async(dispatch_get_main_queue(), ^{
        BSLCalendar *calendar = [[BSLCalendar alloc]initWithFrame:CGRectMake(0, MAINHEIGHT - 300, MAINWIDTH, 300)];
        [self.view addSubview:calendar];
        calendar.showChineseCalendar = YES;
        [calendar selectDateOfMonth:^(NSInteger year, NSInteger month, NSInteger day) {
            NSLog(@"%ld-%ld-%ld",(long)year,(long)month,(long)day);
            [calendar removeFromSuperview];
            NSString *chosecalenValueStr = [NSString stringWithFormat:@"%ld-%ld-%ld",(long)year,(long)month,(long)day];
            
            [self executeCallback:@"setCalendar" params:chosecalenValueStr];
            
        }];
        
    });
}

//选择时间
- (void)selectTime:(id)data {
    PGDatePicker *datePicker = [[PGDatePicker alloc]init];
    datePicker.tag = 2000;
    datePicker.delegate = self;
    //[datePicker show];
    datePicker.datePickerType = PGPickerViewType3;
    datePicker.isHiddenMiddleText = false;
    datePicker.datePickerMode = PGDatePickerModeDateHourMinute;
    
    datePicker.minimumDate = [NSDate setYear:2015 month:9 day:30];
    datePicker.maximumDate = [NSDate setYear:2027 month:10 day:2];
}

//选择日期
-(void)selectDate:(id)data {
    PGDatePicker *datePicker = [[PGDatePicker alloc]init];
    datePicker.tag = 2001;
    datePicker.delegate = self;
    //[datePicker show];
    datePicker.datePickerType = PGPickerViewType3;
    datePicker.isHiddenMiddleText = false;
    datePicker.datePickerMode = PGDatePickerModeDate;
    
    datePicker.minimumDate = [NSDate setYear:2015 month:9 day:30];
    datePicker.maximumDate = [NSDate setYear:2027 month:10 day:2];
}

//intToDoubleString
-(NSString *)intToDoubleString:(NSInteger)d {
    if (d<10) {
        return [NSString stringWithFormat:@"0%ld",(long)d];
    }
    return [NSString stringWithFormat:@"%ld",(long)d];
    
}

//导航菜单
- (void)setNavigator:(id)data {
    _hasTopMenu = YES;
    NSArray *array = [data toArrayOrNSDictionary];
    
    _menuFrame = CGRectMake(0, webViewY, MAINWIDTH, MAINHEIGHT - 45);
    _searchViews = [[NSMutableArray alloc] initWithCapacity:1];
    //_departments = [[LOCALMANAGER getDepartments] retain];
    _topMenuCallBacks = [[NSMutableArray alloc] init];
    _checkDepartments = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray *titleArray = [[NSMutableArray alloc] init];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [titleArray addObject:[obj objectForKey:@"label"]];
        [_topMenuCallBacks addObject:[obj objectForKey:@"callback"]];
        if ([[obj objectForKey:@"viewType"] isEqualToString:@"TREE_VIEW"]) {
            [self showTreeView:nil];
            
        }else if ([[obj objectForKey:@"viewType"] isEqualToString:@"REGION_VIEW"]) {
            //地区选择
            [self showRegion];
            
        }else if ([[obj objectForKey:@"viewType"] isEqualToString:@"LIST_VIEW"]) {
            NSMutableArray *mulListArray = [obj objectForKey:@"viewFieldList"];
            NSMutableArray*  dataList = [[NSMutableArray alloc] init];
            [mulListArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                JSmodel *jsmodel = [[JSmodel alloc] init];
                jsmodel.fieldName = [obj objectForKey:@"name"];
                jsmodel.fieldLabel = [obj objectForKey:@"label"];
                jsmodel.value = [obj objectForKey:@"value"];
                [dataList addObject:jsmodel];
            }];
            
            [self showSingleDropListView:dataList];
            
            
        }else if ([[obj objectForKey:@"viewType"] isEqualToString:@"COMPLEX_VIEW"]) {
            NSMutableArray *complexArray = [obj objectForKey:@"viewFieldList"];
            //            JSmodel *jsmodel = [[JSmodel alloc] init];
            //            jsmodel.fieldName = [obj objectForKey:@"name"];
            //            jsmodel.fieldLabel = [obj objectForKey:@"label"];
            //            jsmodel.value = [obj objectForKey:@"value"];
            
            [self showComplexSearchView:complexArray];
        }
        
    }];
    
    _headerBar = [[HeaderSearchBar alloc] initWithFrame:CGRectMake(0, STATEBARHEIGHT, MAINWIDTH, 45)];
    _headerBar.titles = titleArray;
    NSMutableArray *iconMuarray = [[NSMutableArray alloc] init];
    for (int i = 0; i < titleArray.count; i ++) {
        [iconMuarray addObject:@""];
    }
    _headerBar.icontitles = iconMuarray;
    _headerBar.backgroundColor = [UIColor whiteColor];
    _headerBar.delegate = self;
    [self.view addSubview:_headerBar];
    
}

//获取手机型号
-(NSString*)getDeviceModel {
    if (![[LocalHelper sharedInstance] getValueFromUserDefaultsWithKey:kDeviceId]){
        [[LocalHelper sharedInstance] saveValueToUserDefaultsWithKey:[UIDevice deviceId] key:kDeviceId];
    }
    
    NSString* deviceid = [[LocalHelper sharedInstance] getValueFromUserDefaultsWithKey:kDeviceId];
    DeviceModel *model = [[DeviceModel alloc] init];
    model.sdk = @"";
    model.version = [UIDevice osVersion];
    model.display = @"";
    model.model = [UIDevice model];
    model.id = deviceid;
    
    NSString *jsonObj = [model mj_JSONString];
    return jsonObj;
}

//检查版本更新
-(void)checkNewVersion:(id)updateUrl :(id)isShowTip {
    _updateUrlString = updateUrl;
    NSDictionary* dict = [NSDictionary dictionaryWithContentsOfURL:[NSURL URLWithString:updateUrl]];
    if (dict) {
        
        NSArray* list = [dict objectForKey:@"items"];
        NSDictionary* dict2 = [list objectAtIndex:0];
        
        NSDictionary* dict3 = [dict2 objectForKey:@"metadata"];
        NSString *changelogStr = [dict3 objectForKey:@"changelog"];
        changelogStr = [changelogStr stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"];
        NSString* newVersion = [dict3 objectForKey:@"bundle-version"];
        
        NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
        NSString *myVersion = [infoDict objectForKey:@"CFBundleShortVersionString"];
        
        [MBProgressHUD showIconMessage:@"正在检查版本升级..."  ToView:nil RemainTime:2.0];
       
        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0/*延迟执行时间*/ * NSEC_PER_SEC));
        
        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
            if(isShowTip){
                if (![newVersion isEqualToString:myVersion]) {
                    //提示让用户来肯定更新不更新
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"版本升级"
                                                                        message:changelogStr
                                                                       delegate:self
                                                              cancelButtonTitle:@"稍后再说"
                                                              otherButtonTitles:@"现在升级", nil];
                    
                    [self showAlertView:alertView];
                }else {
                    
                    UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"版本升级"
                                                                   message:@"目前已是最新版本，无需升级。"
                                                                  delegate:self
                                                         cancelButtonTitle:@"确定"
                                                         otherButtonTitles:nil];
                    NSLog(@"您已经是最新版");
                    [alert show];
                }
            }else{
                if (![newVersion isEqualToString:myVersion]) {
                    //这里博主是直接更新的，你可以给用户弹个提示让用户来肯定更新不更新
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"版本升级"
                                                                        message:changelogStr
                                                                       delegate:self
                                                              cancelButtonTitle:@"稍后再说"
                                                              otherButtonTitles:@"现在升级", nil];
                    [self showAlertView:alertView];
                    
                }
            }
        });
        
        
        
    }
}

//选择时间范围
-(void)selectDateRange:(id)data {
    NSDictionary *dict;
    if ([data isKindOfClass:[NSDictionary class]]) {
        dict =data;
    }else {
        dict = [self dictionaryWithJsonString:data];
        
    }
    _dateType = [dict objectForKey:@"params"];
    //为空时默认的格式
    if (_dateType == nil) {
        _dateType = @"yyyy-MM-dd HH:mm";
    }
    
    DateRangeView *dateViewRange = [[DateRangeView alloc] initWithFrame:CGRectMake(15, 0,MAINWIDTH - 30 , 200)];
    dateViewRange.delegate = self;
    _dateRangePopView = [KLCPopup popupWithContentView:dateViewRange showType:KLCPopupShowTypeSlideInFromBottom dismissType:KLCPopupDismissTypeSlideOutToBottom maskType:KLCPopupMaskTypeDimmed dismissOnBackgroundTouch:YES dismissOnContentTouch:NO isNoAllView:NO];
    [_dateRangePopView showAtCenter:CGPointMake(self.view.centerX, self.view.centerY ) inView:self.view];
}

//查看图片
-(void)viewPic:(id)data {
    NSInteger currentIndex;
    NSDictionary *dict = [data toArrayOrNSDictionary];
    NSNumber *index = dict[@"current"];
    
    NSString* p1 = [index stringValue];
    
    // NSInteger currentIndex = [p1 integerValue];
    if([p1 isEqualToString:@"0"]){
        currentIndex =0;
    }
    else{
        currentIndex = [p1 integerValue];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSArray * arr = dict[@"images"];
        if(!arr.count){
            return;
        }
        if ([arr[0] hasPrefix:@"http://"] ||[arr[0] hasPrefix:@"https://"] ) {
            
            [[XLImageViewer shareInstanse] showNetImages:dict[@"images"] index:currentIndex  fromImageContainer:nil];
            
        } else {
            NSMutableArray * imageArr = [[NSMutableArray alloc]init];
            for (int i=0;i<arr.count;i++){
                
                UIImage *tmpImg = [UIImage imageWithContentsOfFile:arr[i] ];
                NSData *dataImg = UIImageJPEGRepresentation(tmpImg,0.5);
                //                NSData *_decodedImageData = [[NSData alloc] initWithBase64EncodedString:arr[i]  options:0];
                //                UIImage *_decodedImage = [UIImage imageWithData:_decodedImageData];
                //+非空的判断  崩溃（本地图片有wt0
                if (dataImg != nil) {
                    [imageArr addObject:dataImg];
                    
                }
            }
            if (imageArr.count) {
                [[XLImageViewer shareInstanse] showLocalImageDatas:imageArr index:currentIndex fromImageContainer:nil];
            }
            
        }
    });
    
}
//视频拍摄
-(void)selectVideo:(id)data {
    NSDictionary *dataDict = [data toArrayOrNSDictionary];
    NSDictionary *paramsDic = [dataDict objectForKey:@"params"];
    CGFloat duration = [[paramsDic objectForKey:@"duration"] floatValue];
    _dictCallback[@"setVideo"] = dataDict[@"callback"];
    
    [MBProgressHUD showMessage:@"加载中..." ToView:self.view];

    static dispatch_once_t once;
    dispatch_once(&once, ^{
        //阿里巴巴趣拍初始
        [[TaeSDK sharedInstance] asyncInit:^{
            NSLog(@"阿里巴巴趣拍初始化ok");
        } failedCallback:^(NSError *error) {
            NSLog(@"TaeSDK init failed!!!");
        }];
    });
    
    id<ALBBQuPaiPluginPluginServiceProtocol> taeSDK =[[TaeSDK sharedInstance] getService:@protocol(ALBBQuPaiPluginPluginServiceProtocol)];
    [taeSDK setDelegte:self];
    dispatch_async(dispatch_get_main_queue(), ^{
        _pickerView = [taeSDK createRecordViewControllerWithMaxDuration:duration
                                                                bitRate:600000
                                            thumbnailCompressionQuality:.8f
                                                         watermarkImage:nil
                                                      watermarkPosition:QupaiSDKWatermarkPositionTopRight
                                                              tintColor:[UIColor clearColor]
                                                        enableMoreMusic:NO
                                                           enableImport:NO
                                                      enableVideoEffect:NO];
        [self presentViewController:_pickerView animated:YES completion:nil];
    });
    [MBProgressHUD hideHUDForView:self.view];
}

//播放视频
-(void)playVideo:(id)data {
    NSString *videoPath = data;
    PlayVideViewController* playVC = [[PlayVideViewController alloc] init];
    playVC.videoPath = videoPath;
    playVC.delegate = self;
    //判断是否是网络视频
    if([videoPath hasPrefix:@"http"] || [videoPath hasPrefix:@"https"]) {
        playVC.bNetWork = YES;
    }else {
        playVC.bNetWork = NO;
    }
    
    // playVC.bNetWork = YES;
    UINavigationController* navCtrl = [[UINavigationController alloc] initWithRootViewController:playVC];
    navCtrl.navigationBarHidden = YES;
    [self presentViewController:navCtrl animated:YES completion:nil];
}

- (void)cancel {
    [_dateRangePopView removeFromSuperview];
}

- (void)selector:(id)data {
    
}


- (void)setBottomBadge:(id)data {
    
}

- (void)setFootMenu:(id)data {
    
}

- (void)readFile:(id)data {
    
}

- (void)getNavValue:(id)data {
    
}

- (void)hideTopRight:(id)data {
    
}

- (void)message:(id)data {
    
}


- (void)onPageEnd:(id)data {
    
}

- (void)onResume:(id)data {
    
}

- (void)onSaveState:(id)data {
    
}

- (void)openModal:(id)data {
    
}
- (void)acceptMessage:(id)data {
    
}

- (void)actions:(id)data {
    
}

- (void)topMessage:(id)data {
    
}

- (void)viewPicture:(id)data {
    
}

- (void)setTitleIcon:(id)data {
    
}

- (void)callHostPlugin:(id)data {
    
}

//根据URL地址打开窗体
-(void)goToNewPageWithUrlString:(NSString *)urlString params:(NSDictionary *)params {
    dispatch_async(dispatch_get_main_queue(), ^{
        DLog(@"Open new url from string:%@",urlString);
        DeprecatedWebViewController *newVC = [[DeprecatedWebViewController alloc] init];
        newVC.parentController = self;
        __block NSString *paramsString = nil;
        if (params != nil) {
            [params enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                paramsString = [NSString stringWithFormat:@"%@=%@&", key, obj];
            }];
        }
        if (paramsString != nil) {
            if ([urlString hasSuffix:@"?"]) {
                newVC.urlString = [NSString stringWithFormat:@"%@%@", urlString, paramsString];
            }else{
                newVC.urlString = [NSString stringWithFormat:@"%@?%@", urlString, paramsString];
            }
        }else{
            newVC.urlString = urlString;
        }
        [UIView transitionWithView:self.navigationController.view
                          duration:0.4
                           options:UIViewAnimationOptionCurveLinear
                        animations:^{
                            [self.navigationController pushViewController:newVC animated:NO];
                        }
                        completion:nil];
    });
}

#pragma mark ios调用JavaScript函数
-(void)executeCallback:(NSString *)callback params:(id)params{
    if ([callback containsString:@"("] && [callback containsString:@")"]) {
        [_webView stringByEvaluatingJavaScriptFromString:callback];
    }else {
        //JSValue *funcValue = _context[callback];
        if (params != nil) {
            //[funcValue callWithArguments:@[params]];
            [_webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"%@(%@)",callback,[params mj_JSONString]]];
        }else{
            NSString *sss = [NSString stringWithFormat:@"%@()", callback];
            [_webView stringByEvaluatingJavaScriptFromString:sss];
        }
        
    }
}

#pragma mark - 网络加载html
//根据URL地址加载webview
- (void)loadRequestWithURLString:(NSString *)strURL{
    if (strURL.length == 0){
        [self loadFailHTMLFromLocal];
        NSLog(@"Cannont load nil url.");
        return;
    }
    
    if ([strURL containsString:@"assets/index.html"]) {
        //测试代码**
        NSString *path = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html" inDirectory:@"assets"];
        NSURL*Url = [NSURL fileURLWithPath:path];
        [_webView loadRequest:[NSURLRequest requestWithURL:Url]];
        //********
    } else  if([strURL containsString:@"assets/detail.html"]){
        //测试代码**
        NSString *path = [[NSBundle mainBundle] pathForResource:@"detail" ofType:@"html" inDirectory:@"assets"];
        NSURL*Url = [NSURL fileURLWithPath:path];
        [_webView loadRequest:[NSURLRequest requestWithURL:Url]];
        //********
    }else{
        NSURL *url = [NSURL URLWithString:strURL];
        NSURLRequest *request =[NSURLRequest requestWithURL:url
                                                cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                            timeoutInterval:TIME_OUT];
        [_webView loadRequest:request];
        
        //判读返回代码
        NSURLSessionDataTask * dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
            DLog(@"Http response statusCode:%ld", httpResponse.statusCode);
            
            if (httpResponse.statusCode == 404){
                [self loadFailHTMLFromLocal];
            }
        }];
        [dataTask resume];
        
        if (_connection){
            [_connection cancel];
            DLog(@"safe release connection");
        }
        _connection= [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:YES];
    }
}

//网络异常加载本地文件
- (void) loadFailHTMLFromLocal{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"error" ofType:@"html" inDirectory:@"assets"];
    NSURL*Url = [NSURL fileURLWithPath:path];
    dispatch_async(dispatch_get_main_queue(), ^{
        [_webView loadRequest:[NSURLRequest requestWithURL:Url]];
    });
    
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    if (_connection) {
        [_connection cancel];
        _connection = nil;
    }
    
    if ([response isKindOfClass:[NSHTTPURLResponse class]]){
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
        if ((([httpResponse statusCode]/100) == 2)){
            NSLog(@"connection ok");
        }
        else{
            NSError *error = [NSError errorWithDomain:@"HTTP" code:[httpResponse statusCode] userInfo:nil];
            if ([error code] == 404){
                DLog(@"404");
                
            }
        }
    }
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    if (_connection) {
        [_connection cancel];
        _connection = nil;
    }
    if (error.code == 22) //The operation couldn’t be completed. Invalid argument
        NSLog(@"22");
    else if (error.code == -1001) //The request timed out.  webview code -999的时候会收到－1001，这里可以做一些超时时候所需要做的事情，一些提示什么的
        NSLog(@"-1001");
    else if (error.code == -1005) //The network connection was lost.
        NSLog(@"-1005");
    else if (error.code == -1009){ //The Internet connection appears to be offline
        NSLog(@"-1009");
    }
    [self loadFailHTMLFromLocal];

}

//网络状态的监听
//通知监听回调 网络状态发送改变 系统会发出一个kReachabilityChangedNotification通知，然后会触发此回调方法
- (void)netStatusChange:(NSNotification *)noti{
    NSLog(@"Notification: %@",noti.userInfo);
    //判断网络状态
    switch (_hostReach.currentReachabilityStatus) {
        case NotReachable:
            NSLog(@"当前网络连接失败，请查看设置");//[MBProgressHUD showInfo:@"当前网络连接失败，请查看设置" ToView:self.view];
            break;
        case ReachableViaWiFi:
            NSLog(@"Network status: wifi上网");
            break;
        case ReachableViaWWAN:
            NSLog(@"Network status: 手机上网");
            break;
        default:
            break;
    }
}

#pragma mark - 照片和图像处理
//访问相册
-(void) takeAPhotoWithAlbum {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
        UIImagePickerController *imgPickerVC = [[UIImagePickerController alloc] init];
        [imgPickerVC setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [imgPickerVC.navigationBar setBarStyle:UIBarStyleBlack];
        [imgPickerVC setDelegate:self];
        [imgPickerVC setAllowsEditing:NO];
        //显示Image Picker
        [self presentViewController:imgPickerVC animated:YES completion:nil];
    }else {
        NSLog(@"Album is not available.");
    }
}

//实时拍照
-(void) takeAPhotoWithCamera {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *cameraVC = [[UIImagePickerController alloc] init];
        [cameraVC setSourceType:UIImagePickerControllerSourceTypeCamera];
        [cameraVC.navigationBar setBarStyle:UIBarStyleBlack];
        [cameraVC setDelegate:self];
        [cameraVC setAllowsEditing:NO];
        cameraVC.hidesBottomBarWhenPushed = YES;
        //显示Camera VC
        
        self.hidesBottomBarWhenPushed = YES;
        [self presentViewController:cameraVC animated:YES completion:nil];
        
    }else {
        NSLog(@"Camera is not available.");
    }
}

//imagePickerController代理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    // Obtain the path to save to
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *imageFile = [[NSString alloc] initWithString:[NSString UUID]];
    
    _imagePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg",imageFile]];
    
    // Extract image from the picker and save it
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:@"public.image"]){
        //判断是否需要裁剪
        if (!_isNeedCrop) {
            CropImageViewController *vctrl = [[CropImageViewController alloc] init];
            vctrl.image = [UIView fitSmallImage:[info objectForKey:UIImagePickerControllerOriginalImage]];
            vctrl.delegate = self;
            [self.navigationController pushViewController:vctrl animated:YES];
            
        }else {
            UIImage *image = [UIView scaleToSize:[info objectForKey:UIImagePickerControllerOriginalImage] size:_cropSize];
            // UIImage *image = [self fitSmallImage:[info objectForKey:UIImagePickerControllerOriginalImage]] ;
            NSData *data = UIImageJPEGRepresentation(image, 0.5);//UIImagePNGRepresentation(image);
            [data writeToFile:_imagePath atomically:YES];
            JSValue *funcValue = _context[_dictCallback[@"setImage"]];
            NSLog(@"address === %@",_imagePath);
            [funcValue callWithArguments:@[_imagePath]];
        }
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

//图片裁剪
- (void)cropImageController:(CropImageViewController *)controller didFinishCroppingImage:(UIImage *)croppedImage {
    UIImage *image = [UIView scaleToSize:croppedImage size:_cropSize];
    NSData *data = UIImageJPEGRepresentation(image, 0.5);
    [data writeToFile:_imagePath atomically:YES];
    
    JSValue *funcValue = _context[_dictCallback[@"setImage"]];
    [funcValue callWithArguments:@[_imagePath]];
    //    NSData *imageData = UIImagePNGRepresentation(image);
}

-(UIImage *)fitSmallImage:(UIImage *)image {
    if (nil == image)
    {
        return nil;
    }
    if (image.size.width<720 && image.size.height<960)
    {
        return image;
    }
    CGSize size = [self fitsize:image.size];
    UIGraphicsBeginImageContext(size);
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    [image drawInRect:rect];
    UIImage *newing = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newing;
}

- (CGSize)fitsize:(CGSize)thisSize {
    if(thisSize.width == 0 && thisSize.height ==0)
        return CGSizeMake(0, 0);
    CGFloat wscale = thisSize.width/720;
    CGFloat hscale = thisSize.height/960;
    CGFloat scale = (wscale>hscale)?wscale:hscale;
    CGSize newSize = CGSizeMake(thisSize.width/scale, thisSize.height/scale);
    return newSize;
}

- (void)showLoading:(id)data {
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD showMessage:@"加载中" ToView:self.view];
    });
}

- (void)hideLoading:(id)data {
    dispatch_async(dispatch_get_main_queue(), ^{
        //[MBProgressHUD hideHUD];
        [MBProgressHUD hideHUDForView:self.view];
    });
}

//json转换
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    @try {
        NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        return dic;
    }
    @catch (NSException *exception) {
        [self prompt:exception.reason];
    }
    
}

#pragma mark 菜单显示
//单列菜单
-(void)showSingleDropListView: (NSMutableArray*)dataList {
    SingleDropMenu* categoryMenu = [[SingleDropMenu alloc] initWithFrame:_menuFrame];
    categoryMenu.dataList = dataList;
    categoryMenu.delegate = self;
    [categoryMenu initMenu];
    [_searchViews addObject:categoryMenu];
}

//区域菜单
-(void)showRegion {
    [self loadCityData];
    _reginMenu = [[DropMenu alloc] initWithFrame:_menuFrame];
    _reginMenu.delegate = self;
    _reginMenu.menuCount = 3;
    
    _reginMenu.array1 = [[NSMutableArray alloc] init];
    [_reginMenu.array1 addObject:@"全部"];
    for (NSDictionary *p in _provinces) {
        [_reginMenu.array1 addObject:[p objectForKey:@"province"]];
    }
    
    _reginMenu.array2 = [[NSMutableArray alloc] init];
    _reginMenu.array3 = [[NSMutableArray alloc] init];
    [_reginMenu initMenu];
    [_searchViews addObject:_reginMenu];
    
}

-(void)selectedDropMenuIndex:(int)index row:(int)row {
    NSString *lableTitle = nil;
    
    if (row == 0) {
        [_reginMenu removeFromSuperview];
        
        
        if (index == 1){
            NSString *title = _headerBar.titles[_btnIndex];
            [_reginMenu.array2 removeAllObjects];
            [_reginMenu.array3 removeAllObjects];
            [_reginMenu.tableView2 reloadData];
            [_reginMenu.tableView3 reloadData];
            [_headerBar.buttons[_btnIndex] setTitle:@"全部" forState:UIControlStateNormal];
            lableTitle = title;
            [self executeCallback:_topMenuCallBacks[_btnIndex] params:nil];

        }else if (index == 2) {
            NSString *title = [_reginMenu.array1 objectAtIndex:_reginMenu.selectedIndex1];
            [_reginMenu.array3 removeAllObjects];
            [_reginMenu.tableView3 reloadData];
            [_headerBar.buttons[_btnIndex] setTitle:title forState:UIControlStateNormal];
            lableTitle = title;
            JSmodel *model = [[JSmodel alloc] init];
            model.fieldName = @"province";
            model.fieldLabel = title;
            model.value = [[[_provinces objectAtIndex:_reginMenu.selectedIndex1-1] objectForKey:@"provinceId"] substringToIndex:5];
            [self executeCallback:_topMenuCallBacks[_btnIndex] params:[model mj_JSONObject]];
            // setProvinceCode
        }else if (index == 3){
            NSString  *title = [_reginMenu.array2 objectAtIndex:_reginMenu.selectedIndex2];
            [_headerBar.buttons[_btnIndex] setTitle:title forState:UIControlStateNormal];
            lableTitle =  title;
            
            JSmodel *model = [[JSmodel alloc] init];
            model.fieldName = @"city";
            model.fieldLabel = title;
            model.value = [NSString stringWithFormat:@"%d",((Area *)[_areas objectAtIndex:0]).id];
            [self executeCallback:_topMenuCallBacks[_btnIndex] params:[model mj_JSONObject]];
            //setCityCode
            //  [lb setCityCode:[[areas objectAtIndex:dropMenu4.selectedIndex3-1] objectForKey:@"cityId"]];
            
            
            
            
        }
    }else if (index == 1) {
        _cities = [[_provinces objectAtIndex:row-1] objectForKey:@"cities"];
        [_reginMenu.array2 removeAllObjects];
        [_reginMenu.array2 addObject:@"全部"];
        for (NSDictionary *c in _cities) {
            [_reginMenu.array2 addObject:[c objectForKey:@"city"]];
        }
        if (_cities.count > 0)
            _areas = [[_cities objectAtIndex:0] objectForKey:@"areas"];
        [_reginMenu.array3 removeAllObjects];
        [_reginMenu.tableView2 reloadData];
        [_reginMenu.tableView3 reloadData];
        lableTitle = [[_provinces objectAtIndex:_reginMenu.selectedIndex1-1] objectForKey:@"province"];
    }else if (index == 2){
        _areas = [[_cities objectAtIndex:row-1] objectForKey:@"areas"];
        [_reginMenu.array3 removeAllObjects];
        [_reginMenu.array3 addObject:@"全部"];
        for (Area *a in _areas) {
            [_reginMenu.array3 addObject:a.name];
        }
        [_reginMenu.tableView3 reloadData];
        lableTitle =  [[_cities objectAtIndex:_reginMenu.selectedIndex2-1] objectForKey:@"city"];
    }else if (index == 3) {
        [_reginMenu removeFromSuperview];
        NSString *title = [_reginMenu.array3 objectAtIndex:_reginMenu.selectedIndex3];
        [_headerBar.buttons[_btnIndex] setTitle:title forState:UIControlStateNormal];
        lableTitle = ((Area *)[_areas objectAtIndex:_reginMenu.selectedIndex3-1]).name;
        //setDistrictCode
        JSmodel *model = [[JSmodel alloc] init];
        model.fieldName = @"district";
        model.fieldLabel = title;
        model.value = [NSString stringWithFormat:@"%d",((Area *)[_areas objectAtIndex:_reginMenu.selectedIndex3-1]).id];
        [self executeCallback:_topMenuCallBacks[_btnIndex] params:[model mj_JSONObject]];
        
    }
    [self setSearchHeaderTitle:_btnIndex title:lableTitle];
}


-(void) setSearchHeaderTitle:(int) index title:(NSString *) title{
    UIButton *btn = _headerBar.buttons[index];
    [btn setTitle:title forState:UIControlStateNormal];
}

//加载地区本地数据
-(void)loadCityData{
    NSMutableArray* p = [LOCALMANAGER getProvinces];
    NSMutableArray *pArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < p.count; i++) {
        Province *province = (Province*)[p objectAtIndex:i];
        NSMutableArray* c = [LOCALMANAGER getCities:province.name];
        NSMutableArray* cArray = [[NSMutableArray alloc] init];
        
        for (int j = 0; j < c.count; j++) {
            City *city = (City *)[c objectAtIndex:j];
            NSMutableArray* a = [LOCALMANAGER getAreas:city.name];
            NSMutableDictionary *aDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:a,@"areas",city.name,@"city",[NSString stringWithFormat:@"%d",city.id],@"cityId", nil];
            [cArray addObject:aDict];
            
        }
        
        NSMutableDictionary *cDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:cArray,@"cities",province.name,@"province",[NSString stringWithFormat:@"%d",province.id],@"provinceId", nil];
        [pArray addObject:cDict];
    }
    NSMutableDictionary *addressDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:pArray,@"provinces", nil];
    
    
    _provinces = [addressDict objectForKey:@"provinces"];
    _cities = [[_provinces objectAtIndex:0] objectForKey:@"cities"];
    _areas = [[_cities objectAtIndex:0] objectForKey:@"areas"];
    
    
}


//复合型条件查询
-(void)showComplexSearchView:(NSMutableArray*)listArray {
    ComplexSearchView *compleView = [[ComplexSearchView alloc] initWithFrame:_menuFrame WithArray:listArray];
    compleView.delegate = self;
    [_searchViews addObject:compleView];
}

//树形结构展示
-(void)showTreeView:(NSMutableArray*)mulArray{
    UIViewController* VC = [[UIViewController alloc] init];
    VC.view.frame = _menuFrame;
    [self addChildViewController:VC];
    [_searchViews addObject:self.childViewControllers.firstObject.view];
    
}

//复合条件查询提交
-(void)seacrchWithJsonArr:(NSMutableArray *)jsonMuarry {
    [self executeCallback:@"complexChange" params:jsonMuarry];
    
    [_headerBar setColor:-1];
}

//SingleDropMenu代理
-(void)selectedSingleDropMenu:(NSObject*)obj {
    UIButton* btn = _headerBar.buttons[_btnIndex];
    JSmodel *model = (JSmodel*)obj;
    NSString* title = model.fieldLabel ;
    [btn setTitle:title forState:UIControlStateNormal];
    NSLog(@"选择了:%@ fieldLabel= %@,callback = %@ ",[model mj_JSONObject],model.fieldLabel,_topMenuCallBacks[_btnIndex]);
    [self executeCallback:_topMenuCallBacks[_btnIndex] params:[model mj_JSONObject]];
    
    [UIView removeViewFormSubViews:-1 views:_searchViews];
    [_headerBar setColor:-1];
}

//自定义显示AltertView
-(void)showAlertView:(UIAlertView*)alertView {
    //如果你的系统大于等于7.0
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1)
    {
        // CGSize size = [_changelog sizeWithFont:[UIFont systemFontOfSize:15]constrainedToSize:CGSizeMake(240,400) lineBreakMode:NSLineBreakByTruncatingTail];
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.font = [UIFont systemFontOfSize:15];
        textLabel.textColor = [UIColor blackColor];
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.lineBreakMode =NSLineBreakByWordWrapping;
        textLabel.numberOfLines =0;
        textLabel.textAlignment =NSTextAlignmentLeft;
        
        NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:alertView.message];
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        style.headIndent = 15;//缩进
        style.firstLineHeadIndent = 15;
        [text addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, text.length)];
        
        textLabel.attributedText = text;
        [alertView setValue:textLabel forKey:@"accessoryView"];
        
        alertView.message =@"";
    }else{
        NSInteger count = 0;
        for( UIView * view in alertView.subviews )
        {
            if( [view isKindOfClass:[UILabel class]] )
            {
                count ++;
                if ( count == 2 ) { //仅对message左对齐
                    UILabel* label = (UILabel*) view;
                    label.textAlignment =NSTextAlignmentLeft;
                }
            }
        }
    }
    [alertView show];
}

//clickedButtonAtIndex
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"%ld+++++++++",(long)buttonIndex);
    switch (buttonIndex) {
        case 0:
            break;
        case 1:
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"itms-services://?action=download-manifest&url=%@",_updateUrlString]]];
            break;
        default:
            break;
    }
    
}

//DateRangeView代理，选择开始时间
-(void)choseStartTime {
    PGDatePicker *datePicker = [[PGDatePicker alloc]init];
    datePicker.tag = 1000;
    datePicker.delegate = self;
    //[datePicker show];
    datePicker.datePickerType = PGPickerViewType3;
    datePicker.isHiddenMiddleText = false;
    datePicker.datePickerMode = [self selectDateType];
    
    datePicker.minimumDate = [NSDate setYear:2015 month:9 day:30];
    datePicker.maximumDate = [NSDate setYear:2027 month:10 day:2];
    
}

//选择结束时间
-(void)choseEndTime{
    PGDatePicker *datePicker = [[PGDatePicker alloc]init];
    datePicker.tag = 1001;
    datePicker.delegate = self;
    //[datePicker show];
    datePicker.datePickerType = PGPickerViewType3;
    datePicker.isHiddenMiddleText = false;
    datePicker.datePickerMode = [self selectDateType];
    
    datePicker.minimumDate = [NSDate setYear:2015 month:9 day:30];
    datePicker.maximumDate = [NSDate setYear:2027 month:10 day:2];
}

#pragma mark 时间选择器类型
-(PGDatePickerMode)selectDateType {
    //年月日
    if ([_dateType isEqualToString:@"yyyy-MM-dd"] || [_dateType isEqualToString:@"yyyy/MM/dd"]) {
        NSLog(@"年月日");
        return  PGDatePickerModeDate;
    }
    //年月
    if ([_dateType isEqualToString:@"yyyy-MM"] || [_dateType isEqualToString:@"yyyy/MM"] ) {
        NSLog(@"年月");
        return PGDatePickerModeDate;
    }
    //年月日时分
    if ([_dateType isEqualToString:@"yyyy-MM-dd HH:mm"] || [_dateType isEqualToString:@"yyyy/MM/dd HH:mm"] ) {
        NSLog(@"年月日时分");
        return PGDatePickerModeDateHourMinute;
    }
    //月日
    if ([_dateType isEqualToString:@"MM-dd"] || [_dateType isEqualToString:@"MM/dd"] ) {
        NSLog(@"月日");
        return PGDatePickerModeDate;
    }
    
    //月日时分
    if ([_dateType isEqualToString:@"MM-dd HH:mm"] || [_dateType isEqualToString:@"MM/dd HH:mm"] ) {
        NSLog(@"月日时分");
        return PGDatePickerModeDateHourMinute;
    }
    //时分
    if ([_dateType isEqualToString:@"HH:mm"]) {
        NSLog(@"时分");
        return PGDatePickerModeTime;
    }
    return 0;
}

//时间选择提交
-(void)submitWithStartDate:(NSString *)startDate andEndDate:(NSString *)endDate {
    NSLog(@"----时间范围选择----");
    //json数据组装
    NSMutableArray *jsonMulArray = [[NSMutableArray alloc] init];
    JSmodel *startModel = [[JSmodel alloc] init];
    startModel.fieldLabel = @"开始日期";
    startModel.fieldName = @"startDate";
    startModel.value = startDate;
    [jsonMulArray addObject:[startModel mj_JSONObject]];
    
    JSmodel *endModel = [[JSmodel alloc] init];
    endModel.fieldLabel = @"结束日期";
    endModel.fieldName = @"endDate";
    endModel.value = endDate;
    [jsonMulArray addObject:[endModel mj_JSONObject]];
    if(!([startDate isEqualToString:@"(null)"] && [endDate isEqualToString:@"(null)"])){
        
        [self executeCallback:@"selectDateRangeCallback" params:jsonMulArray];
        
    }
    [_dateRangePopView removeFromSuperview];
}

//PGDatePicker代理
-(void)datePicker:(PGDatePicker *)datePicker didSelectDate:(NSDateComponents *)dateComponents {
    NSLog(@"dateComponents ====== %@",dateComponents);
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSDate * date = [calendar dateFromComponents:dateComponents];
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = _dateType;
    NSString * selectDateString = [formatter stringFromDate:date];
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:selectDateString,@"selectDate",@(datePicker.tag),@"tag",nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"refshSelectTime" object:dict];
}

//趣拍代理
-(void)qupaiSDK:(id<ALBBQuPaiPluginPluginServiceProtocol>)sdk compeleteVideoPath:(NSString *)videoPath thumbnailPath:(NSString *)thumbnailPath{
    NSString *vurl = nil;
    NSString *iurl = nil;
    if (!videoPath && !thumbnailPath) {
        NSLog(@"取消拍摄");
    }else{
        NSData *data = [[NSData alloc] initWithContentsOfFile:videoPath];
        vurl = [PATH_OF_DOCUMENT stringByAppendingPathComponent:[videoPath lastPathComponent]];
        [data writeToFile:vurl atomically:YES];
        iurl = [PATH_OF_DOCUMENT stringByAppendingPathComponent:[thumbnailPath lastPathComponent]];
        data = [[NSData alloc] initWithContentsOfFile:thumbnailPath];
        [data writeToFile:iurl atomically:YES];
        NSString* videoPath = [vurl copy];
        AVURLAsset * asset = [AVURLAsset assetWithURL:[NSURL fileURLWithPath:videoPath]];
        CMTime   time = [asset duration];
        int seconds = ceil(time.value/time.timescale);
        //视频上传
        VideoModel *videoModel = [[VideoModel alloc] init];
        videoModel.duration = seconds;
        videoModel.videoPath = videoPath;
        videoModel.thumbPath = thumbnailPath;
        videoModel.size = [self getVideoSizeWith:videoPath];
        videoModel.wrapSize  = [FileHelper formartFileSizeToString:videoModel.size];
        if (videoModel.size) {
            [self executeCallback:_dictCallback[@"setVideo"] params:[videoModel mj_JSONObject]];
        }
        
    }
    [_pickerView dismissViewControllerAnimated:YES completion:nil];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
}

//获取视频大小
-(NSInteger)getVideoSizeWith:(NSString*)path {
    NSInteger fileSize = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil].fileSize;
    NSLog(@"+++++++++++++++++++视频大小%ld",(long)fileSize);
    return fileSize;
}

//HttpRequest代理请求成功 返回数据
-(void)receiveMessage:(id)message {
    [self executeCallback:@"saveCallback" params:message];
}

- (void) didFailWithError:(NSError *)error {
    [self executeCallback:@"saveCallback" params:error];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

