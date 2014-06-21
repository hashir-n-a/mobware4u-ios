//
//  m4u_DbUtils.m
//  Dhakir
//
//  Created by Hashir N A on 16/06/14.
//  Copyright (c) 2014 mobware4u. All rights reserved.
//

#import "m4u_DbUtils.h"
#import "Data.h"

@implementation m4u_DbUtils

+(NSString*) getAllDataAsCSV
{
    NSString *results = [[NSString alloc] init];
    m4u_AppDelegate *mainDelegate   = (m4u_AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *context = mainDelegate.managedObjectContext;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Data" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    for (Data *data in fetchedObjects)
    {
        results = [results stringByAppendingString:[NSString stringWithFormat:@"%@,%@,%@,%@,\n",
                                                        data.title,
                                                        data.username,
                                                        data.password,
                                                        data.notes]];
    }
    return results;
}
 

+(void) deleteAllData
{
    m4u_AppDelegate *mainDelegate   = (m4u_AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *context = mainDelegate.managedObjectContext;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Data" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    for (Data *data in fetchedObjects)
    {
        [context deleteObject:data];
    }
    if (![context save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
}

+(void) generateTestData
{
    m4u_AppDelegate *mainDelegate   = (m4u_AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *context = mainDelegate.managedObjectContext;
    
    NSData *testData = [m4u_EncryptUtils encrypt:@"testtestest"];
    for(int i=0; i<100; i++) {
        NSManagedObject *dataObject = [NSEntityDescription
                                       insertNewObjectForEntityForName:@"Data"
                                       inManagedObjectContext:context];
        
        NSString *title = [NSString stringWithFormat:@"test title %d", i];
        [dataObject setValue:title forKey:@"title"];
        [dataObject setValue:testData forKey:@"username"];
        [dataObject setValue:testData forKey:@"password"];
        [dataObject setValue:testData forKey:@"notes"];
    }
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    
}

@end
