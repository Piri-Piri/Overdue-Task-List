//
//  AddTaskViewController.h
//  Overdue Task List
//
//  Created by David Pirih on 03.09.14.
//  Copyright (c) 2014 piri-piri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"

@protocol AddTaskViewControllerDelegate <NSObject>

@required
-(void)didAddTask:(Task *)task;
-(void)didCancel;

@end

@interface AddTaskViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate>

@property (weak, nonatomic) id <AddTaskViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITextField *taskNameTextField;
@property (weak, nonatomic) IBOutlet UITextView *taskDescriptionTextView;
@property (weak, nonatomic) IBOutlet UIDatePicker *taskDatePicker;
@property (weak, nonatomic) IBOutlet UISlider *taskProgressSilder;
@property (weak, nonatomic) IBOutlet UILabel *taskProgessLabel;

- (IBAction)saveTaskAction:(UIButton *)sender;
- (IBAction)cancelTaskAction:(UIButton *)sender;
- (IBAction)updateProgessAction:(UISlider *)sender;


@end
