//
//  Task.h
//  Overdue Task List
//
//  Created by David Pirih on 03.09.14.
//  Copyright (c) 2014 piri-piri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Task : NSObject

@property (strong, nonatomic) NSString *taskTitle;
@property (strong, nonatomic) NSString *taskDescription;
@property (strong, nonatomic) NSDate *taskDate;
@property (nonatomic) BOOL isTaskCompleted;

- (id)initWithData:(NSDictionary *)data;

@end