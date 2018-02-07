//
//  FootMenuView.m
//  SalesManager
//
//  Created by iOS-Dev on 2017/12/14.
//  Copyright © 2017年 yutang xu. All rights reserved.
//

#import "FootMenuView.h"
#import "DeviceConstant.h"
#import "UIView+CNKit.h"
#import "JXButton.h"
#import "UIButton+WebCache.h"


@implementation FootMenuView

-(instancetype)initWithFrame:(CGRect)frame titleArray:(NSMutableArray*)titleArray anddefaultImagArray:(NSMutableArray*)defaultImagArray andActive:(NSMutableArray *)activeImaArray delegate:(id)delegate {
    self = [super initWithFrame:frame];
    if (self) {
        self.titles = titleArray;
        self.defaultIcons = defaultImagArray;
        self.activeIcons = activeImaArray;
        self.delegate  = delegate;
        [self createUI];
    }
    return self;
}

-(void)createUI{
    //背景色
    self.backgroundColor = [UIColor colorWithHexString:@"#f7f7fa"];
    if (_defaultIcons.count != _titles.count || _defaultIcons.count == 0) {
        NSLog(@"图标个数与标题个数不一致 或者 个数不能为0");
        return;
    }
    //上面的灰色直线
    UIView* topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0,MAINWIDTH,0.5)];
    topLine.backgroundColor = [UIColor colorWithHexString:@"#c0bfc4"];
    [self addSubview:topLine];
    _buttons = [[NSMutableArray alloc] init];
    _lables = [[NSMutableArray alloc] init];
    float x,y,w,h,linex;
    
    for (int i = 0 ; i < _defaultIcons.count; i++) {
        float cellWidth = self.frame.size.width / _defaultIcons.count * i;
        //按钮

        x = (self.frame.size.width / _defaultIcons.count) * 0.2 + cellWidth;
        y = 5;
        h = self.frame.size.height;
        w = self.frame.size.width / _defaultIcons.count;
        x = self.frame.size.width / _defaultIcons.count * i;
        linex = x + 1;
        //居中显示
        CGRect tmpFrame = CGRectMake(x, y, i > 0 ? w - 1 : w, h);
        JXButton *tmpBtn = [[JXButton alloc] initWithFrame:tmpFrame];
        tmpBtn.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [tmpBtn setTitle:_titles[i] forState:UIControlStateNormal];
        [self sd_setImageWithImadString:_defaultIcons[i] forButton:tmpBtn];
        tmpBtn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        [tmpBtn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
        tmpBtn.tag = i;
        [tmpBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_buttons addObject:tmpBtn];
        [self addSubview:tmpBtn];
        
        //角标
        _bagesLabel = [[UILabel alloc] initWithFrame:CGRectMake(tmpBtn.width*i + tmpBtn.width/2 + 8, 5, 16, 16)];
        _bagesLabel.layer.masksToBounds = YES;
        _bagesLabel.layer.cornerRadius = 8;
        _bagesLabel.textAlignment = 1;
        _bagesLabel.textColor = [UIColor whiteColor];
        _bagesLabel.font = [UIFont systemFontOfSize:9];
        _bagesLabel.backgroundColor = [UIColor colorWithHexString:MAIN_COLOR];
        _bagesLabel.hidden = YES;
        [self addSubview:_bagesLabel];
        [_lables addObject:_bagesLabel];
        //分界线
//        if (i > 0) {
//            UIView* line = [[UIView alloc] initWithFrame:CGRectMake(linex, 0, 1, self.frame.size.height)];
//            line.backgroundColor = [UIColor colorWithHexString:@"#ffececec"];
//            [self addSubview:line];
//        }
       
    }
  
     [self setDefaultColor];
}

-(void)btnAction:(NSObject*) objct{
    UIButton* btn = (UIButton*) objct;
    //设置选择颜色
    [self setBtnColor:btn.tag];
    if (_delegate && [_delegate respondsToSelector:@selector(FootMenuViewClickBtn:current:)]) {
        
        [_delegate FootMenuViewClickBtn:(int)btn.tag current:_currentIndex];
        if (btn.tag == _currentIndex) {
            _currentIndex = -1;
        }else{
            _currentIndex = (int)btn.tag;
        }
    }
    
}

-(void) setBtnColor:(int)index{
    
    UIButton* item;
    for (int i = 0; i < _buttons.count; i++) {
        item = _buttons[i];
        
        if (i == index) {
            [item setTitleColor:[UIColor colorWithHexString:MAIN_COLOR] forState:UIControlStateNormal];
            [self sd_setImageWithImadString:_activeIcons[index] forButton:item];
            
        }
        else{
            [item setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
            [self sd_setImageWithImadString:_defaultIcons[i] forButton:item];
        }
    }
    if (_currentIndex == index) {
        //选择为当前的btn，已经为选中状态，再次点击
        //        item = _buttons[index];
        //        icon = _icons[index];
        //        [item setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //  [UIColor colorWithHexString:MAIN_COLOR]      icon.image = [UIImage imageNamed:_activeIcons[index]];
    }
}


-(void)setDefaultColor {
    [((UIButton *)_buttons[0])setTitleColor:[UIColor colorWithHexString:MAIN_COLOR] forState:UIControlStateNormal];
    [self sd_setImageWithImadString:_activeIcons[0] forButton:((UIButton *)_buttons[0])];
}

-(void) setColor:(int)index{
    if (index == -1) {
        for (int i = 0; i < _buttons.count; i++) {
            [((UIButton *)_buttons[i])setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
            [self sd_setImageWithImadString:_activeIcons[index] forButton:((UIButton *)_buttons[i])];


        }
    }else{
        UIButton* item = _buttons[index];
        [item setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
        [self sd_setImageWithImadString:_activeIcons[index] forButton:item];
    }
    _currentIndex = -1;
}

//加载图片
-(void)sd_setImageWithImadString:(NSString*)imageString forButton:(UIButton*)button {
    UIImage *image ;
    if ([imageString hasPrefix:@"http"] || [imageString hasPrefix:@"https"]) {
        [button sd_setImageWithURL:[NSURL URLWithString:imageString] forState:UIControlStateNormal];
    }else {
        NSString *imagePath = [[NSBundle mainBundle] pathForResource:imageString ofType:@"png" inDirectory:@"assets/images"];
        image = [UIImage imageWithContentsOfFile:imagePath];
        [button setImage:image forState:UIControlStateNormal];
    }
}

//设置角标
-(void)setbadge {
    UILabel* label;
    
    for (int i = 0; i < _lables.count; i++) {
        label = _lables[i];
        
        if (i == self.badgeIndex) {
            label.hidden = NO;
            label.text = [NSString stringWithFormat:@"%ld",(long)self.badgeNumber];
            label.width  = [self getWidthWithTitle:[NSString stringWithFormat:@"%ld",(long)self.badgeNumber] font:[UIFont systemFontOfSize:9]] + 10;
        }
        else{
            //            [item setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
            //            //icon.image = [UIImage imageNamed:_defaultIcons[i]];
            //            icon.image = [self setImageWithImageName:_defaultIcons[i]];
            
        }
    }
    if (_currentIndex == index) {
        //选择为当前的btn，已经为选中状态，再次点击
        //        item = _buttons[index];
        //        icon = _icons[index];
        //        [item setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //  [UIColor colorWithHexString:MAIN_COLOR]      icon.image = [UIImage imageNamed:_activeIcons[index]];
    }
}

-(CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1000, 0)];
    label.text = title;
    label.font = font;
    [label sizeToFit];
    return label.frame.size.width;
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end

