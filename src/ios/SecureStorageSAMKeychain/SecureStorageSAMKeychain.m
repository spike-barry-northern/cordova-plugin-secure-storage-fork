//
//  SecureStorageSAMKeychain.m
//  SecureStorageSAMKeychain
//
//  Created by Sam Soffes on 5/19/10.
//  Copyright (c) 2010-2014 Sam Soffes. All rights reserved.
//

#import "SecureStorageSAMKeychain.h"
#import "SecureStorageSAMKeychainQuery.h"

NSString *const kSecureStorageSAMKeychainErrorDomain = @"com.samsoffes.samkeychain";
NSString *const kSecureStorageSAMKeychainAccountKey = @"acct";
NSString *const kSecureStorageSAMKeychainCreatedAtKey = @"cdat";
NSString *const kSecureStorageSAMKeychainClassKey = @"labl";
NSString *const kSecureStorageSAMKeychainDescriptionKey = @"desc";
NSString *const kSecureStorageSAMKeychainLabelKey = @"labl";
NSString *const kSecureStorageSAMKeychainLastModifiedKey = @"mdat";
NSString *const kSecureStorageSAMKeychainWhereKey = @"svce";

#if __IPHONE_4_0 && TARGET_OS_IPHONE
	static CFTypeRef SAMKeychainAccessibilityType = NULL;
#endif

@implementation SecureStorageSAMKeychain

+ (NSString *)passwordForService:(NSString *)serviceName account:(NSString *)account {
	return [self passwordForService:serviceName account:account error:nil];
}


+ (NSString *)passwordForService:(NSString *)serviceName account:(NSString *)account error:(NSError *__autoreleasing *)error {
	SecureStorageSAMKeychainQuery *query = [[SecureStorageSAMKeychainQuery alloc] init];
	query.service = serviceName;
	query.account = account;
	[query fetch:error];
	return query.password;
}

+ (NSData *)passwordDataForService:(NSString *)serviceName account:(NSString *)account {
	return [self passwordDataForService:serviceName account:account error:nil];
}

+ (NSData *)passwordDataForService:(NSString *)serviceName account:(NSString *)account error:(NSError **)error {
    SecureStorageSAMKeychainQuery *query = [[SecureStorageSAMKeychainQuery alloc] init];
    query.service = serviceName;
    query.account = account;
    [query fetch:error];

    return query.passwordData;
}


+ (BOOL)deletePasswordForService:(NSString *)serviceName account:(NSString *)account {
	return [self deletePasswordForService:serviceName account:account error:nil];
}


+ (BOOL)deletePasswordForService:(NSString *)serviceName account:(NSString *)account error:(NSError *__autoreleasing *)error {
	SecureStorageSAMKeychainQuery *query = [[SecureStorageSAMKeychainQuery alloc] init];
	query.service = serviceName;
	query.account = account;
	return [query deleteItem:error];
}


+ (BOOL)setPassword:(NSString *)password forService:(NSString *)serviceName account:(NSString *)account {
	return [self setPassword:password forService:serviceName account:account error:nil];
}


+ (BOOL)setPassword:(NSString *)password forService:(NSString *)serviceName account:(NSString *)account error:(NSError *__autoreleasing *)error {
	SecureStorageSAMKeychainQuery *query = [[SecureStorageSAMKeychainQuery alloc] init];
	query.service = serviceName;
	query.account = account;
	query.password = password;
	return [query save:error];
}

+ (BOOL)setPasswordData:(NSData *)password forService:(NSString *)serviceName account:(NSString *)account {
	return [self setPasswordData:password forService:serviceName account:account error:nil];
}


+ (BOOL)setPasswordData:(NSData *)password forService:(NSString *)serviceName account:(NSString *)account error:(NSError **)error {
    SecureStorageSAMKeychainQuery *query = [[SecureStorageSAMKeychainQuery alloc] init];
    query.service = serviceName;
    query.account = account;
    query.passwordData = password;
    return [query save:error];
}

+ (NSArray *)allAccounts {
	return [self allAccounts:nil];
}


+ (NSArray *)allAccounts:(NSError *__autoreleasing *)error {
    return [self accountsForService:nil error:error];
}


+ (NSArray *)accountsForService:(NSString *)serviceName {
	return [self accountsForService:serviceName error:nil];
}


+ (NSArray *)accountsForService:(NSString *)serviceName error:(NSError *__autoreleasing *)error {
    SecureStorageSAMKeychainQuery *query = [[SecureStorageSAMKeychainQuery alloc] init];
    query.service = serviceName;
    return [query fetchAll:error];
}


#if __IPHONE_4_0 && TARGET_OS_IPHONE
+ (CFTypeRef)accessibilityType {
	return SAMKeychainAccessibilityType;
}


+ (void)setAccessibilityType:(CFTypeRef)accessibilityType {
	CFRetain(accessibilityType);
	if (SAMKeychainAccessibilityType) {
		CFRelease(SAMKeychainAccessibilityType);
	}
	SAMKeychainAccessibilityType = accessibilityType;
}
#endif

@end
