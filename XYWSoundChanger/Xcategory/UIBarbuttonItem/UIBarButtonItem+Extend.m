//
//  UIBarButtonItem+Extend.m
//  Carpenter
//
//  Created by 薛永伟 on 15/11/26.
//  xueyongwei@foxmail.com
//  Copyright © 2015年 薛永伟. All rights reserved.
//

#import "UIBarButtonItem+Extend.h"
#import "UIImage+Color.h"

@implementation UIBarButtonItem (Extend)


+(instancetype)barButtonItemWithSize:(CGSize)size target:(id)target selector:(SEL)selector ImgName:(NSString *)imgName hlImageColor:(UIColor *)hlImageColor{
    
    //创建按钮
    UIButton *btn = [[UIButton alloc] init];
    
    //绑定事件
    [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    btn.frame= (CGRect){CGPointZero,size};
    
    //image
    UIImage *image = [UIImage imageNamed:imgName];
    UIImage *hlImage = [image imageWithGradientTintColor:hlImageColor];
    
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:hlImage forState:UIControlStateHighlighted];
    
    //创建
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
   
    return item;
}

@end
