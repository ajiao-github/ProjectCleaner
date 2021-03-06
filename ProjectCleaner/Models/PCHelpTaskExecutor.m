//
//  PCHelpTaskExecutor.m
//  ProjectCleaner
//
//  Created by qinzhiwei on 16/7/15.
//  Copyright © 2016年 lobster. All rights reserved.
//

#import "PCHelpTaskExecutor.h"
#import <Cocoa/Cocoa.h>
#import "PCTaskStatusMachine.h"

@implementation PCHelpTaskExecutor

- (void)executeTaskWithCmd:(NSString *)cmd, ...{
    
    NSTextView *console = nil;
    NSDictionary *cmdMap = nil;
    PCTaskStatusMachine *task = nil;
    va_list arguments;
    va_start(arguments, cmd);
    if (cmd) {
        id param = nil;
        while ((param = va_arg(arguments, id))) {
            if ([param isKindOfClass:[NSTextView class]]) {
                console = param;
            }
            if ([param isKindOfClass:[NSDictionary class]]) {
                cmdMap = param;
            }
            if ([param isKindOfClass:[PCTaskStatusMachine class]]) {
                task = param;
            }
        }
    }
    va_end(arguments);
    
    /*logic*/
    
    NSString *helpString = @"";
    for (NSString *name in [cmdMap allKeys]) {
        helpString = [helpString stringByAppendingString:[NSString stringWithFormat:@"%@-->%@\n",name,cmdMap[name][@"description"]]];
    }
    if (helpString.length) {
        console.string = [console.string stringByAppendingString:helpString];
    }
    
}

@end
