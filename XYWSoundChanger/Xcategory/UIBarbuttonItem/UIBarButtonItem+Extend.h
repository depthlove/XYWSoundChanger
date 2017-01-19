//
//  UIBarButtonItem+Extend.h
//  Carpenter
//
//  Created by 薛永伟 on 15/11/26.
//  xueyongwei@foxmail.com
//  Copyright © 2015年 薛永伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+Extend.h"


@interface UIBarButtonItem (Extend)



+(instancetype)barButtonItemWithSize:(CGSize)size target:(id)target selector:(SEL)selector ImgName:(NSString *)imgName hlImageColor:(UIColor *)hlImageColor;


@end
