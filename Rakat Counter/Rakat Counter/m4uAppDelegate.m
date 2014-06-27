//
//  m4uAppDelegate.m
//  Rakat Counter
//
//  Created by Hashir N A on 22/06/14.
//  Copyright (c) 2014 mobware4u. All rights reserved.
//

#import "m4uAppDelegate.h"
#import "m4u_Preference.h"

@implementation m4uAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
    float brightnessPrior = [m4u_Preference getDefaultBrightness];
    [[UIScreen mainScreen] setBrightness:brightnessPrior];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
    float brightnessPrior = [m4u_Preference getDefaultBrightness];
    [[UIScreen mainScreen] setBrightness:brightnessPrior];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.

}

- (void)applicationDidBecomeActive:(UIApplication *)application
{   
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    float currentBrightness = [UIScreen mainScreen].brightness;
    [m4u_Preference saveDefaultBrightness:currentBrightness];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
