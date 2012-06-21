//
//  CrashViewController.m
//  Find the investor
//
//  Created by Yeray Callero on 12/06/12.
//  Copyright (c) 2012 Geosophic Ltd. All rights reserved.
//

#import "CrashViewController.h"

@interface CrashViewController ()

@end

@implementation CrashViewController
@synthesize titleText;
@synthesize crashImage;
@synthesize messageText;
@synthesize closeButton;

int cash;
double equity;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithCash:(int) currentCash withEquity:(double) currentEquity
{
    cash = currentCash;
    equity = currentEquity;
    return [self initWithNibName:@"CrashViewController" bundle:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle];
    [self setImage];
    [self setMessage];
    // Do any additional setup after loading the view from its nib.
}

- (void) setTitle 
{
    [titleText setText:@"You run out of money!!!"];
}

- (void) setImage
{
    [crashImage setImage:[UIImage imageNamed:@"techie_Serif"]];
}

- (void) setMessage 
{
    [messageText setText:@"You lost your company. Take your things and leave the building."];
}

- (IBAction)closeAction:(id)sender
{
    [[UIApplication sharedApplication].keyWindow.rootViewController dismissModalViewControllerAnimated:TRUE];
}

- (void)viewDidUnload
{
    [self setTitleText:nil];
    [self setCrashImage:nil];
    [self setMessageText:nil];
    [self setCloseButton:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [titleText release];
    [crashImage release];
    [messageText release];
    [closeButton release];
    [super dealloc];
}
@end
