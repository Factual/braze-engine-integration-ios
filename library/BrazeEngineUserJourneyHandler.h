/*
 * Use of this software is subject to the terms and
 * conditions of the license agreement between you
 * and Factual Inc
 *
 * Copyright © 2019 Factual Inc. All rights reserved.
 */

#ifndef BrazeEngineUserJourneyHandler_h
#define BrazeEngineUserJourneyHandler_h

#import "FactualEngine.h"

@interface BrazeEngineUserJourneyHandler : NSObject<UserJourneyDelegate>
- (id) initWithMaxAttachedPlaceEventsPerEvent:(int)maxAttachedPlaceEventsPerEvent;
- (id) init;
@end

#endif /* BrazeEngineUserJourneyHandler_h */
