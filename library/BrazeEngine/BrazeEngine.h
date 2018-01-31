/*
 * Use of this software is subject to the terms and
 * conditions of the license agreement between you
 * and Factual Inc
 *
 * Copyright © 2018 Factual Inc. All rights reserved.
 */

#import "FactualEngine.h"

@interface BrazeEngine : NSObject
+ (int) maxPlaceEventsPerCircumstanceDefault;
+ (void) initIntegrationWithEngine:(FactualEngine *)engine withUserJourneyEnabled:(BOOL)userJourneyEnabled withMaxEventsPerCircumstance:(int)maxEventsPerCircumstance;
+ (void) initIntegrationWithEngine:(FactualEngine *)engine withUserJourneyEnabled:(BOOL)userJourneyEnabled;
+ (void) initIntegrationWithEngine:(FactualEngine *)engine;
@end
