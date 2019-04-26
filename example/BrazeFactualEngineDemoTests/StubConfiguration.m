/*
 * Use of this software is subject to the terms and
 * conditions of the license agreement between you
 * and Factual Inc
 *
 * Copyright © 2019 Factual Inc. All rights reserved.
 */

#import "StubConfiguration.h"

@implementation StubConfiguration

+ (NSString *)engineApiKey {
    return @"Your Engine API Key here";
}

+ (NSString *)brazeApiKey {
    return @"Your Braze API Key here";
}

+ (NSString *)brazeEndpoint {
    return @"Your Braze SDK Endpoint here";
}

+ (NSString *)brazeRestApiKey {
    return @"Your Braze Rest API Key here";
}

+ (NSString *)brazeRestEndpoint {
    return @"Your Braze Rest Endpoint here";
}

+ (NSString *)testUser {
    return @"Your Braze User ID here";
}

+ (NSString *)testEmail {
    return @"Your Braze User Email here";
}

+ (NSString *)circumstanceName {
    return @"Your Factual Engine Circumstance Name here";
}

// Change testLatitude and testLongitude to a location that will trigger your circumstance
+ (double)testLatitude {
    return 34.0141;
}

+ (double)testLongitude {
    return -118.2879;
}

@end
