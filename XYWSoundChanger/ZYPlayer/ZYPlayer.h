//
//  ZYPlayer.h
//  Player
//
//  Created by xueyongwei on 2016/11/22.
//  Copyright © 2016年 任子丰. All rights reserved.
//

#ifndef ZYPlayer_h
#define ZYPlayer_h

#define iPhone4s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
// 监听TableView的contentOffset
#define kZFPlayerViewContentOffset          @"contentOffset"
#define kZYPlayToEndTimeNotification        @"ZYPlayToEndTimeNotification"
#define kZYPlayRepeatPlayNotification        @"ZYPlayRepeatPlayNotification"
#define kZYPlayShowControllerNotification        @"ZYPlayShowControllerNotification"
#define kZYPlayHideControllerNotification        @"ZYPlayHideControllerNotification"

// player的单例
#define ZFPlayerShared                      [ZFBrightnessView sharedBrightnessView]
// 屏幕的宽
#define ScreenWidth                         [[UIScreen mainScreen] bounds].size.width
// 屏幕的高
#define ScreenHeight                        [[UIScreen mainScreen] bounds].size.height
// 颜色值RGB
#define RGBA(r,g,b,a)                       [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

#import "ZYPlayerView.h"
#import "ZYPlayerControlView.h"
#import <Masonry/Masonry.h>
#import "XYWAlert.h"
#endif /* ZYPlayer_h */
