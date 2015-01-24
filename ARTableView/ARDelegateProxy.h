//
//  ARDelegateProxy.h
//  ARTableView
//
//  Created by Anton Remizov on 01/10/15.
//  Copyright (c) 2015 froggyproggy. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ARDelegateProxy : NSObject<NSTableViewDelegate, NSTableViewDataSource>
{
    @public
    id _originalDelegate;
    id _breakingDelegate;
}

@property (nonatomic, assign) SEL willNotPassSelector;

@end