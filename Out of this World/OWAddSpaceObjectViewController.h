//
//  OWAddSpaceObjectViewController.h
//  Out of this World
//
//  Created by Benjamin on 2014-02-28.
//  Copyright (c) 2014 Benjamin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OWSpaceObject.h"

@protocol OWAddSpaceObjectViewControllerDelegate <NSObject>

@required

-(void)addSpaceObject:(OWSpaceObject *)spaceObject;
-(void)didCancel;

@end

@interface OWAddSpaceObjectViewController : UIViewController

@property (weak, nonatomic) id <OWAddSpaceObjectViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *nicknameTextField;
@property (strong, nonatomic) IBOutlet UITextField *diameterTextField;
@property (strong, nonatomic) IBOutlet UITextField *temperatureTextField;
@property (strong, nonatomic) IBOutlet UITextField *numberOfMoonsTextField;
@property (strong, nonatomic) IBOutlet UITextField *interestingFactsTextField;

- (IBAction)cancelButtonPressed:(id)sender;
- (IBAction)addButtonPressed:(id)sender;

@end
