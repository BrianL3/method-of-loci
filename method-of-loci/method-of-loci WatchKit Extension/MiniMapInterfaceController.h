//
//  MiniMapInterfaceController.h
//  method-of-loci
//
//  Created by Brian Ledbetter on 2/5/15.
//  Copyright (c) 2015 Brian Ledbetter. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "InterfaceController.h"
#import <MapKit/MapKit.h>

@interface MiniMapInterfaceController : WKInterfaceController
@property (strong, nonatomic) CLCircularRegion* circularRegion;
@end