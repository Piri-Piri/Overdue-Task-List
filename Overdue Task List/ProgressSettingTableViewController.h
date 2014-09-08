//
//  ProgressSettingTableViewController.h
//  Overdue Task List
//
//  Created by David Pirih on 06.09.14.
//  Copyright (c) 2014 piri-piri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrefixHeader.pch"

@protocol ProgressSettingTableViewControllerDelegate <NSObject>

@required
-(void)didSaveProgressStep:(NSString *)progessStep;

@end

@interface ProgressSettingTableViewController : UITableViewController

@property (weak) id <ProgressSettingTableViewControllerDelegate> delegate;
@property (strong,nonatomic) NSString *progressStep;

@end
