//
//  m4u_SettingsViewController.h
//  Dhakir
//
//  Created by Hashir N A on 15/06/14.
//  Copyright (c) 2014 mobware4u. All rights reserved.
//

#import <MessageUI/MessageUI.h>

@interface m4u_SettingsViewController : UIViewController<MFMailComposeViewControllerDelegate, UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *exportButton;
@property (weak, nonatomic) IBOutlet UISwitch *showPasswordSwitch;
@property (weak, nonatomic) IBOutlet UILabel *showPasswordSwitchLabel;

-(IBAction) exportData:(id) sender;
-(IBAction) deleteAllData:(id) sender;
-(IBAction) showPassword:(id) sender;

@end
