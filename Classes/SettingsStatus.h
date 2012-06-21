//
//  SettingsStatus.h
//  Find the investor
//
//  Created by Yeray Callero on 12/06/12.
//  Copyright (c) 2012 Geosophic Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettingsStatus : NSObject

+ (void) setGeosophicServiceStatus: (bool) newStatus;
+ (bool) isGeosophicServiceEnabled;
+ (void) setCompanyName: (NSString*) newCompanyName;
+(NSString*) getCompanyName;
+(void) setLastLeaderboardId:(int) leaderboardId;
+(int) getLastLeaderboardId;

@end
