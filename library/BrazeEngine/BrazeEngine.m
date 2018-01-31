/*
 * Use of this software is subject to the terms and
 * conditions of the license agreement between you
 * and Factual Inc
 *
 * Copyright © 2018 Factual Inc. All rights reserved.
 */

#import "BrazeEngine.h"
#import "EngineBrazeActionHandler.h"

@implementation BrazeEngine

+ (int) maxPlaceEventsPerCircumstanceDefault {
    return 10;
}

+ (void) startIntegrationWithEngine:(FactualEngine *)engine {
    [BrazeEngine startIntegrationWithEngine:engine withUserJourneyEnabled:true];
}

+ (void) startIntegrationWithEngine:(FactualEngine *)engine withUserJourneyEnabled:(BOOL)userJourneyEnabled {
    [BrazeEngine
     startIntegrationWithEngine:engine
     withUserJourneyEnabled:userJourneyEnabled
     withMaxEventsPerCircumstance:[BrazeEngine maxPlaceEventsPerCircumstanceDefault]];
}

+ (void) startIntegrationWithEngine:(FactualEngine *)engine withUserJourneyEnabled:(BOOL)userJourneyEnabled withMaxEventsPerCircumstance:(int)maxNumbEventsPerCircumstance {
    if (userJourneyEnabled) {
        FactualCircumstance *userJourney = [[FactualCircumstance alloc]
                                            initWithId:[EngineBrazeActionHandler userJourneyCircumstanceId]
                                            expr:@"(at any-factual-place)"
                                            actionId:[EngineBrazeActionHandler uploadToBrazeActionId]];
        [engine registerCircumstance:userJourney];
    }
    [engine registerActionWithId:[EngineBrazeActionHandler uploadToBrazeActionId]
                        listener:[[EngineBrazeActionHandler alloc] initWithMaxEventsPerCircumstance:maxNumbEventsPerCircumstance]];
}

@end
