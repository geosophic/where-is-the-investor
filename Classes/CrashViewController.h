//
//  CrashViewController.h
//  monkey
//
//  Created by Yeray Callero on 12/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CrashViewController : UIViewController

@property (retain, nonatomic) IBOutlet UILabel *titleText;
@property (retain, nonatomic) IBOutlet UIImageView *crashImage;
@property (retain, nonatomic) IBOutlet UILabel *messageText;
@property (retain, nonatomic) IBOutlet UIButton *closeButton;

- (IBAction)closeAction:(id)sender;
- (id)initWithCash:(int) currentCash withEquity:(double) currentEquity;

@end
