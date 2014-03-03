//
//  OWSpaceDataViewController.h
//  Out of this World
//
//  Created by Benjamin on 2/26/2014.
//  Copyright (c) 2014 Benjamin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OWSpaceObject.h"

@interface OWSpaceDataViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) OWSpaceObject *spaceObject;

@end
