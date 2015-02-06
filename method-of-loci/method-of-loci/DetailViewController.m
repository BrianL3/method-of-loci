//
//  DetailViewController.m
//  method-of-loci
//
//  Created by Brian Ledbetter on 2/3/15.
//  Copyright (c) 2015 Brian Ledbetter. All rights reserved.
//

#import "DetailViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface DetailViewController () <UITextFieldDelegate>
//outlet properties
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;

//ensuring that all regions have names
@property (weak, nonatomic) NSString* regionName;


// action properties
- (IBAction)addReminder:(id)sender;
//other properties

@end

@implementation DetailViewController
//MARK: ViewController LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.doneButton.enabled = false;
    //set self as text delegate
    self.nameTextField.delegate = self;
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
        CLCircularRegion* region = [[CLCircularRegion alloc] initWithCenter:self.annotation.coordinate radius:100 identifier:self.nameTextField.text];
        // begin monitoring for region
        [self.manager startMonitoringForRegion:region];
        //prepare to broadcast notification that a reminder region has been created
        NSDictionary* regionInfo = @{@"region" : region};
        //broadcast the region
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ReminderRegionAdded" object:self userInfo:regionInfo];
    }
    [self.navigationController popToRootViewControllerAnimated: true];
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString* oldText = self.nameTextField.text;
    NSString* newText = [oldText stringByReplacingCharactersInRange:range withString:string];
    self.doneButton.enabled = (newText.length > 0 );

    return true;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.nameTextField resignFirstResponder];
    
    return true;
}



@end






























