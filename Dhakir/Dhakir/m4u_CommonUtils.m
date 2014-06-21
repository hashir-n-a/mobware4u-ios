//
//  m4u_CommonUtils.m
//  Dhakir
//
//  Created by Hashir N A on 17/06/14.
//  Copyright (c) 2014 mobware4u. All rights reserved.
//

#import "m4u_CommonUtils.h"

@implementation m4u_CommonUtils


+(NSString*) getCurrentDateTimeAsString
{
    NSDate *currDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"dd_MM_YY"];
    NSString *dateString = [dateFormatter stringFromDate:currDate];
    return dateString;
}

+(NSString*) generatePassword
{
    NSString *alphabet  = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXZY0123456789";
    NSMutableString *s = [NSMutableString stringWithCapacity:20];
    for (NSUInteger i = 0U; i < 20; i++) {
        u_int32_t r = arc4random() % [alphabet length];
        unichar c = [alphabet characterAtIndex:r];
        [s appendFormat:@"%C", c];
    }
    return s;
}

+(NSString*) getAppName
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
}


@end
