//
//  WhereamiViewController.h
//  Whereami
//
//  Created by Bernardo Tabuenca on 23/08/13.
//  Copyright (c) 2013 Bernardo Tabuenca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>


@interface WhereamiViewController : UIViewController <CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;

    IBOutlet MKMapView *worldView;
    IBOutlet UIActivityIndicatorView *activityIndicator;
    IBOutlet UITextField *locationTitleField;

}
@end