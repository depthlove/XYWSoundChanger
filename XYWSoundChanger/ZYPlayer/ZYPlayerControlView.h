//
//  ZYPlayerControlView.h
//  Player
//
//  Created by xueyongwei on 2016/11/22.
//  Copyright © 2016年 任子丰. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SliderTapBlock)(CGFloat value);

@interface ZYPlayerControlView : UIView
/** 开始播放按钮 */
@property (nonatomic, strong, readonly) UIButton                *startBtn;
/** 当前播放时长label */
@property (nonatomic, strong, readonly) UILabel                 *currentTimeLabel;
/** 视频总时长label */
@property (nonatomic, strong, readonly) UILabel                 *totalTimeLabel;
/** 缓冲进度条 */
@property (nonatomic, strong, readonly) UIProgressView          *progressView;
/** 滑杆 */
@property (nonatomic, strong, readonly) UISlider   *videoSlider;
/** 快进快退label */
@property (nonatomic, strong, readonly) UILabel                 *horizontalLabel;
/** 系统菊花 */
@property (nonatomic, strong, readonly) UIActivityIndicatorView *activity;
/** 重播按钮 */
@property (nonatomic, strong, readonly) UIButton                *repeatBtn;
/** bottomView*/
@property (nonatomic, strong, readonly) UIView             *bottomToolView;
/** 底部播放进度条 */
@property (nonatomic, strong, readonly) UIProgressView          *bottomProgressView;
/** 播放按钮 */
@property (nonatomic, strong, readonly) UIButton                *playeBtn;
/** slidertap事件Block */
@property (nonatomic, copy  ) SliderTapBlock                    tapBlock;

/** 重置ControlView */
- (void)resetControlView;
/** 切换分辨率时候调用此方法*/
- (void)resetControlViewForResolution;
/** 显示top、bottom、lockBtn*/
- (void)showControlView;
/** 隐藏top、bottom、lockBtn*/
- (void)hideControlView;
@end
