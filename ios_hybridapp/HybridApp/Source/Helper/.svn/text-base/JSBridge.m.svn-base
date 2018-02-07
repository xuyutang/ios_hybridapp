//
//  JSBridge.m
//  CPYJSCoreDemo
//
//  Created by ciel on 2016/9/29.
//  Copyright © 2016年 CPY. All rights reserved.
//

#import "JSBridge.h"
#import "AppDelegate.h"

@implementation JSBridge

- (id)initWithDelegate:(id <JSBridgeProtocol>)delegate {
    if ((self = [self init])) {
        _delegate = delegate;
    }
    return self;
}
//打开模型
-(void)openModal:(id)data{
    if (_delegate) {
        [_delegate openModal:data];
    }
}

//设置标题
-(void)setTitle:(id)data{
    if (_delegate) {
        [_delegate setTitle:data];
    }
}
//选择图片
-(void)selectImage:(id)data{
    if (_delegate) {
        [_delegate selectImage:data];
    }
}

//上部菜单
-(void)setNavigator:(id)data{
    if (_delegate) {
        [_delegate setNavigator:data];
    }
}
//获取导航栏的的值
-(void)getNavValue:(id)data{
    if (_delegate) {
        [_delegate getNavValue:data];
    }
}
//打开新视图
-(void)openNew:(id)data{
    if (_delegate) {
        [_delegate openNew:data];
    }
}
//选择时间
-(void)selectTime:(id)data{
    if (_delegate) {
        [_delegate selectTime:data];
    }
}
//设置顶部菜单
-(void)setTopMenu:(id)data{
    if (_delegate) {
        [_delegate setTopMenu:data];
    }
}
//弹框显示
-(void)alert:(id)data{
    if (_delegate) {
        [_delegate alert:data];
    }
}
//日期选择
-(void)selectDate:(id)data{
    if (_delegate) {
        [_delegate selectDate:data];
    }
}
//等待窗口
-(void)showLoading:(id)data{
    if (_delegate) {
        [_delegate showLoading:data];
    }
}
//操作成功后可隐藏 Loading
-(void)hideLoading:(id)data{
    if (_delegate) {
        [_delegate hideLoading:data];
    }
}
//选择省市区
-(void)selector:(id)data{
    if (_delegate) {
        [_delegate selector:data];
    }
}
//设置底部菜单
-(void)setTabbar:(id)data{
    if (_delegate) {
        [_delegate setTabbar:data];
    }
}
//读取文件
-(void)readFile:(id)data{
    if (_delegate) {
        [_delegate readFile:data];
    }
}
//查看大图
-(void)viewPicture:(id)data{
    if (_delegate) {
        [_delegate viewPicture:data];
    }
}
//callHostPlugin
-(void)callHostPlugin:(id)data{
    if (_delegate) {
        [_delegate callHostPlugin:data];
    }
}
//隐藏顶部菜单
-(void)hideTopRight:(id)data{
    if (_delegate) {
        [_delegate hideTopRight:data];
    }
}
//拨打电话
-(void)dial:(id)data{
    if (_delegate) {
        [_delegate dial:data];
    }
}
//关闭
-(void)close:(id)data{
    if (_delegate) {
        [_delegate close:data];
    }
}
//call 父类
-(void)callParent:(id)data{
    if (_delegate) {
        [_delegate callParent:data];
    }
}

//刷新父类
-(void)refreshParent:(id)data{
    if (_delegate) {
        [_delegate refreshParent:data];
    }
}
//下拉刷新
-(void)dragRefresh:(id)data{
    if (_delegate) {
        [_delegate dragRefresh:data];
    }
}
//提示信息
-(void)prompt:(id)data{
    if (_delegate) {
        [_delegate prompt:data];
    }
}
//是否确定操作
-(void)confirm:(id)data{
    if (_delegate) {
        [_delegate confirm:data];
    }
}
//行为动作
-(void)actions:(id)data{
    if (_delegate) {
        [_delegate actions:data];
    }
}
//获取位置信息
-(void)getLocation:(id)data{
    if (_delegate) {
        [_delegate getLocation:data];
    }
}
//分页结束
-(void)onPageEnd:(id)data{
    if (_delegate) {
        [_delegate onPageEnd:data];
    }
}
//
-(void)onResume:(id)data{
    if (_delegate) {
        [_delegate onResume:data];
    }
}
//保存状态
-(void)onSaveState:(id)data{
    if (_delegate) {
        [_delegate onSaveState:data];
    }
}
//获取
-(NSString*)get:(id)data{
    if (_delegate) {
        return [_delegate get:data];
    }
    return nil;
}
//移除
-(void)remove:(id)data{
    if (_delegate) {
        [_delegate remove:data];
    }
}
//放置
-(void)put:(id)data{
    if (_delegate) {
        [_delegate put:data];
    }
}
//接受消息
-(void)acceptMessage:(id)data{
    if (_delegate) {
        [_delegate acceptMessage:data];
    }
}
//日历
-(void)selectCalendar:(id)data{
    if (_delegate) {
        [_delegate selectCalendar:data];
    }
}
//二维码
-(void)show2dCode:(id)data{
    if (_delegate) {
        [_delegate show2dCode:data];
    }
}
//消息
-(void)message:(id)data{
    if (_delegate) {
        [_delegate message:data];
    }
}
//顶部消息
-(void)topMessage:(id)data{
    if (_delegate) {
        [_delegate topMessage:data];
    }
}
//设置底部
-(void)setTabbarBadge:(id)index :(id)number
{
    if (_delegate) {
        [_delegate setTabbarBadge:index :number];
    }
}
//设置标题图标
-(void)setTitleIcon:(id)data{
    if (_delegate) {
        [_delegate setTitleIcon:data];
    }
}
//POST
-(void)postData:(id)url :(id)requestMapping :(id)callback :(id)content :(id)files {
    if (_delegate) {
        [_delegate postData:url :requestMapping :callback :content :files];
    }
}
//视频拍摄
-(void)selectVideo:(id)data{
    if (_delegate) {
        [_delegate selectVideo:data];
    }
}
//播放视频
-(void)playVideo:(id)data{
    if (_delegate) {
        [_delegate playVideo:data];
    }
}
//获取设备类型
-(NSString*)getDeviceModel{
    if (_delegate) {
       return [_delegate getDeviceModel];
    }
    return nil;
}
//图片预览
-(void)viewPic:(id)data{
    if (_delegate) {
        [_delegate viewPic:data];
    }
}
//转base64
-(NSString*)base64File:(id)data{
    if (_delegate) {
        return [_delegate base64File:data];
    }
    return nil;
}
//检查更新
-(void)checkNewVersion:(id)updateUrl :(id)isShowTip{
    if (_delegate) {
        [_delegate checkNewVersion:updateUrl :isShowTip];
    }
}
//日历 选择时间范围 开始时间／结束时间
-(void)selectCalendarWithRange:(id)data{
    if (_delegate) {
        [_delegate selectCalendarWithRange:data];
    }
}
//选择时间范围
-(void)selectDateRange:(id)data{
    if (_delegate) {
        [_delegate selectDateRange:data];
    }
}
//删除文件
-(void)deleteFile:(id)data;{
    if (_delegate) {
        [_delegate deleteFile:data];
    }
}

-(NSString*)getUrl{
    if (_delegate) {
       return [_delegate getUrl];
    }
    return nil;
}
//关闭窗口回传参数
-(void)closeForResult:(id)data{
    if (_delegate) {
        [_delegate closeForResult:data];
    }
}
//打开WiFi设置
-(void)openWifiSetting {
    if (_delegate) {
        [_delegate openWifiSetting];
    }
}
//获取WiFi
-(NSString*)getCurrentWifi {
    if (_delegate) {
     return [_delegate getCurrentWifi];
    }
    return nil;
}

@end
