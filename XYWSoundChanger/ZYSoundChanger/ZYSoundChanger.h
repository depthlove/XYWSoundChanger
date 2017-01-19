//
//  ZYSoundChanger.h
//  XYWSoundChanger
//
//  Created by xueyognwei on 17/1/18.
//  Copyright © 2017年 xueyognwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYSoundChanger : NSObject

+(ZYSoundChanger *)changer;

/**
 把某个视频文件进行变声操作

 @param videoPath 视频url
 @param tempo 速度 <变速不变调> 范围 -50 ~ 100
 @param pitch 音调  范围 -12 ~ 12 （-12男，12女）
 @param rate 声音速率 范围 -50 ~ 100
 */
-(void)changeVideo:(NSString *)videoPath withTempo:(int)tempo andPitch:(int)pitch andRate:(int)rate sucess:(void (^)(NSString *videoPath))success failure:(void (^)(NSError *error))failure;
@end
