//
//  OWOuterSpaceTableViewController.h
//  Out of this World
//
//  Created by Benjamin on 2/21/2014.
//  Copyright (c) 2014 Benjamin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OWAddSpaceObjectViewController.h"

@interface OWOuterSpaceTableViewController : UITableViewController <OWAddSpaceObjectViewControllerDelegate>

@property (strong, nonatomic) NSMutableArray *planets;
@property (strong, nonatomic) NSMutableArray *addedSpaceObjects;

@end
