//
//  CustomerViewController.h
//  monkey
//
//  Created by Yeray Callero on 12/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomerViewController : UIViewController

@property (retain, nonatomic) IBOutlet UILabel *titleText;
@property (retain, nonatomic) IBOutlet UIImageView *customerImage;
@property (retain, nonatomic) IBOutlet UILabel *messageText;
@property (retain, nonatomic) IBOutlet UIButton *continueButton;
@property (retain, nonatomic) IBOutlet UITextField *currentCashField;
@property (retain, nonatomic) IBOutlet UITextField *currentEquityField;

-(IBAction)closeAction:(id)sender;
- (id) initWithStage:(int) stage withFunds:(NSNumber*) funds withCurrentCash:(int) currentCash withCurrentEquity:(double) currentEquity;

@end
