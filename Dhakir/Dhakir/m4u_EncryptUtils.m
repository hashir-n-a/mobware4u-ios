//
//  m4u_EncryptUtils.m
//  Dhakir
//
//  Created by Hashir N A on 16/06/14.
//  Copyright (c) 2014 mobware4u. All rights reserved.
//

#import "m4u_EncryptUtils.h"
#import "NSData+Encryption.h"
#import "JNKeychain.h"

@implementation m4u_EncryptUtils

+ (NSData*) encryptString:(NSString*)plaintext withKey:(NSString*)key {
	return [[plaintext dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptWithKey:key];
}

+ (NSString*) decryptData:(NSData*)ciphertext withKey:(NSString*)key {
	return [[NSString alloc] initWithData:[ciphertext AES256DecryptWithKey:key]
	                              encoding:NSUTF8StringEncoding];
}

+ (NSData*) encrypt: (NSString*) plainText
{
    return [m4u_EncryptUtils encryptString:plainText withKey:[self getKey]];
}

+ (NSString*) decrypt: (NSData*) encryptedData
{
    return  [m4u_EncryptUtils decryptData:encryptedData withKey:[self getKey]];
}

+(NSString*) getKey
{
    NSData* key = [JNKeychain loadValueForKey:KEY];
    if(key == nil || [key length] == 0) {
        // empty
        key = [self random128BitAESKey];
        [JNKeychain saveValue:key forKey:KEY];
    }
    return [self convertToString:key];
}

+(NSString*) convertToString:(NSData*) key
{
    unichar* hexChars = (unichar*)malloc(sizeof(unichar) * (key.length*2));
    unsigned char* bytes = (unsigned char*)key.bytes;
    for (NSUInteger i = 0; i < key.length; i++) {
        unichar c = bytes[i] / 16;
        if (c < 10) c += '0';
        else c += 'a' - 10;
        hexChars[i*2] = c;
        c = bytes[i] % 16;
        if (c < 10) c += '0';
        else c += 'a' - 10;
        hexChars[i*2+1] = c;
    }
    NSString* keyString = [[NSString alloc] initWithCharactersNoCopy:hexChars
                                                              length:key.length*2
                                                        freeWhenDone:YES];
    return keyString;
}

+ (NSData *)random128BitAESKey {
    unsigned char buf[16];
    arc4random_buf(buf, sizeof(buf));
    return [NSData dataWithBytes:buf length:sizeof(buf)];
}

+ (void) clearCredentials {
    [JNKeychain saveValue:@"" forKey:KEY];
    [JNKeychain saveValue:@"" forKey:PASSWORD];
}


@end
