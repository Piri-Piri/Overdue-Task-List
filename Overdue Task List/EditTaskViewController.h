//
//  EditTaskViewController.h
//  Overdue Task List
//
//  Created by David Pirih on 03.09.14.
//  Copyright (c) 2014 piri-piri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"

@protocol EditTaskViewControllerDelegate <NSObject>

@required
-(void)didSaveTask:(Task *)task;

@end

@interface EditTaskViewController : UIViewController

@property (strong,nonatomic) Task *editedTask;
@property (weak) id <EditTaskViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITextField *taskNameTextField;
@property (weak, nonatomic) IBOutlet UITextView *taskDescriptionTextView;
@property (weak, nonatomic) IBOutlet UIDatePicker *taskDatePicker;

- (IBAction)editedTaskSaveAction:(UIBarButtonItem *)sender;

@end
