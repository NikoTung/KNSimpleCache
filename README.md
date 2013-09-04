KNSimpleCache
=================================

KNSimpleCache is a simple cache class for ios.It surpport array,dictionary and nsdata cache,each object stored as a file,and you can simply use get/set to operate the object.Each key which used to store is the file name.The default expiration time is unlimit,but you can modify by youself if you need.

It has the following methods:

remove a file with a specified key

	+ (BOOL)removeObjectForKey:(NSString *)aKey;

store the Dictionary to local disk and the key will be used as the file name

	+ (BOOL)setDictionary:(NSDictionary *)aDictionary forKey:(NSString *)aKey;

get the Dictionary of the specified key

	+ (NSDictionary *)dictionaryForKey:(NSString *)aKey;

get the file path of the specify key

	+ (NSString *)filePathForKey:(NSString *)aKey;