//
//  CropImageViewController.m
//  Club
//
//  Created by iOS-Dev on 2018/1/2.
//  Copyright © 2018年 Administrator. All rights reserved.
//
#import "CropImageViewController.h"

@interface CropImageViewController ()

@end

@implementation CropImageViewController
@synthesize imageCropView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	//
    [self.view setBackgroundColor:[UIColor whiteColor]];
  [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navBack"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.hidden = NO;
    
    UIButton* leftBtn= [UIButton buttonWithType:UIButtonTypeCustom];
   // [leftBtn setImage:[UIImage imageNamed:@"设置按钮"] forState:UIControlStateNormal];
   // leftBtn.frame = CGRectMake(0, 0, 30, 30);
    [leftBtn setTitle:@"返回" forState:UIControlStateNormal];
    UIBarButtonItem* leftBtnItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    [leftBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = leftBtnItem;
    
    UIButton* rightBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    // [leftBtn setImage:[UIImage imageNamed:@"设置按钮"] forState:UIControlStateNormal];
    //leftBtn.frame = CGRectMake(0, 0, 30, 30);
    [rightBtn setTitle:@"保存"forState:UIControlStateNormal];
    UIBarButtonItem* rightBtnItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    [rightBtn addTarget:self action:@selector(saveImage:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = rightBtnItem;
  //  [self.navigationItem setleftBarButtonItem:leftBtnItem];
//    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 130, 60)];
//    UIImageView *seachImageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 10, 25, 25)];
//    [seachImageView setImage:[UIImage imageNamed:@"ab_icon_save"]];
    
//    [seachImageView setImage:[UIImage imageNamed:@"topbar_button_save"]];
//    seachImageView.textColor = WT_RED;
//    seachImageView.font = [UIFont fontWithName:kFontAwesomeFamilyName size:20.f];
//    seachImageView.text = [NSString fontAwesomeIconStringForEnum:ICON_SAVE];
 
    
  //  UIBarButtonItem *btRight = [[UIBarButtonItem alloc] initWithCustomView:rightView];
//    self.rightButton = btRight;
//    [btRight release];
//    [rightView release];
//    [lblFunctionName setText:NSLocalizedString(@"bar_cut_photo", @"")];
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.view.backgroundColor = [UIColor blackColor];
    
    self.imageCropView = [[ImageCropView alloc] initWithFrame:self.view.bounds];
    self.imageCropView.controlColor = [UIColor redColor];
    
    [self.view addSubview:self.imageCropView];
    
    self.imageCropView.image = self.image;
}

-(void)back {
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)clickLeftButton:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)saveImage:(id)sender{
    if ([self.delegate respondsToSelector:@selector(cropImageController:didFinishCroppingImage:)]) {
        [self.delegate cropImageController:self didFinishCroppingImage:[self.imageCropView getCropImage]];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    self.imageCropView.image = image;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{


}

-(void)viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Hidden_nav" object:nil];
}

@end
