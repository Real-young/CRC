//
//  CRCFile.m
//  FeiHangChuangKe
//
//  Created by 王飞 on 16/7/15.
//  Copyright © 2016年 FeiHangKeJi.com. All rights reserved.
//

#import "CRCFile.h"
// 6月21日
static int MAVLINK_MESSAGE_CRCS[] = {24, 171, 166, 193, 251, 112, 0, 250, 0, 213, 220, 160, 206, 181, 244, 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 40, 117, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 130, 197, 190, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 96, 179, 229, 115, 130, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 23, 50, 8, 0, 0, 0, 0, 0, 0, 0, 77, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 76, 26, 0, 0, 171};
@interface CRCFile ()
{
    int crcValue;
    int CRC_INIT_VALUE;
}

@end

@implementation CRCFile

-(instancetype)init
{
    if (self = [super init]) {
        crcValue = 0;
        CRC_INIT_VALUE = 0xffff;
        
    }
    return self;
}

//每一位往里装
-(void)update_checksum:(int) data
{
    data = data & 0xff; //cast because we want an unsigned type
    int tmp = data ^ (crcValue & 0xff);
    tmp ^= (tmp << 4) & 0xff;
    crcValue = ((crcValue >> 8) & 0xff) ^ (tmp << 8) ^ (tmp << 3) ^ ((tmp >> 4) & 0xf);
}
//取对应的消息id
-(void)finish_checksum:(int) msgid
{
    [self update_checksum:MAVLINK_MESSAGE_CRCS[msgid]];
}

-(void)start_checksum
{
    crcValue = CRC_INIT_VALUE;
}

-(int)getMSB
{
    return ((crcValue >> 8) & 0xff);
}

-(int)getLSB
{
    return (crcValue & 0xff);
}

-(void)CRC
{
    [self start_checksum];
}

@end
