//
//  HelloWorldViewController.h
//  HelloWorld
//
//  Created by Bernardo Tabuenca on 14/02/13.
//  Copyright 2013 ou.nl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HelloWorldViewController : UIViewController {
    
    IBOutlet UILabel *label;
    
}
@property (nonatomic, retain) IBOutlet UILabel *label;
-(IBAction)buttonPressed;


@end
