//
//  JSBridge.h
//  CPYJSCoreDemo
//
//  Created by ciel on 2016/9/29.
//  Copyright © 2016年 CPY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol JSBridgeProtocol <JSExport>
//打开模型
-(void)openModal:(id)data;
//设置标题
-(void)setTitle:(id)data;
//选择图片
-(void)selectImage:(id)data;
//上部菜单
-(void)setNavigator:(id)data;
//获取导航栏的的值
-(void)getNavValue:(id)data;
//打开新视图
-(void)openNew:(id)data;
//选择时间
-(void)selectTime:(id)data;
//设置顶部菜单
-(void)setTopMenu:(id)data;
//弹框显示
-(void)alert:(id)data;
//日期选择
-(void)selectDate:(id)data;
//等待窗口
-(void)showLoading:(id)data;
//操作成功后可隐藏 Loading
-(void)hideLoading:(id)data;
//选择省市区
-(void)selector:(id)data;
//设置底部菜单
-(void)setFootMenu:(id)data;
//读取文件
-(void)readFile:(id)data;
//查看大图
-(void)viewPicture:(id)data;
//callHostPlugin
-(void)callHostPlugin:(id)data;
//隐藏顶部菜单
-(void)hideTopRight:(id)data;
//拨打电话
-(void)dial:(id)data;
//关闭
-(void)close:(id)data;
//call 父类
-(void)callParent:(id)data;
//刷新父类
-(void)refreshParent:(id)data;
//下拉刷新
-(void)dragRefresh:(id)data;
//提示信息
-(void)prompt:(id)data;
//是否确定操作
-(void)confirm:(id)data;
//行为动作
-(void)actions:(id)data;
//获取位置信息
-(void)getLocation:(id)data;
//分页结束
-(void)onPageEnd:(id)data;
//
-(void)onResume:(id)data;
//保存状态
-(void)onSaveState:(id)data;
//获取
-(NSString*)get:(id)data;
//移除
-(void)remove:(id)data;
//放置
-(void)put:(id)data;
//接受消息
-(void)acceptMessage:(id)data;
//日历
-(void)selectCalendar:(id)data;
//二维码
-(void)show2dCode:(id)data;
//消息
-(void)message:(id)data;
//顶部消息
-(void)topMessage:(id)data;
//设置底部
-(void)setBottomBadge:(id)data;
//设置标题图标
-(void)setTitleIcon:(id)data;
//POST
-(void)postData:(id)url :(id)requestMapping :(id)callback :(id)content :(id)files ;
//视频拍摄
-(void)selectVideo:(id)data;
//播放视频
-(void)playVideo:(id)data;
//获取设备类型
-(NSString*)getDeviceModel;
//图片预览
-(void)viewPic:(id)data;
//转base64
-(NSString*)base64File:(id)data;
//检查更新
-(void)checkNewVersion:(id)updateUrl :(id)isShowTip;
//日历 选择时间范围 开始时间／结束时间
-(void)selectCalendarWithRange:(id)data;
//选择时间范围
-(void)selectDateRange:(id)data;
//删除文件
-(void)deleteFile:(id)data;
-(NSString*)getUrl;
//关闭窗口回传参数
-(void)closeForResult:(id)data;

@end

@interface JSBridge : NSObject<JSBridgeProtocol>

- (id)initWithDelegate:(id <JSBridgeProtocol>)delegate;

@property (nonatomic, weak) id<JSBridgeProtocol> delegate;
@property (nonatomic, assign) NSInteger a;

@end
