//
//  InvestorViewController.h
//  Find the investor
//
//  Created by Yeray Callero on 12/06/12.
//  Copyright (c) 2012 Geosophic Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InvestorType.h"

@interface InvestorViewController : UIViewController 
{
    IBOutlet UILabel *titleText;
}

@property (retain, nonatomic) IBOutlet UILabel *titleText;
@property (retain, nonatomic) IBOutlet UILabel *commentText;
@property (retain, nonatomic) IBOutlet UIButton *continueButton;
@property (retain, nonatomic) IBOutlet UIImageView *centralImage;
@property (retain, nonatomic) IBOutlet UITextField *cashLabel;
@property (retain, nonatomic) IBOutlet UITextField *equityLabel;

-(IBAction)continueAction:(id)sender;
-(id) initWithStage:(int) stage withInvestor:(NSNumber*) investor withFunds:(NSNumber*) funds withEquity:(NSNumber*) equity withTotalCash:(int) totalCash withTotalEquity:(double) totalEquity;

@end
