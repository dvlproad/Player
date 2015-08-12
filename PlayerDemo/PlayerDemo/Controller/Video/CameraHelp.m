//
//  CameraHelp.m
//  Lee
//
//  Created by lichq on 15/4/29.
//  Copyright (c) 2015年 lichq. All rights reserved.
//

#import "CameraHelp.h"

@implementation CameraHelp




- (void)startVideoCapture{
    
    //防锁
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    
    
    if (session || [session.inputs containsObject:videoInput]) {
        NSLog(@"Already capturing");
        return;
    }
    
    [self initialSession];
}


- (void)initialSession
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    videoInput = [[AVCaptureDeviceInput alloc]initWithDevice:device error:nil];
    //videoInput = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    
    
    dataOutput = [[AVCaptureVideoDataOutput alloc]init];
    dataOutput.videoSettings = [NSDictionary dictionaryWithObject:[NSNumber numberWithUnsignedInt:kCVPixelFormatType_420YpCbCr8BiPlanarFullRange] forKey:(NSString *)kCVPixelBufferPixelFormatTypeKey];
    [dataOutput setAlwaysDiscardsLateVideoFrames:YES];
    
    dispatch_queue_t queue = dispatch_queue_create("VideoQueue", DISPATCH_QUEUE_SERIAL);
    [dataOutput setSampleBufferDelegate:self queue:queue];
    

    session = [[AVCaptureSession alloc] init];
    [session setSessionPreset:AVCaptureSessionPresetMedium];
    if ([session canAddInput:videoInput]) {
        [session addInput:videoInput];
    }
    if ([session canAddOutput:dataOutput]) {
        [session addOutput:dataOutput];
    }
    
}


@end
