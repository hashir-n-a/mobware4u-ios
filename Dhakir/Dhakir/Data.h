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

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSString * notes;

@end
