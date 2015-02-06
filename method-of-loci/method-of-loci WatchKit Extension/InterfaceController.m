//
//  InterfaceController.m
//  method-of-loci WatchKit Extension
//
//  Created by Brian Ledbetter on 2/5/15.
//  Copyright (c) 2015 Brian Ledbetter. All rights reserved.
//

#import "InterfaceController.h"
#import "RegionTableRowController.h"
#import <CoreLocation/CoreLocation.h>
#import "MiniMapInterfaceController.h"


@interface InterfaceController()
@property (weak, nonatomic) IBOutlet WKInterfaceTable *table;
@property (strong, nonatomic) NSArray* regionsArray;

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    CLLocationManager *locationManager = [CLLocationManager new];
    NSSet *regions = locationManager.monitoredRegions;
    self.regionsArray = regions.allObjects;

    // display table of regions
    [self.table setNumberOfRows:regions.count withRowType:@"REGION_ROW"];
    NSInteger index = 0;
    for (CLRegion *region in _regionsArray) {
        RegionTableRowController *rowController = [self.table rowControllerAtIndex:index];
        [rowController.regionNameLabel setText:region.identifier];
        index++;
    }
}

-(id)contextForSegueWithIdentifier:(NSString *)segueIdentifier inTable:(WKInterfaceTable *)table rowIndex:(NSInteger)rowIndex{
    
    return (CLCircularRegion*) self.regionsArray[rowIndex];
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end



