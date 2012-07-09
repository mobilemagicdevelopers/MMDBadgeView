//
//  MMDViewController.m
//  MMDBadgeViewDemo
//
//  Created by Douglas Patrick Caldwell on 7/9/12.
//  Copyright (c) 2012 Mobile Magic Developers, LLC. All rights reserved.
//

#import "MMDViewController.h"

@interface MMDViewController ()

@end

@implementation MMDViewController
@synthesize backgroundColorBadgeView;

- (void)viewDidLoad
{
    self.backgroundColorBadgeView.backgroundColor = UIColor.orangeColor;
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setBackgroundColorBadgeView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
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
