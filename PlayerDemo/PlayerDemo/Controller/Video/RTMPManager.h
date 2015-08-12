//
//  RTMPManager.h
//  Lee
//
//  Created by lichq on 15/5/5.
//  Copyright (c) 2015年 lichq. All rights reserved.
//

#import <Foundation/Foundation.h>

#include "librtmp/rtmp.h"

#include "x264.h"
#include "common/common.h"
#include "encoder/set.h"


/*定义包头长度,RTMP_MAX_HEADER_SIZE为rtmp.h中定义值为18*/
#define RTMP_HEAD_SIZE   (sizeof(RTMPPacket)+RTMP_MAX_HEADER_SIZE)


@interface RTMPManager : NSObject{
    RTMP *rtmp;
    
    RTMPPacket * packet;
    unsigned char * body;
    
    
    
    x264_slice_header_t *winsys;
    
}

- (int)initizalRTMPByUrl:(char *)rtmp_url;

@end
