//
//  m4u_viewUtils.m
//  Dhakir
//
//  Created by Hashir N A on 17/06/14.
//  Copyright (c) 2014 mobware4u. All rights reserved.
//

#import "m4u_viewUtils.h"

@implementation m4u_ViewUtils


+(void) showPopup:(NSString*) title andWithMessage:(NSString*) message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

+(void) showPopupTwoButtons:(NSString*) title andWithMessage:(NSString*) message andWithButton1Text:(NSString*) button1 andWithButton2Text:(NSString*) button2 delegate:(UIViewController*) delegate
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:delegate
                                          cancelButtonTitle:button2
                                          otherButtonTitles:button1,nil];
    [alert show];
}


+(void) showActionSheet:(UIViewController*) forController withTitle:(NSString*) title destructiveButtonText:(NSString*) buttonText cancelButtonText:(NSString*) cancelButtonText
{
    NSString *actionSheetTitle = title;
    NSString *destructiveTitle = buttonText;
    NSString *cancelTitle      = cancelButtonText;
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:actionSheetTitle
                                  delegate:(id<UIActionSheetDelegate>)forController
                                  cancelButtonTitle:cancelTitle
                                  destructiveButtonTitle:destructiveTitle
                                  otherButtonTitles:nil];
    
    [actionSheet showInView:forController.view];
}

@end
