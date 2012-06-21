//
//  Geosophic_Leaderboards.h
//  GeosophicSDK
//
//  Created by Yeray Callero on 14/06/12.
//  Copyright (c) 2012 Geosophic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Geosophic_Leaderboard : NSObject {
    NSMutableDictionary* schema;
    NSMutableDictionary* metadata;
    NSMutableDictionary* content;
}

@property (retain, nonatomic) NSMutableDictionary* schema;
@property (retain, nonatomic) NSMutableDictionary* metadata;
@property (retain, nonatomic) NSMutableDictionary* content;

- (id) init;
- (id) initWithData:(NSDictionary*) data;
- (NSString*) getLeaderboardName;
- (NSString*) getLeaderboardType;
- (NSString*) getUnitName;
- (NSString*) getSortType;
- (NSNumber*) getLeaderboardSchemaId;
- (NSNumber*) getLeaderboardPlaceId;
- (NSString*) getLeaderboardPlaceName;
- (NSNumber*) getLeaderboardPlaceLatitude;
- (NSNumber*) getLeaderboardPlaceLongitude;
- (NSDictionary*) getScores;

@end
