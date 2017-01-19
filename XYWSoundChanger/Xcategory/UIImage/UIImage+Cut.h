//
//  UIImage+Cut.h
//  mohu
//
//  Created by 薛永伟 on 15/11/26.
//  xueyongwei@foxmail.com
//  Copyright © 2015年 薛永伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Cut)


/*
 *  圆形图片
 */
@property (nonatomic,strong,readonly) UIImage *roundImage;






/**
 *  从给定UIView中截图：UIView转UIImage
 */
+(UIImage *)cutFromView:(UIView *)view;





/**
 *  直接截屏
 */
+(UIImage *)cutScreen;





/**
 *  从给定UIImage和指定Frame截图：
 */
-(UIImage *)cutWithFrame:(CGRect)frame;







@end
