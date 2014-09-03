//
//  ViewController.h
//  Overdue Task List
//
//  Created by David Pirih on 03.09.14.
//  Copyright (c) 2014 piri-piri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddTaskViewController.h"

@interface ViewController : UIViewController <AddTaskViewConrollerDelegate>

- (IBAction)orderTasksAction:(UIBarButtonItem *)sender;
- (IBAction)addTaskAction:(UIBarButtonItem *)sender;

@end

