//
//  MoviePlayViewController.m
//  PlayerDemo
//
//  Created by lichq on 15/4/21.
//  Copyright (c) 2015年 lichq. All rights reserved.
//

#import "MoviePlayViewController.h"

@interface MoviePlayViewController ()


@end




@implementation MoviePlayViewController

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.mp_player stop]; //一定要记得关掉，否则播放器会崩溃
    
    //不用的使用记得removeObserver
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerPlaybackDidFinishNotification
                                                  object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self selectMovie_Local:nil];
}



//MPMoviePlayerController 类通过一个NSURL来初始化，这个URL可以使本地的，也可以是远程的。
- (IBAction)selectMovie_Local:(id)sender{
    NSString *pathExtension = [@"Movie.m4v" pathExtension];
    NSString *pahtWithoutExtension = [@"Movie.m4v" stringByDeletingPathExtension];
    NSString *path = [[NSBundle mainBundle] pathForResource:pahtWithoutExtension ofType:pathExtension];
    if (path == nil) {
        [[[UIAlertView alloc]initWithTitle:@"提示" message:@"本地视频不存在，请检查" delegate:nil cancelButtonTitle:@"好的，我知道了" otherButtonTitles:nil] show];
    }else{
        self.tView.text = path;
    }
}

- (IBAction)selectMovie_Remote_HTTP:(UIButton *)sender{
    self.tView.text = Url_Video_HTTP;
}

- (IBAction)selectMovie_Remote_RTSP:(UIButton *)sender{
    self.tView.text = Url_Video_RTSP;
}

- (IBAction)selectMovie_Remote_RTMP:(UIButton *)sender{
    self.tView.text = Url_Video_RTMP;
}





//方法①：使用ViewController的时候，直接present
//控制器样式使用MPMovieControlStyleFullscreen       只显示音量控制
- (IBAction)play_MPMoviePlayerViewController:(id)sender{
    NSString *path = self.tView.text;
    if ([path hasPrefix:@"http://"] || [path hasPrefix:@"rtsp://"] || [path hasPrefix:@"rtmp://"]) {
        self.movieURL = [NSURL URLWithString:path];
    }else{
        self.movieURL = [NSURL fileURLWithPath:path];//本地视频地址：注意这里不要用[NSURL urlwithstring]
    }
    
    MPMoviePlayerViewController *movieVC = [[MPMoviePlayerViewController alloc]initWithContentURL:self.movieURL];
    [self presentMoviePlayerViewControllerAnimated:movieVC];
    
    
    MPMoviePlayerController *player = movieVC.moviePlayer;
    [player setControlStyle:MPMovieControlStyleFullscreen];
    //[player setFullscreen:YES animated:YES];
    [player setScalingMode:MPMovieScalingModeAspectFit];
    [player prepareToPlay];
    [player setShouldAutoplay:YES];
    [self setPlayerProperty:player];
}


//方法②：使用Controller的时候，直接addSubview
//控制器样式使用MPMovieControlStyleEmbedded         显示播放/暂停、音量和时间控制
//是否切换到全屏[player setFullscreen:NO animated:YES];
- (IBAction)play_MPMoviePlayerController:(id)sender{
    NSString *path = self.tView.text;
    if ([path hasPrefix:@"http://"] || [path hasPrefix:@"rtsp://"] || [path hasPrefix:@"rtmp://"]) {
        self.movieURL = [NSURL URLWithString:path];
    }else{
        self.movieURL = [NSURL fileURLWithPath:path];
    }
    
    if (self.mp_player == nil) { //防止重复创建而导致内存过高，从而引起程序崩溃
        self.mp_player = [[MPMoviePlayerController alloc]initWithContentURL:self.movieURL];
        [self.mp_player.view setFrame:self.playerView.bounds];
        [self.playerView addSubview:self.mp_player.view];
        
        [self.mp_player setControlStyle:MPMovieControlStyleEmbedded];
        [self.mp_player setFullscreen:NO animated:YES];
        [self.mp_player setScalingMode:MPMovieScalingModeAspectFit];
        [self.mp_player prepareToPlay];
        [self.mp_player setShouldAutoplay:YES];
        [self setPlayerProperty:self.mp_player];
    }else{
        [self.mp_player setContentURL:self.movieURL];
    }
    
}


- (void)setPlayerProperty:(MPMoviePlayerController *)player{
    /*
    // 1.控制器样式
     可以使用下列样式：
     MPMovieControlStyleEmbedded         显示播放/暂停、音量和时间控制
     MPMovieControlStyleFullscreen       只显示音量控制
     MPMovieControlStyleNone             没有控制器
     */
    
    /*
    //2、设置视频资源类型 [movie setMovieSourceType:MPMovieSourceTypeStreaming];
     MPMovieSourceTypeUnknown     未知类型
     MPMovieSourceTypeFile        本地资源  或  容易从网络加载到本地的资源
     MPMovieSourceTypeStreaming   在线流媒体
     */
    
    [player setRepeatMode:MPMovieRepeatModeOne];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(movieFinishedCallback:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayerPlaybackStateDidChange:)
                                                 name:MPMoviePlayerPlaybackStateDidChangeNotification
                                               object:player];
    /*
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(exitFullScreen:)
                                                 name:MPMoviePlayerDidExitFullscreenNotification
                                               object:player];
    */
}



/*
 通知：
 MPMoviePlayerContentPreloadDidFinishNotification
 当电影播放器结束对内容的预加载后发出。因为内容可以在仅加载了一部分的情况下播放，所以这个通知可能在已经播放后才发出。
 
 MPMoviePlayerScallingModeDidChangedNotification
 当用户改变了电影的缩放模式后发出。用户可以点触缩放图标，在全屏播放和窗口播放之间切换。
 
 MPMoviePlayerPlaybackDidFinishNotification
 当电影播放完毕或者用户按下了Done按钮后发出。
 */

//视频播放完或者在presentMoviePlayerViewControllerAnimated下的Done按钮被点击响应的通知。
- (void)movieFinishedCallback:(NSNotification *)notify{
    MPMoviePlayerController *player = [notify object];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerPlaybackDidFinishNotification
                                                  object:player];
    [self dismissMoviePlayerViewControllerAnimated];
}

- (void)moviePlayerPlaybackStateDidChange:(NSNotification *)notify{
    NSLog(@"moviePlayerPlaybackStateDidChange");
}

//-(void)exitFullScreen:(NSNotification *)notify{
//    MPMoviePlayerController *player = [notify object];
//    [player.view removeFromSuperview];
//}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
