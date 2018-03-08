//
//  Configuration.m
//  BrazeFactualEngineDemo
//
//  Created by Sevada Abraamyan on 3/8/18.
//  Copyright © 2018 Factual Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Configuration.h"

@implementation Configuration

+ (NSString *) engineApiKey {
    return @"REPLACE_WITH_ENGINE_API_KEY";
}

+ (NSString *) brazeApiKey {
    return @"REPLAY_WITH_BRAZE_API_KEY";
}

+ (NSString *) brazeEndpoint {
    return @"REPLACE_WITH_BRAZE_ENDPOINT";
}

@end
