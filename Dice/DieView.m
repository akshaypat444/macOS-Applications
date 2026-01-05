//
//  DieView.m
//  Dice
//
//  Created by AKSHAY PATEL on 1/3/26.
//

#import "DieView.h"

@implementation DieView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
        if (self) {
            _intValue = 4;
        }
        return self;
}

- (void)setIntValue:(NSInteger)intValue
{
    _intValue = intValue;
    [self setNeedsDisplay:YES];
}

- (NSSize)intrinsicContentSize
{
    return NSMakeSize(20, 20);
}

// dirtyRect is a rectangle which needs to be drawn
// it's like WM_PAINT
- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
    
    NSColor *backgroundColor = [NSColor lightGrayColor];
    [backgroundColor set];
    [NSBezierPath fillRect:[self bounds]];
    
    [self drawDieWithSize:[self bounds].size];
}

- (void)metricsFromSize:(CGSize)size
             edgeLength:(CGFloat *)length
               dieFrame:(CGRect *)frame
{
    *length = MIN(size.width, size.height);
    CGFloat padding = *length/10.0;
    CGRect drawingBounds = CGRectMake(0, 0, *length, *length);
    *frame = CGRectInset(drawingBounds, padding, padding);
}

- (void)drawDieWithSize:(CGSize)size
{
    CGFloat edgeLength;
    CGRect dieFrame;
    
    if (self.intValue)
    {
        [self metricsFromSize:size edgeLength:&edgeLength dieFrame:&dieFrame];
        
        CGFloat cornerRadius = edgeLength / 5.0;
        CGFloat dotRadius = edgeLength / 12.0;
        CGRect dotFrame = CGRectInset(dieFrame,
                                      dotRadius * 2.5,
                                      dotRadius * 2.5);
        
        // Save the graphics context so that shadow is applicable only to die
        // and not die circle
        [NSGraphicsContext saveGraphicsState];
            NSShadow *shadow = [[NSShadow alloc] init];
            [shadow setShadowOffset:NSMakeSize(0, -1)];
            [shadow setShadowBlurRadius:edgeLength/20];
            [shadow set];
        [NSGraphicsContext restoreGraphicsState];
        
        // Draw rounded shape of die profile
        [[NSColor whiteColor] set];
        [[NSBezierPath bezierPathWithRoundedRect:dieFrame
                                         xRadius:cornerRadius
                                         yRadius:cornerRadius] fill];
        
        // Draw the dots
        [[NSColor blackColor] set];
        
        void (^drawDot)(CGFloat, CGFloat) = ^(CGFloat u, CGFloat v){
            CGPoint dotOrigin = CGPointMake(
                dotFrame.origin.x + dotFrame.size.width * u,
                dotFrame.origin.y + dotFrame.size.height * v);
            
            CGRect dotRect = CGRectMake(dotOrigin.x, dotOrigin.y, 0, 0);
            dotRect = CGRectInset(dotRect, -dotRadius, -dotRadius);
            
            NSBezierPath *path = [NSBezierPath bezierPathWithOvalInRect:dotRect];
            [path fill];
        };
        
        if (_intValue >= 1 && _intValue <= 6)
        {
            if (_intValue == 1 || _intValue == 3 || _intValue == 5)
            {
                drawDot(0.5, 0.5);
            }
            
            if (_intValue >= 2 && _intValue <= 6)
            {
                drawDot(0, 1);
                drawDot(1, 0);
            }
            
            if (_intValue >= 4 && _intValue <= 6)
            {
                drawDot(1, 1);
                drawDot(0, 0);
            }
            
            if (_intValue == 6)
            {
                drawDot(0, 0.5);
                drawDot(1, 0.5);
            }
        }
        
    }
}


@end
