//
//  CustomAlertView.m
//  JSAndApp
//
//  Created by DiorSama on 2017/7/5.
//  Copyright © 2017年 Shane. All rights reserved.
//

#import "CustomAlertView.h"
//#import "Constant.h"

@interface CustomAlertView()

@property (nonatomic,strong) NSDictionary * dataDic;
@property (nonatomic,assign) BOOL isAlert; //是否是alert警告框

@end

@implementation CustomAlertView

- (instancetype) initWithFrame:(CGRect)frame WithData:(id)data isAlert:(BOOL)isAlert{
    if (self = [super initWithFrame:frame]){
        self.dataDic = data;
        self.isAlert = isAlert;
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 8;
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(30, 35, self.frame.size.width-60, 60)];
        if(isAlert){
            label.text = [NSString stringWithFormat:@"%@",data];
        }
        else{
            label.text = data[@"message"];
        }
        
        label.font = [UIFont systemFontOfSize:15];
        label.numberOfLines = 0;
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        
        if(isAlert){
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake((self.frame.size.width)/4, ViewMaxY(label)+10, (self.frame.size.width)/2, 35);
            [btn setTitle:@"确定" forState:UIControlStateNormal];
            btn.layer.cornerRadius = 5;
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
         
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.backgroundColor = [UIColor blueColor];
            [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag =  1;
            [self addSubview:btn];
        }
        else{
            NSArray * titleArr = @[@"取消",@"确认"];
            for(int i = 0;i<2;i++){
                UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame = CGRectMake(25+(self.frame.size.width-65)/2*i+i*15, ViewMaxY(label)+10, (self.frame.size.width-65)/2, 35);
                [btn setTitle:titleArr[i] forState:UIControlStateNormal];
                btn.layer.cornerRadius = 5;
                btn.titleLabel.font = [UIFont systemFontOfSize:14];
                if(i==0){
                    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                    btn.layer.borderWidth = 0.5;
                    btn.layer.borderColor = [UIColor grayColor].CGColor;
                }
                else{
                    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    btn.backgroundColor = [UIColor blueColor];
                }
           
                [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
                btn.tag = i;
                [self addSubview:btn];
            }
        }
       
        
    }
    return self;
}

-(void)clickBtn:(UIButton*)btn
{
    if(_block){
        if(self.isAlert){
           _block(btn.tag,nil);
        }
        else{
           _block(btn.tag,self.dataDic[@"callback"]);
        }
        
    }
    
   
//        if(_delegate){
//            [self.delegate confirmSureBtBtnClickWithBlock:self.dataDic[@"callback"] withTag:btn.tag];
//        }
    
}

-(void)aletBtnClickWithBlock:(btnClickBlock)block
{
    _block = block;
}
@end
