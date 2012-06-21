//
//  ScoreResponse.h
//  GeosophicSDK
//
//  Created by Yeray Callero on 17/06/12.
//  Copyright (c) 2012 Geosophic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Geosophic_ScoreResponse : NSObject

- (id) initWithData:(NSDictionary*) data;
- (int) getLeaderboardId;
- (BOOL) isHighscore;

@end
