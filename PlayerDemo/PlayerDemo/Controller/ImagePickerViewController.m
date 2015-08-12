//
//  ImagePickerViewController.m
//  PlayerDemo
//
//  Created by lichq on 8/7/15.
//  Copyright (c) 2015 ciyouzen. All rights reserved.
//

#import "ImagePickerViewController.h"
#import <MobileCoreServices/MobileCoreServices.h> //用于设置self.imagePicker.mediaTypes = @[(NSString *)kUTTypeImage];

#import <AVFoundation/AVFoundation.h>


@interface ImagePickerViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (strong,nonatomic) UIImagePickerController *imagePicker;
@property (weak, nonatomic) IBOutlet UIImageView *imageV;//照片展示视图
@property (strong ,nonatomic) AVPlayer *av_player;//播放器，用于录制完视频后播放视频

@end

@implementation ImagePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


#pragma mark - 点击拍照按钮
- (IBAction)takeClick:(UIButton *)sender{
    if (sender.tag == 1000 || sender.tag == 1001) { //摄像头:(视频拍摄、图片拍摄)
        BOOL isSupportCamera = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
        if (isSupportCamera == NO) {
            [[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"友情提示", nil)
                                       message:NSLocalizedString(@"对不起，您的手机不支持拍照功能", nil)
                                      delegate:nil
                             cancelButtonTitle:NSLocalizedString(@"好的，我知道了", nil)
                             otherButtonTitles:nil] show];
            return;
        }
        
        
        if (!self.imagePicker) {
            self.imagePicker = [[UIImagePickerController alloc]init];
        }
        
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        self.imagePicker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        self.imagePicker.delegate = self;
        self.imagePicker.allowsEditing = YES;
        
        if (sender.tag == 1000) {
            self.imagePicker.mediaTypes = @[(NSString *)kUTTypeMovie];
            self.imagePicker.videoQuality = UIImagePickerControllerQualityTypeIFrame1280x720;
            self.imagePicker.videoMaximumDuration = 30.0f;
            self.imagePicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModeVideo;//设置摄像头模式（拍照，录制视频）
            
        }else{
            self.imagePicker.mediaTypes = @[(NSString *)kUTTypeImage];
            self.imagePicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
        }
        
        
        [self presentViewController:self.imagePicker animated:YES completion:nil];
    }
}

/*
 //检测
 - (BOOL)videoRecordingAvailable{
 if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
 return NO;
 }
 
 NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
 
 return [availableMediaTypes containsObject:@"test.video"];
 }
 */


#pragma mark - UIImagePickerController代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {//照片拍摄
        UIImage *image;
        if (self.imagePicker.allowsEditing) {
            image = [info objectForKey:UIImagePickerControllerEditedImage];
        }else{
            image = [info objectForKey:UIImagePickerControllerOriginalImage];
        }
        [self.imageV setImage:image];//显示照片
        //UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);//保存到相簿
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }else if([mediaType isEqualToString:(NSString *)kUTTypeMovie]){//视频录制
        NSURL *url= [info objectForKey:UIImagePickerControllerMediaURL];//视频路径
        NSString *urlStr = [url path];
        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(urlStr)) {
            //保存视频到相簿，注意也可以使用ALAssetsLibrary来保存
            //UISaveVideoAtPathToSavedPhotosAlbum(urlStr, self, @selector(video:didFinishSavingWithError:contextInfo:), nil);//保存视频到相簿
            
            [self dismissViewControllerAnimated:YES completion:nil];
            [self video:urlStr didFinishSavingWithError:nil contextInfo:nil];
        }
        
    }
    
    //    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}



//视频保存后的回调
- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error) {
        NSLog(@"保存视频过程中发生错误，错误信息:%@",error.localizedDescription);
    }else{
        NSLog(@"视频保存成功.");
        //录制完之后自动播放
        NSURL *movieURL = [NSURL fileURLWithPath:videoPath];
        //        _player = [AVPlayer playerWithURL:self.movieURL];
        //        AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
        //        playerLayer.frame = self.imageV.frame;
        //        [self.imageV.layer addSublayer:playerLayer];
        //        [_player play];
    }
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
