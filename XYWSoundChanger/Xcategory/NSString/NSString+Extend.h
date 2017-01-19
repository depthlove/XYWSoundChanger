//
//  NSString+Extend.h
//  CoreCategory
//
//  Created by 薛永伟 on 15/11/26.
//  xueyongwei@foxmail.com
//  Copyright © 2015年 薛永伟. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface NSString (Extend)

/** 删除所有的空格 */
@property (nonatomic,copy,readonly) NSString *deleteSpace;

/*根据文件路径获取文件的MD5*/
+(NSString*)getFileMD5WithPath:(NSString*)path;
/*
 *  时间戳对应的NSDate
 */
@property (nonatomic,strong,readonly) NSDate *date;

/*
 *  生成一个UUID
 */
+ (NSString*) stringWithUUID;

/**
 *  时间戳转格式化的时间字符串
 */
-(NSString *)timestampToTimeStringWithFormatString:(NSString *)formatString;


/*
 *反转字符串
 */
-(NSString *)reverseStr;

/*
 *取最后一个X字符前的字符串
 */
-(NSString *)beforeLastStr:(NSString *)x;

@end
