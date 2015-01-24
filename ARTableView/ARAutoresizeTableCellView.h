//
//  ARAutoresizeTableCellView.h
//  ARTableView
//
//  Created by Anton Remizov on 1/11/15.
//  Copyright (c) 2015 froggyproggy. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class ARAutoresizeTableCellView;

@protocol ARAutoresizeTableCellViewDelegate <NSObject>

- (void) cell:(ARAutoresizeTableCellView*)cell shouldChangeToHeight:(CGFloat)height;

@end

@interface ARAutoresizeTableCellView : NSTableCellView

@property (nonatomic, weak) id<ARAutoresizeTableCellViewDelegate> delegate;

@end
