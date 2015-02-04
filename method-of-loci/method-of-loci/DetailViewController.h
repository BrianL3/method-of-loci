//
//  DetailViewController.h
//  method-of-loci
//
//  Created by Brian Ledbetter on 2/3/15.
//  Copyright (c) 2015 Brian Ledbetter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) MKPointAnnotation * annotation;
@property (strong, nonatomic) CLLocationManager * manager;


@end
