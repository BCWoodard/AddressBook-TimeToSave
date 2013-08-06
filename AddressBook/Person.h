//
//  Person.h
//  AddressBook
//
//  Created by Brad Woodard on 7/22/13.
//  Copyright (c) 2013 Brad Woodard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *phoneNumber;

- (Person *)initWithFirstName:(NSString *)aFirstName andLastName:(NSString *)aLastName andEmail:(NSString *)aEmail andPhoneNumber:(NSString *)aPhoneNumber;

- (NSDictionary *)makeDictionary;

@end
