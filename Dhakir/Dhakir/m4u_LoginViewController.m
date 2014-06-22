//
//  m4u_LoginController.m
//  Dhakir
//
//  Created by Hashir N A on 15/06/14.
//  Copyright (c) 2014 mobware4u. All rights reserved.
//

#import "m4u_LoginViewController.h"

@interface m4u_LoginViewController ()

@end

@implementation m4u_LoginViewController

@synthesize  passwordTextField;
@synthesize  messageLabel;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    messageLabel.text = STR_LOGIN_PASSWORD_PROMPT_MESSAGE;
    [passwordTextField addTarget:self
                  action:@selector(textFieldDidChange:)
        forControlEvents:UIControlEventEditingChanged];
}

- (void) loginButtonPress:(id) sender
{
    NSString* passStored = [JNKeychain loadValueForKey:PASSWORD];
    if(passStored == nil || [passwordTextField.text isEqualToString:passStored]) {
        [self performSegueWithIdentifier:@"loginSuccess" sender:@"success"];
    } else {
        messageLabel.textColor = [UIColor redColor];
        messageLabel.text = STR_LOGIN_PASSWORD_INCORRECT_MESSAGE;
    }
}

-(void) resetButtonPress:(id)sender
{
    [passwordTextField resignFirstResponder];
    
    [m4u_ViewUtils showActionSheet:self
                         withTitle:STR_LOGIN_RESET_WARNING_TITLE
             destructiveButtonText:STR_LOGIN_RESET_ACTION_SHEET_BUTTON
                  cancelButtonText:STR_CANCEL];
}

-(void) textFieldDidChange:(id) sender
{
    messageLabel.textColor = [UIColor blackColor];
    messageLabel.text = STR_LOGIN_PASSWORD_PROMPT_MESSAGE;
}

// Dismiss keyboard if touched elsewhere on screen
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark actionsheet
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if  (buttonIndex == 0) {
        [m4u_EncryptUtils clearCredentials];
        [m4u_DbUtils deleteAllData];
        [m4u_ViewUtils showPopup:STR_SUCCESS andWithMessage:STR_LOGIN_RESET_CONFIRMATION];
    }
}

@end
