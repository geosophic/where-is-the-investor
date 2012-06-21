//
//  SettingsViewController.h
//  monkey
//
//  Created by Yeray Callero on 15/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController <UITextFieldDelegate> {
    UITextField *companyNameLabel;
}

@property (retain, nonatomic) IBOutlet UITextField *companyNameLabel;
@property (retain, nonatomic) IBOutlet UISwitch *serviceStatus;
@property (retain, nonatomic) IBOutlet UIButton *returnButton;
@end
