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
    return @"YOUR_ENGINE_API_KEY_HERE";
}

+ (NSString *)brazeApiKey {
    return @"YOUR_BRAZE_API_KEY_HERE";
}

+ (NSString *)brazeEndpoint {
    return @"YOUR_BRAZE_API_KEY_HERE";
}

+ (NSString *)brazeRestApiKey {
    return @"YOUR_BRAZE_REST_API_KEY_HERE";
}

+ (NSString *)brazeRestEndpoint {
    return @"YOUR_BRAZE_REST_ENDPOINT_HERE";
}

+ (NSString *)testUser {
    return @"YOUR_BRAZE_USER_ID_HERE";
}

+ (NSString *)testEmail {
    return @"YOUR_BRAZE_USER_EMAIL_HERE";
}

+ (NSString *)circumstanceName {
    return @"YOUR_CIRCUMSTANCE_NAME_HERE";
}

// Change testLatitude and testLongitude to a location that will trigger your circumstance
+ (double)testLatitude {
    return 34.0141;
}

+ (double)testLongitude {
    return -118.2879;
}

@end
