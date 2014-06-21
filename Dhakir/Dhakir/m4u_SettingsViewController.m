//
//  m4u_SettingsViewController.m
//  Dhakir
//
//  Created by Hashir N A on 15/06/14.
//  Copyright (c) 2014 mobware4u. All rights reserved.
//

#import "m4u_SettingsViewController.h"
#import <CoreText/CoreText.h>
#import "PDFRenderer.h"

@interface m4u_SettingsViewController ()

@end

@implementation m4u_SettingsViewController

@synthesize passwordTextField;
@synthesize exportButton;
@synthesize showPasswordSwitch;
@synthesize showPasswordSwitchLabel;


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
    [self loadPassword];
    [self initToolBarButtons];
}

-(void) initToolBarButtons
{
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                   target:self
                                   action:@selector(goBackAndSave)];
    self.navigationItem.rightBarButtonItem = saveButton;
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]
                                     initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                     target:self
                                     action:@selector(goBack)];
    self.navigationItem.leftBarButtonItem = cancelButton;
}

- (void) goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) goBackAndSave
{
    [self saveData];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) loadPassword
{
    passwordTextField.text = [JNKeychain loadValueForKey:@"m4u_dhakir_lp"];
}

-(void) saveData
{
    NSString* passwordEntered = passwordTextField.text;
    if(passwordEntered != nil) {
        [JNKeychain saveValue:passwordEntered forKey:@"m4u_dhakir_lp"];
    }
}

-(void) exportData:(id)sender
{
    [exportButton setEnabled:NO];
    [self emailPasswordAsProtectedPdf];
}

-(void) showPassword:(id)sender
{
    if(![sender isOn])
    {
        [passwordTextField setSecureTextEntry:YES ];
        [showPasswordSwitchLabel setText:@"Show Password"];
    }
    else
    {
        [passwordTextField setSecureTextEntry:NO  ];
        [showPasswordSwitchLabel setText:@"Hide Password"];
    }
}

-(void) emailPasswordAsProtectedPdf
{
    NSString* data = [m4u_DbUtils getAllDataAsCSV];
    if(nil == data || [data isEqualToString:@""]) {
        [m4u_ViewUtils showPopup:STR_ERROR andWithMessage:STR_ERROR_NO_DATA];
        return;
    }
    
    [m4u_FileUtils deletePdfFileIfItExists];
    
    NSString* filePath = [m4u_FileUtils getPasswordPdfPath];
    NSString* fileName = [NSString stringWithFormat:@"%@_%@.pdf",
                          [m4u_CommonUtils getAppName],
                          [m4u_CommonUtils getCurrentDateTimeAsString]];
    
    if(filePath != nil && ![filePath isEqualToString:@""]) {
        NSString* subject  = [STR_SETTINGS_EXPORT_SUBJECT stringByAppendingString:[m4u_CommonUtils getCurrentDateTimeAsString]];
        
        // render pdf
        [PDFRenderer drawPDF:filePath content:data];
        
        NSData *myData = [[NSFileManager defaultManager] contentsAtPath:filePath];
        
        if(myData != nil && [myData length] > 0) {
            MFMailComposeViewController *composeViewController = [[MFMailComposeViewController alloc] initWithNibName:nil bundle:nil];
            [composeViewController setMailComposeDelegate:self];
            [composeViewController setSubject: subject];
            [composeViewController setMessageBody:STR_SETTINGS_EMAIL_BODY isHTML:NO];
            [composeViewController addAttachmentData:myData mimeType:@"application/pdf" fileName:fileName];
            
            [self presentViewController:composeViewController animated:YES completion:nil];
        } else {
            NSLog(@"Some error occured reading file");
        }
    }
}

-(void) deleteAllData:(id)sender
{
    [m4u_ViewUtils showActionSheet:self
                    withTitle:STR_SETTINGS_DELETE_ACTION_TITLE
                    destructiveButtonText:STR_DELETE
                    cancelButtonText:STR_CANCEL];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    //Add an alert in case of failure
    [self dismissViewControllerAnimated:YES completion:nil];
    
    // delete the pdf
    [m4u_FileUtils deletePdfFileIfItExists];
    
    [exportButton setEnabled:YES];
}

#pragma mark actionsheet
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if  (buttonIndex == 0) {
        [m4u_DbUtils deleteAllData];
        [m4u_ViewUtils
                  showPopup:STR_SUCCESS
                  andWithMessage:STR_SETTINGS_DATA_DELETED_CONFIRMATION_MESSAGE];
    }
}

@end
