/*
 * Use of this software is subject to the terms and
 * conditions of the license agreement between you
 * and Factual Inc
 *
 * Copyright © 2019 Factual Inc. All rights reserved.
 */

#import "AppboyKit.h"
#import "BrazeEngineActionHandler.h"
#import "PlaceCategoryMap.h"
#import "PlaceChainMap.h"

@implementation BrazeEngineActionHandler
{
    int _maxAtPlaceEventsPerCircumstance;
    int _maxNearPlaceEventsPerCircumstance;
}

NSString *CUSTOM_EVENT_ACTION_ID = @"send-custom-event";
NSString *SOURCE_NAME = @"factual";

NSString *BRAZE_ENGINE_CIRCUMSTANCE_KEY = @"engine_circumstance_";
NSString *INCIDENT_ID_KEY = @"incident_id";
NSString *USER_LATITUDE_KEY = @"user_latitude";
NSString *USER_LONGITUDE_KEY = @"user_longitude";
NSString *EVENT_SOURCE_KEY = @"event_source";

NSString *BRAZE_ENGINE_AT_PLACE_EVENT_KEY = @"engine_circumstance_at_place_";
NSString *BRAZE_ENGINE_NEAR_PLACE_EVENT_KEY = @"engine_circumstance_near_place_";
NSString *PLACE_NAME_KEY = @"name";
NSString *PLACE_ID_KEY = @"factual_id";
NSString *PLACE_LATITUDE_KEY = @"latitude";
NSString *PLACE_LONGITUDE_KEY = @"longitude";
NSString *PLACE_CATEGORIES_KEY = @"category_labels";
NSString *PLACE_CHAIN_KEY = @"chain_name";

- (id)initWithMaxAtPlaceEventsPerCircumstance:(int)maxAtPlaceEventsPerCircumstance
        withMaxNearPlaceEventsPerCircumstance:(int)maxNearPlaceEventsPerCircumstance {
    if (self = [super init]) {
        _maxAtPlaceEventsPerCircumstance = maxAtPlaceEventsPerCircumstance;
        _maxNearPlaceEventsPerCircumstance = maxNearPlaceEventsPerCircumstance;
    }
    
    return self;
}

+ (NSString*)customEventActionID {
    return CUSTOM_EVENT_ACTION_ID;
}

- (void)circumstancesDidOccur:(NSArray<CircumstanceResponse *> *)circumstanceResponses {
    for (CircumstanceResponse *circumstanceResponse in circumstanceResponses) {
        // Circumstance information
        NSString *circumstanceName = [[circumstanceResponse circumstance] name];
        CLLocation *userLocation = [circumstanceResponse deviceLocation];
        NSNumber *latitude = [NSNumber numberWithDouble:userLocation.coordinate.latitude];
        NSNumber *longitude = [NSNumber numberWithDouble:userLocation.coordinate.longitude];
        NSString *incidentId = [[NSUUID UUID] UUIDString];
        
        NSString *eventKey = [BRAZE_ENGINE_CIRCUMSTANCE_KEY stringByAppendingString:circumstanceName];
        
        // Populate properties data
        NSMutableDictionary *properties = [[NSMutableDictionary alloc] init];
        [properties setValue:incidentId forKey:INCIDENT_ID_KEY];
        [properties setValue:latitude forKey:USER_LATITUDE_KEY];
        [properties setValue:longitude forKey:USER_LONGITUDE_KEY];
        [properties setValue:SOURCE_NAME forKey:EVENT_SOURCE_KEY];
        
        // Send to Braze
        [[Appboy sharedInstance] logCustomEvent:eventKey withProperties:properties];
        
        // Send any At Places data
        if (_maxAtPlaceEventsPerCircumstance > 0 &&
            circumstanceResponse.atPlaces &&
            [circumstanceResponse.atPlaces count] > 0) {
            NSUInteger maxAtPlaces = MIN(_maxAtPlaceEventsPerCircumstance, [circumstanceResponse.atPlaces count]);
            NSString * atPlaceEventKey = [BRAZE_ENGINE_AT_PLACE_EVENT_KEY stringByAppendingString:circumstanceName];
            [self sendPlacesData:circumstanceResponse.atPlaces
                   withEventName:atPlaceEventKey
                  withProperties:properties
              withMaxPlaceEvents:maxAtPlaces];
        }

        // Send any Near Places data
        if (_maxNearPlaceEventsPerCircumstance > 0 &&
            circumstanceResponse.nearPlaces &&
            [circumstanceResponse.nearPlaces count] > 0) {
            NSUInteger maxNearPlaces = MIN(_maxNearPlaceEventsPerCircumstance, [circumstanceResponse.nearPlaces count]);
            NSString *nearPlaceEventKey = [BRAZE_ENGINE_NEAR_PLACE_EVENT_KEY stringByAppendingString:circumstanceName];
            [self sendPlacesData:circumstanceResponse.nearPlaces
                   withEventName:nearPlaceEventKey
                  withProperties:properties
              withMaxPlaceEvents:maxNearPlaces];
        }
    }
}

- (void)sendPlacesData:(NSArray<FactualPlace *> *)places
         withEventName:(NSString *)eventName
        withProperties:(NSMutableDictionary *)properties
    withMaxPlaceEvents:(NSUInteger)maxPlaceEvents {
    // Loop through each place up to maxPlaceEvents
    for (int i = 0; i < maxPlaceEvents; i++) {
        FactualPlace *place = places[i];
        // Get categoires
        NSString *categories = [[PlaceCategoryMap getCategoriesFromPlace:place] componentsJoinedByString:@", "];
        
        // Get chain
        NSString *chain = [PlaceChainMap getChainFromPlace:place];
        
        // Populate properties data
        [properties setValue:place.name forKey:PLACE_NAME_KEY];
        [properties setValue:place.factualId forKey:PLACE_ID_KEY];
        [properties setValue:[NSNumber numberWithDouble:place.latitude] forKey:PLACE_LATITUDE_KEY];
        [properties setValue:[NSNumber numberWithDouble:place.longitude] forKey:PLACE_LONGITUDE_KEY];
        [properties setValue:categories forKey:PLACE_CATEGORIES_KEY];
        [properties setValue:chain forKey:PLACE_CHAIN_KEY];
        
        // Send to Braze
        [[Appboy sharedInstance] logCustomEvent:eventName withProperties:properties];
    }
}

- (void)circumstance:(FactualCircumstance *)circumstance didFailWithError:(NSString *)error {
    NSLog(@"Engine Circumstance Evaluation error: %@", error);
}

@end


