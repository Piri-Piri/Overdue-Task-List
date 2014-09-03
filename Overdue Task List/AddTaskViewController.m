//
//  AddTaskViewController.m
//  Overdue Task List
//
//  Created by David Pirih on 03.09.14.
//  Copyright (c) 2014 piri-piri. All rights reserved.
//

#import "AddTaskViewController.h"
#import "PrefixHeader.pch"
#import "Task.h"

@interface AddTaskViewController ()

@end

@implementation AddTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveTaskAction:(UIButton *)sender {
    [self.delegate didAddTask:[self returnNewTaskObject]];
}

- (IBAction)cancelTaskAction:(UIButton *)sender {
    [self.delegate didCancel];
}

#pragma mark - Helper methodes

-(Task *)returnNewTaskObject {
    Task *newTaskObject = [[Task alloc] init];
    
    newTaskObject.taskTitle = self.taskNameTextField.text;
    newTaskObject.taskDescription = self.taskDescriptionTextView.text;
    newTaskObject.taskDate = self.taskDatePicker.date;
    
    // initial value for completion
    newTaskObject.isTaskCompleted = NO;

    return newTaskObject;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
