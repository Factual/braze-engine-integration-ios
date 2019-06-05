/*
 * Use of this software is subject to the terms and
 * conditions of the license agreement between you
 * and Factual Inc
 *
 * Copyright © 2019 Factual Inc. All rights reserved.
 */

#import "BrazeEngineUserJourneyHandler.h"
#import "FactualEngine.h"

@interface BrazeEngine : NSObject

/**
 Returns true if tracking spans is enabled and false if it is not.
 
 Call trackUserJourneySpans to start tracking circumstances and stopTrackingUserJourneySpans to stop tracking circumstances
 */
+ (BOOL)isTrackingSpans;

/**
 Sends a CircumstanceResponse to Braze as a custom event.  This method assumes that Braze has already been started.
 
 The following three types of custom events may be sent:
 
 1) Circumstance Triggered Events:
 
    - Description: Circumstance
 
    - EventName: "engine_" + CIRCUMSTANCE_NAME
 
    - EventProperties: incidence_id, user_latitude, user_longitude, event_source
 
 2) Circumstance At Place Events:
 
    - Description: Sent for each place the user may have been at which triggered the circumstance event
 
    - EventName: "engine_at_" + CIRCUMSTANCE_NAME
 
    - EventProperties: Same as (1) with the addition of place properties: name, factual_id, latitude, longitude, place_categories, chain
 
 3) Circumstance Near Place Events:
 
    - Description: Sent for each place the user may have been near to - but not at - which triggered the circumstance event
 
    - EventName: "engine_near_" + CIRCUSMTANCE_NAME
 
    - EventProperties: Same as (2)
 
 For each circumstance response sent there will be one event of type (1) and a maximum of 10 events of type (2) and a
 maximum of 20 events of type (3).  If you wish to send more or less events of type (2) and (3) use the method
 pushToBraze:withMaxAtPlaceEvents:withMaxNearPlaceEvents.
 
 Based on the generality of the circumstance definition, Factual's Engine SDK may match multiple potential candidate
 places the user may have been at or near when the circumstance was triggered.
 
 @param circumstanceResponse A CircumstanceResponse given in circumstancesMet: in the FactualEngineDelegate
 */
+ (void)pushToBraze:(CircumstanceResponse *)circumstanceResponse;

/**
 Sends a CircumstanceResponse to Braze as a custom event.  This method assumes that Braze has already been started.
 
 The following three types of custom events may be sent:
 
 1) Circumstance Triggered Events:
 
    - Description: Circumstance
 
    - EventName: "engine_" + CIRCUMSTANCE_NAME
 
    - EventProperties: incidence_id, user_latitude, user_longitude, event_source
 
 2) Circumstance At Place Events:
 
    - Description: Sent for each place the user may have been at which triggered the circumstance event
 
    - EventName: "engine_at_" + CIRCUMSTANCE_NAME
 
    - EventProperties: Same as (1) with the addition of place properties: name, factual_id, latitude, longitude, place_categories, chain
 
 3) Circumstance Near Place Events:
 
    - Description: Sent for each place the user may have been near to - but not at - which triggered the circumstance event
 
    - EventName: "engine_near_" + CIRCUSMTANCE_NAME
 
    - EventProperties: Same as (2)
 
 For each circumstance response sent there will be one event of type (1) and you set the maximum number of events of
 type (2) and type (3) to send.
 
 Based on the generality of the circumstance definition,
 Factual's Engine SDK may match multiple potential candidate places the user may have been at or near when the
 circumstance was triggered.
 
 @param circumstanceResponse A CircumstanceResponse given in circumstancesMet: in the FactualEngineDelegate
 @param maxAtPlaceEvents max number of AtPlace events to send to Braze. Sent in order of decreasing confidence
 @param maxNearPlaceEvents max number of NearPlace events to send to Braze. Sent in order of decreasing confidence
 */
+ (void)pushToBraze:(CircumstanceResponse *)circumstanceResponse
withMaxAtPlaceEvents:(int)maxAtPlaceEvents
withMaxNearPlaceEvents:(int)maxNearPlaceEvents;

/**
 Sends User Journey Spans to Braze.
 
 The following events may be sent:
 
 1) User Journey Span Events:
 
    - Description: Sent when a User Journey Span occurs
 
    - EventName: "engine_span_occurred"
 
    - EventProperties: span_id, event_source, start_time_unavailable, end_time_unavailable, start_timestamp,
    end_timestamp, duration, is_home, is_work, ingress_latitude, ingress_longitude, country, localities, postcode,
    region
 
 2) User Journey Span Attached Place Events:
 
    - Description: Sent for each attached place in a User Journey Span
 
    - EventName: "engine_span_attached_place"
 
    - EventProperties: span_id, event_source, name, factual_id, latitude, longitude, place_categories, place_chain
 
 For each User Journey Span that occurs there will be one event of type (1) and multiple events of type (2).  Based
 on the generality of the attached place definition, Factual's Engine SDK may match multiple potential candidate
 places the user may gave been at during the User Journey Span.
 
 You must set Factual Engine's User Journey Delegate to BrazeEngineUserJourneyHandler using Factual Engine's
 startWithApiKey:delegate:userJourneyDelegate: method in order to send spans to Braze
 */
+ (void)trackUserJourneySpans;

/** Disables Braze Engine's User Journey Span tracking */
+ (void)stopTrackingUserJourneySpans;

@end
