//
//  DetailTaskViewController.m
//  Overdue Task List
//
//  Created by David Pirih on 03.09.14.
//  Copyright (c) 2014 piri-piri. All rights reserved.
//

#import "DetailTaskViewController.h"

@interface DetailTaskViewController ()

@end

@implementation DetailTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.taskNameLabel.text = self.task.taskTitle;
    self.taskDescriptionLabel.text = self.task.taskDescription;
    
    // Set date format
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    
    self.taskDateLabel.text = [formatter stringFromDate:self.task.taskDate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)editTaskAction:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"toEditTaskViewController" sender:sender];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([sender isKindOfClass:[UIBarButtonItem class]]) {
        if ([segue.destinationViewController isKindOfClass:[EditTaskViewController class]]) {
            EditTaskViewController *editTaskViewController = segue.destinationViewController;
            editTaskViewController.editedTask = self.task;
            editTaskViewController.delegate = self;
        }
    }
}

#pragma mark - EditTaskViewControllerDelegate

-(void)didSaveTask:(Task *)task {
    // ...
}

@end
