//
//  PrefsTableViewController.h
//  Overdue Task List
//
//  Created by David Pirih on 06.09.14.
//  Copyright (c) 2014 piri-piri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrefixHeader.pch"
#import "ProgressSettingTableViewController.h"

typedef enum {
    red = 0,
    purple,
    magenta
} overdueColorSelector;

typedef enum {
    orange = 0,
    cyan,
    yellow
} ongoingColorSelector;

typedef enum {
    green = 0,
    blue,
    gray
} completeColorSelector;

typedef enum {
    begin = 0,
    end
} insertPosition;

typedef enum {
    None = 0,
    Date,
    Title
} sortOrder;

typedef enum {
    Appearence = 0,
    Sort,
    Options,
    Auomation
} prefSectionNames;

typedef enum {
    SortTaskBy = 0,
    InsertPosition,
    SortAcending
} sortRowNames;

    
@protocol PrefsTableViewControllerDelegate <NSObject>

@required
-(void)didSavePrefs;

@end

@interface PrefsTableViewController : UITableViewController <ProgressSettingTableViewControllerDelegate>

@property (weak) id <PrefsTableViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UISegmentedControl *overdueColorSelect;
@property (weak, nonatomic) IBOutlet UISegmentedControl *ongoingColorSelect;
@property (weak, nonatomic) IBOutlet UISegmentedControl *completeColorSelect;
@property (weak, nonatomic) IBOutlet UISwitch *capitalizeTitelSwitch;

@property (weak, nonatomic) IBOutlet UISegmentedControl *insertPositionSelect;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sortSelect;
@property (weak, nonatomic) IBOutlet UISwitch *sortAscending;

@property (weak, nonatomic) IBOutlet UISwitch *hideCompletedTask;
@property (weak, nonatomic) IBOutlet UISwitch *hideEmptySectionSwitch;

@property (weak, nonatomic) IBOutlet UILabel *progessStep;


- (IBAction)sortOrderAction:(UISegmentedControl *)sender;
- (IBAction)savePrefsAction:(UIBarButtonItem *)sender;


@end
