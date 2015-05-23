//
//  main.m
//  RandomPossessions
//
//  Created by Bernardo Tabuenca on 16/08/13.
//  Copyright (c) 2013 Bernardo Tabuenca. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BNRItem.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        

        // Create a mutable array object, store its address in items variable
        NSMutableArray *items = [[NSMutableArray alloc] init];
        
        // Send the message addObject: to the NSMutableArray pointed to
        // by the variable items, passing a string each time.
        [items addObject:@"One"];
        [items addObject:@"Two"];
        [items addObject:@"Three"];        
        
        // Send another message, insertObject:atIndex:, to that same array object
        [items insertObject:@"Zero" atIndex:0];
        
        // For every item in the array as determined by sending count to items
        for (int i = 0; i < [items count]; i++) {
            // We get the ith object from the array and pass it as an argument to
            // NSLog, which implicitly sends the description message to that object
            NSLog(@"%@", [items objectAtIndex:i]);
        }
        
        
        
        BNRItem *p = [[BNRItem alloc] init];
        

/*
        
        // This creates a new NSString, "Red Sofa" and gives it to the BNRItem
        [p setItemName:@"Red Sofa"];
        // This creates a new NSString, "A1B2C" and gives it to the BNRItem
        [p setSerialNumber:@"A1B2C"];
        // We send the value 100 to be used as the valueInDollars of this BNRItem
        [p setValueInDollars:100];
        
        NSLog(@"%@ %@ %@ %d", [p itemName], [p dateCreated], [p serialNumber], [p valueInDollars]);
        
        // Remember, an NSLog with %@ as the token will print the
        // description of the corresponding argument
        NSLog(@"%@", p);
        // The following and previous lines do the same
        NSLog(@"%@", [p description]);
        
*/
        
        for (int i = 0; i < 10; i++) {
            BNRItem *p = [BNRItem randomItem];
            [items addObject:p];
        }

/*
        // Iterating over enumaration
        // This does the same than the previous for
        for (BNRItem *item in items) {
            NSLog(@"%@", item);
        }
*/
        for (int i = 0; i < [items count]; i++) {
            NSLog(@"%@", [items objectAtIndex:i]);
        }
        
        
        
        items = nil;
        
        
    }
    return 0;
}

