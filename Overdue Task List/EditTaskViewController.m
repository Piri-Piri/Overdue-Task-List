//
//  EditTaskViewController.m
//  Overdue Task List
//
//  Created by David Pirih on 03.09.14.
//  Copyright (c) 2014 piri-piri. All rights reserved.
//

#import "EditTaskViewController.h"

@interface EditTaskViewController ()

@end

@implementation EditTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.taskNameTextField.delegate = self;
    self.taskDescriptionTextView.delegate = self;
    
    self.taskNameTextField.text = self.editedTask.taskTitle;
    self.taskDescriptionTextView.text = self.editedTask.taskDescription;
    self.taskDatePicker.date = self.editedTask.taskDate;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TextField Delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - TextView Delegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)editedTaskSaveAction:(UIBarButtonItem *)sender {
    self.editedTask.taskTitle = self.taskNameTextField.text;
    self.editedTask.taskDescription = self.taskDescriptionTextView.text;
    self.editedTask.taskDate = self.taskDatePicker.date;
    
    [self.delegate didSaveTask];
}
@end
