//
//  PCMainWindowController.m
//  ProjectCleaner
//
//  Created by qinzhiwei on 16/7/6.
//  Copyright © 2016年 lobster. All rights reserved.
//

#import "PCMainWindowController.h"
#import "PCMainTableViewDelegate.h"
#import "PCUtils.h"
#import "NSView+PCUserInteraction.h"

static NSInteger const kSearchOptionsTextFieldTag   = 50000;
static NSInteger const kDeleteOptionsTextFieldTag   = 50001;
static NSInteger const kUnusedOptionsTextFieldTag   = 50002;

static NSInteger const kSearchOptionCheckButtonTag  = 10000;
static NSInteger const kDeleteOptionCheckButtonTag  = 20000;
static NSInteger const kUnusedOptionCheckButtonTag  = 30000;

@interface PCMainWindowController ()<NSTextFieldDelegate,NSTextViewDelegate>

@property (nonatomic, retain)PCMainTableViewDelegate *tableViewDelegate;

@property (weak) IBOutlet NSView *searchOptionsView;
@property (weak) IBOutlet NSView *deleteOptionsView;
@property (weak) IBOutlet NSView *unusedOptionsView;

@property (weak) IBOutlet NSScrollView *consoleLogView;
@property (unsafe_unretained) IBOutlet NSTextView *consoleLogTextView;
@property (weak) IBOutlet NSTextField *statusLabel;
@property (weak) IBOutlet NSProgressIndicator *indicator;
@property (weak) IBOutlet NSButton *exportCheckButton;

@property (weak) IBOutlet NSTextField *searchOptionsTextField;
@property (weak) IBOutlet NSTextField *deleteOptionsTextField;
@property (weak) IBOutlet NSTextField *unusedOptionsTextField;

@property (weak) IBOutlet NSButton *searchCheckButton;
@property (weak) IBOutlet NSButton *deleteCheckButton;
@property (weak) IBOutlet NSButton *unusedCheckButton;


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
    [self initSearchOptionsCheckButton];
    [self initDeleteOptionsCheckButton];
    [self initUnusedOptionsCheckButton];
    [self initConsoleLogCheckButton];
    [self initConsoleTextView];
    [self initIndicatorView];
    self.searchOptionsTextField.delegate = self;
    self.deleteOptionsTextField.delegate = self;
    self.unusedOptionsTextField.delegate = self;
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

#pragma mark--Private Methods--
- (void)initSearchOptionsCheckButton{
    for (id obj in self.searchOptionsView.subviews) {
        if ([obj isKindOfClass:[NSButton class]]) {
            NSButton *checkButton = (NSButton *)obj;
            [checkButton setTarget:self];
            [checkButton setAction:@selector(searchOptionsCheckButtonAction:)];
        }
    }
}

- (void)initDeleteOptionsCheckButton{
    for (id obj in self.deleteOptionsView.subviews) {
        if ([obj isKindOfClass:[NSButton class]]) {
            NSButton *checkButton = (NSButton *)obj;
            [checkButton setTarget:self];
            [checkButton setAction:@selector(deleteOptionsCheckButtonAction:)];
        }
    }
}

- (void)initUnusedOptionsCheckButton{
    for (id obj in self.unusedOptionsView.subviews) {
        if ([obj isKindOfClass:[NSButton class]]) {
            NSButton *checkButton = (NSButton *)obj;
            [checkButton setTarget:self];
            [checkButton setAction:@selector(unusedOptionsCheckButtonAction:)];
        }
    }
}

- (void)initConsoleLogCheckButton{
    [self.exportCheckButton setTarget:self];
    [self.exportCheckButton setAction:@selector(exportLogCheckButtonAction:)];
}

- (void)initConsoleTextView{
    self.consoleLogTextView.delegate = self;
    self.consoleLogTextView.string  = @"hello world";
}

- (void)initIndicatorView{
    
}

#pragma mark--Delegates & Actions--
- (BOOL)control:(NSControl *)control textShouldBeginEditing:(NSText *)fieldEditor{
    if (control.tag == kSearchOptionsTextFieldTag) {
        [self.searchOptionsView userinteractionEnabled];
    }
    return YES;
}

- (BOOL)control:(NSControl *)control textShouldEndEditing:(NSText *)fieldEditor{
    if (control.tag == kDeleteOptionsTextFieldTag && fieldEditor.string.length) {
        [self.deleteOptionsView userinteractionDisabled];
    }else if (control.tag == kDeleteOptionsTextFieldTag && !fieldEditor.string.length){
        [self.deleteOptionsView userinteractionEnabled];
    }
    
    if (control.tag == kUnusedOptionsTextFieldTag && fieldEditor.string.length) {
        [self.unusedOptionsView userinteractionDisabled];
    }else if (control.tag == kUnusedOptionsTextFieldTag && !fieldEditor.string.length){
        [self.unusedOptionsView userinteractionEnabled];
    }
    
    return YES;
}

- (BOOL)textView:(NSTextView *)textView clickedOnLink:(id)link atIndex:(NSUInteger)charIndex{
    return YES;
}

- (void)textView:(NSTextView *)textView clickedOnCell:(id <NSTextAttachmentCell>)cell inRect:(NSRect)cellFrame atIndex:(NSUInteger)charIndex{
    
}

- (BOOL)textView:(NSTextView *)textView shouldChangeTextInRange:(NSRange)affectedCharRange replacementString:(nullable NSString *)replacementString{
    return YES;
}

- (IBAction)deleteAction:(id)sender {
    if(self.searchOptionsTextField.stringValue.length){
        [self.searchOptionsView userinteractionDisabled];
    }
}

- (IBAction)searchAction:(id)sender {
    
}

- (void)searchOptionsCheckButtonAction:(NSButton *)button{
    if (button.tag == kSearchOptionCheckButtonTag && button.state) {
        for (id obj in self.searchOptionsView.subviews) {
            if ([obj isKindOfClass:[NSButton class]]) {
                NSButton *button = (NSButton *)obj;
                button.state = 1;
            }
        }
    }else if(button.tag != kSearchOptionCheckButtonTag && !button.state){
        self.searchCheckButton.state = 0;
    }
}

- (void)deleteOptionsCheckButtonAction:(NSButton *)button{
    if (button.tag == kDeleteOptionCheckButtonTag && button.state) {
        for (id obj in self.deleteOptionsView.subviews) {
            if ([obj isKindOfClass:[NSButton class]]) {
                NSButton *button = (NSButton *)obj;
                button.state = 1;
            }
        }
    }else if(button.tag != kDeleteOptionCheckButtonTag && !button.state){
        self.deleteCheckButton.state = 0;
    }
}

- (void)unusedOptionsCheckButtonAction:(NSButton *)button{
    if (button.tag == kUnusedOptionCheckButtonTag && button.state) {
        for (id obj in self.unusedOptionsView.subviews) {
            if ([obj isKindOfClass:[NSButton class]]) {
                NSButton *button = (NSButton *)obj;
                button.state = 1;
            }
        }
    }else if(button.tag != kUnusedOptionCheckButtonTag && !button.state){
        self.unusedCheckButton.state = 0;
    }
}

- (void)exportLogCheckButtonAction:(NSButton *)button{
    /*export log.txt to Desktop*/
    
}

#pragma mark--Getters & Setters--
- (PCMainTableViewDelegate *)tableViewDelegate{
    if (!_tableViewDelegate) {
        _tableViewDelegate = [PCMainTableViewDelegate new];
    }
    return _tableViewDelegate;
}
@end
