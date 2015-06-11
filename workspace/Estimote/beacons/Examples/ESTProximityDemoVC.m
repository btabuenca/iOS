//
//  ESTProximityDemoVC.m
//  Examples
//
//  Bernardo Tabuenca
//

#import "ESTProximityDemoVC.h"

@interface ESTProximityDemoVC () <ESTBeaconManagerDelegate>

@property (nonatomic, strong) CLBeacon *beacon;
@property (nonatomic, strong) ESTBeaconManager *beaconManager;
@property (nonatomic, strong) CLBeaconRegion *beaconRegion;

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *zoneLabel;


@end

@implementation ESTProximityDemoVC

- (id)initWithBeacon:(CLBeacon *)beacon
{
    self = [super init];
    if (self)
    {
        self.beacon = beacon;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Proximity Demo";
    
    /*
     * UI setup.
     */
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    // Label 1
    self.zoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                               100,
                                                               self.view.frame.size.width,
                                                               40)];
    self.zoneLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.zoneLabel];
    
    // Image
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,
                                                                   64,
                                                                   self.view.frame.size.width,
                                                                   self.view.frame.size.height - 64)];
    self.imageView.contentMode = UIViewContentModeCenter;
    [self.view addSubview:self.imageView];
    
    
    
    
    /*
     * BeaconManager setup.
     */
    self.beaconManager = [[ESTBeaconManager alloc] init];
    self.beaconManager.delegate = self;
    
    self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:self.beacon.proximityUUID
                                                                 major:[self.beacon.major unsignedIntValue]
                                                                 minor:[self.beacon.minor unsignedIntValue]
                                                            identifier:@"RegionIdentifier"];
    
    [self.beaconManager startRangingBeaconsInRegion:self.beaconRegion];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [self.beaconManager stopRangingBeaconsInRegion:self.beaconRegion];

    [super viewDidDisappear:animated];
}

#pragma mark - ESTBeaconManager delegate

- (void)beaconManager:(id)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
    if (beacons.count > 0)
    {
        CLBeacon *firstBeacon = [beacons firstObject];
        
        self.zoneLabel.text     = [self textForProximity:firstBeacon.proximity];
        self.imageView.image    = [self imageForProximity:firstBeacon.proximity];
        
        NSLog(@"The code runs through here!");

        
        NSString *urlString = [NSString stringWithFormat:@"https://learn-beacon.appspot.com/_ah/api/layerendpoint/v1/layer"];
        
        NSURL *url = [NSURL URLWithString:urlString];
        
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        NSError *error;
        
        NSMutableArray *json = (NSMutableArray*)[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        
        NSLog(@"%@", json);
        

        
        NSError *e = nil;
        NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &e];
        
        if (!jsonArray) {
            NSLog(@"Error parsing JSON: %@", e);
        } else {
            
//            NSDictionary *firstObjectDict = [jsonArray objectAtIndex:0];
//            
//            NSString *kind = firstObjectDict[@"items"][@"kind"];
//            NSLog(@"latin kind: %@", kind);
//            NSString *etag = firstObjectDict[@"items"][@"etag"];
//            NSLog(@"etag como una cabra: %@", etag);
//
//
//            
//            
//            NSString *myValue = [firstObjectDict valueForKey:@"etag"];
//            NSLog(@"eeeeeeeeeeeeee: %@", myValue);
            
            
            
            
            for(NSDictionary *item in jsonArray) {
                NSLog(@"Item: %@", item);

                PONTE A DEPURAR AQUI
                
                
               
                
//                NSString* text= item[@"items"];
//                NSLog(@"KEyyyyyyyyyyyyyyyyyyyyyyY Item: %@", text);
                
                
            }
        }
        
        
        
        //NSLog(@"%@", [json objectAtIndex:0]);
        
        
        
        
//        NSString *imageString = [NSString stringWithFormat:@"%@", [json objectAtIndex:3]];
//        
//        NSURL *urlOne = [NSURL URLWithString:imageString];
//        
//        NSData *newData = [NSData dataWithContentsOfURL:urlOne];
//        
//        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
//        
//        [imageView setImage:[UIImage imageWithData:newData]];
//        
//        [self.view addSubview:imageView];
//        
//        
        
        
        
    }
}

#pragma mark - 

- (NSString *)textForProximity:(CLProximity)proximity
{
    switch (proximity) {
        case CLProximityFar:
            return @"Far";
            break;
        case CLProximityNear:
            return @"Near";
            break;
        case CLProximityImmediate:
            return @"Immediate";
            break;
            
        default:
            return @"Unknown";
            break;
    }
}

- (UIImage *)imageForProximity:(CLProximity)proximity
{
    switch (proximity) {
        case CLProximityFar:
            return [UIImage imageNamed:@"far_image"];
            break;
        case CLProximityNear:
            return [UIImage imageNamed:@"near_image"];
            break;
        case CLProximityImmediate:
            return [UIImage imageNamed:@"immediate_image"];
            break;
            
        default:
            return [UIImage imageNamed:@"unknown_image"];
            break;
    }
}





@end
