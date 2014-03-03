//
//  OWAddSpaceObjectViewController.m
//  Out of this World
//
//  Created by Benjamin on 2014-02-28.
//  Copyright (c) 2014 Benjamin. All rights reserved.
//

#import "OWAddSpaceObjectViewController.h"

@interface OWAddSpaceObjectViewController ()

@end

@implementation OWAddSpaceObjectViewController

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
    UIImage *orionImage = [UIImage imageNamed:@"Orion.jpg"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:orionImage];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelButtonPressed:(id)sender
{
    [self.delegate didCancel];
}

- (IBAction)addButtonPressed:(id)sender
{
    OWSpaceObject *newSpaceObject = [self returnNewSpaceObject];
    [self.delegate addSpaceObject:newSpaceObject];
}

-(OWSpaceObject *)returnNewSpaceObject
{
    OWSpaceObject *addedSpaceObject = [[OWSpaceObject alloc] init];
    addedSpaceObject.name = self.nameTextField.text;
    addedSpaceObject.nickname = self.nicknameTextField.text;
    addedSpaceObject.diameter = [self.diameterTextField.text floatValue];
    addedSpaceObject.temperature = [self.temperatureTextField.text floatValue];
    addedSpaceObject.numberOfMoons = [self.numberOfMoonsTextField.text intValue];
    addedSpaceObject.interestingFact = self.interestingFactsTextField.text;
    addedSpaceObject.spaceImage = [UIImage imageNamed:@"EinsteinRing.jpg"];
    
    return addedSpaceObject;
}

@end
