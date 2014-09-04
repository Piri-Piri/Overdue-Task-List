//
//  DetailTaskViewController.h
//  Overdue Task List
//
//  Created by David Pirih on 03.09.14.
//  Copyright (c) 2014 piri-piri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditTaskViewController.h"
#import "Task.h"

@protocol DetailTaskViewControllerDelegate <NSObject>

@required
-(void)didChangeTask:(Task *)task;

@end

@interface DetailTaskViewController : UIViewController <EditTaskViewControllerDelegate>

@property (weak) id <DetailTaskViewControllerDelegate> delegate;
@property (strong, nonatomic) Task *task;

@property (weak, nonatomic) IBOutlet UILabel *taskNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *taskDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *taskDateLabel;

- (IBAction)editTaskAction:(UIBarButtonItem *)sender;

@end
