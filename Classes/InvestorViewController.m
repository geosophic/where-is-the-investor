//
//  InvestorViewController.m
//  monkey
//
//  Created by Yeray Callero on 11/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "InvestorViewController.h"
#import "ResultsViewController.h"
#import "CrashViewController.h"

#define MAX_IMAGE_WIDTH 200

@interface InvestorViewController ()

@end

@implementation InvestorViewController

@synthesize titleText;
@synthesize commentText;
@synthesize continueButton;
@synthesize centralImage;
@synthesize cashLabel;
@synthesize equityLabel;

int currentStage;
int investorType;
int investorFunds;
int currentCash;
double investorEquity;
double currentEquity;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

-(id) initWithStage:(int) stage withInvestor:(NSNumber*) investor withFunds:(NSNumber*) funds withEquity:(NSNumber*) equity withTotalCash:(int) totalCash withTotalEquity:(double) totalEquity
{
    investorType = [investor intValue];
    investorFunds = [funds intValue];
    investorEquity = [equity doubleValue];
    currentStage = stage;
    currentCash = totalCash;
    currentEquity = totalEquity;
    NSLog(@"Init with investor %d %d %d %f", currentStage, investorType, investorFunds, investorEquity);
    return [self initWithNibName:@"InvestorViewController" bundle:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle];
    [self setImage];
    [self setMessage];
    [self setButtonText];
    [cashLabel setText:[NSString stringWithFormat:@"%d $", currentCash]];
    [equityLabel setText:[NSString stringWithFormat:@"%.3f %%", currentEquity]];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setTitleText:nil];
    [self setCommentText:nil];
    [self setContinueButton:nil];
    [self setCentralImage:nil];
    [self setCashLabel:nil];
    [self setEquityLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)continueAction:(id)sender
{
    if (currentStage == 5) {
        if (currentEquity <= 0) {
            CrashViewController* crashView = [[CrashViewController alloc] initWithCash:currentCash withEquity:currentEquity];
            [self.view addSubview:crashView.view];
        } else {
            ResultsViewController* resultsView = [[ResultsViewController alloc] initWithCash:currentCash withEquity:currentEquity];
            [self.view addSubview:resultsView.view];
        }
    } else
        [self dismissModalViewControllerAnimated:TRUE];
}

-(void) setTitle
{
    switch (investorType) {
        case SHARK:
            [titleText setText:@"You find a shark investor!!!"];
            break;
        case ANGEL:
            [titleText setText:@"You find an investor!!!"];
            break;
        default:
            break;
    }   
}

-(void) setImage
{
    switch (investorType) {
        case SHARK:
            [centralImage setImage:[UIImage imageNamed:@"newbie_shark"]];
            break;
        case ANGEL:
            [centralImage setImage:[UIImage imageNamed:@"newbie_bird"]];            
            break;
        default:
            break;
    }
}

-(void) setMessage
{
    [commentText setText:[NSString stringWithFormat:@"Your company gets %d $ of funding for %.3f %% of your equity", investorFunds, investorEquity]];
}

-(void) setButtonText
{
    switch (currentStage) {
        case 1:
            [continueButton setTitle:@"Continue to Seed" forState:UIControlStateNormal];
            break;
        case 2:
            [continueButton setTitle:@"Continue to Series A" forState:UIControlStateNormal];
            break;   
        case 3:
            [continueButton setTitle:@"Continue to Series B" forState:UIControlStateNormal];
            break;
        case 4:
            [continueButton setTitle:@"Continue to IPO" forState:UIControlStateNormal];
            break;
        case 5:
            [continueButton setTitle:@"View final results" forState:UIControlStateNormal];
            break;
        default:
            break;
    }
}

- (void)dealloc {
    [titleText release];
    [commentText release];
    [continueButton release];
    [centralImage release];
    [cashLabel release];
    [equityLabel release];
    [super dealloc];
}
@end
