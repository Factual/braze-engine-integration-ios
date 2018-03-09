/*
 * Use of this software is subject to the terms and
 * conditions of the license agreement between you
 * and Factual Inc
 *
 * Copyright © 2017 Factual Inc. All rights reserved.
 */


#import "AppDelegate.h"
#import "BrazeEngine.h"
#import "Configuration.h"

@interface AppboyEndpointDelegate : NSObject <ABKAppboyEndpointDelegate>
@end

@implementation AppboyEndpointDelegate
- (NSString *) getApiEndpoint:(NSString *)appboyApiEndpoint {
    return [appboyApiEndpoint stringByReplacingOccurrencesOfString:@"dev.appboy.com" withString:[Configuration brazeEndpoint]];
}

@end
static FactualEngine *_engine = nil;

@interface AppDelegate ()
@property CLLocationManager *manager; // Engine assumes you are managing location permissions
@end

@implementation AppDelegate
+ (void) setEngine:(FactualEngine *)engine {
    _engine = engine;
}

+ (FactualEngine *) engine {
    return _engine;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // for demonstration, we're requesting location permissions here:
    if (_manager == nil) {
        _manager = [[CLLocationManager alloc] init];
    }
    [_manager requestAlwaysAuthorization];
    // start the SDK.
    // Note, you don't need to worry about whether or not the necessary
    // authorizations have returned from the user before calling start.
    // Engine will automatically detect for any changes to location
    // authorizations and behave accordingly.
    [FactualEngine startWithApiKey:[Configuration engineApiKey]
                          delegate:self]; // FactualEngineDelegate
    
    [Appboy startWithApiKey:[Configuration brazeApiKey]
              inApplication:application
          withLaunchOptions:launchOptions
          withAppboyOptions:@{ABKAppboyEndpointDelegateKey: [[AppboyEndpointDelegate alloc] init]}];
    
    return YES;
}

// ---- methods to support the FactualEngineDelegate interface ----
- (void)engineDidStartWithInstance:(FactualEngine *)engine {
    NSLog(@"Engine started.");
    [engine syncWithGarage];
    [AppDelegate setEngine:engine];
    [BrazeEngine startIntegrationWithEngine:engine];
}

- (void)engineDidStop{
    NSLog(@"Engine stopped.");
}

- (void)engineDidFailWithError:(FactualError *)error{
    NSLog(@"Engine error: %@", [error message]);
}

- (void)engineDidReportInfo:(NSString *)infoMessage{
    NSLog(@"Engine debug info: %@", infoMessage);
}

- (void)engineDidSyncWithGarage{
    NSLog(@"Engine updated configuration.");
}

- (void)engineDidLoadConfig:(FactualConfigMetadata *)data{
    NSLog(@"Engine config loaded: %@", [data version]);
}
@end
