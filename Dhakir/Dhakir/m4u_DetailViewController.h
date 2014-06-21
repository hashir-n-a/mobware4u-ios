//
//  m4u_DetailViewController.h
//  Dhakir
//
//  Created by Hashir N A on 14/06/14.
//  Copyright (c) 2014 mobware4u. All rights reserved.
//


@interface m4u_DetailViewController : UIViewController<UITextViewDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextView  *notesTextView;
@property (weak, nonatomic) IBOutlet UILabel     *detailDescriptionLabel;
@property (weak, nonatomic) IBOutlet UIScrollView  *scrollView;

-(IBAction) generatePassword:(id) sender;

@end
