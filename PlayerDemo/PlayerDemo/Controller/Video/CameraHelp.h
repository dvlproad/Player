//
//  CameraHelp.h
//  Lee
//
//  Created by lichq on 15/4/29.
//  Copyright (c) 2015年 lichq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import <AVFoundation/AVFoundation.h>
//#import <AssetsLibrary/AssetsLibrary.h>
//#import <Accelerate/Accelerate.h>           //为了使用Pixel_8

@interface CameraHelp : NSObject{
    AVCaptureSession *session;
    AVCaptureDeviceInput *videoInput;
    AVCaptureVideoDataOutput *dataOutput;
    
    AVCaptureVideoPreviewLayer *previewLayer;
    //UIView *cameraShowView;
    
    CALayer *destinationLayer;//dstLayer
    //UIView *destinationShowView;
}

@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureDeviceInput *videoInput;
@property (nonatomic, strong) AVCaptureVideoDataOutput *dataOutput;

@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;
@property (nonatomic, strong) IBOutlet UIView *cameraShowView;

@property (nonatomic, strong) CALayer *destinationLayer;//dstLayer
@property (nonatomic, strong) IBOutlet UIView *destinationShowView;


@end
