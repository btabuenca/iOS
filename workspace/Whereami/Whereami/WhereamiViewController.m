//
//  WhereamiViewController.m
//  Whereami
//
//  Created by Bernardo Tabuenca on 23/08/13.
//  Copyright (c) 2013 Bernardo Tabuenca. All rights reserved.
//

#import "WhereamiViewController.h"

@interface WhereamiViewController ()

@end

#import "WhereamiViewController.h"
@implementation WhereamiViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
        // Create location manager object
        locationManager = [[CLLocationManager alloc] init];
        [locationManager setDelegate:self];
        
        // And we want it to be as accurate as possible
        // regardless of how much time/power it takes
        [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        
        // Tell our manager to start looking for its location immediately
        [locationManager startUpdatingLocation];
        
        
    }
    return self;
}

// This method is called when there is a new location updated
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"New location: %@", newLocation);
}

// This method is called whenever locationManager returns an error
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    NSLog(@"Could not find location: %@", error);
}

- (void)dealloc
{
    // Tell the location manager to stop sending us messages
    [locationManager setDelegate:nil];
}





@end
