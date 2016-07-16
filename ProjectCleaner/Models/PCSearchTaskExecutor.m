//
//  PCSearchTaskExecutor.m
//  ProjectCleaner
//
//  Created by qinzhiwei on 16/7/16.
//  Copyright © 2016年 lobster. All rights reserved.
//

#import "PCSearchTaskExecutor.h"
#import <Cocoa/Cocoa.h>
#import "PCTaskStatusMachine.h"
#import "PCUtils.h"

@interface PCSearchTaskExecutor()

@property (nonatomic, retain)NSArray *searchOptions;
@property (nonatomic, retain)NSArray *unusedOptions;

@end

@implementation PCSearchTaskExecutor

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
            if ([param isKindOfClass:[NSArray class]]) {
                self.searchOptions = param[0];
                self.unusedOptions = param[1];
            }
        }
    }
    va_end(arguments);
    
    /*logic*/
    dispatch_async(dispatch_get_main_queue(), ^{
        task.status = 0;
    });
    NSString *path = nil;
    NSDirectoryEnumerator *enumerator = [[NSFileManager defaultManager] enumeratorAtPath:@"/Users/lobster/Downloads/GSD_WeiXin-master"];
    while (((path = [enumerator nextObject])))
    {
        NSString *searchStringPath = [@"/Users/lobster/Downloads/GSD_WeiXin-master/" stringByAppendingString:path];
        NSString *searchString = [NSString stringWithFormat:@"delete-->%@\n",searchStringPath];
        dispatch_async(dispatch_get_main_queue(), ^{
            console.string = [console.string stringByAppendingString:searchString];
            [console scrollLineDown:nil];
        });
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        task.status = 1;
    });
}

@end
