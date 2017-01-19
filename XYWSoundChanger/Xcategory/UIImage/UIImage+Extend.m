//
//  UIImage+Extend.m
//  CDHN
//
//  Created by 薛永伟 on 15/11/26.
//  xueyongwei@foxmail.com
//  Copyright © 2015年 薛永伟. All rights reserved.
//

#import "UIImage+Extend.h"
#import <objc/runtime.h>
#import "UIDevice+Extend.h"

static const void *CompleteBlockKey = &CompleteBlockKey;
static const void *FailBlockKey = &FailBlockKey;

@interface UIImage ()

@property (nonatomic,copy)  void(^CompleteBlock)();

@property (nonatomic,copy)  void(^FailBlock)();

@end


@implementation UIImage (Extend)


/**
 *  获取启动图片
 */
+(UIImage *)launchImage{
    
    NSString *imageName=@"LaunchImage-700";
    
    if(iphone5x_4_0) imageName=@"LaunchImage-700-568h";
    
    if(iphone6_4_7) imageName = @"LaunchImage-800-667h";
    
    if(iphone6Plus_5_5) imageName = @"LaunchImage-800-Portrait-736h";
    
    return [UIImage imageNamed:imageName];
}


/**
 *  根据不同的iphone屏幕大小自动加载对应的图片名
 *  加载规则：
 *  iPhone4:             默认图片名，无后缀
 *  iPhone5系列:          _ip5
 *  iPhone6:             _ip6
 *  iPhone6 Plus:     _ip6p,注意屏幕旋转显示不同的图片不是这个方法能决定的，需要使用UIImage的sizeClass特性决定
 */
+(UIImage *)deviceImageNamed:(NSString *)name{
    
    NSString *imageName=[name copy];
    
    //iphone5
    if(iphone5x_4_0) imageName=[NSString stringWithFormat:@"%@%@",imageName,@"_ip5"];
    
    //iphone6
    if(iphone6_4_7) imageName=[NSString stringWithFormat:@"%@%@",imageName,@"_ip6"];
    
    //iphone6 Plus
    if(iphone6Plus_5_5) imageName=[NSString stringWithFormat:@"%@%@",imageName,@"_ip6p"];
    
    UIImage *originalImage=[UIImage imageNamed:name];
    
    UIImage *deviceImage=[UIImage imageNamed:imageName];
    
    if(deviceImage==nil) deviceImage=originalImage;
    
    return deviceImage;
}
/**
 *  根据文件名加载图片，不存到内存
 *
 */
+(UIImage *)loadImageNamed:(NSString *)name
{
    //    NSString *fileName = [[NSString alloc]initWithFormat:@"%@@%.0fx",name,[UIScreen mainScreen].scale ];
    //    DbLog(@"%@",fileName);
    //    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"png"];
    //    UIImage *image = [UIImage imageWithContentsOfFile:path];
    UIImage *image = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:name]];
    return image;
}



/**
 *  拉伸图片
 */
#pragma mark  拉伸图片:自定义比例
+(UIImage *)resizeWithImageName:(NSString *)name leftCap:(CGFloat)leftCap topCap:(CGFloat)topCap{
    UIImage *image = [self imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * leftCap topCapHeight:image.size.height * topCap];
}




#pragma mark  拉伸图片
+(UIImage *)resizeWithImageName:(NSString *)name{
    
    return [self resizeWithImageName:name leftCap:.5f topCap:.5f];
    
}




/**
 *  保存相册
 *
 *  @param completeBlock 成功回调
 *  @param completeBlock 出错回调
 */
-(void)savedPhotosAlbum:(void(^)())completeBlock failBlock:(void(^)())failBlock{
    
    UIImageWriteToSavedPhotosAlbum(self, self, @selector(image:didFinishSavingWithError:contextInfo:),NULL);
    
    self.CompleteBlock = completeBlock;
    self.FailBlock = failBlock;
}




- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
    if(error == nil){
        if(self.CompleteBlock != nil) self.CompleteBlock();
    }else{
        if(self.FailBlock !=nil) self.FailBlock();
    }
    
}
- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize
{
    UIImage *sourceImage = self;
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth= width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else if (widthFactor < heightFactor)
        {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(targetSize); // this will crop
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width= scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil)
        NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}


/*
 *  模拟成员变量
 */
-(void (^)())FailBlock{
    return objc_getAssociatedObject(self, FailBlockKey);
}
-(void)setFailBlock:(void (^)())FailBlock{
    objc_setAssociatedObject(self, FailBlockKey, FailBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(void (^)())CompleteBlock{
    return objc_getAssociatedObject(self, CompleteBlockKey);
}

-(void)setCompleteBlock:(void (^)())CompleteBlock{
    objc_setAssociatedObject(self, CompleteBlockKey, CompleteBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
