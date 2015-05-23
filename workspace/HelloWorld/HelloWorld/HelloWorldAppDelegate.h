//
//  HelloWorldAppDelegate.h
//  HelloWorld
//
//  Created by Bernardo Tabuenca on 14/02/13.
//  Copyright 2013 ou.nl. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HelloWorldViewController;

@interface HelloWorldAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet HelloWorldViewController *viewController;

@end
