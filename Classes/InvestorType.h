//
//  InvestorType.h
//  monkey
//
//  Created by Yeray Callero on 12/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

enum Investor
{
    ANGEL = 0,
    SHARK
};

@interface InvestorType : NSObject

@property (nonatomic) enum Investor investorType;

@end
