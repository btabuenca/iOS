//
//  QuizViewController.h
//  Quiz
//
//  Created by Bernardo Tabuenca on 15/08/13.
//  Copyright (c) 2013 Bernardo Tabuenca. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuizViewController : UIViewController
{
    int currentQuestionIndex;
    
    // The model objects
    NSMutableArray *questions;
    NSMutableArray *answers;
    
    // The view objects
    IBOutlet UILabel *questionField;
    IBOutlet UILabel *answerField;
}

// The action methods
- (IBAction)showQuestion:(id)sender;
- (IBAction)showAnswer:(id)sender;

@end
