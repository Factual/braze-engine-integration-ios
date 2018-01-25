//
//  EngineBrazeIntegration.m
//  EngineBrazeIntegration
//
//  Created by Sevada Abraamyan on 1/18/18.
//  Copyright © 2018 Factual Inc. All rights reserved.
//

#import "EngineBrazeIntegration.h"
#import "EngineBrazeActionHandler.h"

@implementation EngineBrazeIntegration

+ (int) maxNumbPlaceEventsPerCircumstanceDefault {
    int numPlaces = 10;
    return numPlaces;
}

+ (void) initializeEngineBrazeIntegration:(FactualEngine *)engine {
    [EngineBrazeIntegration initializeEngineBrazeIntegration:engine withUserJourney:true];
}

+ (void) initializeEngineBrazeIntegration:(FactualEngine *)engine withUserJourney:(BOOL)withUserJourney {
    [EngineBrazeIntegration
        initializeEngineBrazeIntegration:engine
        withUserJourney:withUserJourney
     withMaxNumbEventsPerCircumstance:[EngineBrazeIntegration maxNumbPlaceEventsPerCircumstanceDefault]];
}

+ (void) initializeEngineBrazeIntegration:(FactualEngine *)engine withUserJourney:(BOOL)withUserJourney withMaxNumbEventsPerCircumstance:(int)maxNumbEventsPerCircumstance {
    if (withUserJourney) {
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
