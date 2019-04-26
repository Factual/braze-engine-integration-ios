/*
 * Use of this software is subject to the terms and
 * conditions of the license agreement between you
 * and Factual Inc
 *
 * Copyright © 2019 Factual Inc. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import "Configuration.h"

@implementation Configuration

+ (NSString *)engineApiKey {
    return @"Your Engine API Key here";
}

+ (NSString *)brazeApiKey {
    return @"Your Braze API Key here";
}

+ (NSString *)brazeEndpoint {
    return @"Your Braze SDK Endpoint here";
}

+ (NSString *)brazeUser {
    return @"Your Braze User ID here";
}

+ (NSString *)brazeUserEmail {
    return @"Your Braze User Email here";
}

@end
