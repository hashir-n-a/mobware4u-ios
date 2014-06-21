//
//  m4u_EncryptUtils.h
//  Dhakir
//
//  Created by Hashir N A on 16/06/14.
//  Copyright (c) 2014 mobware4u. All rights reserved.
//

@interface m4u_EncryptUtils : NSObject

+ (NSData*) encrypt: (NSString*) plainText;
+ (NSString*) decrypt: (NSData*) encryptedData;
+ (void) clearCredentials;
+(NSString*) getKey;

@end
