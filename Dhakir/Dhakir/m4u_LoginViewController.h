//
//  m4u_LoginController.h
//  Dhakir
//
//  Created by Hashir N A on 15/06/14.
//  Copyright (c) 2014 mobware4u. All rights reserved.
//


@interface m4u_LoginViewController : UIViewController<UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

-(IBAction) loginButtonPress:(id) sender;
-(IBAction) resetButtonPress:(id) sender;

@end
