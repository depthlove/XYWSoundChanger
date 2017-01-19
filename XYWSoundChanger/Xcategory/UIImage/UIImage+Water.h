//
//  UIImage+Water.h
//  CoreCategory
//
//  Created by 薛永伟 on 15/11/26.
//  xueyongwei@foxmail.com
//  Copyright © 2015年 薛永伟. All rights reserved.
//

#import <UIKit/UIKit.h>


/*
 *  水印方向
 */
typedef enum {
    
    //左上
    ImageWaterDirectTopLeft=0,
    
    //右上
    ImageWaterDirectTopRight,
    
    //左下
    ImageWaterDirectBottomLeft,
    
    //右下
    ImageWaterDirectBottomRight,
    
    //正中
    ImageWaterDirectCenter
    
}ImageWaterDirect;






@interface UIImage (Water)




-(UIImage *)waterWithText:(NSString *)text direction:(ImageWaterDirect)direction fontColor:(UIColor *)fontColor fontPoint:(CGFloat)fontPoint marginXY:(CGPoint)marginXY;


-(UIImage *)waterWithWaterImage:(UIImage *)waterImage direction:(ImageWaterDirect)direction waterSize:(CGSize)waterSize  marginXY:(CGPoint)marginXY;



@end
