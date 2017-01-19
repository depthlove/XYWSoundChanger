//
//  CALayer+Anim.h
//  Carpenter
//
//  Created by 薛永伟 on 15/11/26.
//  xueyongwei@foxmail.com
//  Copyright © 2015年 薛永伟. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "CALayerAnimConst.h"

/*
 *  反转方向
 */
typedef enum {
    
    //X
    AnimReverDirectionX=0,
    
    //Y
    AnimReverDirectionY,
    
    //Z
    AnimReverDirectionZ,
    
}AnimReverDirection;





@interface CALayer (Anim)


/** 封装的关键帧动画 */
-(CAAnimation *)animWithKeyPath:(NSString *)keyPath kfs:(NSArray *)kfs duration:(NSTimeInterval)duration repeatCount:(NSUInteger)repeatCount;


-(CAAnimation *)anim_revers:(AnimReverDirection)direction duration:(NSTimeInterval)duration isReverse:(BOOL)isReverse repeatCount:(NSUInteger)repeatCount timingFuncName:(NSString *)timingFuncName;


@end
