//
//  m4u_FileUtils.m
//  Dhakir
//
//  Created by Hashir N A on 16/06/14.
//  Copyright (c) 2014 mobware4u. All rights reserved.
//

#import "m4u_FileUtils.h"

@implementation m4u_FileUtils


+(void) deletePdfFileIfItExists
{
    NSString* fileName = [self getPasswordPdfPath];
    if(fileName != nil && ![fileName isEqualToString:@""]) {
        [[NSFileManager defaultManager] removeItemAtPath:fileName error:nil];
    }
}

+(NSString*) getPasswordPdfPath
{
    // delete the pdf
    NSString* fileName = [NSString stringWithFormat:@"%@_%@.pdf",
                          [m4u_CommonUtils getAppName],
                          [m4u_CommonUtils getCurrentDateTimeAsString]];
    
    m4u_AppDelegate *mainDelegate = (m4u_AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSURL *storeURL = [[mainDelegate applicationDocumentsDirectory] URLByAppendingPathComponent:fileName];
    return [storeURL path];
}



@end
