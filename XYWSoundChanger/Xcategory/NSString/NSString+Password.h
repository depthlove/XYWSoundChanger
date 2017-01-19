//
//  NSString+Password.h
//  03.数据加密
//
//  Created by 薛永伟 on 15/11/26.
//  xueyongwei@foxmail.com
//  Copyright © 2015年 薛永伟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Password)





/**
 *  32位MD5加密
 */
@property (nonatomic,copy,readonly) NSString *md5;





/**
 *  SHA1加密
 */
@property (nonatomic,copy,readonly) NSString *sha1;





@end
