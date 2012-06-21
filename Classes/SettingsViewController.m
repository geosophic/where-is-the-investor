//
//  SettingsViewController.m
//  monkey
//
//  Created by Yeray Callero on 15/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SettingsViewController.h"
#import "SettingsStatus.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController
@synthesize companyNameLabel;
@synthesize serviceStatus;
@synthesize returnButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    //[SettingsStatus setCompanyName:[textField text]];
    return TRUE;
}

- (void) textFieldDidEndEditing:(UITextField *)textField
{
    [SettingsStatus setCompanyName:[NSString stringWithFormat:@"%@",[companyNameLabel text]]]; 
    [SettingsStatus setCompanyName:[NSString stringWithFormat:@"%@",[companyNameLabel text]]]; 
}

- (void)viewDidLoad
{
    companyNameLabel.delegate = self;
    [companyNameLabel setText:[SettingsStatus getCompanyName]];
    [serviceStatus setOn:[SettingsStatus isGeosophicServiceEnabled]];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setCompanyNameLabel:nil];
    [self setServiceStatus:nil];
    [self setReturnButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)companyNameChanged:(id)sender
{
}

- (IBAction)serviceStatusChange:(id)sender
{
    bool status = serviceStatus.on; 
    
    if (status) {
        NSString* companyName = [companyNameLabel text];
        if (companyName.length == 0) {
            UIAlertView *alertView = [[[UIAlertView alloc] initWithTitle:@"Your company name" message:@"Your company needs a name to use in it Geosophic service." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
                [alertView show];    
            [serviceStatus setOn:FALSE];
        } else {
            [SettingsStatus setGeosophicServiceStatus:status];
        }
    } else {
        [SettingsStatus setGeosophicServiceStatus:status];
    }
}


- (void)alertView:(UIAlertView*)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{

}

- (IBAction)returnToGame:(id)sender
{
    [self dismissModalViewControllerAnimated:TRUE];
}

- (void)dealloc {
    [companyNameLabel release];
    [serviceStatus release];
    [returnButton release];
    [super dealloc];
}
@end
