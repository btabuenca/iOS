//
//  BNRItem.h
//  RandomPossessions
//
//  Created by Bernardo Tabuenca on 16/08/13.
//  Copyright (c) 2013 Bernardo Tabuenca. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRItem : NSObject
{
    NSString *itemName;
    NSString *serialNumber;
    int valueInDollars;
    NSDate *dateCreated;
}

// Class method
// Class methods typically either create new instances of the class or retrieve some global property of the class
+ (id)randomItem;


// Init methods are identified with (id)
- (id)initWithItemName:(NSString *)name
        valueInDollars:(int)value
          serialNumber:(NSString *)sNumber;


- (void)setItemName:(NSString *)str;
- (NSString *)itemName;

- (void)setSerialNumber:(NSString *)str;
- (NSString *)serialNumber;

- (void)setValueInDollars:(int)i;
- (int)valueInDollars;

- (NSDate *)dateCreated;





@end