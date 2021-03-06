//
//  GeosophicController.h
//  MyLibrary
//
//  Created by Yeray Callero on 29/05/12.
//  Copyright (c) 2012 Geosophic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Geosophic_ScoreResponse.h"
#import "Geosophic_Leaderboard.h"

#define geosophicControllerDebugMode FALSE

@interface GeosophicServiceController : NSObject

+(void) initService:(NSString*) consumerKey withSecret:(NSString*) consumerSecret;
+(void) stopService;
+(UIViewController*)getGeosophicDashboardView:(int) leaderboardId withSchema:(int) leaderboardSchema withOffset:(int) offset withNumberOfScores:(int) totalScores error:(NSError**) error;
+(void)getGeosophicDahsboadWindow:(int) leaderboardId withSchema:(int) leaderboardSchema withOffset:(int) offset withNumberOfScores:(int) totalScores error:(NSError**) error;
+(NSArray*) getNearestLeaderboardsById:(int) leaderboardId withOffset:(int) offset withNumberOfScores:(int) totalScores error:(NSError**) error;
+(Geosophic_ScoreResponse*) postScore:(int) score withNickname:(NSString*) nickname inLeaderboard:(int) leaderboardId error:(NSError**) error;
+(Geosophic_Leaderboard*) getLeaderboardById:(int) lid withOffset:(int) offset withNumberOfScores:(int) nScores error:(NSError**) error;

@end
