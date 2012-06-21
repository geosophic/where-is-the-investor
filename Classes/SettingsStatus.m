//
//  SettingsStatus.m
//  Find the investor
//
//  Created by Yeray Callero on 12/06/12.
//  Copyright (c) 2012 Geosophic Ltd. All rights reserved.
//

#import "SettingsStatus.h"
#import "SettingsViewController.h"

@implementation SettingsStatus

bool geosophicServiceEnabled;
NSString* companyName;
int lastLeaderboardId = -1;

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
    companyName = [newCompanyName retain];
}

+(NSString*) getCompanyName
{
    return companyName;
}

+(void) setLastLeaderboardId:(int) leaderboardId
{
    lastLeaderboardId = leaderboardId;
}

+(int) getLastLeaderboardId
{
    return lastLeaderboardId;
}

@end
