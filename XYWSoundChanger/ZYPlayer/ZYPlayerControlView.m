//
//  ZYPlayerControlView.m
//  Player
//
//  Created by xueyongwei on 2016/11/22.
//  Copyright © 2016年 任子丰. All rights reserved.
//

#import "ZYPlayerControlView.h"
#import "ZYPlayer.h"
@interface ZYPlayerControlView ()
/** 开始播放按钮 */
@property (nonatomic, strong) UIButton                *startBtn;
/** 播放按钮 */
@property (nonatomic, strong) UIButton                *playeBtn;
/** 快进快退label */
@property (nonatomic, strong) UILabel                 *horizontalLabel;
/** 系统菊花 */
@property (nonatomic, strong) UIActivityIndicatorView *activity;
/** 重播按钮 */
@property (nonatomic, strong) UIButton                *repeatBtn;

/** bottomView*/
@property (nonatomic, strong) UIView             *bottomToolView;
/** 当前播放时长label */
@property (nonatomic, strong) UILabel                 *currentTimeLabel;
/** 视频总时长label */
@property (nonatomic, strong) UILabel                 *totalTimeLabel;
/** 缓冲进度条 */
@property (nonatomic, strong) UIProgressView          *progressView;
/** 滑杆 */
@property (nonatomic, strong) UISlider                *videoSlider;

/** 底部播放进度条 */
@property (nonatomic, strong) UIProgressView          *bottomProgressView;
@end

@implementation ZYPlayerControlView
- (instancetype)init
{
    self = [super init];
    
    if (self) {
        {
            [self addSubview:self.startBtn];
            [self addSubview:self.playeBtn];
            [self addSubview:self.activity];
            [self addSubview:self.repeatBtn];
            [self addSubview:self.horizontalLabel];
            
            [self addSubview:self.bottomToolView];
        }
        {
            [self.bottomToolView addSubview:self.currentTimeLabel];
            [self.bottomToolView addSubview:self.progressView];
            [self.bottomToolView addSubview:self.videoSlider];
            [self.bottomToolView addSubview:self.totalTimeLabel];
        }
        {
            [self addSubview:self.bottomProgressView];
            self.bottomProgressView.alpha = 0;
        }
        // 添加子控件的约束
        [self makeSubViewsConstraints];
        
        UITapGestureRecognizer *sliderTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSliderAction:)];
        [self.videoSlider addGestureRecognizer:sliderTap];
        
        [self.activity stopAnimating];
        // 初始化时重置controlView
        [self resetControlView];
    }
    return self;
}

- (void)makeSubViewsConstraints
{
    {
        [self.activity mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
        [self.repeatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
        [self.playeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.width.height.mas_equalTo(50);
        }];
        [self.startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.width.height.mas_equalTo(50);
        }];
        [self.horizontalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.height.mas_equalTo(20);
        }];
    }
    {
        [self.bottomToolView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.equalTo(self);
            make.height.mas_equalTo(30);
        }];
        [self.currentTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bottomToolView.mas_left).offset(3);
            make.centerY.equalTo(self.bottomToolView.mas_centerY);
            make.width.mas_equalTo(43);
            make.height.mas_equalTo(30);
        }];
        
        [self.totalTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.bottomToolView.mas_right).offset(3);
            make.centerY.equalTo(self.bottomToolView.mas_centerY);
            make.width.mas_equalTo(43);
            make.height.mas_equalTo(30);
        }];
        
        [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.currentTimeLabel.mas_right).offset(3);
            make.centerY.equalTo(self.bottomToolView.mas_centerY).offset(1);
            make.right.equalTo(self.totalTimeLabel.mas_left).offset(3);
        }];
        
        [self.videoSlider mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.currentTimeLabel.mas_right).offset(3);
            make.centerY.equalTo(self.bottomToolView.mas_centerY);
            make.right.equalTo(self.totalTimeLabel.mas_left).offset(3);
            make.height.mas_equalTo(30);
        }];
    }
    [self.bottomProgressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_bottom);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(1);
    }];
    
    
    
    
    
    
}
#pragma mark - Action

/**
 *  UISlider TapAction
 */
- (void)tapSliderAction:(UITapGestureRecognizer *)tap
{
    if ([tap.view isKindOfClass:[UISlider class]] && self.tapBlock) {
        UISlider *slider = (UISlider *)tap.view;
        CGPoint point = [tap locationInView:slider];
        CGFloat length = slider.frame.size.width;
        // 视频跳转的value
        CGFloat tapValue = point.x / length;
        self.tapBlock(tapValue);
    }
}

#pragma mark - Public Method

/** 重置ControlView */
- (void)resetControlView
{
    self.videoSlider.value      = 0;
    self.progressView.progress  = 0;
    self.currentTimeLabel.text  = @"00:00";
    self.totalTimeLabel.text    = @"00:00";
    self.horizontalLabel.hidden = YES;
    self.repeatBtn.hidden       = YES;
    self.backgroundColor        = [UIColor clearColor];
}

- (void)resetControlViewForResolution
{
    self.horizontalLabel.hidden = YES;
    self.repeatBtn.hidden       = YES;
    self.backgroundColor        = [UIColor clearColor];
}

- (void)showControlView
{
    dispatch_async(dispatch_get_main_queue(), ^{
        //主线程更新界面
        self.bottomToolView.alpha = 1;
        self.bottomProgressView.alpha = 0;
        self.startBtn.hidden = NO;
    });
    
}

- (void)hideControlView
{
    dispatch_async(dispatch_get_main_queue(), ^{
        //主线程更新界面
        self.bottomToolView.alpha = 0;
        self.bottomProgressView.alpha = 1;
        self.startBtn.hidden = YES;
    });
    
}

#pragma mark - getter
-(UIButton *)playeBtn
{
    if (!_playeBtn) {
        _playeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playeBtn setImage:[UIImage imageNamed:@"zyplayer_play"] forState:UIControlStateNormal];
    }
    return _playeBtn;
}
- (UIButton *)repeatBtn
{
    if (!_repeatBtn) {
        _repeatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_repeatBtn setImage:[UIImage imageNamed:@"zyplayer_repeat@2x"] forState:UIControlStateNormal];
    }
    return _repeatBtn;
}
- (UIButton *)startBtn
{
    if (!_startBtn) {
        _startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_startBtn setImage:[UIImage imageNamed:@"zyplayer_play"] forState:UIControlStateNormal];
        [_startBtn setImage:[UIImage imageNamed:@"zyplayer_none"] forState:UIControlStateSelected];
    }
    return _startBtn;
}
- (UILabel *)horizontalLabel
{
    if (!_horizontalLabel) {
        _horizontalLabel                 = [[UILabel alloc] init];
        _horizontalLabel.textColor       = [UIColor whiteColor];
        _horizontalLabel.font = [UIFont systemFontOfSize:14];
        _horizontalLabel.textAlignment   = NSTextAlignmentCenter;
        // 设置快进快退label
        _horizontalLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
    }
    return _horizontalLabel;
}
- (UIActivityIndicatorView *)activity
{
    if (!_activity) {
        _activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    }
    return _activity;
}

-(UIView *)bottomToolView
{
    if (!_bottomToolView) {
        _bottomToolView = [UIView new];
        _bottomToolView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        _bottomToolView.userInteractionEnabled = YES;
        [self addSubview:_bottomToolView];
    }
    return _bottomToolView;
}
- (UILabel *)currentTimeLabel
{
    if (!_currentTimeLabel) {
        _currentTimeLabel               = [[UILabel alloc] init];
        _currentTimeLabel.textColor     = [UIColor whiteColor];
        _currentTimeLabel.font          = [UIFont systemFontOfSize:12.0f];
        _currentTimeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _currentTimeLabel;
}

- (UIProgressView *)progressView
{
    if (!_progressView) {
        _progressView                   = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        _progressView.progressTintColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];
        _progressView.trackTintColor    = [UIColor clearColor];
    }
    return _progressView;
}

- (UISlider *)videoSlider
{
    if (!_videoSlider) {
        _videoSlider                       = [[UISlider alloc] init];
        // 设置slider
        [_videoSlider setThumbImage:[UIImage imageNamed:@"zyplayer_slider"] forState:UIControlStateNormal];
        _videoSlider.maximumValue          = 1;
        _videoSlider.minimumTrackTintColor = [UIColor redColor];
        _videoSlider.maximumTrackTintColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
    }
    return _videoSlider;
}

- (UILabel *)totalTimeLabel
{
    if (!_totalTimeLabel) {
        _totalTimeLabel               = [[UILabel alloc] init];
        _totalTimeLabel.textColor     = [UIColor whiteColor];
        _totalTimeLabel.font          = [UIFont systemFontOfSize:12.0f];
        _totalTimeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _totalTimeLabel;
}

-(UIProgressView *)bottomProgressView
{
    if (!_bottomProgressView) {
        _bottomProgressView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
        _bottomProgressView.progressTintColor = [UIColor redColor];
        _bottomProgressView.progress = 0.0;
        _bottomProgressView.trackTintColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    }
    return _bottomProgressView;
}
@end
