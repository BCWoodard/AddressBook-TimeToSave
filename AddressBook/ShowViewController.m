//
//  ShowViewController.m
//  AddressBook
//
//  Created by Brad Woodard on 7/22/13.
//  Copyright (c) 2013 Brad Woodard. All rights reserved.
//

#import "ShowViewController.h"
#import "EditViewController.h"

@interface ShowViewController ()
{
    __weak IBOutlet UILabel     *firstNameLabel;
    __weak IBOutlet UILabel     *lastNameLabel;
    __weak IBOutlet UILabel     *emailLabel;
    __weak IBOutlet UILabel     *phoneNumberLabel;
    EditViewController          *editViewController;

}
- (IBAction)editPerson:(id)sender;

@end

@implementation ShowViewController
@synthesize incomingPerson;
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.navigationItem.title = [NSString stringWithFormat:@"%@ %@", [incomingPerson valueForKey:@"firstName"], [incomingPerson valueForKey:@"lastName"]];
    
    [self fillFormFields];

}


- (void)viewWillDisappear:(BOOL)animated
{
    //  1.  Create the person object from the textFields
    //  2.  Run the delegate method to update "people" and save to NSUserDefaults
    // 
    Person *editPerson = [[Person alloc] initWithFirstName:firstNameLabel.text andLastName:lastNameLabel.text andEmail:emailLabel.text andPhoneNumber:phoneNumberLabel.text];   // 1
    
    [delegate editRecord:editPerson];   // 2
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    editViewController = segue.destinationViewController;
    editViewController.delegate = self;
    
    editViewController.incomingPerson = incomingPerson;

}


- (void)fillFormFields
{
    firstNameLabel.text = [incomingPerson valueForKey:@"firstName"];
    lastNameLabel.text = [incomingPerson valueForKey:@"lastName"];
    emailLabel.text = [incomingPerson valueForKey:@"email"];
    phoneNumberLabel.text = [incomingPerson valueForKey:@"phoneNumber"];
}


#pragma mark - IBAction

- (IBAction)editPerson:(id)sender
{
    editViewController = [[EditViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:editViewController animated:YES];
}


#pragma mark - DELEGATE
- (void)editRecord:(Person *)updatedPerson
{
    // Assign values to properties of updatedPerson
    firstNameLabel.text = updatedPerson.firstName;
    lastNameLabel.text = updatedPerson.lastName;
    emailLabel.text = updatedPerson.email;
    phoneNumberLabel.text = updatedPerson.phoneNumber;
}

@end
