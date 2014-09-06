//
//  ViewController.m
//  Overdue Task List
//
//  Created by David Pirih on 03.09.14.
//  Copyright (c) 2014 piri-piri. All rights reserved.
//

#import "ViewController.h"
#import "PrefixHeader.pch"

@interface ViewController ()

@property (strong,nonatomic) NSMutableArray *taskObjects;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSArray *savedTaskObjects = [[NSUserDefaults standardUserDefaults] objectForKey:TASK_OBJECTS_KEY];
    for (NSDictionary *taskDict in savedTaskObjects) {
        [self.taskObjects addObject:[self taskObjectForDictionary:taskDict]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)orderTasksAction:(UIBarButtonItem *)sender {
    // toogle edit mode for editing (reorder) in tableview
    self.tableView.editing = !self.tableView.editing;
}

- (IBAction)addTaskAction:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"toAddTaskViewController" sender:sender];
}

- (IBAction)prefsAction:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"toPrefsTableViewController" sender:sender];
}

#pragma mark - Lazy Instantiation

- (NSMutableArray *)taskObjects
{
    if (!_taskObjects) {
        _taskObjects = [[NSMutableArray alloc] init];
    }
    return _taskObjects;
}

#pragma mark - TableView data source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // only one section defined
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.taskObjects count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"taskCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    //Configure the cell...
    
    // catch corresponding the task object
    Task *task = [self.taskObjects objectAtIndex:indexPath.row];
    
    cell.textLabel.text = task.taskTitle;
    
    // Set date format
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    
    cell.detailTextLabel.text = [formatter stringFromDate:task.taskDate];
    
    // Set background depending on task is overdue or not
    if (task.isTaskCompleted) cell.backgroundColor = [UIColor greenColor];
    else if ([self isDateGreaterThanDate:[NSDate date] and:task.taskDate])
        cell.backgroundColor = [UIColor redColor];
    else cell.backgroundColor = [UIColor yellowColor];
    
    // hide completed task, if cooreponding pref is enabled
    if (task.isTaskCompleted && [[[NSUserDefaults standardUserDefaults] objectForKey:PREF_HIDE_COMPLETED_TASK] boolValue]) cell.hidden = YES;
    else cell.hidden = NO;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
     // update completion status (toogle)
    Task *taskObject = [self.taskObjects objectAtIndex:indexPath.row];
    [self updateCompletionOfTask:taskObject forIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"performSeguetoDetailTaskViewController");
    [self performSegueWithIdentifier:@"toDetailTaskViewController" sender:indexPath];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Read NSUserDefaults, delete row...
        NSMutableArray *savedTaskObjects = [[[NSUserDefaults standardUserDefaults] objectForKey:TASK_OBJECTS_KEY] mutableCopy];
        [savedTaskObjects removeObjectAtIndex:indexPath.row];
        // and write back to NSUserDefaults
        [[NSUserDefaults standardUserDefaults] setObject:savedTaskObjects forKey:TASK_OBJECTS_KEY];
        [[NSUserDefaults standardUserDefaults] synchronize];
         
        // Delete the row from NSMutableArray (taskObjects)
        [self.taskObjects removeObjectAtIndex:indexPath.row];
        
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    // Read NSUserDefaults, move row...
    NSMutableArray *savedTaskObjects = [[[NSUserDefaults standardUserDefaults] objectForKey:TASK_OBJECTS_KEY] mutableCopy];
    [savedTaskObjects exchangeObjectAtIndex:fromIndexPath.row withObjectAtIndex:toIndexPath.row];
    // and write back to NSUserDefaults
    [[NSUserDefaults standardUserDefaults] setObject:savedTaskObjects forKey:TASK_OBJECTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    // Move the row in NSMutableArray (taskObjects)
    [self.taskObjects exchangeObjectAtIndex:fromIndexPath.row withObjectAtIndex:toIndexPath.row];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
     // Return NO if you do not want the item to be re-orderable.
     return YES;
}

#pragma mark - Navigation

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([sender isKindOfClass:[UIBarButtonItem class]]) {
        if ([segue.destinationViewController isKindOfClass:[AddTaskViewController class]]) {
            AddTaskViewController *addTaskViewController = segue.destinationViewController;
            addTaskViewController.delegate = self;
        }
    }
    if ([segue.destinationViewController isKindOfClass:[DetailTaskViewController class]]) {
        NSIndexPath *indexPath = sender;
        
        // forward selected task object to DetailTaskViewController
        DetailTaskViewController *detailTaskViewController = segue.destinationViewController;
        detailTaskViewController.task = [self.taskObjects objectAtIndex:indexPath.row];
        detailTaskViewController.delegate = self;
    }
    if ([segue.destinationViewController isKindOfClass:[PrefsTableViewController class]]) {
        PrefsTableViewController *prefsViewController = segue.destinationViewController;
        prefsViewController.delegate = self;
    }
}

#pragma mark - AddViewController Delegate

-(void)didAddTask:(Task *)task {
    NSLog(@"The delegated method didAddTask is being called");
    
    // add task to taskObjects
    [self.taskObjects addObject:task];
    
    // load saved tasks
    NSMutableArray *tasksAsPropertyLists = [[[NSUserDefaults standardUserDefaults] arrayForKey:TASK_OBJECTS_KEY] mutableCopy];
    
    // init, if no saved tasks at NSUSerDefaults found
    if (!tasksAsPropertyLists) tasksAsPropertyLists = [[NSMutableArray alloc] init];
    
    // add task as PropertyList (NSDictionary)
    [tasksAsPropertyLists addObject:[self taskObjectAsDictionary:task]];
    
    // write array with tasks (NSDictionary) back to NSUSerDefaults
    [[NSUserDefaults standardUserDefaults] setObject:tasksAsPropertyLists forKey:TASK_OBJECTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    // refresh tableview with new data
    [self.tableView reloadData];
    
    // dismiss modal segue animated
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)didCancel {
    NSLog(@"The delegated method didCancel is being called");
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - DetailViewController Delegate

-(void)shouldSaveTask{
    // save task objects to nsuserdefaults (including the edited one)
    // and reload the tableview data with it.
    [self saveTasks];
    [self.tableView reloadData];
}

#pragma mark - PrefsTableViewController Delegate

-(void)didSavePrefs{
    NSLog(@"The delegated method didSavePrefs is being called");
    [self.navigationController popViewControllerAnimated:YES];
    [self.tableView reloadData];
}

#pragma mark - Helper Methods

-(void)saveTasks
{
    // collect all task object in a dictionary and save it to nsuserdefaults
    NSMutableArray *taskObjectAsDictionary = [[NSMutableArray alloc] init];
    for (int x = 0; x < [self.taskObjects count]; x ++){
        [taskObjectAsDictionary addObject:[self taskObjectAsDictionary:self.taskObjects[x]]];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:taskObjectAsDictionary forKey:TASK_OBJECTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(NSDictionary *)taskObjectAsDictionary:(Task *)taskObject {
    NSMutableDictionary *taskDict = [[NSMutableDictionary alloc] init];
    [taskDict setValue:taskObject.taskTitle forKey:TASK_TITLE];
    [taskDict setValue:taskObject.taskDescription forKey:TASK_DESCRIPTION];
    [taskDict setValue:taskObject.taskDate forKey:TASK_DATE];
    [taskDict setValue:taskObject.taskProgess forKey:TASK_PROGRESS];
    [taskDict setValue:@(taskObject.isTaskCompleted) forKey:TASK_COMPLETION];
    
    return taskDict;
}

-(Task *)taskObjectForDictionary:(NSDictionary *)taskDict {
    Task *task = [[Task alloc] initWithData:taskDict];
    return task;
}

- (BOOL)isDateGreaterThanDate:(NSDate*)date and:(NSDate*)toDate {
    int timeInterval = [date timeIntervalSince1970];
    int toTimeInterval = [toDate timeIntervalSince1970];
    
    if (timeInterval > toTimeInterval) return YES;
    return NO;
}

-(void)updateCompletionOfTask:(Task *)task forIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *savedTaskObjects = [[[NSUserDefaults standardUserDefaults] objectForKey:TASK_OBJECTS_KEY] mutableCopy];
    
    // remove the task to be updated
    [savedTaskObjects removeObjectAtIndex:indexPath.row];
    
    // toogle task completion state
    task.isTaskCompleted = !task.isTaskCompleted;
    
    // set/reset progress on completion toogle 
    if (task.isTaskCompleted) task.taskProgess = @100;
    else task.taskProgess = @0;
    
    // save updated task object as dictionary
    [savedTaskObjects insertObject:[self taskObjectAsDictionary:task] atIndex:indexPath.row];
    
    // save the updated array to NSUserDefaults
    [[NSUserDefaults standardUserDefaults] setObject:savedTaskObjects forKey:TASK_OBJECTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self.tableView reloadData];
}

@end
