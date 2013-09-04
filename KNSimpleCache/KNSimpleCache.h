//
//  KNSimpleCache.h
//  KNSimpleCache
//
//  Created by Niko on 13-9-4.
//  Copyright (c) 2013年 Niko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KNSimpleCache : NSObject

/*
 * delete all cached item,remove the cache path
 *
 */
+ (BOOL)resetCache;

/*
 * get cache default cache directory
 *
 */
+ (NSString *)cacheDirectory;

/*
 * create the default cache path;
 *
 */
+ (BOOL )createDirectory;

/*
 * @ brief: remove a file with a specified key
 *
 * @ param: aKey, the key specified to be moved
 */
+ (BOOL)removeObjectForKey:(NSString *)aKey;

/*
 * @ brief: remove a file with a specified path.The same as removeObjectForKey:,which is recommand to use
 *
 * @ param: aPath, the path of a file specified to be moved
 */
+ (BOOL)removeObjectForPath:(NSString *)aPath;

/*
 * @ brief: store the Dictionary to local disk and the key will be used as the file name
 *
 * @ param :aDictionary ,the object to be store
 *
 * @ param :aKey ,the key of the stored object
 */
+ (BOOL)setDictionary:(NSDictionary *)aDictionary forKey:(NSString *)aKey;

/*
 * @ brief:get the Dictionary of the specified key
 *
 * @ param:aKey,the key use to get specify file
 */
+ (NSDictionary *)dictionaryForKey:(NSString *)aKey;

+ (BOOL)setArray:(NSArray *)aArray forKey:(NSString *)aKey;
+ (NSArray *)arrayForKey:(NSString *)aKey;

//can cache image pdf with this
+ (BOOL)setData:(NSData *)aData forKey:(NSString *)aKey;
+ (NSData *)dataForKey:(NSString *)aKey;

/*
 * @ brief:get the object of the specified key
 *
 * @ param:aKey,the key use to get specify file
 */
+ (id)objectForKey:(NSString *)aKey;

/*
 * @ brief:get the file path of the specify key
 *
 * @ param:aKey,the key use to get specify file path;
 */
+ (NSString *)filePathForKey:(NSString *)aKey;

@end
