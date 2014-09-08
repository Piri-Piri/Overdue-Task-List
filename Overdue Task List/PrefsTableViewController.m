//
//  PrefsTableViewController.m
//  Overdue Task List
//
//  Created by David Pirih on 06.09.14.
//  Copyright (c) 2014 piri-piri. All rights reserved.
//

#import "PrefsTableViewController.h"

@interface PrefsTableViewController ()

@end

@implementation PrefsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // read prefs from NSUserDefaults
    self.completeColorSelect.selectedSegmentIndex = [[[NSUserDefaults standardUserDefaults] objectForKey:PREF_COMPLETE_COLOR] integerValue];
    self.overdueColorSelect.selectedSegmentIndex = [[[NSUserDefaults standardUserDefaults] objectForKey:PREF_OVERDUE_COLOR] integerValue];
    self.ongoingColorSelect.selectedSegmentIndex = [[[NSUserDefaults standardUserDefaults] objectForKey:PREF_ONGOING_COLOR] integerValue];
    self.capitalizeTitelSwitch.on = [[[NSUserDefaults standardUserDefaults] objectForKey:PREF_CAPITALIZE_TITEL] boolValue];
    self.hideCompletedTask.on = [[[NSUserDefaults standardUserDefaults] objectForKey:PREF_HIDE_COMPLETED_TASK] boolValue];
    self.hideEmptySectionSwitch.on =  [[[NSUserDefaults standardUserDefaults] objectForKey:PREF_HIDE_EMPTY_SECTION] boolValue];
    self.insertPositionSelect.selectedSegmentIndex = [[[NSUserDefaults standardUserDefaults] objectForKey:PREF_INSERT_POSITION] integerValue];
    self.sortSelect.selectedSegmentIndex = [[[NSUserDefaults standardUserDefaults] objectForKey:PREF_SORT] integerValue];
    self.progessStep.text = [[NSUserDefaults standardUserDefaults] objectForKey:PREF_PROGRESS_STEP];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction methods

- (IBAction)savePrefsAction:(UIBarButtonItem *)sender {
    // save prefs from NSUserDefaults
    [[NSUserDefaults standardUserDefaults] setObject:@(self.completeColorSelect.selectedSegmentIndex) forKey:PREF_COMPLETE_COLOR];
    [[NSUserDefaults standardUserDefaults] setObject:@(self.overdueColorSelect.selectedSegmentIndex) forKey:PREF_OVERDUE_COLOR];
    [[NSUserDefaults standardUserDefaults] setObject:@(self.ongoingColorSelect.selectedSegmentIndex) forKey:PREF_ONGOING_COLOR];
    [[NSUserDefaults standardUserDefaults] setObject:@(self.capitalizeTitelSwitch.on) forKey:PREF_CAPITALIZE_TITEL];
    [[NSUserDefaults standardUserDefaults] setObject:@(self.hideCompletedTask.on) forKey:PREF_HIDE_COMPLETED_TASK];
    [[NSUserDefaults standardUserDefaults] setObject:@(self.hideEmptySectionSwitch.on) forKey:PREF_HIDE_EMPTY_SECTION];
    [[NSUserDefaults standardUserDefaults] setObject:@(self.insertPositionSelect.selectedSegmentIndex) forKey:PREF_INSERT_POSITION];
    [[NSUserDefaults standardUserDefaults] setObject:@(self.sortSelect.selectedSegmentIndex) forKey:PREF_SORT];
    [[NSUserDefaults standardUserDefaults] setObject:self.progessStep.text forKey:PREF_PROGRESS_STEP];
    [[NSUserDefaults standardUserDefaults] synchronize];
     
    [self.delegate didSavePrefs];
}

- (IBAction)sortOrderAction:(UISegmentedControl *)sender {
    [self.tableView reloadData];
}

#pragma mark - ProgressSettingTableViewControllerDelegate

-(void)didSaveProgressStep:(NSString *)progessStep {
    self.progessStep.text = progessStep;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.destinationViewController isKindOfClass:[ProgressSettingTableViewController class]]) {
        ProgressSettingTableViewController *progressSettingTableViewController = segue.destinationViewController;
        progressSettingTableViewController.delegate = self;
        progressSettingTableViewController.progressStep = self.progessStep.text;
    }
}

#pragma mark - UITableView Data Source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    
    if (indexPath.section == Sort) {
        if (self.sortSelect.selectedSegmentIndex == None && indexPath.row == SortAcending) {
            cell.hidden = YES;
            return 0;
        }
        if (self.sortSelect.selectedSegmentIndex != None && indexPath.row == InsertPosition) {
            cell.hidden = YES;
            return 0;
        }
    }
    
    cell.hidden = NO;
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

@end
