//
//  EngineBrazeActionHandler.h
//  EngineBrazeIntegration
//
//  Created by Sevada Abraamyan on 1/23/18.
//  Copyright © 2018 Factual Inc. All rights reserved.
//

#ifndef EngineBrazeActionHandler_h
#define EngineBrazeActionHandler_h

#import <Foundation/Foundation.h>
#import "FactualEngine.h"

@interface EngineBrazeActionHandler : NSObject<FactualActionDelegate>
+ (NSString *) uploadToBrazeActionId;
+ (NSString *) userJourneyCircumstanceId;
+ (NSString *) circumstanceEventNamePrefix;
+ (NSString *) circumstancePlaceEventNamePrefix;
- (id) initWithMaxEventsPerCircumstance:(int)maxEventsPerCircumstance;
- (NSMutableDictionary *) createCircumstanceAppBoyProperties:(NSString *)incidenceId withUserLocation:(CLLocation *)userLocation;
- (NSMutableDictionary *) createPlaceAppboyProperties:(FactualPlace *)place withUserLocation:(CLLocation *)userLocation;
- (NSMutableDictionary *) createPlaceAppboyProperties:(FactualPlace *)place withUserLocation:(CLLocation *)userLocation withIncidenceId:(NSString *)incidenceId;
@end

#endif /* EngineBrazeActionHandler_h */
