//
//  AddTaskViewController.h
//  Overdue Task List
//
//  Created by David Pirih on 03.09.14.
//  Copyright (c) 2014 piri-piri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"

@protocol AddTaskViewConrollerDelegate <NSObject>

@required
-(void)didAddTask:(Task *)task;
-(void)didCancel;

@end

@interface AddTaskViewController : UIViewController

@property (weak, nonatomic) id <AddTaskViewConrollerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITextField *taskNameTextField;
@property (weak, nonatomic) IBOutlet UITextView *taskDescriptionTextView;
@property (weak, nonatomic) IBOutlet UIDatePicker *taskDatePicker;

- (IBAction)saveTaskAction:(UIButton *)sender;
- (IBAction)cancelTaskAction:(UIButton *)sender;


@end
