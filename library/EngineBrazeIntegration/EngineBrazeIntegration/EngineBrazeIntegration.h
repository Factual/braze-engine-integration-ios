//
//  EngineBrazeIntegration.h
//  EngineBrazeIntegration
//
//  Created by Sevada Abraamyan on 1/18/18.
//  Copyright © 2018 Factual Inc. All rights reserved.
//

#ifndef EngineBrazeIntegration_h
#define EngineBrazeIntegration_h

#import <Foundation/Foundation.h>
#import "FactualEngine.h"

@interface EngineBrazeIntegration : NSObject
+ (int) maxNumbPlaceEventsPerCircumstanceDefault;
+ (void) initializeEngineBrazeIntegration:(FactualEngine *)engine withUserJourney:(BOOL)withUserJourney withMaxNumbEventsPerCircumstance:(int)maxNumbEventsPerCircumstance;
+ (void) initializeEngineBrazeIntegration:(FactualEngine *)engine withUserJourney:(BOOL)withUserJourney;
+ (void) initializeEngineBrazeIntegration:(FactualEngine *)engine;
@end

#endif
