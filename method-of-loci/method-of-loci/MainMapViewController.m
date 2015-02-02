//
//  MainMapViewController.m
//  method-of-loci
//
//  Created by Brian Ledbetter on 2/2/15.
//  Copyright (c) 2015 Brian Ledbetter. All rights reserved.
//

#import "MainMapViewController.h"
#import <MapKit/MapKit.h>
#import <UIKit/UIKit.h>

#define METERS_PER_MILE 1609.344


@interface MainMapViewController () <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;



@end

@implementation MainMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // set the mapView's delegate
    _mapView.delegate = self;
    // disable that rotate bullshit
    _mapView.rotateEnabled = false;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)hereButton:(UIBarButtonItem *)sender {
    // get user location
    MKUserLocation *userLocation = _mapView.userLocation;
    // create region centered on user
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance (userLocation.location.coordinate, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    // zoom in on that location
    [_mapView setRegion:region animated:true];

}

- (IBAction)workButton:(UIBarButtonItem *)sender {
    CLLocationCoordinate2D workCoordinate = CLLocationCoordinate2DMake(47.623402, -122.336013);
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance (workCoordinate, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);

    [_mapView setRegion:region animated:true];

    
}

- (IBAction)homeButton:(UIBarButtonItem *)sender {
    CLLocationCoordinate2D workCoordinate = CLLocationCoordinate2DMake(47.611299, -122.322770);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance (workCoordinate, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    [_mapView setRegion:region animated:true];
}


@end
