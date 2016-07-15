//
//  PCConsoleLogHandler.h
//  ProjectCleaner
//
//  Created by qinzhiwei on 16/7/15.
//  Copyright © 2016年 lobster. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

@interface PCConsoleLogHandler : NSObject

/*print cmd executing log to window*/
- (void)consoleLogInWindow:(NSTextView *)window withAttributedString:(NSAttributedString *)attributeString;

/*export executed log to dirtory*/
- (void)consoleLogUsingWindow:(NSTextView *)window exportToTargetDirectory:(NSString *)directoryPath;

@end
