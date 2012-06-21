//
//  gpcAppDelegate.h
//  Find the investor
//
//  Created by Yeray Callero on 12/06/12.
//  Copyright (c) 2012 Geosophic Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class boardViewController;

@interface gpcAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    boardViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet boardViewController *viewController;

@end

