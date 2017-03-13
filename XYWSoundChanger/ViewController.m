//
//  ViewController.m
//  XYWSoundChanger
//
//  Created by xueyognwei on 17/1/16.
//  Copyright © 2017年 xueyognwei. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "AudioConvert.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "XYWSandBox.h"
#import "ZYSoundChanger.h"
#import "ZYPlayer.h"
#import "CoreSVP.h"

@interface ViewController ()<AVAudioPlayerDelegate,AudioConvertDelegate>
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *waitView;

@property (nonatomic,strong) NSMutableArray *audioDataArray;
@property (weak, nonatomic) IBOutlet UILabel *tempLabel;
@property (nonatomic,assign)int tempoChangeNum;
@property (weak, nonatomic) IBOutlet UILabel *pitchLabel;
@property (nonatomic,assign)int pitchSemiTonesNum;
@property (weak, nonatomic) IBOutlet UILabel *rateLabel;
@property (nonatomic,assign)int rateChangeNum;
@property (nonatomic,strong)AVAudioPlayer *audioPalyer;
@property (weak, nonatomic) IBOutlet ZYPlayerView *player;
@property (nonatomic,strong)NSDate *startDate;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.audioDataArray= [[NSMutableArray alloc] init];
    self.tempoChangeNum = 10;
    self.pitchSemiTonesNum= 0;
    self.rateChangeNum = 0;
    NSLog(@"%@",[XYWSandBox getTmpDirectory]) ;
    
}
- (IBAction)tempo:(UISlider *)sender {
    self.tempoChangeNum = sender.value;
    self.tempLabel.text = [NSString stringWithFormat:@"tempo:%.0f",sender.value];
}
- (IBAction)rateChange:(UISlider *)sender {
    self.rateChangeNum = sender.value;
    self.rateLabel.text = [NSString stringWithFormat:@"pitch:%.0f",sender.value];
}
- (IBAction)ptichChange:(UISlider *)sender {
    self.pitchSemiTonesNum = sender.value;
    self.pitchLabel.text = [NSString stringWithFormat:@"rate:%.0f",sender.value];
}

- (IBAction)ChangeAndPlay:(UIButton *)sender {
    self.timeLabel.text = @"";
    if (self.waitView.animating) {
        [self.player pause];
        [self.player resetToPlayNewURL];
        [self.waitView stopAnimating];
    }else{
        CoreSVPLoading(@"视频处理中..", NO);
        NSDate* tmpStartData = [NSDate date];
        self.startDate = tmpStartData;
        [self.waitView startAnimating];
        NSString *sourceVideoPath = [[NSBundle mainBundle] pathForResource:@"0" ofType:@"mp4"];
        ZYSoundChanger *manager = [ZYSoundChanger changer];
        [manager changeVideo:sourceVideoPath withTempo:self.tempoChangeNum andPitch:self.pitchSemiTonesNum andRate:self.rateChangeNum sucess:^(NSString *videoPath) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [CoreSVP dismiss];
                NSLog(@"视频合成完毕！ %@",videoPath);
                CoreSVPCenterMsg(@"视频合成完毕！");
                CGFloat time = fabs([self.startDate timeIntervalSinceNow]);
                self.timeLabel.text = [NSString stringWithFormat:@"耗时:%.1f",time];
                [self.player setVideoURL:[NSURL fileURLWithPath:videoPath]];
                [self.player autoPlayTheVideo];
                [self.waitView startAnimating];
            });
            
        } failure:^(NSError *error) {
            NSLog(@"视频合成出错：%@",error.localizedDescription);
            CoreSVPCenterMsg(@"视频合成出错！");
        }];

    }
}


/**
 点击播放本地原视频文件

 @param sender 按钮
 */
- (IBAction)onPlayCLick:(UIButton *)sender {
    self.timeLabel.text =@"";
    if (self.waitView.animating) {
        [self.player pause];
        [self.player resetToPlayNewURL];
        [self.waitView stopAnimating];
    }else{
        CoreSVPLoading(@"视频处理中..", NO);
        NSDate* tmpStartData = [NSDate date];
        self.startDate = tmpStartData;
        [self.waitView startAnimating];
        NSString *sourceVideoPath = [[NSBundle mainBundle] pathForResource:@"1" ofType:@"mp4"];
        ZYSoundChanger *manager = [ZYSoundChanger changer];
        [manager changeVideo:sourceVideoPath withTempo:self.tempoChangeNum andPitch:self.pitchSemiTonesNum andRate:self.rateChangeNum sucess:^(NSString *videoPath) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [CoreSVP dismiss];
                NSLog(@"视频合成完毕！ %@",videoPath);
                CoreSVPCenterMsg(@"视频合成完毕！");
                CGFloat time = fabs([self.startDate timeIntervalSinceNow]);
                self.timeLabel.text = [NSString stringWithFormat:@"耗时:%.1f",time];
                [self.player setVideoURL:[NSURL fileURLWithPath:videoPath]];
                [self.player autoPlayTheVideo];
                [self.waitView startAnimating];
            });
            
        } failure:^(NSError *error) {
            NSLog(@"视频合成出错：%@",error.localizedDescription);
            CoreSVPCenterMsg(@"视频合成出错！");
        }];
    }
//    sender.selected = !sender.selected;
////    sender.selected?[self.waitView startAnimating]:[self.waitView stopAnimating];
//    
//    if (self.audioPalyer) {
//        [self.audioPalyer stop];
//    }
//    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
