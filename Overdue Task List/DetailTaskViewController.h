//
//  DetailTaskViewController.h
//  Overdue Task List
//
//  Created by David Pirih on 03.09.14.
//  Copyright (c) 2014 piri-piri. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailTaskViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *taskNameLAbel;
@property (weak, nonatomic) IBOutlet UILabel *taskDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *taskDateLabel;

- (IBAction)editTaskAction:(UIBarButtonItem *)sender;

@end
