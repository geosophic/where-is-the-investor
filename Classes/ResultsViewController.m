//
//  ResultsViewController.m
//  monkey
//
//  Created by Yeray Callero on 12/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ResultsViewController.h"
#import "GeosophicServiceController.h"
#import "SettingsStatus.h"
#import "GeosophicServiceUserIdentification.h"
#import "Geosophic_ScoreResponse.h"
#import "Geosophic_Leaderboard.h"

#define kBackGroudQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

@interface ResultsViewController ()

@end

@implementation ResultsViewController
@synthesize cashText;
@synthesize equityText;
@synthesize pointText;
@synthesize highscoreLabel;

int cash;
double equity;
int points;
NSString* companyName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id) initWithCash:(int) finalCash withEquity:(double) finalEquity
{
    cash = finalCash;
    equity = finalEquity;
    points = [[NSNumber numberWithDouble:((double)cash * equity * 0.01)]intValue];
    return [self initWithNibName:@"ResultsViewController" bundle:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [equityText setText:[NSString stringWithFormat:@"%.3f %%", equity]];
    [cashText setText:[NSString stringWithFormat:@"%d $", cash]];
    [pointText setText:[NSString stringWithFormat:@"%d points", points]];
    if ([SettingsStatus isGeosophicServiceEnabled]) {
        dispatch_async(kBackGroudQueue, ^{
            [self performSelectorOnMainThread:@selector(updateHighscoreLabel:) 
                                   withObject:@"Uploading score ..." waitUntilDone:NO];
            [self performSelectorOnMainThread:@selector(updateCompanyName:) 
                                   withObject:nil waitUntilDone:YES];
            NSError* error = nil;
            Geosophic_ScoreResponse* scoreResponse = [GeosophicServiceController postScore:points withNickname:companyName inLeaderboard:bestEntrepreneurLeaderboardId error:&error];
            BOOL highscore;
            int leaderboardId;
            if (!error) {
                highscore = [scoreResponse isHighscore];
                if (highscore)
                    [self performSelectorOnMainThread:@selector(updateHighscoreLabel:) 
                                       withObject:@"NEW HIGHSCORE!!!!" waitUntilDone:NO];
                else 
                    [self performSelectorOnMainThread:@selector(updateHighscoreLabel:) 
                                       withObject:@"Score uploaded." waitUntilDone:NO];
                leaderboardId = [scoreResponse getLeaderboardId];
                Geosophic_Leaderboard* leaderboard = [GeosophicServiceController getLeaderboardById:leaderboardId withOffset:0 withNumberOfScores:10 error:&error];
                NSLog(@"After send score recieves %@", [leaderboard getScores]);
                
            }
        });
    }
    // Do any additional setup after loading the view from its nib.
}

- (void) updateHighscoreLabel:(NSString*) text
{
    [UIView animateWithDuration:1.0 animations:^{
        highscoreLabel.text = text;
    }];   
}

- (void) updateCompanyName:(NSString*) text
{
   companyName = [SettingsStatus getCompanyName];
    NSLog(@"Company name: %@", companyName);
}

- (void)viewDidUnload
{
    [self setCashText:nil];
    [self setEquityText:nil];
    [self setPointText:nil];
    [self setHighscoreLabel:nil];
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
    [[UIApplication sharedApplication].keyWindow.rootViewController dismissModalViewControllerAnimated:TRUE];
}

- (void)dealloc {
    [cashText release];
    [equityText release];
    [pointText release];
    [highscoreLabel release];
    [super dealloc];
}
@end
