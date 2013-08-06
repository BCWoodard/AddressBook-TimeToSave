//
//  ViewController.m
//  AddressBook
//
//  Created by Brad Woodard on 7/22/13.
//  Copyright (c) 2013 Brad Woodard. All rights reserved.
//

#import "ViewController.h"
#import "ShowViewController.h"
#import "EditViewController.h"
#import "Person.h"

@interface ViewController ()
{
    NSMutableArray          *people;
    Person                  *person1, *person2, *person3;
    int                     path;
    BOOL                    editRecord;
    
    __weak IBOutlet UITableView *myTableView;
}
- (IBAction)addPerson:(id)sender;

@end

@implementation ViewController


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        //  1.  If the NSUserDefaults boolean "addresses_exist" is not set,
        //  2.  Alloc and init 3 person objects
        //  3.  Assign values to the properties
        //  4.  Convert them to dictionaries
        //  5.  Add to mutable array "people"
        
        if (![[NSUserDefaults standardUserDefaults] boolForKey:@"addresses_exist"]) { // 1
            
            person1 = [[Person alloc] init];    // 2
            person1.firstName = @"Stephan";     // 3
            person1.lastName = @"Duggan";
            person1.email = @"s.duggan@gmail.me";
            person1.phoneNumber = @"900-Call-Me";
            [person1 makeDictionary];           // 4
            
            person2 = [[Person alloc] init];
            person2.firstName = @"Maria";
            person2.lastName = @"Escano";
            person2.email = @"mescano@gmail.me";
            person2.phoneNumber = @"900-Call-ME";
            [person2 makeDictionary];
            
            person3 = [[Person alloc] init];
            person3.firstName = @"Kin";
            person3.lastName = @"Bariso";
            person3.email = @"kbariso@gmail.me";
            person3.phoneNumber = @"900-Call-KB";
            [person3 makeDictionary];
            
            people = [[NSMutableArray alloc] initWithObjects:person1, person2, person3, nil];   // 5
        }
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    //  1.  If the boolean "addresses_exist" is YES,
    //  2.  Alloc and init the mutable array "people" with the objects stored
    //      in NSUserDefaults
    //
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"addresses_exist"]) {    // 1
        people = [[NSMutableArray alloc] initWithObjects:[NSUserDefaults standardUserDefaults], nil];   // 2
        
    }
}


- (void)viewDidAppear:(BOOL)animated
{
    [myTableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDataSource
- (int)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    
    //  "people" is now an array of dictionaries so we need to populate the table
    //  fields by identifying the dictionary object we want to display and then
    //  selecting the appropriate "valueForKey" from the dictionary
    // 
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", [[people objectAtIndex:indexPath.row] valueForKey:@"firstName"], [[people objectAtIndex:indexPath.row] valueForKey:@"lastName"]];
    cell.detailTextLabel.text = [[people objectAtIndex:indexPath.row] valueForKey:@"email"];
    return cell;
}

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [people count];
}



#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    path = indexPath.row;
    [self performSegueWithIdentifier:@"toShowView" sender:self];
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES to make the row editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        //  1.  Remove the object from the people array
        //  2.  reload the tableView
        
        [people removeObjectAtIndex:indexPath.row]; // 1
        [myTableView reloadData];   // 2
    }
}


#pragma mark - PrepareForSegue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"toEditView"]) {
        //  1.  Set our editRecord boolean to YES since we're navigating to editVC
        //  2.  Assign editVC the value of our segue.destinationViewController
        //  3.  Make VC editVC's delegate
        
        editRecord = YES;   // 1
        EditViewController *editViewController = segue.destinationViewController;   // 2
        editViewController.delegate = self; // 3
        
    } else {
        
        editRecord = NO;
        ShowViewController *showViewController = segue.destinationViewController;
        showViewController.delegate = self;
        
        for (int i = 0; i < [people count]; i++) {
            showViewController.incomingPerson = [people objectAtIndex:path];

        }
    }
}

- (void)updateLabels
{
    return;
}

- (IBAction)addPerson:(id)sender
{
    
    [self performSegueWithIdentifier:@"toEditView" sender:self];
    
}


#pragma mark - DELEGATE
- (void)editRecord:(Person *)updatedPerson
{
    //  1.  Set the boolean value "addresses_exist" for NSUserDefaults
    //  2.  Add the person object (as a dictionary) to NSUserDefaults
    //  3.  Synchronize NSUserDefaults
    // 
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"addresses_exist"];  // 1
    [[NSUserDefaults standardUserDefaults] setValuesForKeysWithDictionary:[updatedPerson makeDictionary]];  // 2
    [[NSUserDefaults standardUserDefaults] synchronize];    // 3
    
    // if statement here to identify which view controller is passing data to VC    
    if (!editRecord) {
        //  1.  Replace the dictionary object in "people" with the new dictionary object
        //      via [updatedPerson makeDictionary] (in our Person class)
        //  2.  Reload the table
        //
        [people replaceObjectAtIndex:path withObject:[updatedPerson makeDictionary]];   // 1
        [myTableView reloadData];   // 2
        
    } else {
        
        //  1.  Add the dictionary object to "people" with the new dictionary object
        //      via [updatedPerson makeDictionary] (in our Person class)
        //  2.  Reload the data
        [people addObject:[updatedPerson makeDictionary]];  // 1
        [myTableView reloadData];   // 2
        
    }
}


@end
