//
//  XYWAlertView.h
//  XYWAlertView
//
//  Created by xueyongwei on 16/10/9.
//  Copyright © 2016年 xueyongwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "XCategory.h"
@interface XYWAlert : NSObject
+(void)XYWAlertTitle:(NSString *)title message:(NSString *)message first:(NSString *)first firstHandle:(void (^)(void))FirstBlock  second:(NSString *)second Secondhandle:(void (^)(void))SecondBlock cancle:(NSString *)cancle handle:(void (^)(void))CancleBlock;
+(void)XYWAlertTitle:(NSString *)title message:(NSString *)message inWkVC:(UIViewController *)vc first:(NSString *)first firstHandle:(void (^)(void))FirstBlock  second:(NSString *)second Secondhandle:(void (^)(void))SecondBlock cancle:(NSString *)cancle handle:(void (^)(void))CancleBlock;
@end
