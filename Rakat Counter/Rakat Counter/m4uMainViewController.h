//
//  m4uMainViewController.h
//  Rakat Counter
//
//  Created by Hashir N A on 22/06/14.
//  Copyright (c) 2014 mobware4u. All rights reserved.
//

#import "m4uFlipsideViewController.h"

@interface m4uMainViewController : UIViewController <m4uFlipsideViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *rakatCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *startMessageB;

-(IBAction)touched:(id)sender;
-(IBAction)reset:(id)sender;

@end
