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

        NSLog(@"The code runs through here 0!");
        
        
        NSString *uuid = [firstBeacon.proximityUUID UUIDString];
        NSNumber *major = firstBeacon.major;
        NSNumber *minor = firstBeacon.minor;
//        NSInteger *rssi = firstBeacon.rssi;
//        
//        
//        NSLog(@"Proximity UUID @", uuid);
//        NSLog(@" major @", major);
//        NSLog(@" minor @", minor);
//        NSLog(@" rssi @", rssi);


        NSString *urlRoot = @"https://learn-beacon.appspot.com/_ah/api/layerendpoint/v1/layer/beacon";
        NSString *urlString = [NSString stringWithFormat:@"%@/%@", urlRoot, uuid];

        NSLog(@"The code runs through here 1!");
        

    
        
        NSURL *url = [NSURL URLWithString:urlString];
        NSData *data = [NSData dataWithContentsOfURL:url];
        NSError *error;

        // This is just for printing
        NSMutableArray *json = (NSMutableArray*)[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        NSLog(@"%@", json);
        NSLog(@"The code runs through here 2!");
        
        
        
        NSError *errDict;
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&errDict];
        NSArray *fetchedArr = [jsonDict objectForKey:@"items"];
        NSLog(@"The code runs through here 3!");
        
        
                    for(NSDictionary *item in fetchedArr) {
                        
//                        "beacon_id" = "B9407F30-F5F8-466E-AFF9-25556B57FE6D";
//                        content =             {
//                            value = "Interact layer content";
//                        };
//                        distance = 5;
//                        id = 5695159920492544;
//                        kind = "layerendpoint#resourcesItem";
//                        "layer_cc" = "CC_BY";
//                        level = 0;
//                        signal = 0;
//                        tag = btb;
//                        "timestamp_update" = 1421433780000;
//                        "timestamp_validity_end" = 1516128180000;
//                        "timestamp_validity_start" = 1421433780000;

                        NSString *strBeaconId = [item objectForKey:@"beacon_id"];
                        NSString *strContent = [item objectForKey:@"content"];
                        NSString *strDistance = [item objectForKey:@"distance"];
                        NSString *strId = [item objectForKey:@"id"];
                        NSString *strLayerCC = [item objectForKey:@"layer_cc"];
                        NSString *strLevel = [item objectForKey:@"level"];
                        NSString *strSignal = [item objectForKey:@"signal"];
                        NSString *strTag = [item objectForKey:@"tag"];
                        NSString *strTimestampUpdate = [item objectForKey:@"timestamp_update"];
                        NSString *strTimestampEnd = [item objectForKey:@"timestamp_validity_end"];
                        NSString *strTimestampStart = [item objectForKey:@"timestamp_validity_start"];

                        
                        NSLog(@"strBeaconId: %@", strBeaconId);
                        NSLog(@"strContent: %@", strContent);
                        NSLog(@"strDistance: %@", strDistance);
                        NSLog(@"strId: %@", strId);
                        NSLog(@"strLayerCC: %@", strLayerCC);
                        NSLog(@"strLevel: %@", strLevel);
                        NSLog(@"strSignal: %@", strSignal);
                        NSLog(@"strTag: %@", strTag);
                        NSLog(@"strTimestampUpdate: %@", strTimestampUpdate);
                        NSLog(@"strTimestampEnd: %@", strTimestampEnd);
                        NSLog(@"strTimestampStart: %@", strTimestampStart);

                        
                        
                    }
        
        
//
//        // Let s read the details
//        NSError *e = nil;
//        NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &e];
//               if (!jsonArray) {
//                    NSLog(@"Error parsing JSON: %@", e);
//                } else {
//                    NSLog(@"Geen Error parsing JSON: %@");
//                    
//                }
//        NSLog(@"The code runs through here 4!");
        
        
        
//        if (!jsonArray) {
//            NSLog(@"Error parsing JSON: %@", e);
//        } else {
//            
//            
//            
//            if([[jsonArray objectAtIndex:0] isKindOfClass:[NSArray class]]){
//                //Is array
//                NSLog(@"This looks like an array");
//                NSArray *nsarrItems = [jsonArray objectAtIndex:0];
//                
//                
//                
//                for(NSDictionary *item in nsarrItems) {
//                    NSLog(@"Item x: %@", item);
//                    
//                }
//                
//                
//                
//            }else if([[jsonArray objectAtIndex:0] isKindOfClass:[NSDictionary class]]){
//                //is dictionary
//                NSLog(@"This looks like an dictionary");
////                NSArray *nsarrItems = [jsonArray objectAtIndex:0];
//                
//                
//                NSDictionary *nsdictItems = [jsonArray objectAtIndex:0];
//                NSString *strKey = @"layer_cc";
//                NSLog(@"Getting licence: %@", [nsdictItems valueForKey:strKey]);
//                NSLog(@"Let us iterate... ");
//                for( NSString *aKey in [nsdictItems allKeys] )
//                {
//                    // do something like a log:
//                    //NSLog(@"Key: %@", aKey);
//                    if ([aKey isEqualToString:strKey]) {
//                        NSLog(@"Licencia encontrada!");
//                    }
//                }
//                
//            }else{
//                //is something else
//            }
//            
//       
////            NSDictionary *nsdictItems = [jsonArray objectAtIndex:0];
////            NSDictionary *nsdictKind = [jsonArray objectAtIndex:1];
////            NSDictionary *nsdictEtag = [jsonArray objectAtIndex:2];
//
//            NSLog(@"The code runs through here!");
//            
//
//            
//            for(NSDictionary *item in jsonArray) {
//                NSLog(@"Item: %@", item);
//               
//                NSLog(@"The codes breakes somewhere herer.");
//                
//                
//            }
//        }
        
        
        
        //NSLog(@"%@", [json objectAtIndex:0]);
        
        
        
        
        NSString *imageString = [NSString stringWithFormat:@"%@", uuid];
        
        NSURL *urlOne = [NSURL URLWithString:imageString];
        
        NSData *newData = [NSData dataWithContentsOfURL:urlOne];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
        
        [imageView setImage:[UIImage imageWithData:newData]];
        
        [self.view addSubview:imageView];
        
        
        
        
        
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
