# Introduction

This app demonstrates the usage of the Braze/Engine integration library. 

# Requirements

Set proper values in ``Configuration.h`` for both Factual Engine SDK API and Braze Android SDK API key/endpoint. [see here](demo/BrazeFactualEngineDemo/Configuration.m) 

```objective-c
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
```

# Usage

This demo app will send Braze both user journey and circumstance met events. To see circumstance events 
define your custom circumstances with actionId `push-to-braze` using Engine's Garage dashboard.
