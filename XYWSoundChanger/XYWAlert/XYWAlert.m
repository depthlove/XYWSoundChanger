//
//  XYWAlertView.m
//  XYWAlertView
//
//  Created by xueyongwei on 16/10/9.
//  Copyright © 2016年 xueyongwei. All rights reserved.
//

#import "XYWAlert.h"

@implementation XYWAlert
+(void)XYWAlertTitle:(NSString *)title message:(NSString *)message first:(NSString *)first firstHandle:(void (^)(void))FirstBlock  second:(NSString *)second Secondhandle:(void (^)(void))SecondBlock cancle:(NSString *)cancle handle:(void (^)(void))CancleBlock
{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];

    //title
    if (title) {
        NSMutableAttributedString *alertControllerStr = [[NSMutableAttributedString alloc] initWithString:title];
        [alertControllerStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexColorString:@"333333"] range:NSMakeRange(0, title.length)];
        [alertControllerStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, title.length)];
        
        [alertController setValue:alertControllerStr forKey:@"attributedTitle"];
    }
    //message
    if (message) {
        NSMutableAttributedString *alertControllerMessageStr = [[NSMutableAttributedString alloc] initWithString:message];
        [alertControllerMessageStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexColorString:@"555555"] range:NSMakeRange(0, message.length)];
        [alertControllerMessageStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, message.length)];
        [alertController setValue:alertControllerMessageStr forKey:@"attributedMessage"];
    }
    if (cancle) {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (CancleBlock) {
                CancleBlock();
            }
        }];
        [cancelAction setValue:[UIColor colorWithHexColorString:@"555555"] forKey:@"titleTextColor"];
        //添加action
        
        [alertController addAction:cancelAction];
    }
    //一个按钮
    if (first) {
        UIAlertAction *aAction = [UIAlertAction actionWithTitle:first style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (FirstBlock) {
                FirstBlock();
            }
        }];
        [aAction setValue:[UIColor colorWithHexColorString:@"ff4a4b"] forKey:@"titleTextColor"];
        [alertController addAction:aAction];
    }
    if (second) {
        UIAlertAction *aAction = [UIAlertAction actionWithTitle:second style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (FirstBlock) {
                FirstBlock();
            }
        }];
        [aAction setValue:[UIColor colorWithHexColorString:@"555555"] forKey:@"titleTextColor"];
        [alertController addAction:aAction];
    }
    //弹出
    
    [[self getCurrentVC] presentViewController:alertController animated:YES completion:nil];
}
+ (UIViewController *)getCurrentVC{
    
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    //app默认windowLevel是UIWindowLevelNormal，如果不是，找到UIWindowLevelNormal的
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    id  nextResponder = nil;
    UIViewController *appRootVC=window.rootViewController;
    //    如果是present上来的appRootVC.presentedViewController 不为nil
    if (appRootVC.presentedViewController) {
        nextResponder = appRootVC.presentedViewController;
    }else{
        UIView *frontView = [[window subviews] objectAtIndex:0];
        nextResponder = [frontView nextResponder]; //  这方法下面有详解
    }
    
    if ([nextResponder isKindOfClass:[UITabBarController class]]){
        UITabBarController * tabbar = (UITabBarController *)nextResponder;
        UINavigationController * nav = (UINavigationController *)tabbar.viewControllers[tabbar.selectedIndex];
        //        UINavigationController * nav = tabbar.selectedViewController ; 上下两种写法都行
        result=nav.childViewControllers.lastObject;
        
    }else if ([nextResponder isKindOfClass:[UINavigationController class]]){
        UIViewController * nav = (UIViewController *)nextResponder;
        result = nav.childViewControllers.lastObject;
    }else{
        result = nextResponder;
    }
    
    return result;
}

+(void)XYWAlertTitle:(NSString *)title message:(NSString *)message inWkVC:(UIViewController *)vc first:(NSString *)first firstHandle:(void (^)(void))FirstBlock  second:(NSString *)second Secondhandle:(void (^)(void))SecondBlock cancle:(NSString *)cancle handle:(void (^)(void))CancleBlock
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    //title
    if (title) {
        NSMutableAttributedString *alertControllerStr = [[NSMutableAttributedString alloc] initWithString:title];
        [alertControllerStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexColorString:@"333333"] range:NSMakeRange(0, title.length)];
        [alertControllerStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, title.length)];
        
        [alertController setValue:alertControllerStr forKey:@"attributedTitle"];
    }
    //message
    if (message) {
        NSMutableAttributedString *alertControllerMessageStr = [[NSMutableAttributedString alloc] initWithString:message];
        [alertControllerMessageStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexColorString:@"555555"] range:NSMakeRange(0, message.length)];
        [alertControllerMessageStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, message.length)];
        [alertController setValue:alertControllerMessageStr forKey:@"attributedMessage"];
    }
    if (cancle) {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (CancleBlock) {
                CancleBlock();
            }
        }];
        [cancelAction setValue:[UIColor colorWithHexColorString:@"555555"] forKey:@"titleTextColor"];
        //添加action
        
        [alertController addAction:cancelAction];
    }
    //一个按钮
    if (first) {
        UIAlertAction *aAction = [UIAlertAction actionWithTitle:first style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (FirstBlock) {
                FirstBlock();
            }
        }];
        [aAction setValue:[UIColor colorWithHexColorString:@"ff4a4b"] forKey:@"titleTextColor"];
        [alertController addAction:aAction];
    }
    if (second) {
        UIAlertAction *aAction = [UIAlertAction actionWithTitle:second style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (FirstBlock) {
                FirstBlock();
            }
        }];
        [aAction setValue:[UIColor colorWithHexColorString:@"555555"] forKey:@"titleTextColor"];
        [alertController addAction:aAction];
    }
    //弹出
    __weak typeof(vc) wkVC = vc;
    [wkVC presentViewController:alertController animated:YES completion:nil];
}
@end
