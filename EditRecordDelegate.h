//
//  EditRecordDelegate.h
//  AddressBook
//
//  Created by Brad Woodard on 7/23/13.
//  Copyright (c) 2013 Brad Woodard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

@protocol EditRecordDelegate <NSObject>


- (void)editRecord:(Person *)updatedPerson;

@optional

// optional AddRecord method

@end
