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

- (void)viewDidMoveToWindow {
    excelOpacity = 0.0;
    increasingExcelOpacity = YES;
    communicationOpacity = -4.0;
    increasingCommunicationOpacity = YES;
    innovationOpacity = -3.0;
    increasingInnovationOpacity = NO;
    trustOpacity = 1.0;
    increasingTrustOpacity = NO;
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

- (void)updateOpacity:(BOOL*)increasing opacity:(float*)opacity
{
    if (*opacity > 2.5) {
        *increasing = NO;
    }
    
    if (*opacity < -5.5) {
        *increasing = YES;
    }
    
    if(*increasing) {
        *opacity += 0.1;
    } else {
        *opacity -= 0.1;
    }
}

- (void)drawLogo:(NSString *)imageName
{
    NSRect viewBounds = [self bounds];
    NSImage* foregroundImage = [[NSImage alloc] initWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:imageName ofType:@"png"]];    
    float dstWidth = viewBounds.size.width/4;
    float dstHeight = dstWidth * (foregroundImage.size.height/foregroundImage.size.width);
    NSRect destRect = NSMakeRect(
                          viewBounds.size.width-dstWidth-(viewBounds.size.height/20),
                          viewBounds.size.height-dstHeight-(viewBounds.size.height/20),
                          dstWidth,
                          dstHeight
                          );
    [foregroundImage drawInRect:destRect
                       fromRect:NSMakeRect( 0, 0, [foregroundImage size].width, [foregroundImage size].height )
                      operation:NSCompositeSourceOver
                       fraction:1.0];
}

- (void)drawOverlay:(NSString *)imageName withRatio:(float *)ratio withOpacity:(float *)opacity
{
    NSRect viewBounds = [self bounds];
    NSImage* foregroundImage = [[NSImage alloc] initWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:imageName ofType:@"png"]];
    float dstWidth = foregroundImage.size.width * *ratio * 0.6;
    float dstHeight = foregroundImage.size.height * *ratio * 0.6;
    NSRect destRect = NSMakeRect((viewBounds.size.width/2)-(dstWidth/2), (viewBounds.size.height/2)-(dstHeight/2), dstWidth, dstHeight );
    [foregroundImage drawInRect:destRect
                       fromRect:NSMakeRect( 0, 0, [foregroundImage size].width, [foregroundImage size].height )
                      operation:NSCompositeSourceOver
                       fraction:*opacity];
}

- (void)animateOneFrame
{
    NSRect viewBounds = [self bounds];
    NSString* backgroundImageName = [[NSBundle bundleForClass:[self class]] pathForResource:@"ACCESS" ofType:@"png"];
    NSImage* backgroundImage = [[NSImage alloc] initWithContentsOfFile:backgroundImageName];
    NSSize backgroundImageSize = [backgroundImage size];
    NSRect backgroundImageRect = NSMakeRect( 0, 0, backgroundImageSize.width, backgroundImageSize.height );
    [backgroundImage drawInRect:viewBounds fromRect:backgroundImageRect operation:NSCompositeCopy fraction:1.0];
    
    [self updateOpacity:&increasingCommunicationOpacity opacity:&communicationOpacity];
    [self updateOpacity:&increasingExcelOpacity opacity:&excelOpacity];
    [self updateOpacity:&increasingInnovationOpacity opacity:&innovationOpacity];
    [self updateOpacity:&increasingTrustOpacity opacity:&trustOpacity];

    float ratio;
    ratio = viewBounds.size.width / backgroundImage.size.width;
    
    [self drawLogo:@"ACCESS deliver - clear"];

    [self drawOverlay:@"excel - clear" withRatio:&ratio withOpacity:&excelOpacity];
    [self drawOverlay:@"communication - clear" withRatio:&ratio withOpacity:&communicationOpacity];
    [self drawOverlay:@"innovation - clear" withRatio:&ratio withOpacity:&innovationOpacity];
    [self drawOverlay:@"trust - clear" withRatio:&ratio withOpacity:&trustOpacity];
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
