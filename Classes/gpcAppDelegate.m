//
//  gpcAppDelegate.m
//  Find the investor
//
//  Created by Yeray Callero on 12/06/12.
//  Copyright (c) 2012 Geosophic Ltd. All rights reserved.
//

#import "gpcAppDelegate.h"
#import "boardViewController.h"
#import "GeosophicSDK.h"
#import "SettingsStatus.h"

#define notificationMessage @"This game uses the Geosophic service to share your scores in our geolocated leaderboards. Do you want to allow Geosophic to know your location and upload your score? If you choose \"No\", the game will work properly but you won't be able to share your scores. You can always disable the Geosophic service by pressing the Geosophic button in the main window of the game." 
#define defaultCompanyName @"Unknown company"

@implementation gpcAppDelegate

@synthesize window;
@synthesize viewController;

bool firstExecution = true;

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions { 
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"HasLaunchedOnce"])
    {
        // app already launched
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"HasLaunchedOnce"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        // This is the first launch ever
        UIAlertView *alertView = [[[UIAlertView alloc] initWithTitle:@"Geosophic service notification" message:notificationMessage delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil] autorelease];
        [alertView show];
    }

	// Set the view controller as the window's root view controller and display.
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    // the user clicked one of the OK/Cancel buttons
    if (buttonIndex == 0)
    {
        [SettingsStatus setCompanyName:defaultCompanyName];
        [SettingsStatus setGeosophicServiceStatus:TRUE];
         [GeosophicServiceController initService:@"442163249fnDpN5EIsdgsJzEwoP3IVMUQ" withSecret:@"RZTB1UDM0YC5DQ1R52HRBASMV4DAGS0ZSVG1TNZE4Q2ERF4SB2"];
    }
    else
    {
        [SettingsStatus setCompanyName:defaultCompanyName];
        [SettingsStatus setGeosophicServiceStatus:FALSE];
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
    [GeosophicServiceController stopService];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
    if ([SettingsStatus isGeosophicServiceEnabled])
        [GeosophicServiceController initService:@"442163249fnDpN5EIsdgsJzEwoP3IVMUQ" withSecret:@"RZTB1UDM0YC5DQ1R52HRBASMV4DAGS0ZSVG1TNZE4Q2ERF4SB2"];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
