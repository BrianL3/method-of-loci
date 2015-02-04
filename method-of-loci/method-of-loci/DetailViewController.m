//
//  DetailViewController.m
//  method-of-loci
//
//  Created by Brian Ledbetter on 2/3/15.
//  Copyright (c) 2015 Brian Ledbetter. All rights reserved.
//

#import "DetailViewController.h"
#import <MapKit/MapKit.h>

@interface DetailViewController ()
//outlet properties
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
// action properties
- (IBAction)addReminder:(id)sender;
//other properties

@end

@implementation DetailViewController
//MARK: ViewController LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0.517647 green:0.72156 blue:1.0 alpha:1.0];
    NSString* latString = [NSString stringWithFormat:@"%f", self.annotation.coordinate.latitude];
    NSString* longString = [NSString stringWithFormat:@"%f", self.annotation.coordinate.longitude];
    self.locationLabel.text = [NSString stringWithFormat:@"Your location is %@ by %@", latString, longString];
    //self.coordinateLabel.text = self.annotation.coordinate.latitude;
}

//MARK: Add Reminder Button
- (IBAction)addReminder:(id)sender {
    if ([CLLocationManager isMonitoringAvailableForClass:[CLCircularRegion class]]){
        CLCircularRegion* region = [[CLCircularRegion alloc] initWithCenter:self.annotation.coordinate radius:100 identifier:@"reminderRegion"];
        // begin monitoring for region
        [self.manager startMonitoringForRegion:region];
        //prepare to broadcast notification that a reminder region has been created
        NSDictionary* regionInfo = @{@"region" : region};
        //broadcast the region
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ReminderRegionAdded" object:self userInfo:regionInfo];
    }
}
@end






























