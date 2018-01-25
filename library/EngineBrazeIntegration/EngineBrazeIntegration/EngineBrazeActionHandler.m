//
//  EngineBrazeActionHandler.m
//  EngineBrazeIntegration
//
//  Created by Sevada Abraamyan on 1/23/18.
//  Copyright © 2018 Factual Inc. All rights reserved.
//

#import "EngineBrazeActionHandler.h"
#import "Appboy-iOS-SDK/AppboyKit.h"

@implementation EngineBrazeActionHandler
{
    NSRange _rangeOfPlaceEvents;
}

- (id) initWithMaxEventsPerCircumstance:(int)maxEventsPerCircumstance {
    if (self = [super init]) {
        _rangeOfPlaceEvents = NSMakeRange(0, maxEventsPerCircumstance);
    }
    return self;
}

+ (NSString *) uploadToBrazeActionId {
    return @"upload_to_braze";
}

+ (NSString *) userJourneyCircumstanceId {
    return @"engine_user_journey";
}

+ (NSString *) circumstanceEventNamePrefix {
    return @"engine_circumstance_";
}

+ (NSString *) circumstancePlaceEventNamePrefix {
    return @"engine_circumstance_place_at_";
}

- (void)circumstancesDidOccur:(NSArray<CircumstanceResponse *> *)circumstanceResponses {
    for (CircumstanceResponse *circumstanceResponse in circumstanceResponses) {
        NSString *circumstanceId = [[circumstanceResponse circumstance] circumstanceId];
        CLLocation *userLocation = [circumstanceResponse deviceLocation];
        
        if ([circumstanceId isEqualToString:[EngineBrazeActionHandler userJourneyCircumstanceId]]) { //todo: check withUserJourney???
            FactualPlace *place = [[circumstanceResponse atPlaces] firstObject];
            [[Appboy sharedInstance] logCustomEvent:circumstanceId withProperties:[self createPlaceAppboyProperties:place withUserLocation:userLocation]];
        } else {
            NSString *incidentId = [[NSUUID UUID] UUIDString];
            [[Appboy sharedInstance] logCustomEvent:[[EngineBrazeActionHandler circumstanceEventNamePrefix] stringByAppendingString:circumstanceId]
                                     withProperties:[self createCircumstanceAppBoyProperties:incidentId withUserLocation:userLocation]];
            
            NSArray *places = [[circumstanceResponse atPlaces] subarrayWithRange:_rangeOfPlaceEvents];
            
            for(FactualPlace *factualPlace in places) {
                [[Appboy sharedInstance]
                 logCustomEvent:[[EngineBrazeActionHandler circumstancePlaceEventNamePrefix] stringByAppendingString:circumstanceId]
                 withProperties:[self createPlaceAppboyProperties:factualPlace withUserLocation:userLocation withIncidenceId:incidentId]];
            }
        }
    }
}

- (NSDictionary *) createCircumstanceAppBoyProperties:(NSString *)incidenceId withUserLocation:(CLLocation *)userLocation {
    NSDictionary *eventProperties = @{
             @"incidence_id": incidenceId,
             @"user_latitude": [NSNumber numberWithDouble:[userLocation coordinate].latitude],
             @"user_longitude": [NSNumber numberWithDouble:[userLocation coordinate].longitude]
             };
    return eventProperties;
}

- (NSMutableDictionary *) createPlaceAppboyProperties:(FactualPlace *)place withUserLocation:(CLLocation *)userLocation withIncidenceId:(NSString *)incidenceId {
    NSMutableDictionary *properties = [self createPlaceAppboyProperties:place withUserLocation:userLocation];
    [properties setObject:@"incidence_id" forKey:incidenceId];
    return properties;
}
- (NSMutableDictionary *) createPlaceAppboyProperties:(FactualPlace *)place withUserLocation:(CLLocation *)userLocation {
    return [[NSMutableDictionary alloc] initWithObjectsAndKeys:
             [place name], @"name",
             [place factualId], @"factual_id",
             [NSNumber numberWithDouble:[place latitude]], @"latitude",
             [NSNumber numberWithDouble:[place longitude]], @"longitude",
             [NSNumber numberWithDouble:[userLocation coordinate].latitude], @"user_latitude",
             [NSNumber numberWithDouble:[userLocation coordinate].longitude], @"user_longitude",
             [[place categoryIds] componentsJoinedByString:@","], @"place_categories",
             nil
            ];
}

- (void)circumstance:(FactualCircumstance *)circumstance didFailWithError:(NSString *)error {
    NSLog(@"Engine Circumstance Evaluation error: %@", error);
}
@end

