//
//  ARAutoresizeTableCellView.m
//  ARTableView
//
//  Created by Anton Remizov on 1/11/15.
//  Copyright (c) 2015 froggyproggy. All rights reserved.
//

#import "ARAutoresizeTableCellView.h"
#import "ARAutoresizeTableCellContentView.h"

@interface ARAutoresizeTableCellView ()

@property (weak, nonatomic) ARAutoresizeTableCellContentView* innerContent;

@end

@implementation ARAutoresizeTableCellView

- (void)innerInit
{
    NSArray* subviews = [[self subviews] copy];

    if (!subviews.count || self.innerContent) {
        return;
    }
    
    ARAutoresizeTableCellContentView* content = [[ARAutoresizeTableCellContentView alloc] initWithFrame:self.bounds];
        
    NSArray* constraints = [self.constraints copy];
    for (NSView* view in subviews) {
        [content addSubview:view];
    }
    NSMutableArray* newConstraints = [NSMutableArray array];
    for (NSLayoutConstraint* constraint in constraints) {
        id firstItem = (constraint.firstItem == self)?content:constraint.firstItem;
        id secondItem = (constraint.secondItem == self)?content:constraint.secondItem;
        
        NSLayoutConstraint* newConstraint = [NSLayoutConstraint constraintWithItem:firstItem
                                                                         attribute:constraint.firstAttribute
                                                                         relatedBy:constraint.relation
                                                                            toItem:secondItem
                                                                         attribute:constraint.secondAttribute
                                                                        multiplier:constraint.multiplier
                                                                          constant:constraint.constant];
        [newConstraints addObject:newConstraint];
    }
    [content addConstraints:newConstraints];
    [content setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.innerContent = content;
}

- (void)setInnerContent:(ARAutoresizeTableCellContentView *)innerContent
{
    _innerContent = innerContent;
    [self addSubview:_innerContent];
    [self addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[_innerContent]-0-|"
                                             options:0
                                             metrics:nil
                                               views:NSDictionaryOfVariableBindings(_innerContent)]];
    [self addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_innerContent]"
                                             options:0
                                             metrics:nil
                                               views:NSDictionaryOfVariableBindings(_innerContent)]];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self innerInit];
    }
    return self;
}

- (instancetype)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self innerInit];
    }
    return self;
}

- (void)awakeFromNib
{
    [self innerInit];
}

- (void)layout
{
    [super layout];
    [self.delegate cell:self shouldChangeToHeight:self.innerContent.frame.size.height];
}
@end
