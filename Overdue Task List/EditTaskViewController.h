//
//  EditTaskViewController.h
//  Overdue Task List
//
//  Created by David Pirih on 03.09.14.
//  Copyright (c) 2014 piri-piri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrefixHeader.pch"
#import "Task.h"


@protocol EditTaskViewControllerDelegate <NSObject>

@required
-(void)didSaveTask;

@end

@interface EditTaskViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate>

@property (strong,nonatomic) Task *editedTask;
@property (weak) id <EditTaskViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITextField *taskNameTextField;
@property (weak, nonatomic) IBOutlet UITextView *taskDescriptionTextView;
@property (weak, nonatomic) IBOutlet UIDatePicker *taskDatePicker;
@property (weak, nonatomic) IBOutlet UISwitch *taskCompleteSwitch;
@property (weak, nonatomic) IBOutlet UISlider *taskProgressSilder;
@property (weak, nonatomic) IBOutlet UILabel *taskProgessLabel;

- (IBAction)editedTaskSaveAction:(UIBarButtonItem *)sender;
- (IBAction)updateProgessAction:(UISlider *)sender;

@end
