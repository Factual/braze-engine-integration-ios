/*
 * Use of this software is subject to the terms and
 * conditions of the license agreement between you
 * and Factual Inc
 *
 * Copyright © 2019 Factual Inc. All rights reserved.
 */

#import "Appboy_iOS_SDK/AppboyKit.h"
#import "BrazeEngine.h"
#import "PlaceCategoryMap.h"
#import "PlaceChainMap.h"

@implementation BrazeEngine

NSString *SOURCE_NAME = @"factual";

NSString *CIRCUMSTANCE_MET_EVENT_KEY = @"engine_";
NSString *INCIDENT_ID_KEY = @"incident_id";
NSString *USER_LATITUDE_KEY = @"user_latitude";
NSString *USER_LONGITUDE_KEY = @"user_longitude";
NSString *EVENT_SOURCE_KEY = @"event_source";

NSString *AT_PLACE_EVENT_KEY = @"engine_at_";
NSString *NEAR_PLACE_EVENT_KEY = @"engine_near_";
NSString *PLACE_NAME_KEY = @"name";
NSString *PLACE_ID_KEY = @"factual_id";
NSString *PLACE_LATITUDE_KEY = @"latitude";
NSString *PLACE_LONGITUDE_KEY = @"longitude";
NSString *PLACE_CATEGORIES_KEY = @"category_labels";
NSString *PLACE_CHAIN_KEY = @"chain_name";

static BOOL trackingSpans = NO;

+ (BOOL)isTrackingSpans {
  return trackingSpans;
}

+ (void)pushToBraze:(CircumstanceResponse *)circumstanceResponse {
  [BrazeEngine pushToBraze:circumstanceResponse withMaxAtPlaceEvents:10 withMaxNearPlaceEvents:20];
}

+ (void)pushToBraze:(CircumstanceResponse *)circumstanceResponse
withMaxAtPlaceEvents:(int)maxAtPlaceEvents
withMaxNearPlaceEvents:(int)maxNearPlaceEvents {
  // Circumstance information
  NSString *circumstanceName = [[circumstanceResponse circumstance] name];
  CLLocation *userLocation = [circumstanceResponse deviceLocation];
  NSNumber *latitude = [NSNumber numberWithDouble:userLocation.coordinate.latitude];
  NSNumber *longitude = [NSNumber numberWithDouble:userLocation.coordinate.longitude];
  NSString *incidentId = [[NSUUID UUID] UUIDString];
  
  NSString *eventKey = [CIRCUMSTANCE_MET_EVENT_KEY stringByAppendingString:circumstanceName];
  
  // Populate properties data
  NSMutableDictionary *properties = [[NSMutableDictionary alloc] init];
  [properties setValue:incidentId forKey:INCIDENT_ID_KEY];
  [properties setValue:latitude forKey:USER_LATITUDE_KEY];
  [properties setValue:longitude forKey:USER_LONGITUDE_KEY];
  [properties setValue:SOURCE_NAME forKey:EVENT_SOURCE_KEY];
  
  // Send to Braze
  NSLog(@"Sending circumstance %@ event to braze", circumstanceName);
  [[Appboy sharedInstance] logCustomEvent:eventKey withProperties:properties];
  
  // Send any At Places data
  if (maxAtPlaceEvents > 0 && circumstanceResponse.atPlaces && [circumstanceResponse.atPlaces count] > 0) {
    NSUInteger numAtPlaces = MIN(maxAtPlaceEvents, [circumstanceResponse.atPlaces count]);
    NSLog(@"Sending %@ at place event(s) to braze", [@(numAtPlaces) stringValue]);
    NSString * atPlaceEventKey = [AT_PLACE_EVENT_KEY stringByAppendingString:circumstanceName];
    [self sendPlacesData:circumstanceResponse.atPlaces
           withEventName:atPlaceEventKey
          withProperties:properties
      withNumPlaceEvents:numAtPlaces];
  }
  
  // Send any Near Places data
  if (maxNearPlaceEvents > 0 && circumstanceResponse.nearPlaces && [circumstanceResponse.nearPlaces count] > 0) {
    NSUInteger numNearPlaces = MIN(maxNearPlaceEvents, [circumstanceResponse.nearPlaces count]);
    NSLog(@"Sending %@ near place event(s) to braze", [@(numNearPlaces) stringValue]);
    NSString *nearPlaceEventKey = [NEAR_PLACE_EVENT_KEY stringByAppendingString:circumstanceName];
    [self sendPlacesData:circumstanceResponse.nearPlaces
           withEventName:nearPlaceEventKey
          withProperties:properties
      withNumPlaceEvents:numNearPlaces];
  }
}

+ (void)sendPlacesData:(NSArray<FactualPlace *> *)places
         withEventName:(NSString *)eventName
        withProperties:(NSMutableDictionary *)properties
    withNumPlaceEvents:(NSUInteger)numPlaceEvents {
  // Loop through each place up to maxPlaceEvents
  for (int i = 0; i < numPlaceEvents; i++) {
    FactualPlace *place = places[i];
    
    // Get place data
    NSString *categories = [[PlaceCategoryMap getCategoriesFromPlace:place] componentsJoinedByString:@", "];
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

+ (void)trackUserJourneySpans {
  NSLog(@"Enabling Braze -> Engine span logging");
  trackingSpans = YES;
}

+ (void)stopTrackingUserJourneySpans {
  NSLog(@"Disabling Braze -> Engine span logging");
  trackingSpans = NO;
}

@end
