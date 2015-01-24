//
//  TableViewController.m
//  ARTableView
//
//  Created by Anton Remizov on 1/11/15.
//  Copyright (c) 2015 froggyproggy. All rights reserved.
//

#import "TableViewController.h"
#import "ARAutoresizeTableView.h"

@interface TableViewController() <ARAutoresizeTableCellViewDelegate>
{
}

@end

@implementation TableViewController

- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView
{
    NSInteger rows = 4;
    return rows;
}

- (NSView*) tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    ARAutoresizeTableCellView* cellView = [tableView makeViewWithIdentifier:@"customCell" owner:self];
    return cellView;
}

- (CGFloat) tableView:(NSTableView *)tableView  heightOfRow:(NSInteger)row
{
    if (row == 2) {
        return 60;
    }
    return ARAutoresizeTableViewCellHeightAuto;
}

@end
