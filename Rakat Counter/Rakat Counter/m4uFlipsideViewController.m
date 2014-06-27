//
//  m4uFlipsideViewController.m
//  Rakat Counter
//
//  Created by Hashir N A on 22/06/14.
//  Copyright (c) 2014 mobware4u. All rights reserved.
//

#import "m4uFlipsideViewController.h"
#import "m4u_Preference.h"

@interface m4uFlipsideViewController ()

@end

@implementation m4uFlipsideViewController

@synthesize timeoutLabel;
@synthesize timeoutSlider;
@synthesize brightnessSlider;

- (void)viewDidLoad
{
    [super viewDidLoad];
	float brightnessValue  = [m4u_Preference getBrightness];
    brightnessSlider.value = brightnessValue;
    [[UIScreen mainScreen] setBrightness: brightnessValue];
    
    float timeout  = [m4u_Preference getTimeout];
    timeoutSlider.value = timeout;
    [self handleTimeoutLabel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}

-(IBAction)brightnessChanged:(id)sender
{
    [[UIScreen mainScreen] setBrightness: brightnessSlider.value];
    [m4u_Preference saveBrightness:brightnessSlider.value];
}

-(IBAction)timeoutChanged:(id)sender
{
    [self handleTimeoutLabel];
    int value = (int) timeoutSlider.value;
    [m4u_Preference saveTimeout:value];
}

-(void) handleTimeoutLabel
{
    int value = (int) timeoutSlider.value;
    if(value > 60) {
        int minutes = value / 60;
        int seconds = value % 60;
        timeoutLabel.text = [NSString stringWithFormat:@"%d min %d sec", minutes, seconds];
    } else {
        timeoutLabel.text = [NSString stringWithFormat:@"%d sec", value];
    }
}


@end
