//
//  UIView+Extend.h
//  wucai
//
//  Created by 薛永伟 on 15/11/26.
//  xueyongwei@foxmail.com
//  Copyright © 2015年 薛永伟. All rights reserved.
//

#import <UIKit/UIKit.h>


#define CustomViewTranslate(ViewClass,view) (ViewClass *)view;

typedef enum{
    
    //上
    UIViewBorderDirectTop=0,
    
    //左
    UIViewBorderDirectLeft,
    
    //下
    UIViewBorderDirectBottom,
    
    //右
    UIViewBorderDirectRight,
    
    
}UIViewBorderDirect;

@interface UIView (Extend)

@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic,assign) CGFloat radius;




/**
 *  添加边框：注给scrollView添加会出错
 *
 *  @param direct 方向
 *  @param color  颜色
 *  @param width  线宽
 */
-(void)addSingleBorder:(UIViewBorderDirect)direct color:(UIColor *)color width:(CGFloat)width;


/**
 *  自动从xib创建视图
 */
+(instancetype)viewFromXIB;


/**
 *  添加一组子view：
 */
-(void)addSubviewsWithArray:(NSArray *)subViews;


/**
 *  添加边框:四边
 */
-(void)setBorder:(UIColor *)color width:(CGFloat)width;



/**
 *  调试
 */
-(void)debug:(UIColor *)color width:(CGFloat)width;

/**
 *  为view添加虚线框
 */

-(void)addXuxianBorderWith:(float)theWith and:(UIColor*)aColor;

/**
 *  批量移除视图
 *
 *  @param views 需要移除的视图数组
 */
+(void)removeViews:(NSArray *)views;
//获取vc
- (UIViewController*)viewController;
@end
