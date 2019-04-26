/*
 * Use of this software is subject to the terms and
 * conditions of the license agreement between you
 * and Factual Inc
 *
 * Copyright © 2019 Factual Inc. All rights reserved.
 */

#ifndef EngineBrazeActionHandler_h
#define EngineBrazeActionHandler_h

#import "FactualEngine.h"

@interface BrazeEngineActionHandler : NSObject<FactualActionDelegate>
- (id) initWithMaxAtPlaceEventsPerCircumstance:(int)maxAtPlaceEventsPerCircumstance
         withMaxNearPlaceEventsPerCircumstance:(int)maxNearPlaceEventsPerCircumstance;

+ (NSString*)customEventActionID;
@end

#endif /* EngineBrazeActionHandler_h */
