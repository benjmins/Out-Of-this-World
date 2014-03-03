//
//  OWOuterSpaceTableViewController.m
//  Out of this World
//
//  Created by Benjamin on 2/21/2014.
//  Copyright (c) 2014 Benjamin. All rights reserved.
//

#import "OWOuterSpaceTableViewController.h"
#import "AstronomicalData.h"
#import "OWSpaceObject.h"
#import "OWSpaceImageViewController.h"
#import "OWSpaceDataViewController.h"


@interface OWOuterSpaceTableViewController ()

@end

@implementation OWOuterSpaceTableViewController
#define ADDED_SPACE_OBJECTS_KEY @"Added Space Objects Array"

#pragma mark - Lazy Instantiation of Properties

-(NSMutableArray *)planets
{
    if(!_planets){
        _planets = [[NSMutableArray alloc] init];
    }
    return _planets;
}

-(NSMutableArray *)addedSpaceObjects
{
    if(!_addedSpaceObjects){
        _addedSpaceObjects = [[NSMutableArray alloc] init];
    }
    return _addedSpaceObjects;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    
    for (NSMutableDictionary *planetData in [AstronomicalData allKnownPlanets]){
        NSString *imageName = [NSString stringWithFormat:@"%@.jpg", planetData[PLANET_NAME]];
        OWSpaceObject *planet = [[OWSpaceObject alloc] initWithData:planetData andImage:[UIImage imageNamed:imageName]];
        [self.planets addObject:planet];
    }
    
    NSArray *myPlanetsAsPropertyLists = [[NSUserDefaults standardUserDefaults] arrayForKey:ADDED_SPACE_OBJECTS_KEY];
    for(NSDictionary *dictionary in myPlanetsAsPropertyLists){
        OWSpaceObject *spaceObject = [self spaceObjectForDictionary:dictionary];
        [self.addedSpaceObjects addObject:spaceObject];
    }
    

    
//    NSMutableDictionary *myDictionary = [[NSMutableDictionary alloc] init];
//    NSString *firstColor = @"red";
//    [myDictionary setObject:firstColor forKey:@"firetruck color"];
//    [myDictionary setObject:@"blue" forKey:@"ocean color"];
//    [myDictionary setObject:@"yellow" forKey:@"Star color"];
//    
//    NSLog(@"%@", myDictionary);
//    
//    NSString *blueString=[myDictionary objectForKey:@"ocean color"];
//    NSLog(@"%@", blueString);
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([sender isKindOfClass:[UITableViewCell class]])
        //checks to see if sender is indeed a type UITableViewCell (if sender is a kind of class)
    {
        if ([segue.destinationViewController isKindOfClass:[OWSpaceImageViewController class]])
            //make sure we are seguiging to space image view controller and to make sure that its public property space object is set to space object represented by our UITableView Cell, because we need to grab onto our spaceimageviewcontroller, we need to import it at the top. test to make sure that the viewcontroller we're going to is indeed a spaceimageviewcontroller class.
        {
            OWSpaceImageViewController *nextViewController = segue.destinationViewController;
            //allow access to the viewcontroller we're gonna be going to. also allows access to properties to owspaceimageviewcontroller, specifically the space object property and gonna be able to set that property equal to space object that your'e currently displaying in your UItableview cell, we get that information from the sender.
            NSIndexPath *path = [self.tableView indexPathForCell:sender];
            //This is how I know where I am on my tableView. It basically is saying : give me back the index path for index path of my cell (sender). tableview is automatically added in UITableView that's why can we use it. Now we have the index path.
            OWSpaceObject *selectedObject;
            
            if (path.section == 0){
                selectedObject = self.planets[path.row];
            }
            
            else if(path.section == 1){
                selectedObject = self.addedSpaceObjects[path.row];
            }
            
            //We can use that indexPath in order to index into our array of objects. Now we know our selected object.
            nextViewController.spaceObject = selectedObject;
            //we're setting the property of spaceObject for our new viewcontroller, once the new viewcontroller loads up, we're gonna have access to this spaceObject and thus change the way our view looks
        }
    }
    
    if ([sender isKindOfClass:[NSIndexPath class]])
    {
        if([segue.destinationViewController isKindOfClass:[OWSpaceDataViewController class]])
        {
            OWSpaceDataViewController *targetViewController = segue.destinationViewController;
            NSIndexPath *path = sender;
            OWSpaceObject *selectedObject;
            if (path.section == 0){
                selectedObject = self.planets[path.row];
            }
            else if (path.section == 1){
                selectedObject = self.addedSpaceObjects[path.row];
            }

            targetViewController.spaceObject = selectedObject;
        }
    }
    if([segue.destinationViewController isKindOfClass:[OWAddSpaceObjectViewController class]]){
        OWAddSpaceObjectViewController *addSpaceObjectVC = segue.destinationViewController;
        addSpaceObjectVC.delegate = self;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - OWAddSpaceObjectViewController Delegate

-(void)didCancel
{
    NSLog(@"didCancel");
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)addSpaceObject:(OWSpaceObject *)spaceObject
{
    [self.addedSpaceObjects addObject:spaceObject];
    
    // Will Save to NSUserDefaults here
    NSMutableArray *spaceObjectsAsPropertyLists = [[[NSUserDefaults standardUserDefaults] arrayForKey:ADDED_SPACE_OBJECTS_KEY] mutableCopy];
    
    
    //Good example of { } shortform. Evaluates the same way.
    if(!spaceObjectsAsPropertyLists) spaceObjectsAsPropertyLists = [[NSMutableArray alloc] init];
    
    //Add our NSDictionary from our helper method to the array
    [spaceObjectsAsPropertyLists addObject:[self spaceObjectAsAPropertyList:spaceObject]];
    
    //Save our array to NSUserDefaults - set our object as our array, for key use our define,
    [[NSUserDefaults standardUserDefaults] setObject:spaceObject forKey:ADDED_SPACE_OBJECTS_KEY];
    
    
    //To save it to our application
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self.tableView reloadData];
    //tell tableView to check again if it should infact update new information
}

#pragma mark - Helper Methods

-(NSDictionary *)spaceObjectAsAPropertyList:(OWSpaceObject *)spaceObject{
    NSData *imageData = UIImagePNGRepresentation(spaceObject.spaceImage);
    NSDictionary *dictionary = @{PLANET_NAME: spaceObject.name, PLANET_GRAVITY : @(spaceObject.diameter), PLANET_YEAR_LENGTH: @(spaceObject.yearLength), PLANET_DAY_LENGTH : @(spaceObject.dayLength), PLANET_TEMPERATURE : @(spaceObject.temperature), PLANET_NUMBER_OF_MOONS : @(spaceObject.numberOfMoons), PLANET_NICKNAME : spaceObject.nickname, PLANET_INTERESTING_FACT : spaceObject.interestingFact, PLANET_IMAGE : spaceObject.spaceImage};
    
    return dictionary;
                            
}

-(OWSpaceObject *)spaceObjectForDictionary:(NSDictionary *)dictionary
{
    //takes our property list and turns it into a space object
    OWSpaceObject *spaceObject = [[OWSpaceObject alloc] initWithData:dictionary andImage:[UIImage imageNamed:@"EinsteinRing.jpg"]];
    return spaceObject;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    if ([self.addedSpaceObjects count])
    {
        return 2;
    }
    else
    {
    return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    if (section ==1)
    {
        return [self.addedSpaceObjects count];
    }
    else{
    return [self.planets count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    if (indexPath.section == 1){
        OWSpaceObject *planet = [self.addedSpaceObjects objectAtIndex:indexPath.row];
        cell.textLabel.text = planet.name;
        cell.detailTextLabel.text = planet.nickname;
        cell.imageView.image = planet.spaceImage;
    }
    else{
    
        OWSpaceObject *planet = [self.planets objectAtIndex:indexPath.row];
        cell.textLabel.text = planet.name;
        cell.detailTextLabel.text = planet.nickname;
        cell.imageView.image = planet.spaceImage;
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.textColor = [UIColor colorWithWhite:0.5 alpha:1.0];
    
    return cell;
    
}

#pragma mark UITableView Delegate

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"push to space data" sender:indexPath];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
