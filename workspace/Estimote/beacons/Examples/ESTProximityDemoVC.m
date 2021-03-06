//
//  ESTProximityDemoVC.m
//  Examples
//
//  Bernardo Tabuenca
//

#import "ESTProximityDemoVC.h"
#import "DataClass.h"


@interface ESTProximityDemoVC () <ESTBeaconManagerDelegate>

@property (nonatomic, strong) CLBeacon *beacon;
@property (nonatomic, strong) ESTBeaconManager *beaconManager;
@property (nonatomic, strong) CLBeaconRegion *beaconRegion;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *zoneLabel;
@property (nonatomic, strong) UILabel *zoneTitle;


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
    
    
    /*
     * UI setup.
     */
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Title here...Mudejar";

    // Initialize sroll view
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    CGFloat scrollViewHeight = 0.0f;
    
    
    // Title
    self.zoneTitle = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                               10,
                                                               self.view.frame.size.width,
                                                               20)];
    self.zoneTitle.textAlignment = NSTextAlignmentCenter;
    self.zoneTitle.lineBreakMode = NSLineBreakByWordWrapping;
    UIColor * color = [UIColor colorWithRed:255/255.0f
                                      green:204/255.0f
                                       blue:0/255.0f
                                      alpha:1.0f];
    self.zoneTitle.textColor = color;
    self.zoneTitle.numberOfLines = 0;
    scrollViewHeight += self.zoneTitle.frame.size.height;
    [self.scrollView addSubview:self.zoneTitle];
    
    
    // Label
    self.zoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,
                                                               scrollViewHeight,
                                                               self.view.frame.size.width,
                                                               400)];
    self.zoneLabel.textAlignment = NSTextAlignmentJustified;
    //[self.view addSubview:self.zoneLabel];
    self.zoneLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.zoneLabel.numberOfLines = 0;
    scrollViewHeight += self.zoneLabel.frame.size.height;
    [self.scrollView addSubview:self.zoneLabel];
    
    


    
    
    // Image
    //    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,
    //                                                                   64,
    //                                                                   self.view.frame.size.width,
    //                                                                   self.view.frame.size.height - 64)];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,
                                                                   scrollViewHeight,
                                                                   self.view.frame.size.width,
                                                                   550)];
    
    self.imageView.contentMode = UIViewContentModeCenter;
    //[self.view addSubview:self.imageView];
    scrollViewHeight += self.imageView.frame.size.height;
    [self.scrollView addSubview:self.imageView];
    
    
    

    [self.scrollView setContentSize:(CGSizeMake(320, scrollViewHeight))];
    
//    self.scrollView.contentSize = self.zoneLabel.frame.size;

    
    

    
    [self.view addSubview:self.scrollView];
    
    
    
    
    
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

        // Line commented by btb
        //self.zoneLabel.text     = [self textForProximity:firstBeacon.proximity];
        self.imageView.image    = [self imageForProximity:firstBeacon.proximity];
        
        NSLog(@"The code runs through here 0!");
        NSLog(@"Proximity text: %@", [self textForProximity:firstBeacon.proximity]);
        NSLog(@"Proximity valu: %ld", (long)firstBeacon.proximity);
        
        
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
        
        
        NSURL *url = [NSURL URLWithString:urlString];
        NSData *data = [NSData dataWithContentsOfURL:url];
        NSError *error;
        
        // This is just for printing
        NSMutableArray *json = (NSMutableArray*)[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        // This line shows the json NSLog(@"%@", json);
        
        
        
        NSError *errDict;
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&errDict];
        
        
        // aqui vas a insertar la variable global
        DataClass *obj=[DataClass getInstance];
        obj.strBeaconID= @"I am Global variable";
        
        NSLog(@"Antes: %@", obj.strBeaconID);
        obj.strBeaconID= @"This is the new value.";
        NSLog(@"Despues: %@", obj.strBeaconID);
        
        
        //arr = [jsonDict objectForKey:@"items"];
        
        
        //NSArray *fetchedArr = [jsonDict objectForKey:@"items"];
        obj.arrLayers = [[NSMutableArray alloc] init];
        obj.arrLayers = [jsonDict objectForKey:@"items"];
        
        NSLog(@"The code runs through here A!");
        
        //NSString *strLev = @"1";
        //[obj printLayers:strLev];
        //[obj printLayers];
        
        
        self.zoneTitle.text = @"Las carlitas";
        self.zoneLabel.text = [self descForProximity:firstBeacon.proximity];
        
        TENDRAS QUE ASIGNAR EL ALTO DE ESTAS COSAS DINAMICAMENTE YA QUE SINO TE COGE LA DE LA PRIMERA VEZ
        
        LO SIGUIENTE ES HACER AQUI UN SWYPE PARA CADA LAYER QUE ENCUENTRE
        


        
        
        //[DataClass printLayers];
        NSLog(@"The code runs through here B!");
        
        
        
        
        
        
//        for(NSDictionary *item in fetchedArr) {
//            
//            
//            
//            NSString *strBeaconId = [item objectForKey:@"beacon_id"];
//            NSString *strContent = [item objectForKey:@"content"];
//            NSString *strDistance = [item objectForKey:@"distance"];
//            NSString *strId = [item objectForKey:@"id"];
//            NSString *strLayerCC = [item objectForKey:@"layer_cc"];
//            NSString *strLevel = [item objectForKey:@"level"];
//            NSString *strSignal = [item objectForKey:@"signal"];
//            NSString *strTag = [item objectForKey:@"tag"];
//            NSString *strTimestampUpdate = [item objectForKey:@"timestamp_update"];
//            NSString *strTimestampEnd = [item objectForKey:@"timestamp_validity_end"];
//            NSString *strTimestampStart = [item objectForKey:@"timestamp_validity_start"];
//            
//            
//            NSLog(@"strBeaconId: %@", strBeaconId);
//            NSLog(@"strContent: %@", strContent);
//            NSLog(@"strDistance: %@", strDistance);
//            NSLog(@"strId: %@", strId);
//            NSLog(@"strLayerCC: %@", strLayerCC);
//            NSLog(@"strLevel: %@", strLevel);
//            NSLog(@"strSignal: %@", strSignal);
//            NSLog(@"strTag: %@", strTag);
//            NSLog(@"strTimestampUpdate: %@", strTimestampUpdate);
//            NSLog(@"strTimestampEnd: %@", strTimestampEnd);
//            NSLog(@"strTimestampStart: %@", strTimestampStart);
//            
//            
//            
//        }
        
        
        
        
        
        NSString *imageString = [NSString stringWithFormat:@"%@", uuid];
        
        NSURL *urlOne = [NSURL URLWithString:imageString];
        
        NSData *newData = [NSData dataWithContentsOfURL:urlOne];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
        
        [imageView setImage:[UIImage imageWithData:newData]];
        
        [self.view addSubview:imageView];
        
        
        
        
        
    }
}

#pragma mark -


- (NSString *)descForProximity:(CLProximity)proximity
{
    
//    NSString *strLev = [NSString stringWithFormat:@"%ld", (long)firstBeacon.proximity];
//    NSDictionary *item = [obj getLayer:strLev];

    NSString *strLev = [NSString stringWithFormat:@"%ld", (long)proximity];
    DataClass *obj=[DataClass getInstance];
//    NSDictionary *item = [obj getLayer:strLev];
//    NSString *strContent = [item objectForKey:@"content"];
//    NSString *strDistance = [item objectForKey:@"distance"];
    
    
    NSString *strContent = [obj getLayerContent:strLev];
    
    

    return [NSString stringWithFormat:@"%@", strContent];
    
    
//    switch (proximity) {
//        case CLProximityFar: // 3
//            return @"Far";
//            break;
//        case CLProximityNear: // 2
//            return @"Near";
//            break;
//        case CLProximityImmediate: // 1
//            return @"Immediate";
//            break;
//            
//        default:
//            return @"Unknown";
//            break;
//    }
}

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
