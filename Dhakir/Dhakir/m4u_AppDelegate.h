//
//  m4u_AppDelegate.h
//  Dhakir
//
//  Created by Hashir N A on 14/06/14.
//  Copyright (c) 2014 mobware4u. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "m4u_MasterViewController.h"


@interface m4u_AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) m4u_MasterViewController *masterViewController;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
