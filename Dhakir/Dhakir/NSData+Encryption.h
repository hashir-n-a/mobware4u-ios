//
//  NSData+Encryption.h
//  Dhakir
//
//  Created by Hashir N A on 16/06/14.
//  Copyright (c) 2014 mobware4u. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Encryption)
- (NSData *)AES256EncryptWithKey:(NSString *)key;
- (NSData *)AES256DecryptWithKey:(NSString *)key;
@end