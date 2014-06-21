//
//  m4u_DetailViewController.m
//  Dhakir
//
//  Created by Hashir N A on 14/06/14.
//  Copyright (c) 2014 mobware4u. All rights reserved.
//

#import "m4u_DetailViewController.h"
#import <QuartzCore/QuartzCore.h>


@interface m4u_DetailViewController ()
- (void)configureView;
@end

@implementation m4u_DetailViewController

@synthesize titleTextField;
@synthesize usernameTextField;
@synthesize passwordTextField;
@synthesize notesTextView;
@synthesize scrollView;

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.titleTextField.text    = [self getData:@"title"];
        self.usernameTextField.text = [self getData:@"username"];
        self.passwordTextField.text = [self getData:@"password"];
        self.notesTextView.text     = [self getData:@"notes"];

        [[self.notesTextView layer] setBorderColor:[[UIColor grayColor] CGColor]];
        [[self.notesTextView layer] setBorderWidth:2.3];
        [[self.notesTextView layer] setCornerRadius:8];
        
        self.navigationItem.title = self.titleTextField.text;
        [titleTextField addTarget:self
                              action:@selector(titleTextFieldChanged)
                    forControlEvents:UIControlEventEditingChanged];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    [self initToolBarButtons];
    [self registerTouch];
}

-(void) titleTextFieldChanged
{
   self.navigationItem.title = self.titleTextField.text;
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

- (void) goBackAndSave
{
    [self saveData];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) saveData
{
    [self saveDataAsEncrypted:titleTextField.text forData:@"title"];
    [self saveDataAsEncrypted:usernameTextField.text forData:@"username"];
    [self saveDataAsEncrypted:passwordTextField.text forData:@"password"];
    [self saveDataAsEncrypted:notesTextView.text forData:@"notes"];
}


-(NSString*) getData:(NSString*) forThisData
{
    if([forThisData isEqualToString:@"title"]) {
        return [[self.detailItem valueForKey:forThisData] description];
    } else {
        NSData* dat = [self.detailItem valueForKey:forThisData];
        return [m4u_EncryptUtils decrypt:dat];
    }
}

-(void) saveDataAsEncrypted:(NSString*) thisString forData:(NSString*)forData
{
    if([forData isEqualToString:@"title"]) {
        [_detailItem setValue:thisString  forKey:forData];
    } else {
        NSData *dat = [m4u_EncryptUtils encrypt:thisString];
        [_detailItem setValue:dat  forKey:forData];
    }
}

-(void) generatePassword:(id)sender
{
    NSString *password = [m4u_CommonUtils generatePassword];
    passwordTextField.text = password;
}


#pragma mark textview delegate
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    CGPoint scrollPoint = CGPointMake(0.0, notesTextView.frame.origin.y-100);
    [scrollView setContentOffset:scrollPoint animated:YES];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if(![notesTextView isFirstResponder]) {
        UIEdgeInsets contentInsets = UIEdgeInsetsZero;
        scrollView.contentInset = contentInsets;
        scrollView.scrollIndicatorInsets = contentInsets;
    }
}

#pragma mark screen touch

-(void) registerTouch
{
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touch)];
    [recognizer setNumberOfTapsRequired:1];
    [recognizer setNumberOfTouchesRequired:1];
    [scrollView addGestureRecognizer:recognizer];
}

// Dismiss keyboard if touched elsewhere on screen
-(void) touch
{
    [self.view endEditing:YES];
}


@end
