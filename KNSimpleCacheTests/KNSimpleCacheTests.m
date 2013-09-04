//
//  KNSimpleCacheTests.m
//  KNSimpleCacheTests
//
//  Created by Niko on 13-9-4.
//  Copyright (c) 2013年 Niko. All rights reserved.
//

#import "KNSimpleCacheTests.h"
#import "KNSimpleCache.h"

@implementation KNSimpleCacheTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testDictionary
{
    NSLog(@"start testDictionary");
    NSDictionary *dictionary = @{@"one" : @"value1",@"two":@"value2"};
    KNSimpleCache *cache = [[KNSimpleCache alloc] init];
    STAssertNotNil(cache, @"the instance should not be nil");
   BOOL exist = [KNSimpleCache createDirectory];
    STAssertTrue(exist, @"cache path should be exist");
    NSString *path = [KNSimpleCache cacheDirectory];
    STAssertNotNil(path, @"cache directory should not be nil");
    BOOL d = [KNSimpleCache setDictionary:dictionary forKey:@"dictionary"];
    STAssertTrue(d, @"the dictionary should be stored successfully");
    
    NSDictionary *get = [KNSimpleCache dictionaryForKey:@"dictionary"];
    STAssertNotNil(get, @"the stored dictionary should not be nil");
    
    STAssertTrue([get isEqualToDictionary:dictionary], @"dictionary before stored should have the save content after got from disk");
    NSLog(@"end testDictionary");
    
}

- (void)testArray
{
    NSLog(@"start testArray");
    NSArray *array = @[@"one",@"two",@"three"];
    KNSimpleCache *cache = [[KNSimpleCache alloc] init];
    STAssertNotNil(cache, @"the instance should not be nil");
    BOOL exist = [KNSimpleCache createDirectory];
    STAssertTrue(exist, @"cache path should be exist");
    NSString *path = [KNSimpleCache cacheDirectory];
    STAssertNotNil(path, @"cache array should not be nil");
    BOOL d = [KNSimpleCache setArray:array forKey:@"array"];
    STAssertTrue(d, @"the array should be stored successfully");
    NSArray *get = [KNSimpleCache arrayForKey:@"array"];
    STAssertNotNil(get, @"the stored array should not be nil");
    
    STAssertTrue([array isEqualToArray:get], @"array before stored should have the save content after got from disk");
    NSLog(@"end testArray");
}

- (void)testData
{
    NSLog(@"start testData");
    NSString *string = @"data to be stored";
    NSData *data =[NSData dataWithBytes:[string UTF8String] length:[string length]];
    KNSimpleCache *cache = [[KNSimpleCache alloc] init];
    STAssertNotNil(cache, @"the instance should not be nil");
    BOOL exist = [KNSimpleCache createDirectory];
    STAssertTrue(exist, @"cache path should be exist");
    NSString *path = [KNSimpleCache cacheDirectory];
    STAssertNotNil(path, @"cache directory should not be nil");
    BOOL d = [KNSimpleCache setData:data forKey:@"data"];
    STAssertTrue(d, @"the data should be stored successfully");
    
    NSData *get = [KNSimpleCache dataForKey:@"data"];
    STAssertNotNil(get, @"the stored data should not be nil");
    
    STAssertTrue([data isEqualToData:data], @"data before stored should have the save content after got from disk");
    NSLog(@"end testData");
}

- (void)testReset
{
    [KNSimpleCache createDirectory];
    BOOL exist = [KNSimpleCache resetCache];
    STAssertTrue(exist, @"cache path should be removed");
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *path  = [KNSimpleCache cacheDirectory];
    BOOL e = [fm fileExistsAtPath:path];
    STAssertFalse(e, @"cache path should be removed");
}
@end
