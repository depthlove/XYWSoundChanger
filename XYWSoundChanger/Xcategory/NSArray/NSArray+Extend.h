//
//  NSArray+Extend.h
//
//  Created by 薛永伟 on 15/11/26.
//  xueyongwei@foxmail.com
//  Copyright © 2015年 薛永伟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Extend)


/**
 *  数组转字符串
 */
-(NSString *)string;


/**
 *  数组比较
 */
-(BOOL)compareIgnoreObjectOrderWithArray:(NSArray *)array;


/**
 *  数组计算交集
 */
-(NSArray *)arrayForIntersectionWithOtherArray:(NSArray *)otherArray;

/**
 *  数据计算差集
 */
-(NSArray *)arrayForMinusWithOtherArray:(NSArray *)otherArray;

@end
