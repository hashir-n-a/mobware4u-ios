//
//  m4uFlipsideViewController.h
//  Rakat Counter
//
//  Created by Hashir N A on 22/06/14.
//  Copyright (c) 2014 mobware4u. All rights reserved.
//

#import <UIKit/UIKit.h>

@class m4uFlipsideViewController;

@protocol m4uFlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(m4uFlipsideViewController *)controller;
@end

@interface m4uFlipsideViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel  *timeoutLabel;
@property (weak, nonatomic) IBOutlet UISlider *brightnessSlider;
@property (weak, nonatomic) IBOutlet UISlider *timeoutSlider;

@property (weak, nonatomic) id <m4uFlipsideViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;
- (IBAction)brightnessChanged:(id)sender;
- (IBAction)timeoutChanged:(id)sender;

@end
