//
//  XYWSandBoxManager.h
//  XYWSoundChanger
//
//  Created by xueyognwei on 17/1/18.
//  Copyright © 2017年 xueyognwei. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface XYWSandBox : NSObject

/**
 获取沙盒Document的文件目录(icloud同步此目录)

 @return Document的文件目录
 */
+ (NSString *)getDocumentDirectory;

/**
 获取沙盒Library的文件目录（目录下有cache和preference）
 
 @return Library的文件目录
 */
+ (NSString *)getLibraryDirectory;

/**
 获取沙盒Library/Caches的文件目录（临时缓存，清空频率较高）
 
 @return Library/Caches的文件目录
 */
+ (NSString *)getCachesDirectory;

/**
 获取沙盒Library/Preference的文件目录（偏好，存放不怎么删除的文件）
 
 @return Library/Preference的文件目录
 */
+ (NSString *)getPreferencePanesDirectory;

/**
 获取沙盒tmp的文件目录（缓存目录）
 
 @return tmp的文件目录
 */
+ (NSString *)getTmpDirectory;

/**
 根据路径返回目录或文件的大小
 
 @return 大小
 */
+ (double)sizeWithFilePath:(NSString *)path;

/**
 得到指定目录下的所有文件
 
 @return 文件数组
 */
+ (NSArray *)getAllFileNames:(NSString *)dirPath;

/**
 删除指定目录或文件
 
 @return 结果
 */
+ (BOOL)clearCachesWithFilePath:(NSString *)path;

/**
 清空指定目录下文件
 
 @return 结果
 */
+ (BOOL)clearCachesFromDirectoryPath:(NSString *)dirPath;
@end
