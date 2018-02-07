//
//  LocationHelper.m
//  JSAPP
//
//  Created by lzhang@juicyshare.cc on 2018/1/21.
//  Copyright © 2018年 Administrator. All rights reserved.
//

#import "LocationHelper.h"
#import "LocationModel.h"
//引入检索功能所有的头文件
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
//引入定位功能所有的头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
//只引入所需的单个头文件
#import <BaiduMapAPI_Map/BMKMapView.h>
#import "DeviceConstant.h"
#import "MBProgressHUD+Util.h"

#define kGpsDuration                10.0
#define kCheckLocationTimes         10
#define khorizontalAccuracy         3000

@interface LocationHelper() <BMKMapViewDelegate,BMKGeneralDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>{
    NSString* _baiduKey;
    double _dLatitude;
    double _dLongitude;
    NSString* _lastAddress;
    
    BMKLocationService *_locService;
    BMKGeoCodeSearch *_search;
    
    NSTimeInterval _lastExecTime;
    NSTimer *_gpsTimer;
    BOOL _isRunning;
}

@end
@implementation LocationHelper

+(LocationHelper*) sharedInstance {
    static LocationHelper* sharedInstance = nil;
    static dispatch_once_t pred;
    
    dispatch_once(&pred, ^{
        sharedInstance = [[LocationHelper alloc] init];
    });
    
    return sharedInstance;
}

- (void)startWithBaiduKey:(NSString*)baiduKey{
    [self initParameter];
    
    _baiduKey = baiduKey;
    
    [self initBM];
}

- (void) initParameter{
    _baiduKey = nil;
    _dLatitude = 0.0;
    _dLongitude = 0.0;
    _lastAddress = nil;
    
    _locService = nil;
    _search = nil;
    
    _locationModel = nil;
    _isRunning = FALSE;
}

- (void) initBM{
    BMKMapManager *mapManager = [[BMKMapManager alloc]init];
    BOOL ret = [mapManager start:_baiduKey generalDelegate:nil];
    DLog(@"Baidu Key:%@",_baiduKey);
    
    if (!ret) {
        DLog(@"manager start failed!");
    }
    
    if ((CURRENT_OS_VERSION >= IOS8) && (CURRENT_OS_VERSION < IOS9)) {
        CLLocationManager  *locationManager = [[CLLocationManager alloc] init];
        //获取授权认证
        [locationManager requestAlwaysAuthorization];
        [locationManager requestWhenInUseAuthorization];
    }
    
    _search = [[BMKGeoCodeSearch alloc]init];
    _search.delegate = self;
    
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    [self startUserLocationService];
}

- (void)onGetNetworkState:(int)iError {
    if (0 == iError) {
        DLog(@"百度地图联网成功");
    }
    else{
        DLog(@"百度地图 onGetNetworkState %d",iError);
    }
}

- (void)onGetPermissionState:(int)iError {
    if (0 == iError) {
        DLog(@"百度地图授权成功");
    }
    else {
        DLog(@"百度地图 onGetPermissionState %d",iError);
    }
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation{
// - (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    //DLog(@"%f,%f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    if ([self checkRepeatLocation])
        return;
    
    _lastExecTime = [[NSDate date] timeIntervalSince1970];
    
    _dLatitude = userLocation.location.coordinate.latitude;
    _dLongitude = userLocation.location.coordinate.longitude;
    //发起反地理编码
    
    if ((_dLatitude < 0) || (_dLongitude < 0)) return;
    
    if (_locationModel)
        _locationModel = nil;
    _locationModel = [[LocationModel alloc] init];
    _locationModel.longitude = _dLongitude;
    _locationModel.latitude = _dLatitude;
    _locationModel.address = [NSString stringWithFormat:@"%f,%f",_dLongitude,_dLatitude];
    
    DLog(@"%@",_locationModel.address);

    if (userLocation.location.horizontalAccuracy > khorizontalAccuracy){
        [MBProgressHUD showMessageWithNoModel:@"当前GPS信号弱，请稍后刷新重试。" RemainTime:2.0];
        [[NSNotificationCenter defaultCenter] postNotificationName:kUpdateLocationNotification object:nil];
        return;
    }
    
    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){_dLatitude, _dLongitude};
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeocodeSearchOption.reverseGeoPoint = pt;
    BOOL flag = [_search reverseGeoCode:reverseGeocodeSearchOption];
    
    if(!flag){
        DLog(@"百度地图反geo检索发送失败");
    }
    //发送广播通知UI更新地址
    [[NSNotificationCenter defaultCenter] postNotificationName:kUpdateLocationNotification object:nil];

}

- (void)didFailToLocateUserWithError:(NSError *)error{
    DLog(@"%@",error);
}

-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
    if (error == 0) {
        _lastAddress = [result.address copy];
    
        LocationModel *locationModel = [[LocationModel alloc] init];
        locationModel.latitude = _dLatitude;
        locationModel.longitude = _dLongitude;
        locationModel.city = result.addressDetail.city;
        locationModel.province = result.addressDetail.province;
        locationModel.district = result.addressDetail.district;
        locationModel.address = [NSString stringWithFormat:@"%@%@",result.address,result.sematicDescription];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        locationModel.createTime = [formatter stringFromDate:[NSDate date]];
        if (_locationModel)
            _locationModel = nil;
        _locationModel = locationModel;
        
        DLog(@"%f,%f,%@",locationModel.longitude,locationModel.latitude,locationModel.address);
    }
    //发送广播通知UI更新地址
    [[NSNotificationCenter defaultCenter] postNotificationName:kUpdateLocationNotification object:nil];
    //[self stopUserLocationService];
}

- (void)refreshUserLocation{
    if ([self checkRepeatLocation])
        return;
    
    if (![self checkCLAuthorizationStatus]){
        if (_locationModel)
            _locationModel = nil;
        [[NSNotificationCenter defaultCenter] postNotificationName:kUpdateLocationNotification object:nil];
    }else{
        [self stopUserLocationService];
        [self startUserLocationService];
    }
}

- (void)startUserLocationService{
    /*if(_gpsTimer == nil){
        _gpsTimer = [NSTimer scheduledTimerWithTimeInterval:GPS_DURATION target:self selector:@selector(starLocationService) userInfo:nil repeats:YES];
    }*/
    if (![self checkCLAuthorizationStatus]){
        [_locService stopUserLocationService];
    }else{
        [self starLocationService];
    }
}

- (void)stopUserLocationService{
    if (_locationModel)
        _locationModel = nil;
    [_locService stopUserLocationService];
    DLog(@"百度地图关闭定位服务");
}

- (void)starLocationService{
    if (![self checkCLAuthorizationStatus]){
        if (_locationModel)
            _locationModel = nil;
        [[NSNotificationCenter defaultCenter] postNotificationName:kUpdateLocationNotification object:nil];
        return;
    }
    [_locService startUserLocationService];
    DLog(@"百度地图启动定位服务");
}

- (void)openLocationSetting{
    if (CURRENT_OS_VERSION >= IOS8) {
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        }
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=LOCATION_SERVICES"]];
    }
}

- (void)trunOnUserLocationService{
    [self startUserLocationService];
    //[_gpsTimer setFireDate:[NSDate distantPast]];
}

- (void)trunOffUserLocationService{
    [self stopUserLocationService];
    //[_gpsTimer setFireDate:[NSDate distantFuture]];
}

- (BOOL)checkRepeatLocation{
    NSTimeInterval curExecTime = [[NSDate date] timeIntervalSince1970];
    long long int lastExecSec = (long long int)_lastExecTime;
    long long int curExecSec = (long long int)curExecTime;
    
    if ((curExecSec - lastExecSec) < kCheckLocationTimes){
        //DLog(@"Should be not update loaction in 10 sec.");
        [[NSNotificationCenter defaultCenter] postNotificationName:kUpdateLocationNotification object:nil];
        return TRUE;
    }
    return FALSE;
}

//检测是否打开定位
- (BOOL)checkCLAuthorizationStatus{
    if ([CLLocationManager locationServicesEnabled] == NO){
        [MBProgressHUD showMessageWithNoModel:@"当前设备禁用了定位服务，请前往设置开启。" RemainTime:2.0];
        return FALSE;
    }else{
        CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
        if (kCLAuthorizationStatusDenied == status || kCLAuthorizationStatusRestricted == status) {
            [MBProgressHUD showMessageWithNoModel:@"当前设备未开启定位，请前往设置开启。" RemainTime:2.0];
            return FALSE;
        }
        return TRUE;
    }
}

@end
