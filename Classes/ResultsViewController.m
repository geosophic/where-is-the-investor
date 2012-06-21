//
//  ResultsViewController.m
//  Find the investor
//
//  Created by Yeray Callero on 12/06/12.
//  Copyright (c) 2012 Geosophic Ltd. All rights reserved.
//

#import "ResultsViewController.h"
#import "GeosophicSDK.h"
#import "SettingsStatus.h"

#define kBackGroudQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define bestCompanyLeaderboardId 7

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
            Geosophic_ScoreResponse* scoreResponse = [GeosophicServiceController postScore:points withNickname:companyName inLeaderboard:bestCompanyLeaderboardId error:&error];
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
                [self performSelectorOnMainThread:@selector(updateLastLeaderboardId:) 
                                       withObject:[NSNumber numberWithInt:leaderboardId] waitUntilDone:NO];
            } else {
                [self performSelectorOnMainThread:@selector(updateHighscoreLabel:) 
                                       withObject:@"" waitUntilDone:NO];
                switch (error.code) {
                    case 404:
                        [self performSelectorOnMainThread:@selector(showAlert:) 
                                               withObject:@"There's not available network now. Your score will be updated as soon as posible." waitUntilDone:NO];
                        break;
                        
                    default:
                        [self performSelectorOnMainThread:@selector(showAlert:) 
                                               withObject:@"Something is going wrong in the Geosophic service rigth now. Your score will be updated as soon as posible." waitUntilDone:NO];
                        break;
                }
                
            }
        });
    }
    // Do any additional setup after loading the view from its nib.
}

- (void) showAlert:(NSString*) alertMessage
{
    UIAlertView *alertView = [[[UIAlertView alloc] initWithTitle:@"Geosophic service problem" message:alertMessage delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
    [alertView show];   
}

- (void)alertView:(UIAlertView*)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    
}

- (void) updateHighscoreLabel:(NSString*) text
{
    highscoreLabel.text = text;   
}

- (void) updateCompanyName:(NSString*) text
{
   companyName = [SettingsStatus getCompanyName];
}

- (void) updateLastLeaderboardId:(NSNumber*) id
{
    [SettingsStatus setLastLeaderboardId:[id intValue]];
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

-(IBAction)showHighscores:(id)sender
{
    if ([SettingsStatus isGeosophicServiceEnabled]) {
        int leaderboardId = [SettingsStatus getLastLeaderboardId];
        NSError* error = nil;
        UIViewController* geosophicView;
        geosophicView = [GeosophicServiceController getGeosophicDashboardView:leaderboardId withSchema:bestCompanyLeaderboardId withOffset:0 withNumberOfScores:10 error:&error];
    
        if (error != nil) {
            switch (error.code) {
                case 404:
                    [self showAlert:@"There's not available network now. Try again in a few minutes."];
                    break;
                
                default:
                    [self showAlert:@"Something is going wrong in the Geosophic service rigth now. Try again in a few minutes."];
                    break;
            }
        } else
            [self presentModalViewController:geosophicView animated:TRUE];
    } else {
        [self showAlert:@"Geosophic service is not active. You need to activate it to see the highscores."];
    }
   
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
