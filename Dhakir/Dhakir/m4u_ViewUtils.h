//
//  m4u_viewUtils.h
//  Dhakir
//
//  Created by Hashir N A on 17/06/14.
//  Copyright (c) 2014 mobware4u. All rights reserved.
//


@interface m4u_ViewUtils : NSObject

+(void) showPopup:(NSString*) title
              andWithMessage:(NSString*) message;

+(void) showActionSheet:(UIViewController*) forController
              withTitle:(NSString*) title
              destructiveButtonText:(NSString*) buttonText
              cancelButtonText:(NSString*) cancelButtonText;

+(void) showPopupTwoButtons:(NSString*) title
             andWithMessage:(NSString*) message
             andWithButton1Text:(NSString*) button1
             andWithButton2Text:(NSString*) button2
             delegate:(UIViewController*) delegate;

@end
