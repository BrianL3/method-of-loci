//
//  MainMapViewController.m
//  method-of-loci
//
//  Created by Brian Ledbetter on 2/2/15.
//  Copyright (c) 2015 Brian Ledbetter. All rights reserved.
//

#import "MainMapViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

#define METERS_PER_MILE 1609.344


@interface MainMapViewController () <MKMapViewDelegate, CLLocationManagerDelegate>
    @property (weak, nonatomic) IBOutlet MKMapView *mapView;
    @property (strong, nonatomic) CLLocationManager *locationManager;



@end

@implementation MainMapViewController
//MARK: ViewController LifeCycle ========================================================
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // initialize the location manager
    self.locationManager = [[CLLocationManager alloc] init];
    // initiatize the gesture recognizer
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(didLongPress:)];
    [self.mapView addGestureRecognizer: longPress];
    
    // set the delegates
    self.locationManager.delegate = self;
    self.mapView.delegate = self;

    
    // disable that rotate bullshit
    self.mapView.rotateEnabled = false;
    
    // check if Location Services is enabled before proceeding
    if ([CLLocationManager locationServicesEnabled]) {
        
        //NSString* returnString = [_myStack lastObject];
        NSInteger authorizationNumber = [CLLocationManager authorizationStatus];
        // begin switch through location manager's auth statuses
        //NSLog(@"The Auth Number is : %ld", (long)authorizationNumber);
        switch (authorizationNumber) {
            case 0:
                // Status 0 is Not Determined
                [self.locationManager requestAlwaysAuthorization];
                NSLog(@"Hit Status 0 in Authorization switch");
                break;
            case 1:
                // Status 1 is Restricted
                NSLog(@"Hit Status 1 in Authorization switch");
                break;
            case 2:
                // Status 2 is Denied
                break;
            case 3:
                // Status 3 is Authorized
                self.mapView.showsUserLocation = true;
                [self.locationManager startUpdatingLocation];
                break;
            case 4:
                // Status 4 is Always Authorized
                self.mapView.showsUserLocation = true;
                // for very fine, data heavy, specific location data
                [self.locationManager startUpdatingLocation];
                // for less fine (based off wifi) location data [but less battery heavy]
                //[self.locationManager startMonitoringSignificantLocationChanges];
                // for monitoring region changes
                //[self.locationManager startMonitoringForRegion:<#(CLRegion *)#>]
                break;
            default:
                NSLog(@"Hit default case in AuthNumber switch");
                break;
        }
    } else {
        // pop an alert warning user that location services are not enabled
    }
    
}

//MARK:LocationManager  ==================================================================

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    // add an alert to notify users that location services are unavailable
    NSLog(@"Location services are failing.");
}

//-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
//    CLLocation *location = locations.firstObject;
//    NSLog(@"latitide: %f and longitude: %f",location.coordinate.latitude, location.coordinate.longitude);
//
//}

//MARK: Gesture  ======================================================================================
-(void) didLongPress:(id)sender{
    UILongPressGestureRecognizer *press = (UILongPressGestureRecognizer *) sender;
    //reminder: press.state 1 is press started ||| press.state 3 is press ended
    if (press.state == 3) {
        // find the point on screen that the press was
        CGPoint location = [press locationInView:self.view];
        // convert that point into a map coordinate
        CLLocationCoordinate2D mapCoordinates = [self.mapView convertPoint:location toCoordinateFromView:self.mapView];
        // initialize an annotation
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        // give that annotation the map coordinates
        annotation.coordinate = mapCoordinates;
        annotation.title = @"Reminder Location";

        // add the annotation to the map
        [self.mapView addAnnotation:annotation];
    }
}

//MARK: Custom Annotation  ================================================================================
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    // initialize the view
    if ([annotation isEqual:[mapView userLocation]]){
        return nil;
    }
    MKPinAnnotationView *customAnnotation = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"AnnotationView"];
    //customize the view
    customAnnotation.animatesDrop = true;
    customAnnotation.pinColor = MKPinAnnotationColorGreen;
    customAnnotation.canShowCallout = true;
    customAnnotation.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeContactAdd];
    
    return customAnnotation;
}

// when you press the annotation accessory
-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    [self performSegueWithIdentifier:@"SHOW_DETAIL" sender:self];
    
}


//MARK: Buttons ======================================================================================
- (IBAction)hereButton:(UIBarButtonItem *)sender {
    // get user location
    MKUserLocation *userLocation = self.mapView.userLocation;
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
