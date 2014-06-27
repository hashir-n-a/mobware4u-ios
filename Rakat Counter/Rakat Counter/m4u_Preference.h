//
//  m4u_Preference.h
//  Rakat Counter
//
//  Created by Hashir N A on 22/06/14.
//  Copyright (c) 2014 mobware4u. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface m4u_Preference : NSObject

+(void) saveTimeout:(float) value;
+(void) saveBrightness:(float) value;
+(float) getBrightness;
+(int) getTimeout;

+(void) saveDefaultBrightness:(float) value;
+(float) getDefaultBrightness;


@end
