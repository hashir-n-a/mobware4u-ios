//
//  m4u_Preference.m
//  Rakat Counter
//
//  Created by Hashir N A on 22/06/14.
//  Copyright (c) 2014 mobware4u. All rights reserved.
//

#import "m4u_Preference.h"

@implementation m4u_Preference


+(void) save:(NSString*) key value:(float) value
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setFloat :value
                     forKey:key];
    // – setBool:forKey:
    // – setFloat:forKey:
    // in your case
    [userDefaults synchronize];
}

+(void) saveTimeout:(float) value
{
    [self save:@"timeout" value:value];
}


+(void) saveBrightness:(float) value
{
    [self save:@"brightness" value:value];
}

+(float) getBrightness
{
    return [[NSUserDefaults standardUserDefaults] floatForKey:@"brightness"];
}

+(int) getTimeout
{
    return (int) [[NSUserDefaults standardUserDefaults] floatForKey:@"timeout"];
}

+(void) saveDefaultBrightness:(float) value
{
    [self save:@"default_brightness" value:value];
}

+(float) getDefaultBrightness
{
    return [[NSUserDefaults standardUserDefaults] floatForKey:@"default_brightness"];
}


@end
