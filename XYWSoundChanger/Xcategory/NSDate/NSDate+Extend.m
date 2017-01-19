//
//  NSDate+Extend.m
//  CoreCategory
//
//  Created by 薛永伟 on 15/11/26.
//  xueyongwei@foxmail.com
//  Copyright © 2015年 薛永伟. All rights reserved.
//

#import "NSDate+Extend.h"

@interface NSDate ()


/*
 *  清空时分秒，保留年月日
 */
@property (nonatomic,strong,readonly) NSDate *ymdDate;


@end




@implementation NSDate (Extend)





/*
 *  时间戳
 */
-(NSString *)timestamp{

    NSTimeInterval timeInterval = [self timeIntervalSince1970];
    
    NSString *timeString = [NSString stringWithFormat:@"%.0f",timeInterval];
    
    return [timeString copy];
}





/*
 *  时间成分
 */
-(NSDateComponents *)components{
    
    //创建日历
    NSCalendar *calendar=[NSCalendar currentCalendar];
    
    //定义成分
    NSCalendarUnit unit=NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;

    return [calendar components:unit fromDate:self];
}





/*
 *  是否是今年
 */
-(BOOL)isThisYear{
    
    //取出给定时间的components
    NSDateComponents *dateComponents=self.components;
    
    //取出当前时间的components
    NSDateComponents *nowComponents=[NSDate date].components;
    
    //直接对比年成分是否一致即可
    BOOL res = dateComponents.year==nowComponents.year;
    
    return res;
}





/*
 *  是否是今天
 */
-(BOOL)isToday{

    //差值为0天
    return [self calWithValue:0];
}





/*
 *  是否是昨天
 */
-(BOOL)isYesToday{
    
    //差值为1天
    return [self calWithValue:1];
}
-(BOOL)isPass7Days
{
    NSTimeInterval passtime = fabs([self timeIntervalSinceNow]);
    if (passtime/86400>=7) {
        return YES;
    }
    return NO;
}
-(BOOL)isPassDay:(double)day
{
    NSTimeInterval passtime = fabs([self timeIntervalSinceNow]);
    if (passtime/86400>=day) {
        return YES;
    }
    return NO;
}
-(BOOL)moreThan:(double)minites
{
    NSTimeInterval passtime = fabs([self timeIntervalSinceNow]);
    if (passtime/60>=minites) {
        return YES;
    }
    return NO;
}
//是否过期（过了这个时间）
-(BOOL)isExpires
{
    NSTimeInterval passtime = [self timeIntervalSinceNow];
    if (passtime>=0) {//还没到这个时间
        return NO;
    }
    return YES;
}
-(BOOL)calWithValue:(NSInteger)value{
    
    //得到给定时间的处理后的时间的components
    NSDateComponents *dateComponents=self.ymdDate.components;
    
    //得到当前时间的处理后的时间的components
    NSDateComponents *nowComponents=[NSDate date].ymdDate.components;
    
    //比较
    BOOL res=dateComponents.year==nowComponents.year && dateComponents.month==nowComponents.month && (dateComponents.day + value)==nowComponents.day;
    
    return res;
}


/*
 *  清空时分秒，保留年月日
 */
-(NSDate *)ymdDate{
    
    //定义fmt
    NSDateFormatter *fmt=[[NSDateFormatter alloc] init];
    
    //设置格式:去除时分秒
    fmt.dateFormat=@"yyyy-MM-dd";
    
    //得到字符串格式的时间
    NSString *dateString=[fmt stringFromDate:self];
    
    //再转为date
    NSDate *date=[fmt dateFromString:dateString];
    
    return date;
}












/**
 *  两个时间比较
 *
 *  @param unit     成分单元
 *  @param fromDate 起点时间
 *  @param toDate   终点时间
 *
 *  @return 时间成分对象
 */
+(NSDateComponents *)dateComponents:(NSCalendarUnit)unit fromDate:(NSDate *)fromDate toDate:(NSDate *)toDate{
    
    //创建日历
    NSCalendar *calendar=[NSCalendar currentCalendar];
    
    //直接计算
    NSDateComponents *components = [calendar components:unit fromDate:fromDate toDate:toDate options:0];
    
    return components;
}

































@end
