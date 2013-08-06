//
//  Person.m
//  AddressBook
//
//  Created by Brad Woodard on 7/22/13.
//  Copyright (c) 2013 Brad Woodard. All rights reserved.
//

#import "Person.h"

@implementation Person
@synthesize firstName, lastName, email, phoneNumber;

- (Person *)initWithFirstName:(NSString *)aFirstName andLastName:(NSString *)aLastName andEmail:(NSString *)aEmail andPhoneNumber:(NSString *)aPhoneNumber
{
    Person *newPerson = [[Person alloc] init];
    newPerson.firstName = aFirstName;
    newPerson.lastName = aLastName;
    newPerson.email = aEmail;
    newPerson.phoneNumber = aPhoneNumber;
    
    return newPerson;
}

// Converts person object into a dictionary
- (NSDictionary *)makeDictionary
{    
    NSDictionary *personDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:self.firstName, @"firstName", self.lastName, @"lastName", self.email, @"email", self.phoneNumber, @"phoneNumber", nil];
    
    return personDictionary;
}


- (id)initWithDictionary:(NSDictionary *)personDictionary
{
    self = [super init];
    
    if (self) {
        firstName = [personDictionary objectForKey:@"firstName"];
        lastName = [personDictionary objectForKey:@"lastName"];
        email = [personDictionary objectForKey:@"email"];
        phoneNumber = [personDictionary objectForKey:@"phoneNumber"];
    }

    return self;
}

@end
