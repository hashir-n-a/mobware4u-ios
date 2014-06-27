//
//  m4uMainViewController.m
//  Rakat Counter
//
//  Created by Hashir N A on 22/06/14.
//  Copyright (c) 2014 mobware4u. All rights reserved.
//

#import "m4uMainViewController.h"
#import "m4u_Preference.h"

@interface m4uMainViewController ()

@end

@implementation m4uMainViewController

@synthesize rakatCountLabel;
@synthesize startMessageB;

int _rakatCount  = 0;

// only update counter if timedOut is YES
volatile bool _timedOut  = YES;

NSTimer* _timer;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    
}

- (void)viewWillAppear:(BOOL)animated
{
  	float brightnessValue  = [m4u_Preference getBrightness];
    [[UIScreen mainScreen] setBrightness: brightnessValue];
    
    _timedOut     = YES;
    
    [self reset:nil];

    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(m4uFlipsideViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        [[segue destinationViewController] setDelegate:self];
    }
}

-(IBAction)touched:(id)sender
{
    if(_timedOut) {
        _timedOut     = NO;
        
        rakatCountLabel.hidden   = NO;
        startMessageB.hidden     = YES;
        
        _rakatCount++;
        // adjust label font size based on count
        if(_rakatCount <= 9) {
            rakatCountLabel.font=[rakatCountLabel.font fontWithSize:300.0];
        } else if(_rakatCount > 9) {
            rakatCountLabel.font=[rakatCountLabel.font fontWithSize:250.0];
        } else if(_rakatCount > 99) {
            rakatCountLabel.font=[rakatCountLabel.font fontWithSize:100.0];
        } else {
            rakatCountLabel.font=[rakatCountLabel.font fontWithSize:50];
        }
        
        rakatCountLabel.text = [NSString stringWithFormat:@"%d", _rakatCount];
        
        _timer = [NSTimer scheduledTimerWithTimeInterval:[m4u_Preference getTimeout]
                                                  target:self
                                                  selector:@selector(timerTimeout)
                                                  userInfo:nil repeats:NO];
    }
}

-(IBAction)reset:(id)sender
{
    _rakatCount = 0;
    rakatCountLabel.text = [NSString stringWithFormat:@"%d", _rakatCount];
    rakatCountLabel.hidden   = YES;
    startMessageB.hidden     = NO;
    
}

#pragma mark timer
-(void) timerTimeout
{
    _timedOut = YES;
}

@end
