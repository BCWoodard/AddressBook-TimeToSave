//
//  ShowViewController.h
//  AddressBook
//
//  Created by Brad Woodard on 7/22/13.
//  Copyright (c) 2013 Brad Woodard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditRecordDelegate.h"
#import "Person.h"


@interface ShowViewController : UIViewController <EditRecordDelegate>

@property (strong, nonatomic) id <EditRecordDelegate> delegate;
@property (strong, nonatomic) NSDictionary *incomingPerson;

@end
