//
//  ViewController.h
//  AddressBook
//
//  Created by Brad Woodard on 7/22/13.
//  Copyright (c) 2013 Brad Woodard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditRecordDelegate.h"

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, EditRecordDelegate>

@end
