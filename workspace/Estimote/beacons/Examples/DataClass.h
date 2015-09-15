//
//  DataClass.h
//  Examples
//
//  Created by Bernardo Tabuenca on 22/06/15.
//  Copyright (c) 2015 com.estimote. All rights reserved.
//


//DataClass.h
@interface DataClass : NSObject {
    
    NSString *strBeaconID;
    NSMutableArray *arrLayers;

}

@property(nonatomic,retain)NSString *strBeaconID;
@property(nonatomic,retain)NSMutableArray *arrLayers;

+(DataClass*)getInstance;

-(void)printLayers;
-(NSDictionary *)getLayer:(NSString*)level;
-(NSString *)getLayerContent:(NSString*)level;


@end
