//
//  KNSimpleCache.m
//  KNSimpleCache
//
//  Created by Niko on 13-9-4.
//  Copyright (c) 2013年 Niko. All rights reserved.
//

#import "KNSimpleCache.h"

static NSString *cacheFiles = @"KNSimpleCache";
static NSTimeInterval validTime =(double)24*60*60*MAXFLOAT;

@implementation KNSimpleCache

- (id)init
{
    self = [super init];
    if (self) {
        NSFileManager *fm = [NSFileManager defaultManager];
        NSString *path = [KNSimpleCache cacheDirectory];
        if (![fm fileExistsAtPath:path]) {
            [fm createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
        }
        NSLog(@"..... %0.002f",validTime);
    }
    return self;
}

+ (NSString *)cacheDirectory
{
    NSArray *paths= NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cacheDirectory = [paths objectAtIndex:0];
	cacheDirectory = [cacheDirectory stringByAppendingPathComponent:cacheFiles];
	return cacheDirectory;
}

+ (BOOL )createDirectory
{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *path = [KNSimpleCache cacheDirectory];
    return  [fm createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
}

+ (BOOL)resetCache
{
    return [[NSFileManager defaultManager] removeItemAtPath:[KNSimpleCache cacheDirectory] error:nil];
    
}

+ (BOOL)removeObjectForKey:(NSString *)aKey
{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *path  = [[KNSimpleCache cacheDirectory] stringByAppendingPathComponent:aKey];
    if ([fm fileExistsAtPath:path]) {
        return [fm removeItemAtPath:path error:nil];
    }
    else
    {
        return NO;
    }
    
    return NO;
}


+ (BOOL)removeObjectForPath:(NSString *)aPath
{
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:aPath]) {
        return [fm removeItemAtPath:aPath error:nil];
    }
    else
    {
        return NO;
    }
    
    return NO;
}

+ (BOOL)setDictionary:(NSDictionary *)aDictionary forKey:(NSString *)aKey
{
    BOOL result = NO;
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *path = [[KNSimpleCache cacheDirectory] stringByAppendingPathComponent:aKey];
    BOOL dir ;
    if (![fm fileExistsAtPath:[KNSimpleCache cacheDirectory] isDirectory:&dir]) {
        [KNSimpleCache createDirectory];
    }
	@try {
		result = [aDictionary writeToFile:path atomically:YES];
	}
	@catch (NSException * e) {
		NSLog(@"write dictionary %@ fail.",aDictionary);
        return NO;
	}
    return result;
}

+ (NSDictionary *)dictionaryForKey:(NSString *)aKey
{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *path = [[KNSimpleCache cacheDirectory] stringByAppendingPathComponent:aKey];
    if ([fm fileExistsAtPath:path]) {
        NSDate *modificationDate = [[fm attributesOfItemAtPath:path error:nil] objectForKey:NSFileModificationDate];
		NSDate *date = [NSDate date];
		if ([date timeIntervalSinceDate:modificationDate] > validTime) {
			[fm removeItemAtPath:path error:nil];
		} else {
            NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:path];
			return dictionary;
		}
    }
    return nil;
}

+ (BOOL)setArray:(NSArray *)aArray forKey:(NSString *)aKey
{
    BOOL result = NO;
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *path = [[KNSimpleCache cacheDirectory] stringByAppendingPathComponent:aKey];
    BOOL dir ;
    if (![fm fileExistsAtPath:[KNSimpleCache cacheDirectory] isDirectory:&dir]) {
        [KNSimpleCache createDirectory];
    }
	@try {
		result = [aArray writeToFile:path atomically:YES];
	}
	@catch (NSException * e) {
		NSLog(@"write array %@ fail.",aArray);
        return NO;
	}
    return result;
}
+ (NSArray *)arrayForKey:(NSString *)aKey
{

    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *path = [[KNSimpleCache cacheDirectory] stringByAppendingPathComponent:aKey];
    if ([fm fileExistsAtPath:path]) {
        NSDate *modificationDate = [[fm attributesOfItemAtPath:path error:nil] objectForKey:NSFileModificationDate];
        NSDate *date = [NSDate date];
        
		if ([date timeIntervalSinceDate:modificationDate] > validTime) {
			[fm removeItemAtPath:path error:nil];
		} else {
            NSArray *array = [NSArray arrayWithContentsOfFile:path];
            return array;
		}
    }
    return nil;
}

//can cache image pdf with this
+ (BOOL)setData:(NSData *)aData forKey:(NSString *)aKey
{
    BOOL result = NO;
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *path = [[KNSimpleCache cacheDirectory] stringByAppendingPathComponent:aKey];
    BOOL dir ;
    if (![fm fileExistsAtPath:[KNSimpleCache cacheDirectory] isDirectory:&dir]) {
        [KNSimpleCache createDirectory];
    }
	@try {
		result = [aData writeToFile:path options:NSDataWritingAtomic error:nil];
        
	}
	@catch (NSException * e) {
		NSLog(@"write array %@ fail.",aData);
        return NO;
	}
    return result;
}
+ (NSData *)dataForKey:(NSString *)aKey
{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *path = [[KNSimpleCache cacheDirectory] stringByAppendingPathComponent:aKey];
    if ([fm fileExistsAtPath:path]) {
        NSDate *modificationDate = [[fm attributesOfItemAtPath:path error:nil] objectForKey:NSFileModificationDate];
		NSDate *date = [NSDate date];
		if ([date timeIntervalSinceDate:modificationDate] > validTime) {
			[fm removeItemAtPath:path error:nil];
		} else {
            NSData *data = [NSData dataWithContentsOfFile:path];
            return data;
		}
    }
    return nil;
}


+ (id)objectForKey:(NSString *)aKey
{
    return nil;
}

+ (NSString *)filePathForKey:(NSString *)aKey
{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *path = [[KNSimpleCache cacheDirectory] stringByAppendingPathComponent:aKey];
    if ([fm fileExistsAtPath:path]) {
        NSDate *modificationDate = [[fm attributesOfItemAtPath:path error:nil] objectForKey:NSFileModificationDate];
		if ([modificationDate timeIntervalSinceNow] > validTime) {
			[fm removeItemAtPath:path error:nil];
		} else {
            return path;
		}
    }
    return nil;
}


@end
