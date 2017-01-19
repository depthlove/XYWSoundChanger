//
//  NSDate+Extend.h
//  CoreCategory
//
//  Created by 薛永伟 on 15/11/26.
//  xueyongwei@foxmail.com
//  Copyright © 2015年 薛永伟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extend)

/*
 *  时间戳
 */
@property (nonatomic,copy,readonly) NSString *timestamp;



/*
 *  时间成分
 */
@property (nonatomic,strong,readonly) NSDateComponents *components;




/*
 *  是否是今年
 */
@property (nonatomic,assign,readonly) BOOL isThisYear;




/*
 *  是否是今天
 */
@property (nonatomic,assign,readonly) BOOL isToday;
//是否过期（过了这个时间）
-(BOOL)isExpires;
/*
 *  是否超过7天
 */
-(BOOL)isPass7Days;
-(BOOL)isPassDay:(double)day;
/*
*  是否超过n分钟
*/
-(BOOL)moreThan:(double)minites;

/*
 *  是否是昨天
 */
@property (nonatomic,assign,readonly) BOOL isYesToday;




/**
 *  两个时间比较
 *
 *  @param unit     成分单元
 *  @param fromDate 起点时间
 *  @param toDate   终点时间
 *
 *  @return 时间成分对象
 */
+(NSDateComponents *)dateComponents:(NSCalendarUnit)unit fromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;






@end
