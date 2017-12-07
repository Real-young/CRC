//
//  CRCFile.h
//  FeiHangChuangKe
//
//  Created by 王飞 on 16/7/15.
//  Copyright © 2016年 FeiHangKeJi.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CRCFile : NSObject
-(void)CRC;
-(int)getLSB;
-(int)getMSB;
-(void)finish_checksum:(int) msgid;
-(void)start_checksum;
-(void)update_checksum:(int) data;
@end
