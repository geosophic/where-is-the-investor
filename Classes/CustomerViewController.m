//
//  CustomerViewController.m
//  monkey
//
//  Created by Yeray Callero on 12/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomerViewController.h"

@interface CustomerViewController ()

@end

@implementation CustomerViewController
@synthesize titleText;
@synthesize customerImage;
@synthesize messageText;
@synthesize continueButton;
@synthesize currentCashField;
@synthesize currentEquityField;

double _ARC4RANDOM_MAX = 0x100000000;
int currentStage;
int customerFund;
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

- (id) initWithStage:(int) stage withFunds:(NSNumber*) funds withCurrentCash:(int) currentCash withCurrentEquity:(double) currentEquity
{
    currentStage = stage;
    customerFund = [funds intValue];
    cash = currentCash;
    equity = currentEquity;
    return [self initWithNibName:@"CustomerViewController" bundle:nil];
}

-(double) rND_0_1
{
    return ((double)arc4random() / _ARC4RANDOM_MAX);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle];
    [self setCustomerImage];
    [self setMessageText];
    [currentCashField setText:[NSString stringWithFormat:@"%d $", cash]];
    [currentEquityField setText:[NSString stringWithFormat:@"%.3f %%", equity]];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setTitleText:nil];
    [self setCustomerImage:nil];
    [self setMessageText:nil];
    [self setContinueButton:nil];
    [self setCurrentCashField:nil];
    [self setCurrentEquityField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(IBAction)closeAction:(id)sender
{
    [self dismissModalViewControllerAnimated:TRUE];
}

-(void) setTitle
{
    [titleText setText:@"Congratulations. You've found a new customer!!!!"];
}

-(void) setCustomerImage
{
    double random = [self rND_0_1];
    double customerValue = random * 4;
    if (customerValue < 1)
        [customerImage setImage:[UIImage imageNamed:@"techie_arsitek"]];
    else
        if (customerValue < 2)
            [customerImage setImage:[UIImage imageNamed:@"techie_artist"]];
        else
            if (customerValue < 3) 
                [customerImage setImage:[UIImage imageNamed:@"techie_sailor"]];
            else
                [customerImage setImage:[UIImage imageNamed:@"citizen_Japan"]];
}

-(void) setMessageText 
{
    [messageText setText:[NSString stringWithFormat:@"You earn %d $", customerFund]];
}

- (void)dealloc {
    [titleText release];
    [customerImage release];
    [messageText release];
    [continueButton release];
    [currentCashField release];
    [currentCashField release];
    [super dealloc];
}
@end
