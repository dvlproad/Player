//
//  X264Manager.m
//  Lee
//
//  Created by lichq on 15/4/30.
//  Copyright (c) 2015年 lichq. All rights reserved.
//

#import "X264Manager.h"


@implementation X264Manager

- (void)initForX264{
    
    p264Param = malloc(sizeof(x264_param_t));
    p264Pic  = malloc(sizeof(x264_picture_t));
    memset(p264Pic,0,sizeof(x264_picture_t));
    //x264_param_default(p264Param);  //set default param
    x264_param_default_preset(p264Param, "veryfast", "zerolatency");
    p264Param->i_threads = 1;
    p264Param->i_width   = 352;  //set frame width
    p264Param->i_height  = 288;  //set frame height
    p264Param->b_cabac =0;
    p264Param->i_bframe =0;
    p264Param->b_interlaced=0;
    p264Param->rc.i_rc_method=X264_RC_ABR;//X264_RC_CQP
    p264Param->i_level_idc=21;
    p264Param->rc.i_bitrate=128;
    p264Param->b_intra_refresh = 1;
    p264Param->b_annexb = 1;
    p264Param->i_keyint_max=25;
    p264Param->i_fps_num=15;
    p264Param->i_fps_den=1;
    p264Param->b_annexb = 1;
    //    p264Param->i_csp = X264_CSP_I420;
    x264_param_apply_profile(p264Param, "baseline");
    if((p264Handle = x264_encoder_open(p264Param)) == NULL)
    {
        fprintf( stderr, "x264_encoder_open failed/n" );
        return ;
    }
    x264_picture_alloc(p264Pic, X264_CSP_I420, p264Param->i_width, p264Param->i_height);
    p264Pic->i_type = X264_TYPE_AUTO;
    
    
}

- (void)initForFilePath{
    char *path = [self GetFilePathByfileName:"IOSCamDemo.h264"];
    NSLog(@"%s",path);
    fp = fopen(path,"wb");
}

- (char*)GetFilePathByfileName:(char*)filename

{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *strName = [NSString stringWithFormat:@"%s",filename];
    
    NSString *writablePath = [documentsDirectory stringByAppendingPathComponent:strName];
    
    int len = [writablePath length];
    
    char *filepath = (char*)malloc(sizeof(char) * (len + 1));
    
    [writablePath getCString:filepath maxLength:len + 1 encoding:[NSString defaultCStringEncoding]];
    
    return filepath;
}

- (void)encoderToH264:(CMSampleBufferRef)sampleBuffer{
    
    CVImageBufferRef pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    
    CVPixelBufferLockBaseAddress(pixelBuffer, 0);
    
    uint8_t  *baseAddress0 = (uint8_t *)CVPixelBufferGetBaseAddressOfPlane(pixelBuffer, 0);
    uint8_t  *baseAddress1 = (uint8_t *)CVPixelBufferGetBaseAddressOfPlane(pixelBuffer, 1);
    
    int         i264Nal;
    x264_picture_t pic_out;
    
    memcpy(p264Pic->img.plane[0], baseAddress0, 352*288);
    uint8_t * pDst1 = p264Pic->img.plane[1];
    uint8_t * pDst2 = p264Pic->img.plane[2];
    for( int i = 0; i < 352*288/4; i ++ )
    {
        *pDst1++ = *baseAddress1++;
        *pDst2++ = *baseAddress1++;
    }
    
    if( x264_encoder_encode( p264Handle, &p264Nal, &i264Nal, p264Pic ,&pic_out) < 0 )
    {
        fprintf( stderr, "x264_encoder_encode failed/n" );
    }
    NSLog(@"i264Nal======%d",i264Nal);
    
    if (i264Nal > 0) {
        
        int i_size;
        char * data=(char *)szBodyBuffer+100;
        for (int i=0 ; i<i264Nal; i++) {
            if (p264Handle->nal_buffer_size < p264Nal[i].i_payload*3/2+4) {
                p264Handle->nal_buffer_size = p264Nal[i].i_payload*2+4;
                x264_free( p264Handle->nal_buffer );
                p264Handle->nal_buffer = x264_malloc( p264Handle->nal_buffer_size );
            }
            i_size = p264Nal[i].i_payload;
            
            memcpy(data, p264Nal[i].p_payload, p264Nal[i].i_payload);
            fwrite(data, 1, i_size, fp);
        }
        
    }
    CVPixelBufferUnlockBaseAddress(pixelBuffer, 0);
}
@end
