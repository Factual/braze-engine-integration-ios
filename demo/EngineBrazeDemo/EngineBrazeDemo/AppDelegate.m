//
//  AppDelegate.m
//  EngineBrazeDemo
//
//  Created by Sevada Abraamyan on 1/25/18.
//  Copyright © 2018 Factual Inc. All rights reserved.
//

#import "AppDelegate.h"
#import "Appboy-iOS-SDK/AppboyKit.h"
#import "EngineBrazeIntegration.h"
#import "EngineBrazeActionHandler.h"


@interface AppboyEndpointDelegate : NSObject <ABKAppboyEndpointDelegate>
@end

@implementation AppboyEndpointDelegate
- (NSString *) getApiEndpoint:(NSString *)appboyApiEndpoint {
    return [appboyApiEndpoint stringByReplacingOccurrencesOfString:@"dev.appboy.com" withString:@"sdk.iad-03.appboy.com"];
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
    [FactualEngine startWithApiKey:@"AGcGDxzsX5kWVPKAoCiVdkAUtq4PKOckZlSVoNP8"
                          delegate:self]; // FactualEngineDelegate
    
    [Appboy startWithApiKey:@"6aaaf02c-bdd5-469b-be0d-21cf02476871"
              inApplication:application
          withLaunchOptions:launchOptions
          withAppboyOptions:@{ABKAppboyEndpointDelegateKey: [[AppboyEndpointDelegate alloc] init]}];
    
    return YES;
}

// ---- methods to support the FactualEngineDelegate interface ----
- (void)engineDidStartWithInstance:(FactualEngine *)engine {
    NSLog(@"Engine started.");
    [engine syncWithGarage];
    NSLog([EngineBrazeActionHandler uploadToBrazeActionId]);
    [AppDelegate setEngine:engine];
    [EngineBrazeIntegration initializeEngineBrazeIntegration:engine];
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
