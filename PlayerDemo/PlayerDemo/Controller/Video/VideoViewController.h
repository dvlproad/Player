//
//  VideoViewController.h
//  Lee
//
//  Created by lichq on 15/4/20.
//  Copyright (c) 2015年 lichq. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MediaPlayer/MediaPlayer.h>
#import <ASIHTTPRequest.h>
#import "AudioButton.h"

@interface VideoViewController : UIViewController{
    ASIHTTPRequest *videoRequest;
    unsigned long long Recordull;
    BOOL isPlay;
}

@end
