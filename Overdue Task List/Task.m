//
//  Task.m
//  Overdue Task List
//
//  Created by David Pirih on 03.09.14.
//  Copyright (c) 2014 piri-piri. All rights reserved.
//

#import "Task.h"
#import "PrefixHeader.pch"

@implementation Task

- (id)init {
    self = [self initWithData:nil];
    return self;

}

- (id)initWithData:(NSDictionary *)data {
    self = [super init];
    
    if (self) {
        self.taskTitle = [data objectForKey:TASK_TITLE];
        self.taskDescription = [data objectForKey:TASK_DESCRIPTION];
        self.taskDate = [data objectForKey:TASK_DATE];
        self.taskProgess = [data objectForKey:TASK_PROGRESS];
        
        self.isTaskCompleted = [data[TASK_COMPLETION] boolValue];
    }
    return self;
}

@end
