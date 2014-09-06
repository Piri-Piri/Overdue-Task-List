//
//  ViewController.h
//  Overdue Task List
//
//  Created by David Pirih on 03.09.14.
//  Copyright (c) 2014 piri-piri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"
#import "AddTaskViewController.h"
#import "DetailTaskViewController.h"

@interface ViewController : UIViewController <AddTaskViewControllerDelegate, UITableViewDataSource, UITableViewDelegate, DetailTaskViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)orderTasksAction:(UIBarButtonItem *)sender;
- (IBAction)addTaskAction:(UIBarButtonItem *)sender;
- (IBAction)prefsAction:(UIBarButtonItem *)sender;

@end

