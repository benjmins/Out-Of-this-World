//
//  OWSpaceImageViewController.h
//  Out of this World
//
//  Created by Benjamin on 2/24/2014.
//  Copyright (c) 2014 Benjamin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OWSpaceObject.h"

@interface OWSpaceImageViewController : UIViewController <UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) OWSpaceObject *spaceObject;



@end
