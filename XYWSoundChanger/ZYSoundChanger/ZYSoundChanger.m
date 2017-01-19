//
//  ZYSoundChanger.m
//  XYWSoundChanger
//
//  Created by xueyognwei on 17/1/18.
//  Copyright © 2017年 xueyognwei. All rights reserved.
//

#import "ZYSoundChanger.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "AudioConvert.h"
#import "XYWSandBox.h"
@interface ZYSoundChanger()<AudioConvertDelegate>
@property (nonatomic,copy) void(^success)(NSString *videoPath);
@property (nonatomic,copy) void(^failure)(NSError *error);
@property (nonatomic,assign)int tempo;
@property (nonatomic,assign)int pitch;
@property (nonatomic,assign)int rate;
@property (nonatomic,assign)BOOL saveToAlbum;//存到相册里
@property (nonatomic,copy)NSString *videoPath;
@end

@implementation ZYSoundChanger
+(ZYSoundChanger *)changer
{
    static ZYSoundChanger *changer = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        changer = [[self alloc] init];
    });
    return changer;
}
-(void)changeVideo:(NSString *)videoPath withTempo:(int)tempo andPitch:(int)pitch andRate:(int)rate sucess:(void (^)(NSString *))success failure:(void (^)(NSError *))failure
{
    if (![[NSFileManager defaultManager] fileExistsAtPath:videoPath]) {
        CNLog(@"file Not exit");
        NSError *err = [NSError errorWithDomain:@"fileNotExists" code:404 userInfo:@{@"msg":@"this video not exists!"}];
        failure(err);
        return;
    }
    self.failure = failure;
    self.success = success;
    self.videoPath = videoPath;
    self.tempo = tempo;
    self.pitch = pitch;
    self.rate = rate;
    self.saveToAlbum = NO;
    
    [self captureSoundFileOfVideo];
}
#pragma mark --从视频中抓取音频文件
/**
 从视频中抓取音频文件
 */
- (void)captureSoundFileOfVideo
{
    // 创建音频文件
    NSString *documentsDirectoryPath = [XYWSandBox getTmpDirectory];
    NSString *filePath = [documentsDirectoryPath stringByAppendingPathComponent:@"ZYSoundFile4Video"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSString *tempMusicPath = [NSString stringWithFormat:@"%@/%@.m4a",filePath,[NSString stringWithFormat:@"%@", [self getStringWithTimeNow]]];
    AVURLAsset *asset = [AVURLAsset assetWithURL:[NSURL fileURLWithPath:self.videoPath]];
    NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:asset];
    if ([compatiblePresets containsObject:AVAssetExportPresetAppleM4A]) {
        
        AVAssetExportSession *exportSession = [[AVAssetExportSession alloc]
                                               initWithAsset:asset presetName:AVAssetExportPresetAppleM4A];
        CMTimeRange exportTimeRange = CMTimeRangeMake(kCMTimeZero, asset.duration);
        NSURL *furl = [NSURL fileURLWithPath:tempMusicPath];
        exportSession.outputURL = furl;
        exportSession.outputFileType = AVFileTypeAppleM4A;
        exportSession.timeRange = exportTimeRange; // 截取时间
        
        [exportSession exportAsynchronouslyWithCompletionHandler:^{
            
            switch ([exportSession status]) {
                case AVAssetExportSessionStatusFailed:
                    
                    CNLog(@"Export failed: %@", [[exportSession error] localizedDescription]);
                    break;
                case AVAssetExportSessionStatusCancelled:
                    
                    CNLog(@"Export canceled");
                    break;
                default:
                {
                    if (![[NSFileManager defaultManager] fileExistsAtPath:tempMusicPath]) {
                        NSString *errMsg = [NSString stringWithFormat:@"分离音频失败，目标文件不存在！%@",tempMusicPath];
                        NSError *err = [NSError errorWithDomain:@"fileNotExists" code:404 userInfo:@{@"msg":errMsg}];
                        self.failure(err);
                        return ;
                    }
                    CNLog(@"分离成功！即将去变声处理..");
                    [self changeSoundURL:tempMusicPath];
                }
            }
        }];
    }
}
#pragma mark --对音频文件进行变音
/**
 对音频文件进行变音

 @param filePath 音频文件的路径
 */
-(void)changeSoundURL:(NSString *)filePath
{
    AudioConvertConfig dconfig;
    dconfig.sourceAuioPath = [filePath UTF8String];
    dconfig.outputFormat = AudioConvertOutputFormat_WAV;
    dconfig.outputChannelsPerFrame = 1;
    dconfig.outputSampleRate = 8000;
    dconfig.soundTouchPitch = self.pitch;
    dconfig.soundTouchRate = self.rate;
    dconfig.soundTouchTempoChange = self.tempo;
    CNLog(@"设置完毕，开始变声处理..");
    [[AudioConvert shareAudioConvert] audioConvertBegin:dconfig withCallBackDelegate:self];
}
#pragma mark --将原视频和变音后的文件合并成新的视频
/**
 将原视频和变音后的文件合并成新的视频

 @param audioPath 变声过的音频文件
 */
-(void)createNewVideoWithSound:(NSString *)audioPath
{
    AVURLAsset* audioAsset = [AVURLAsset assetWithURL:[NSURL fileURLWithPath:audioPath]];
    AVURLAsset* videoAsset = [AVURLAsset assetWithURL:[NSURL fileURLWithPath:self.videoPath]];
    
    AVMutableComposition* mixComposition = [AVMutableComposition composition];
    
    AVMutableCompositionTrack *compositionCommentaryTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeAudio
                                                                                        preferredTrackID:kCMPersistentTrackID_Invalid];
    [compositionCommentaryTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, audioAsset.duration)
                                        ofTrack:[[audioAsset tracksWithMediaType:AVMediaTypeAudio] objectAtIndex:0]
                                         atTime:kCMTimeZero error:nil];
    
    AVMutableCompositionTrack *compositionVideoTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeVideo
                                                                                   preferredTrackID:kCMPersistentTrackID_Invalid];
    [compositionVideoTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, videoAsset.duration)
                                   ofTrack:[[videoAsset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0]
                                    atTime:kCMTimeZero error:nil];
    
    AVAssetExportSession* _assetExport = [[AVAssetExportSession alloc] initWithAsset:mixComposition
                                                                          presetName:AVAssetExportPresetMediumQuality];
    
    NSString *documentsDirectoryPath = [XYWSandBox getPreferencePanesDirectory];
    NSString *filePath = [documentsDirectoryPath stringByAppendingPathComponent:@"videoWithNewSound"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString* videoName = [NSString stringWithFormat:@"%@export.mp4",[self getStringWithTimeNow]];
    NSString *exportPath = [filePath stringByAppendingPathComponent:videoName];
    NSURL    *exportUrl = [NSURL fileURLWithPath:exportPath];
    
    _assetExport.outputFileType = AVFileTypeMPEG4;
    CNLog(@"file type %@",_assetExport.outputFileType);
    _assetExport.outputURL = exportUrl;
    _assetExport.shouldOptimizeForNetworkUse = YES;
    
    [_assetExport exportAsynchronouslyWithCompletionHandler:
     ^(void ) {
         CNLog(@"export file path %@",exportPath);
         if (![[NSFileManager defaultManager]fileExistsAtPath:exportPath]) {
             CNLog(@"file Not exit");
             NSError *err = [NSError errorWithDomain:@"fileNotExists" code:404 userInfo:@{@"msg":@"createNewVideoWithSound:this resultVideo not exists!"}];
             self.failure(err);
             return;
         }
         self.success(exportPath);
         if (self.saveToAlbum) {
             ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
             [library writeVideoAtPathToSavedPhotosAlbum:[NSURL fileURLWithPath:exportPath]
                                         completionBlock:^(NSURL *assetURL, NSError *error) {
                                             if (error) {
                                                 CNLog(@"Save video fail:%@",error);
                                             } else {
                                                 CNLog(@"Save video succeed.");
                                             }
                                         }];
         }
     }];
}
#pragma mark - AudioConvertDelegate
- (BOOL)audioConvertOnlyDecode
{
    return  NO;
}
- (BOOL)audioConvertHasEnecode
{
    return YES;
}
/**
 * 对音频变声动作的回调
 **/
- (void)audioConvertSoundTouchSuccess:(NSString *)audioPath
{
    //变声成功
    CNLog(@"变声成功，即将播放");
}
- (void)audioConvertSoundTouchFail
{
    //变声失败
    CNLog(@"变声失败！");
}
/**
 * 对音频解码动作的回调
 **/
- (void)audioConvertDecodeSuccess:(NSString *)audioPath {
    //解码成功
    CNLog(@"解码成功");
}
- (void)audioConvertDecodeFaild
{
    //解码失败
    CNLog(@"解码失败");
}

/**
 * 对音频编码动作的回调(左右app变声回调在这里)
 **/
- (void)audioConvertEncodeSuccess:(NSString *)audioPath
{
    //编码完成
    CNLog(@"编码成功");
    [self createNewVideoWithSound:audioPath];
}

- (void)audioConvertEncodeFaild
{
    //编码失败
    CNLog(@"编码失败");
    NSError *err = [NSError errorWithDomain:@"audioConvertEncodeFaild" code:500 userInfo:@{@"errMsg":@"audioConvertEncodeFaild"}];
    self.failure(err);
}

#pragma mark --其他工具方法
/**
 获取时间字符串

 @return 时间字符串
 */
- (NSString *)getStringWithTimeNow
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyMMddHHmmss";
    NSString *nowTimeStr = [formatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:0]];
    return nowTimeStr;
}
@end
