//
//  boardViewController.h
//  Find the investor
//
//  Created by Yeray Callero on 12/06/12.
//  Copyright (c) 2012 Geosophic Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "AUIAnimatableLabel.h"

@interface boardViewController : UIViewController<AVAudioPlayerDelegate> {
	NSUInteger hiddenInvestor;
    NSUInteger hiddenCustomer;
	float equity_remaining;
    int cash_remaining;
    int stage;
	AVAudioPlayer *avp;
	AVAudioPlayer *win;
}

@property (retain, nonatomic) IBOutlet UIButton *geosophicButton;
@property (nonatomic, assign) IBOutlet UITextField *timeRemaining;
@property (nonatomic, assign) IBOutlet UILabel *where;
@property (retain, nonatomic) IBOutlet UITextField *cashRemaining;
@property (retain, nonatomic) IBOutlet AUIAnimatableLabel *animatedMessage;

- (void)startGame;
- (void)guess:(id)sender;
- (void)resetGame;
@end

