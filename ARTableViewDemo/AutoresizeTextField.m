//
//  AutoresizeTextField.m
//  Schedule
//
//  Created by Anton Remizov on 1/3/15.
//  Copyright (c) 2015 froggyproggy. All rights reserved.
//

#import "AutoresizeTextField.h"

@implementation AutoresizeTextField

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
}

-(NSSize)intrinsicContentSize
{
    if ( ![self.cell wraps] ) {
        return [super intrinsicContentSize];
    }
    
    NSRect frame = [self frame];

    NSTextFieldCell* cell = [self cell];
    cell.stringValue = cell.stringValue;
    NSRect bounds = self.bounds;
    bounds.size.height += 100;
    
    NSSize cellSize = [[self cell] cellSizeForBounds:bounds];
    frame.size.height = cellSize.height;
    return frame.size;
}

// you need to invalidate the layout on text change, else it wouldn't grow by changing the text
- (void)textDidChange:(NSNotification *)notification
{
    [super textDidChange:notification];
    [self invalidateIntrinsicContentSize];
}

@end
