//
//  EditableTextCell.h
//  ARTableView
//
//  Created by Anton Remizov on 1/13/15.
//  Copyright (c) 2015 froggyproggy. All rights reserved.
//

#import "ARAutoresizeTableCellView.h"

@interface EditableTextCell : ARAutoresizeTableCellView

@property (weak) IBOutlet NSTextField* textField;

@end
