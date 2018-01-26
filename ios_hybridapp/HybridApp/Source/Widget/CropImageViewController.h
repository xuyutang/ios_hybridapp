//
//  CropImageViewController.h
//  WPEducation
//
//  Created by iOS-Dev on 2018/1/2.
//  Copyright © 2017年 Administrator. All rights reserved.
//

#import "ImageCropView.h"

@class CropImageViewController;
@protocol CropImageViewControllerDelegate <NSObject>

- (void)cropImageController:(CropImageViewController *)controller didFinishCroppingImage:(UIImage *)croppedImage;
- (void)cropImageControllerDidCancel:(CropImageViewController *)controller;

@end

@interface CropImageViewController : UIViewController{

    ImageCropView* imageCropView;

}

@property(nonatomic,retain) ImageCropView* imageCropView;

@property (nonatomic, assign) id<CropImageViewControllerDelegate> delegate;
@property (nonatomic, retain) UIImage *image;

@property (nonatomic, assign) BOOL keepingCropAspectRatio;
@property (nonatomic, assign) CGFloat cropAspectRatio;

@property (nonatomic, assign) CGRect cropRect;

@end
