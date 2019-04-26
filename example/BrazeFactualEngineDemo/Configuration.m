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
    return @"YOUR_ENGINE_API_KEY_HERE";
}

+ (NSString *)brazeApiKey {
    return @"YOUR_BRAZE_API_KEY_HERE";
}

+ (NSString *)brazeEndpoint {
    return @"YOUR_BRAZE_API_KEY_HERE";
}

+ (NSString *)brazeUser {
    return @"YOUR_BRAZE_USER_ID_HERE";
}

+ (NSString *)brazeUserEmail {
    return @"YOUR_BRAZE_USER_EMAIL_HERE";
}

@end
