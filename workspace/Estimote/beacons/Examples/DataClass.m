//
//  DataClass.h
//  Examples
//
//  Created by Bernardo Tabuenca on 22/06/15.
//  Copyright (c) 2015 com.estimote. All rights reserved.
//
#import "DataClass.h"

//DataClass.m
@implementation DataClass
@synthesize strBeaconID;
@synthesize arrLayers;

static DataClass *instance = nil;

+(DataClass *)getInstance
{
    @synchronized(self)
    {
        if(instance==nil)
        {
            instance = [DataClass new];
        }
    }
    return instance;
}





- (void)printLayers;
{
    
    for(NSDictionary *item in arrLayers) {
        
        
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
    
    
}




-(NSDictionary *)getLayer:(NSString*)level;
{
    NSLog(@"Looking for!!: %@", level);
    NSDictionary *layer;
    
    for(NSDictionary *item in arrLayers) {
        
        NSString *strBeaconId = [item objectForKey:@"beacon_id"];
        NSString *strContent = [item objectForKey:@"content"];
        
        NSDictionary *dictContent = [item objectForKey:@"content"];
        NSString *strContentV = [dictContent objectForKey:@"value"];
        
        NSString *strDistance = [item objectForKey:@"distance"];
        NSString *strId = [item objectForKey:@"id"];
        NSString *strLayerCC = [item objectForKey:@"layer_cc"];
        NSString *strLevel = [item objectForKey:@"level"];
        NSString *strSignal = [item objectForKey:@"signal"];
        NSString *strTag = [item objectForKey:@"tag"];
        NSString *strTimestampUpdate = [item objectForKey:@"timestamp_update"];
        NSString *strTimestampEnd = [item objectForKey:@"timestamp_validity_end"];
        NSString *strTimestampStart = [item objectForKey:@"timestamp_validity_start"];
        
        if ( [level intValue] == [strLevel intValue]) {
            
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
            
            
            NSLog(@"Encontrado!!: %@ %@", strContent, strContentV);
            layer = item;
            
        }else{
            NSLog(@"Este no es: %@", strLevel);
        }
        
    }
    return layer;
    
}


-(NSString *)getLayerContent:(NSString*)level;
{
    NSLog(@"Looking for!!: %@", level);
    NSDictionary *layer;
    NSString *strReturn;
    
    for(NSDictionary *item in arrLayers) {
        

        NSString *strLevel = [item objectForKey:@"level"];

        
        if ([level intValue] == [strLevel intValue]) {
            
            NSDictionary *dictContent = [item objectForKey:@"content"];
            NSString *strContentV = [dictContent objectForKey:@"value"];
            
            NSLog(@"Encontrado!!: %@", strContentV);
            strReturn = strContentV;

        }
        
    }
    return strReturn;
    
}

@end

