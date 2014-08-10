//
//  ACCESS_Screen_SaverView.m
//  ACCESS Screen Saver
//
//  Created by Alistair McMillan on 10/08/2014.
//  Copyright (c) 2014 Alistair McMillan. All rights reserved.
//

#import "ACCESS_Screen_SaverView.h"

@implementation ACCESS_Screen_SaverView

- (id)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];
    if (self) {
        [self setAnimationTimeInterval:1/30.0];
    }
    return self;
}

- (void)startAnimation
{
    [super startAnimation];
}

- (void)stopAnimation
{
    [super stopAnimation];
}

- (void)drawRect:(NSRect)rect
{
    [super drawRect:rect];
}

- (void)animateOneFrame
{
    return;
}

- (BOOL)hasConfigureSheet
{
    return NO;
}

- (NSWindow*)configureSheet
{
    return nil;
}

@end
