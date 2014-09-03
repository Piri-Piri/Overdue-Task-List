//
//  ViewController.m
//  Overdue Task List
//
//  Created by David Pirih on 03.09.14.
//  Copyright (c) 2014 piri-piri. All rights reserved.
//

#import "ViewController.h"
#import "PrefixHeader.pch"
#import "Task.h"

@interface ViewController ()

@property (strong,nonatomic) NSMutableArray *taskObjects;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)orderTasksAction:(UIBarButtonItem *)sender {
    // ...
}

- (IBAction)addTaskAction:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"toAddTaskViewController" sender:sender];
}

#pragma mark - Lazy Instantiation

- (NSMutableArray *)taskObjects
{
    if (!_taskObjects) {
        _taskObjects = [[NSMutableArray alloc] init];
    }
    return _taskObjects;
}

#pragma mark - Navigation

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([sender isKindOfClass:[UIBarButtonItem class]]) {
        if ([segue.destinationViewController isKindOfClass:[AddTaskViewController class]]) {
            AddTaskViewController *addTaskViewController = segue.destinationViewController;
            addTaskViewController.delegate = self;
        }
    }
}

#pragma mark - AddViewController Delegate

-(void)didAddTask:(Task *)task {
    NSLog(@"The delegated method didAddTask is being called");
    
    // add task to taskObjects
    [self.taskObjects addObject:task];
    
    // load saved tasks
    NSMutableArray *tasksAsPropertyLists = [[[NSUserDefaults standardUserDefaults] arrayForKey:TASK_OBJECTS] mutableCopy];
    
    // init, if no saved tasks at NSUSerDefaults found
    if (!tasksAsPropertyLists) tasksAsPropertyLists = [[NSMutableArray alloc] init];
    
    // add task as PropertyList (NSDictionary)
    [tasksAsPropertyLists addObject:[self taskObjectAsDictionary:task]];
    
    // write array with tasks (NSDictionary) back to NSUSerDefaults
    [[NSUserDefaults standardUserDefaults] setObject:tasksAsPropertyLists forKey:TASK_OBJECTS];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    // refresh tableview with new data
    //[self.tableView reloadData];
    
    // dismiss modal segue animated
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)didCancel {
    NSLog(@"The delegated method didCancel is being called");
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Helper Methods

-(NSDictionary *)taskObjectAsDictionary:(Task *)taskObject {
    NSDictionary *taskDict = [[NSDictionary alloc] init];
    [taskDict setValue:taskObject.taskTitle forKey:TASK_TITLE];
    [taskDict setValue:taskObject.taskDescription forKey:TASK_DESCRIPTION];
    [taskDict setValue:taskObject.taskDate forKey:TASK_DATE];
    [taskDict setValue:@(taskObject.isTaskCompleted) forKey:TASK_COMPLETION];
    
    return taskDict;
}

-(Task *)taskObjectForDictionary:(NSDictionary *)taskDict {
    Task *task = [[Task alloc] initWithData:taskDict];
    return task;
}

@end
