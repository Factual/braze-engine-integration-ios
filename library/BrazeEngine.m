/*
 * Use of this software is subject to the terms and
 * conditions of the license agreement between you
 * and Factual Inc
 *
 * Copyright © 2019 Factual Inc. All rights reserved.
 */

#import "BrazeEngine.h"
#import "BrazeEngineActionHandler.h"

@implementation BrazeEngine

static BOOL trackingCircumstances = false;
static BOOL trackingSpans = false;

+ (BOOL)isTrackingCircumstances {
    return trackingCircumstances;
}

+ (BOOL)isTrackingSpans {
    return trackingSpans;
}

+ (void)trackCircumstancesWithEngine:(FactualEngine *)engine
 withMaxAtPlaceEventsPerCircumstance:(int)maxAtPlaceEventsPerCircumstance
withMaxNearPlaceEventsPerCircumstance:(int)maxNearPlaceEventsPerCircumstance {
    NSLog(@"Enabling Braze -> Engine circumstance logging");
    
    [engine registerActionWithId:[BrazeEngineActionHandler customEventActionID]
                        listener:[[BrazeEngineActionHandler alloc] initWithMaxAtPlaceEventsPerCircumstance:maxAtPlaceEventsPerCircumstance
                                                                     withMaxNearPlaceEventsPerCircumstance:maxNearPlaceEventsPerCircumstance]];
    
    trackingCircumstances = true;
}

+ (void)trackCircumstancesWithEngine:(FactualEngine *)engine {
    [self trackCircumstancesWithEngine:engine
   withMaxAtPlaceEventsPerCircumstance:10
 withMaxNearPlaceEventsPerCircumstance:20];
}

+ (void)stopTrackCircumstancesWithEngine:(FactualEngine *)engine {
    NSLog(@"Disabling Braze -> Engine circumstance logging");
    [engine disableCircumstanceWithId:[BrazeEngineActionHandler customEventActionID]];
    trackingCircumstances = false;
}

+ (void)trackUserJourneySpans {
    NSLog(@"Enabling Braze -> Engine span logging");
    trackingSpans = true;
}

+ (void)stopTrackingUserJourneySpans {
    NSLog(@"Disabling Braze -> Engine span logging");
    trackingSpans = false;
}

@end
