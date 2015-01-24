//
//  ARAutoresizeTableView.m
//  ARTableView
//
//  Created by Anton Remizov on 1/11/15.
//  Copyright (c) 2015 froggyproggy. All rights reserved.
//

#import "ARAutoresizeTableView.h"
#import "ARDelegateProxy.h"
#import "ARAutoresizeTableCellView.h"

@interface ARAutoresizeTableView () <ARAutoresizeTableCellViewDelegate>
{
    NSMutableArray* heights;
}

@property (strong) ARDelegateProxy* deleagteProxy;
@property (strong) ARDelegateProxy* dataSourceProxy;

@end

@implementation ARAutoresizeTableView

- (void)setDelegate:(id<NSTableViewDelegate>)delegate
{
    self.deleagteProxy   = [ARDelegateProxy new];
    self.deleagteProxy->_breakingDelegate     = self;
    self.deleagteProxy->_originalDelegate = delegate;
    [super setDelegate:self.deleagteProxy];
}

- (void)setDataSource:(id<NSTableViewDataSource>)aSource
{
    self.dataSourceProxy = [ARDelegateProxy new];
    self.dataSourceProxy->_breakingDelegate   = self;
    self.dataSourceProxy->_originalDelegate = aSource;
    [super setDataSource:self.dataSourceProxy];
}

- (NSView*) tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    ARAutoresizeTableCellView* cellView = (ARAutoresizeTableCellView*)
                [self.dataSourceProxy->_originalDelegate tableView:tableView
                                              viewForTableColumn:tableColumn
                                                             row:row];
    if (![cellView isKindOfClass:[ARAutoresizeTableCellView class]]) {
        @throw [NSException exceptionWithName:@"ARTableView Cell Exception"
                                       reason:@"Cell should be a subclass of ARAutoresizeTableCellView"
                                     userInfo:nil];
    }

    cellView.delegate = self;
    return cellView;
}

- (void) initHeights
{
    NSInteger rows = [self.dataSource numberOfRowsInTableView:self];
    heights = [NSMutableArray arrayWithCapacity:rows];
    for (int i = 0; i < rows; ++i) {
        [heights addObject:[NSNull null]];
    }
}

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row
{
    CGFloat staticHeight = ARAutoresizeTableViewCellHeightAuto;
    if ([self.dataSourceProxy->_originalDelegate respondsToSelector:@selector(tableView:heightOfRow:)]) {
        staticHeight = [self.dataSourceProxy->_originalDelegate tableView:tableView
                                               heightOfRow:row];
    }
    if (staticHeight >= 0) {
        return staticHeight;
    }
    
    if (!heights) {
        [self initHeights];
    }
    if (heights[row] != [NSNull null]) {
        float height = [heights[row] floatValue];
        return (height <= 0)?20:height;
    }
    return 100;
}

- (void) cell:(ARAutoresizeTableCellView*)cell shouldChangeToHeight:(CGFloat)height
{
    NSInteger row = [self rowForView:cell];
    if (row < 0) {
        return;
    }
    NSNumber* number = heights[row];
    if (number == (id)[NSNull null] || [number floatValue] != height) {
        heights[row] = @(height);
        [self noteHeightOfRowsWithIndexesChanged:[NSIndexSet indexSetWithIndex:row]];
    }
}

- (void)reloadData {
    [self initHeights];
    [super reloadData];
}
@end
