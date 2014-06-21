//
//  m4u_MasterViewController.h
//  Dhakir
//
//  Created by Hashir N A on 14/06/14.
//  Copyright (c) 2014 mobware4u. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface m4u_MasterViewController : UITableViewController <
                                            UISearchDisplayDelegate,
                                            UISearchBarDelegate,
                                            NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong,nonatomic) NSMutableArray *searchResults;


-(IBAction) showSettings:(id) sender;

@end
