/*
 * Use of this software is subject to the terms and
 * conditions of the license agreement between you
 * and Factual Inc
 *
 * Copyright © 2018 Factual Inc. All rights reserved.
 */

#import "FactualEngine.h"

@interface BrazeEngine : NSObject
+ (int) maxPlaceAtEventsPerCircumstanceDefault;

/**
 Configures Factual's Engine SDK to send Braze custom events whenever either
 a Engine's circumstance or user journey event is triggered. Note that this method
 assumes that both Braze and Engine SDKs have been already been started.

 The following three types of custom events may be sent to Braze:
 
 1) User Journey Events:
    Description: Captures the fact that Engine has detected a user journey event.
    EventName: "engine_user_journey"
    EventProperties: user location and place properties.
 
 2) Circumstance Triggered Events:
    Description: Captures the fact that an Engine circumstance was triggered.
    EventName: "engine_circumstance_" + CIRCUMSTANCE_NAME;
    EventProperties: incidenceId, user location
 
 3) Place At Circumstance Triggered Events:
    Description: Captures the place at which a circumstance was triggered.
    EventName: "engine_circumstance_place_at_" + CIRCUMSTANCE_NAME;
    EventProperties: incidenceId, user location, place properties
 
 For each circumstance that is triggered there will be one event of type (2) and potentially
 multiple events of type (3). Based on the generality of the circumstance definition,
 Factual's Engine SDK may match multiple potential candidate places the user
 may be at when the circumstance was triggered.
 
 @param userJourneyEnabled whether Engine's user journey events should trigger a Braze event
 @param maxPlaceAtEventsPerCircumstance max number of PlaceAt events to send to Braze. Sent in order of decreasing confidence.
 */
+ (void) startIntegrationWithEngine:(FactualEngine *)engine withUserJourneyEnabled:(BOOL)userJourneyEnabled withMaxPlaceAtEventsPerCircumstance:(int)maxPlaceAtEventsPerCircumstance;

/**
 @see BrazeEngine#startIntegrationWithEngine:withUserJourneyEnabled:withMaxPlaceAtEventsPerCircumstance:
 
 Defaults:
    Uses default threshold for maxPlaceAtEventsPerCircumstance
    @see BrazeEngine#maxPlaceAtEventsPerCircumstanceDefault
 */
+ (void) startIntegrationWithEngine:(FactualEngine *)engine withUserJourneyEnabled:(BOOL)userJourneyEnabled;

/**
 @see BrazeEngine#startIntegrationWithEngine:withUserJourneyEnabled:withMaxPlaceAtEventsPerCircumstance:
 
 Defaults:
    Uses default threshold for maxPlaceAtEventsPerCircumstance
    Enables user journey events by default
    @see BrazeEngine#maxPlaceAtEventsPerCircumstanceDefault
 */
+ (void) startIntegrationWithEngine:(FactualEngine *)engine;
@end
