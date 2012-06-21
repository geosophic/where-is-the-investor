//
//  SettingsViewController.h
//  Find the investor
//
//  Created by Yeray Callero on 12/06/12.
//  Copyright (c) 2012 Geosophic Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController <UITextFieldDelegate> {
    UITextField *companyNameLabel;
}

@property (retain, nonatomic) IBOutlet UITextField *companyNameLabel;
@property (retain, nonatomic) IBOutlet UISwitch *serviceStatus;
@property (retain, nonatomic) IBOutlet UIButton *returnButton;
@end
