//
//  ResultsViewController.h
//  Find the investor
//
//  Created by Yeray Callero on 12/06/12.
//  Copyright (c) 2012 Geosophic Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AUIAnimatableLabel.h"

@interface ResultsViewController : UIViewController

@property (retain, nonatomic) IBOutlet UITextField *cashText;
@property (retain, nonatomic) IBOutlet UITextField *equityText;
@property (retain, nonatomic) IBOutlet UITextField *pointText;
@property (retain, nonatomic) IBOutlet UILabel *highscoreLabel;

-(IBAction)closeAction:(id)sender;
- (id) initWithCash:(int) finalCash withEquity:(double) finalEquity;

@end
