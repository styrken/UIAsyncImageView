//
//  ViewController.m
//  UIAsyncImageView
//
//  Created by Rasmus Styrk on 31/08/12.
//  Copyright (c) 2012 Rasmus Styrk. All rights reserved.
//

#import "ViewController.h"
#import "AsyncImageView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void) loadView
{
    [super loadView];
    
    NSString *url = @"https://raw.github.com/styrken/UIAsyncImageView/master/image.jpeg";
    AsyncImageView *image = [[AsyncImageView alloc] initWithUrlString:url
                                                             andFrame:CGRectMake((self.view.frame.size.width / 2) - (239/2), (self.view.frame.size.height / 2)  - (240/2), 239, 240)];
    
    [self.view addSubview:image];
    [image release];
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
