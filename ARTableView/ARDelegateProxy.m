//
//  ARDelegateProxy.m
//  ARTableView
//
//  Created by Anton Remizov on 01/10/15.
//  Copyright (c) 2015 froggyproggy. All rights reserved.
//

#import "ARDelegateProxy.h"

@implementation ARDelegateProxy

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel
{
    NSMethodSignature *sig = [self->_breakingDelegate methodSignatureForSelector:sel];
    if(!sig)
    {
        sig = [self->_originalDelegate methodSignatureForSelector:sel];
    }
    return sig;
}

- (void)forwardInvocation:(NSInvocation *)inv
{
    if ([self->_breakingDelegate respondsToSelector:inv.selector])
        [inv invokeWithTarget:self->_breakingDelegate];
    else if ([self->_originalDelegate respondsToSelector:inv.selector])
        [inv invokeWithTarget:self->_originalDelegate];
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
    return
    [self->_originalDelegate respondsToSelector:aSelector] ||
    [self->_breakingDelegate respondsToSelector:aSelector];
}
@end