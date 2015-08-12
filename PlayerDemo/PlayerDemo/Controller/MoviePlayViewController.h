//
//  MoviePlayViewController.h
//  Lee
//
//  Created by lichq on 15/4/21.
//  Copyright (c) 2015年 lichq. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MediaPlayer/MediaPlayer.h>
#define Url_Video_HTTP   @"http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4"
#define Url_Video_RTSP   @"rtsp://218.204.223.237:554/live/1/66251FC11353191F/e7ooqwcfbqjoo80j.sdp"
#define Url_Video_RTMP   @"rtmp://218.3.205.46/live/jjsh_sd"


@interface MoviePlayViewController : UIViewController<UITextViewDelegate>{

}

@property(nonatomic, weak) IBOutlet UITextView *tView;

@property(nonatomic, weak) IBOutlet UIView *playerView;
@property(nonatomic, strong) MPMoviePlayerController *mp_player; //必须为strong

@property(nonatomic, strong) NSURL *movieURL;

@end
