//
//  UIImage+Extend.h
//  CDHN
//
//  Created by 薛永伟 on 15/11/26.
//  xueyongwei@foxmail.com
//  Copyright © 2015年 薛永伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extend)





/**
 *  拉伸图片:自定义比例
 */
+(UIImage *)resizeWithImageName:(NSString *)name leftCap:(CGFloat)leftCap topCap:(CGFloat)topCap;


/**
 *  加载图片（animation的图片，大图片，不常用的图片）
 *  此方法不会把图片缓存到内存中
 */
+(UIImage *)loadImageNamed:(NSString *)name;

/**
 *  拉伸图片
 */
+(UIImage *)resizeWithImageName:(NSString *)name;

- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize;
/**
 *  获取启动图片
 */
+(UIImage *)launchImage;




/**
 *  保存相册
 *
 *  @param completeBlock 成功回调
 *  @param completeBlock 出错回调
 */
-(void)savedPhotosAlbum:(void(^)())completeBlock failBlock:(void(^)())failBlock;



@end
