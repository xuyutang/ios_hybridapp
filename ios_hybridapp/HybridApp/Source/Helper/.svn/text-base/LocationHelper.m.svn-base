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

@interface LocationHelper() <BMKMapViewDelegate,BMKGeneralDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>{
    NSString* _baiduKey;
    double _dLatitude;
    double _dLongitude;
    NSString* _lastAddress;
    
    BMKLocationService *_locService;
    BMKGeoCodeSearch *_search;
    
    NSTimeInterval _lastExecTime;

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
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    NSTimeInterval curExecTime = [[NSDate date] timeIntervalSince1970];
    long long int lastExecSec = (long long int)_lastExecTime;
    long long int curExecSec = (long long int)curExecTime;
    
    if ((curExecSec - lastExecSec) < 10){
        //DLog(@"Should be not update loaction in 10 sec.");
        return;
    }
    
    _dLatitude = userLocation.location.coordinate.latitude;
    _dLongitude = userLocation.location.coordinate.longitude;
    //发起反地理编码
    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){_dLatitude, _dLongitude};
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeocodeSearchOption.reverseGeoPoint = pt;
    BOOL flag = [_search reverseGeoCode:reverseGeocodeSearchOption];
    
    if(!flag)
        DLog(@"百度地图反geo检索发送失败");
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
        
        //DLog(@"%@",locationModel.address);
        //发送广播通知UI更新地址
        [[NSNotificationCenter defaultCenter] postNotificationName:kUpdateLocationNotification object:nil];
        
        _lastExecTime = [[NSDate date] timeIntervalSince1970];

    }
}

- (void)refreshUserLocation{
    [[NSNotificationCenter defaultCenter] postNotificationName:kUpdateLocationNotification object:nil];
}

- (void)startUserLocationService{
    if ([CLLocationManager locationServicesEnabled]) {
        [_locService startUserLocationService];
        DLog(@"百度地图启动定位服务");
    }else{
        [_locService stopUserLocationService];
        _locationModel = nil;
        DLog(@"本机定位关闭");
    }
}

- (void)stopUserLocationService{
    //[_gpsTimer setFireDate:[NSDate distantFuture]];
    [_locService stopUserLocationService];
    DLog(@"百度地图关闭定位服务");
}
@end
