//
//  PrefsTableViewController.h
//  Overdue Task List
//
//  Created by David Pirih on 06.09.14.
//  Copyright (c) 2014 piri-piri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrefixHeader.pch"

@protocol PrefsTableViewControllerDelegate <NSObject>

@required
-(void)didSavePrefs;

@end

@interface PrefsTableViewController : UITableViewController

@property (weak) id <PrefsTableViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UISegmentedControl *overdueColorSelect;
@property (weak, nonatomic) IBOutlet UISegmentedControl *ongoingColorSelect;
@property (weak, nonatomic) IBOutlet UISegmentedControl *completeColorSelect;
@property (weak, nonatomic) IBOutlet UISwitch *capitalizeTitelSwitch;

@property (weak, nonatomic) IBOutlet UISwitch *hideCompletedTask;
@property (weak, nonatomic) IBOutlet UISwitch *hideEmptySectionSwitch;

@property (weak, nonatomic) IBOutlet UISegmentedControl *insertPositionSelect;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sortSelect;

- (IBAction)savePrefsAction:(UIBarButtonItem *)sender;

@end
