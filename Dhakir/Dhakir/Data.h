//
//  Data.h
//  Dhakir
//
//  Created by Hashir N A on 14/06/14.
//  Copyright (c) 2014 mobware4u. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Data : NSManagedObject

@property (nonatomic, retain) NSString* title;
@property (nonatomic, retain) NSData* username;
@property (nonatomic, retain) NSData* password;
@property (nonatomic, retain) NSData* notes;

@end
