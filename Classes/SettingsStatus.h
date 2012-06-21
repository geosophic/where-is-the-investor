//
//  SettingsStatus.h
//  monkey
//
//  Created by Yeray Callero on 15/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettingsStatus : NSObject

+ (void) setGeosophicServiceStatus: (bool) newStatus;
+ (bool) isGeosophicServiceEnabled;
+ (void) setCompanyName: (NSString*) newCompanyName;
+(NSString*) getCompanyName;

@end
