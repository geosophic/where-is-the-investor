//
//  SettingsStatus.m
//  monkey
//
//  Created by Yeray Callero on 15/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SettingsStatus.h"
#import "SettingsViewController.h"

@implementation SettingsStatus

bool geosophicServiceEnabled;
NSString* companyName;

+ (void) setGeosophicServiceStatus: (bool) newStatus
{
    geosophicServiceEnabled = newStatus;
}

+ (bool) isGeosophicServiceEnabled
{
    return geosophicServiceEnabled;
}

+ (void) setCompanyName: (NSString*) newCompanyName
{
    NSLog(@"Set company name %@", companyName);
    companyName = [newCompanyName retain];
}

+(NSString*) getCompanyName
{
    NSLog(@"Get company name %@", companyName);
    return companyName;
}

@end
