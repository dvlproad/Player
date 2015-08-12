//
//  RTMPManager.m
//  Lee
//
//  Created by lichq on 15/5/5.
//  Copyright (c) 2015年 lichq. All rights reserved.
//

#import "RTMPManager.h"

@implementation RTMPManager


- (int)initizalRTMPByUrl:(char *)rtmp_url{
//    /*分配与初始化*/
//    rtmp = RTMP_Alloc();
//    RTMP_Init(rtmp);
//    
//    /*设置URL*/
//    if (RTMP_SetupURL(rtmp,rtmp_url) == FALSE) {
//        //        log(LOG_ERR,"RTMP_SetupURL() failed!");
//        RTMP_Free(rtmp);
//        return -1;
//    }
//    
//    /*设置可写,即发布流,这个函数必须在连接前使用,否则无效*/
//    RTMP_EnableWrite(rtmp);
//    
//    /*连接服务器*/
//    if (RTMP_Connect(rtmp, NULL) == FALSE) {
//        //        log(LOG_ERR,"RTMP_Connect() failed!");
//        RTMP_Free(rtmp);
//        return -1;
//    }
//    
//    /*连接流*/
//    if (RTMP_ConnectStream(rtmp,0) == FALSE) {
//        //        log(LOG_ERR,"RTMP_ConnectStream() failed!");
//        RTMP_Close(rtmp);
//        RTMP_Free(rtmp);
//        return -1;
//    }
//    
    
    return 1;
}



//
//- (void)useRTMP:(int)len timeoffset:(int)timeoffset{
//    /*分配包内存和初始化,len为包体长度*/
//    packet = (RTMPPacket *)malloc(RTMP_HEAD_SIZE+len);
//    memset(packet,0,RTMP_HEAD_SIZE);
//    
//    /*包体内存*/
//    packet->m_body = (char *)packet + RTMP_HEAD_SIZE;
//    body = (unsigned char *)packet->m_body;
//    packet->m_nBodySize = len;
//    
//    /*
//     * 此处省略包体填充
//     */
//    packet->m_hasAbsTimestamp = 0;
//    packet->m_packetType = RTMP_PACKET_TYPE_VIDEO; /*此处为类型有两种一种是音频,一种是视频*/
//    packet->m_nInfoField2 = rtmp->m_stream_id;
//    packet->m_nChannel = 0x04;
//    packet->m_headerType = RTMP_PACKET_SIZE_LARGE;
//    packet->m_nTimeStamp = timeoffset;
//    
//    /*发送*/
//    int ret = -1;
//    if (RTMP_IsConnected(rtmp)) {
//        ret = RTMP_SendPacket(rtmp,packet,TRUE); /*TRUE为放进发送队列,FALSE是不放进发送队列,直接发送*/
//    }
//    NSLog(@"RTMP_SendPacket发送%@", ret > 0 ? @"成功" : @"失败");
//    
//    
//    /*释放内存*/
//    free(packet);
//}
//
//- (void)rtmpClose{
//    /*关闭与释放*/
//    RTMP_Close(rtmp);
//    RTMP_Free(rtmp);
//}


/*
4.包类型
4.1 H.264编码信息帧

H.264的编码信息帧是发送给RTMP服务器称为AVC sequence header，RTMP服务器只有收到AVC sequence header中的sps,pps才能解析后续发送的H264帧。
*/

//int send_video_sps_pps()
//{
//    RTMPPacket * packet;
//    unsigned char * body;
//    int i;
//    
//    packet = (RTMPPacket *)malloc(RTMP_HEAD_SIZE+1024);
//    memset(packet,0,RTMP_HEAD_SIZE);
//    
//    packet->m_body = (char *)packet + RTMP_HEAD_SIZE;
//    body = (unsigned char *)packet->m_body;
//    
//    memcpy(winsys->pps,buf,len);
//    winsys->pps_len = len;
//    
//    i = 0;
//    body[i++] = 0x17;
//    body[i++] = 0x00;
//    
//    body[i++] = 0x00;
//    body[i++] = 0x00;
//    body[i++] = 0x00;
//    
//    /*AVCDecoderConfigurationRecord*/
//    body[i++] = 0x01;
//    body[i++] = sps[1];
//    body[i++] = sps[2];
//    body[i++] = sps[3];
//    body[i++] = 0xff;
//    
//    /*sps*/
//    body[i++]   = 0xe1;
//    body[i++] = (sps_len >> 8) & 0xff;
//    body[i++] = sps_len & 0xff;
//    memcpy(&body[i],sps,sps_len);
//    i +=  sps_len;
//    
//    /*pps*/
//    body[i++]   = 0x01;
//    body[i++] = (pps_len >> 8) & 0xff;
//    body[i++] = (pps_len) & 0xff;
//    memcpy(&body[i],pps,pps_len);
//    i +=  pps_len;
//    
//    packet->m_packetType = RTMP_PACKET_TYPE_VIDEO;
//    packet->m_nBodySize = i;
//    packet->m_nChannel = 0x04;
//    packet->m_nTimeStamp = 0;
//    packet->m_hasAbsTimestamp = 0;
//    packet->m_headerType = RTMP_PACKET_SIZE_MEDIUM;
//    packet->m_nInfoField2 = rtmp->m_stream_id;
//    
//    /*调用发送接口*/
//    RTMP_SendPacket(rtmp,packet,TRUE);
//    free(packet);
//    
//    return 0;
//}



@end
