/*
 * Use of this software is subject to the terms and
 * conditions of the license agreement between you
 * and Factual Inc
 *
 * Copyright © 2019 Factual Inc. All rights reserved.
 */

#import "Appboy_iOS_SDK/AppboyKit.h"
#import "BrazeEngine.h"
#import "StubConfiguration.h"
#import "StubEngineDelegate.h"
#import <XCTest/XCTest.h>

@interface StubAppboyEndpointDelegate : NSObject <ABKAppboyEndpointDelegate>
@end

@implementation StubAppboyEndpointDelegate
- (NSString *) getApiEndpoint:(NSString *)appboyApiEndpoint {
    return [appboyApiEndpoint stringByReplacingOccurrencesOfString:@"dev.appboy.com" withString:[StubConfiguration brazeEndpoint]];
}

@end

@interface BrazeFactualEngineDemoTests : XCTestCase

@end

@implementation BrazeFactualEngineDemoTests

StubEngineDelegate *engineDelegate;

NSString *USERS_KEY = @"users";
NSString *CUSTOM_EVENTS_KEY = @"custom_events";
NSString *NAME_KEY = @"name";
NSString *EVENT_DATE_KEY = @"last";

- (void)setUp {
    // Set up engine if it isn't already
    if (![FactualEngine isEngineStarted]) {
        engineDelegate = [[StubEngineDelegate alloc] init];
        XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:@"Engine started"];
        [engineDelegate setEngineStartedExpectation:expectation];
        
        [FactualEngine startWithApiKey:[StubConfiguration engineApiKey]
                              delegate:engineDelegate
                   userJourneyDelegate:[[BrazeEngineUserJourneyHandler alloc] initWithMaxAttachedPlaceEventsPerEvent:1]];
        
        [Appboy startWithApiKey:[StubConfiguration brazeApiKey]
                  inApplication:[UIApplication sharedApplication]
              withLaunchOptions:nil
              withAppboyOptions:@{ABKAppboyEndpointDelegateKey: [[StubAppboyEndpointDelegate alloc] init]}];
        
        [[Appboy sharedInstance] changeUser:[StubConfiguration testUser]];
        [[[Appboy sharedInstance] user] setEmail:[StubConfiguration testEmail]];
        
        (void)[XCTWaiter waitForExpectations:[[NSArray alloc] initWithObjects:expectation, nil] timeout:10];
    }
}

- (void)testBrazeEngineCircumstances {
    FactualEngine *engine = engineDelegate.engine;
    XCTAssertNotNil(engine, @"engine not set");
    
    // Get current date and time to later check that Braze received event after.
    NSDate *aboutToRun = [NSDate date];
    
    // Trigger a circumstance from a mock location
    CLLocation *mockLocation = [[CLLocation alloc] initWithLatitude:[StubConfiguration testLatitude]
                                                          longitude:[StubConfiguration testLongitude]];
    [engine runCircumstancesWithMockLocation:mockLocation];
    
    // Wait for Braze to track event
    XCTestExpectation *brazeTrackExpectation = [[XCTestExpectation alloc] initWithDescription:@"Braze event tracking"];
    double secondsDelay = 60.0;
    dispatch_time_t delay = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(secondsDelay * NSEC_PER_SEC));
    dispatch_after(delay, dispatch_get_main_queue(), ^(void) { [brazeTrackExpectation fulfill]; });
    (void)[XCTWaiter waitForExpectations:[[NSArray alloc] initWithObjects:brazeTrackExpectation, nil] timeout:100];
    
    // Ensure event was sent to Braze
    NSURLRequest *brazeRequest = [self getBrazeApiRequest];
    XCTestExpectation *brazeRequestExpectation = [[XCTestExpectation alloc] initWithDescription:@"Braze callback"];
    NSURLSession *session = [NSURLSession sharedSession];
    
    [[session dataTaskWithRequest:brazeRequest
                completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                    // Check for error
                    XCTAssertNil(error, @"Error returned: %@", [error description]);
                    
                    // Get JSON data
                    NSDictionary *reply = [NSJSONSerialization JSONObjectWithData:data
                                                                          options:NSJSONReadingMutableContainers
                                                                            error:nil];
                    // Get custom events from JSON object
                    NSArray<NSDictionary *> *customEvents = [(NSDictionary *)[(NSArray *)[reply valueForKey:USERS_KEY] firstObject]
                                                             valueForKey:CUSTOM_EVENTS_KEY];
                    XCTAssertNotNil(customEvents, @"Custom events not returned");
                    
                    // Ensure our custom events were sent
                    NSMutableSet<NSString *> *events = [[NSMutableSet alloc] initWithObjects:
                                                        [@"engine_circumstance_"
                                                         stringByAppendingString:[StubConfiguration circumstanceName]],
                                                        [@"engine_circumstance_at_place_"
                                                         stringByAppendingString:[StubConfiguration circumstanceName]],
                                                        nil];
                    
                    // There are multiple events, find the circumstance related events
                    for (NSDictionary *event in customEvents) {
                        // Get event name
                        NSString *eventName = (NSString *)[event valueForKey:NAME_KEY];
                        XCTAssertNotNil(eventName, @"Event not in custom events: %@", eventName);
                        // Ensure this event was the one we sent
                        if ([events containsObject:eventName]) {
                            // Get event date
                            NSString *dateString = [event valueForKey:EVENT_DATE_KEY];
                            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                            [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
                            NSDate *date = [dateFormat dateFromString:dateString];
                            XCTAssertNotNil(date, @"date value is nil");
                            // Ensure this is the event we just sent
                            XCTAssertTrue([aboutToRun compare:date] == NSOrderedAscending,
                                          @"Braze did not receive event: %@", eventName);
                            [events removeObject:eventName];
                        }
                    }
                    
                    // Ensure each event was found
                    XCTAssertEqual([events count], 0, @"Events missing from custom events: %@", events);
                    
                    [brazeRequestExpectation fulfill];
                }] resume];
    
    (void)[XCTWaiter waitForExpectations:[[NSArray alloc] initWithObjects:brazeRequestExpectation, nil] timeout:30];
}



// Create a rest API request to braze to ensure our events were sent there
- (NSURLRequest *)getBrazeApiRequest {
    NSString *email = [StubConfiguration testEmail];
    NSString *apiKey = [StubConfiguration brazeRestApiKey];
    NSString *endpoint = [StubConfiguration brazeRestEndpoint];
    NSString *requestUrlString = [[NSString alloc]
                                  initWithFormat:@"https://%@/users/export/ids?api_key=%@&email_address=%@",
                                  endpoint,
                                  apiKey,
                                  email];
    NSURL *requestUrl = [[NSURL alloc] initWithString:requestUrlString];
    XCTAssertNotNil(requestUrl, @"Could not creat URL from string: %@", requestUrlString);
    
    NSMutableURLRequest *brazeRequest = [[NSMutableURLRequest alloc] initWithURL:requestUrl];
    [brazeRequest setHTTPMethod:@"POST"];
    
    return brazeRequest;
}

@end
