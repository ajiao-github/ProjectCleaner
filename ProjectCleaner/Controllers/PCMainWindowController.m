//
//  PCMainWindowController.m
//  ProjectCleaner
//
//  Created by qinzhiwei on 16/7/6.
//  Copyright © 2016年 lobster. All rights reserved.
//

#import "PCMainWindowController.h"
#import "PCMainTableViewDelegate.h"

@interface PCMainWindowController ()

@property (nonatomic, retain)PCMainTableViewDelegate *tableViewDelegate;

@end

@implementation PCMainWindowController

#pragma mark--Life Cycle--
- (id)init{
    if (self = [super initWithWindowNibName:@"PCMainWindowController" owner:self]) {
        
    }
    return self;
}

- (void)windowDidLoad {
    [super windowDidLoad];
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

#pragma mark--Private Methods--

#pragma mark--Getters & Setters--
- (PCMainTableViewDelegate *)tableViewDelegate{
    if (!_tableViewDelegate) {
        _tableViewDelegate = [PCMainTableViewDelegate new];
    }
    return _tableViewDelegate;
}
@end
