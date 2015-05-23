//
//  QuizAppDelegate.h
//  Quiz
//
//  Created by Bernardo Tabuenca on 15/08/13.
//  Copyright (c) 2013 Bernardo Tabuenca. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QuizViewController;

@interface QuizAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) QuizViewController *viewController;

@end
