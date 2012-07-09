//
//  MMDBadgeView.m
//
//  Created by Douglas Patrick Caldwell on 1/28/12.
//  Copyright (c) 2012 Mobile Magic Developers, LLC. All rights reserved.
//

#import "MMDBadgeView.h"

#define degreesToRadians(degrees) M_PI * degrees / 180.0

@interface MMDBadgeView()
@property (nonatomic, readonly) CGRect textFrame;
@property (nonatomic, strong) UIColor *backgroundColorSetting;

+(CGMutablePathRef)newPathForRoundedRectInBounds:(CGRect)rect;
@end

@implementation MMDBadgeView
@synthesize backgroundColorSetting;

-(CGRect)textFrame
{
    CGSize textSize = [self.text sizeWithFont:self.font];
    CGPoint textFrameOrigin = CGPointMake(self.frame.origin.x + .5 * (self.frame.size.width - textSize.width), self.frame.origin.y);
    CGRect textFrame = CGRectMake(textFrameOrigin.x, textFrameOrigin.y, textSize.width, self.frame.size.height);
    return textFrame;
}

-(UIColor *)backgroundColor
{
    if (!self.backgroundColorSetting)
        return UIColor.redColor;
    
    return self.backgroundColorSetting;
}

-(void)setBackgroundColor:(UIColor *)backgroundColor
{
    self.backgroundColorSetting = backgroundColor;
}

-(void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();

    [self.backgroundColor setFill];
    [UIColor.whiteColor setStroke];
    
    float strokeSize = rect.size.height * .1;
    CGContextSetLineWidth(context, strokeSize);
    CGSize textSize = [self.text sizeWithFont:self.font];
    
    // pad the text with a quarter of the height on each side . . . if that would be thinner
    // than a circle, make it a circle
    float drawWidth = MAX(textSize.width + rect.size.height / 2.0, rect.size.height);
    
    // inset the draw width for the stroke
    CGRect insetRect = CGRectInset(rect, (rect.size.width - drawWidth + strokeSize) / 2.0, strokeSize / 2.0);
    
    CGMutablePathRef drawPath = [self.class newPathForRoundedRectInBounds:insetRect];

    CGContextAddPath(context, drawPath);
    CGContextFillPath(context);

    // clip to fill area
    CGContextSaveGState(context);
    CGContextAddPath(context, drawPath);
    CGContextClip(context);

    // gradient over fill area
    UIColor* white =[[UIColor whiteColor] colorWithAlphaComponent:.4];
    UIColor* black = [[UIColor blackColor] colorWithAlphaComponent:.4];
    NSArray* colors = [NSArray arrayWithObjects:(id)white.CGColor, (id)black.CGColor, nil];
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)colors, NULL);
    
    CGContextDrawLinearGradient(UIGraphicsGetCurrentContext(), gradient, CGPointZero, CGPointMake(0, rect.size.height), 0);
    
    CGColorSpaceRelease(colorSpace);
    CGGradientRelease(gradient);

    [super drawRect:rect];

    // draw glare
    CGContextSaveGState(context);
    [[[UIColor whiteColor] colorWithAlphaComponent:.3] setFill];
    CGAffineTransform translation = CGAffineTransformMakeTranslation(0, insetRect.size.height * -.55);
    CGRect glareRect = CGRectApplyAffineTransform(insetRect, translation);
    glareRect = CGRectInset(glareRect, -10, 0);
    CGContextFillEllipseInRect(context, glareRect);
    CGContextRestoreGState(context);
    
    // unclip
    CGContextRestoreGState(context);
    
    CGContextAddPath(context, drawPath);
    CGContextStrokePath(context);
    
    CGPathRelease(drawPath);
}

+(CGMutablePathRef)newPathForRoundedRectInBounds:(CGRect)rect
{
    float radius = rect.size.height / 2.0;
    CGMutablePathRef path = CGPathCreateMutable();
    
    float minY = CGRectGetMinY(rect);
    float minX = CGRectGetMinX(rect);
    float maxX = CGRectGetMaxX(rect);
    float midY = CGRectGetMidY(rect);
    
    CGPathMoveToPoint(path, nil, minX + radius, minY);
    CGPathAddArc(path, nil, maxX - radius, midY, radius, degreesToRadians(270), degreesToRadians(90), NO);
    CGPathAddArc(path, nil, minX + radius, midY, radius, degreesToRadians(90), degreesToRadians(270), NO);
    CGPathCloseSubpath(path);
    
    return path;
}

@end
