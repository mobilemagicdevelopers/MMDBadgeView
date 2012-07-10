//
//  MMDViewController.m
//  MMDBadgeViewDemo
//
//  Created by Douglas Patrick Caldwell on 7/9/12.
//  Copyright (c) 2012 Mobile Magic Developers, LLC. All rights reserved.
//

#import "MMDViewController.h"

@interface MMDViewController ()
@property (nonatomic, strong) NSMutableArray *colorArray;
-(void)cycleBackgroundColor;
@end

@implementation MMDViewController
@synthesize backgroundColorBadgeView;
@synthesize colorArray = _colorArray;

-(NSMutableArray *)colorArray
{
    if (!_colorArray)
    {
        NSMutableArray *colors = [NSMutableArray arrayWithObjects:
                                  UIColor.orangeColor,
                                  UIColor.yellowColor,
                                  UIColor.greenColor,
                                  UIColor.blueColor,
                                  [UIColor colorWithRed:75.0 / 255 green:0 blue:130.0 / 255 alpha:1],
                                  [UIColor colorWithRed:127.0 / 255 green:0 blue:1 alpha:1],
                                  nil];
        
        _colorArray = colors;
    }
    
    return _colorArray;
}

- (void)viewDidLoad
{
    self.backgroundColorBadgeView.backgroundColor = UIColor.redColor;
    [self cycleBackgroundColor];
    [super viewDidLoad];
}

- (void)cycleBackgroundColor
{
    [self.colorArray addObject:self.backgroundColorBadgeView.backgroundColor];
    self.backgroundColorBadgeView.backgroundColor = [self.colorArray objectAtIndex:0];
    [self.colorArray removeObjectAtIndex:0];
    
    [self performSelector:@selector(cycleBackgroundColor) withObject:nil afterDelay:1];
}

- (void)viewDidUnload
{
    [self setBackgroundColorBadgeView:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
