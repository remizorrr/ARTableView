//
//  ColorView.m
//  Light RSS
//
//  Created by Anton Remizov on 1/19/13.
//  Copyright (c) 2013 Anton Remizov. All rights reserved.
//

#import "ColorView.h"

@implementation ColorView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    // Clear the drawing rect.
    [[NSColor clearColor] set];
    NSRectFill([self frame]);
    
    [[NSColor clearColor] set];
    [NSBezierPath fillRect:[self bounds]];
    
    [self.color?:[NSColor whiteColor] set];
    if (self.roundedRect)
        [[NSBezierPath bezierPathWithRoundedRect:[self bounds] xRadius:5 yRadius:5] fill];
    else
        [NSBezierPath fillRect:[self bounds]];
}

@end
