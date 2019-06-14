/*
 * Use of this software is subject to the terms and
 * conditions of the license agreement between you
 * and Factual Inc
 *
 * Copyright © 2019 Factual Inc. All rights reserved.
 */

#import "AppDelegate.h"
#import "BrazeEngine.h"
#import "Configuration.h"
#import "EngineDelegate.h"
#import "FactualEngine.h"

@interface AppboyEndpointDelegate : NSObject <ABKAppboyEndpointDelegate>
@end

@implementation AppboyEndpointDelegate
- (NSString *) getApiEndpoint:(NSString *)appboyApiEndpoint {
  return [appboyApiEndpoint stringByReplacingOccurrencesOfString:@"dev.appboy.com" withString:[Configuration brazeEndpoint]];
}
@end

@interface AppDelegate ()
@property CLLocationManager *manager; // Engine assumes you are managing location permissions
@property EngineDelegate *engineDelegate;
@end

@implementation AppDelegate

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
  if (_engineDelegate == nil) {
    _engineDelegate = [[EngineDelegate alloc] init];
  }
  [FactualEngine startWithApiKey:[Configuration engineApiKey]
                        delegate:_engineDelegate
             userJourneyDelegate:[[BrazeEngineUserJourneyHandler alloc] init]];
  
  [Appboy startWithApiKey:[Configuration brazeApiKey]
            inApplication:application
        withLaunchOptions:launchOptions
        withAppboyOptions:@{ABKAppboyEndpointDelegateKey: [[AppboyEndpointDelegate alloc] init]}];
  
  [[Appboy sharedInstance] changeUser:[Configuration brazeUser]];
  [[[Appboy sharedInstance] user] setEmail:[Configuration brazeUserEmail]];
  
  // Register device for APN
  if (@available(iOS 10.0, *)) {
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate = self;
    UNAuthorizationOptions options = UNAuthorizationOptionAlert | UNAuthorizationOptionSound | UNAuthorizationOptionBadge;
    [center requestAuthorizationWithOptions:options
                          completionHandler:^(BOOL granted, NSError * _Nullable error) {
                            [[Appboy sharedInstance] pushAuthorizationFromUserNotificationCenter:granted];
                          }];
    [[UIApplication sharedApplication] registerForRemoteNotifications];
  } else {
    UIUserNotificationSettings *settings = [UIUserNotificationSettings
                                            settingsForTypes:(UIUserNotificationTypeBadge |
                                                              UIUserNotificationTypeAlert |
                                                              UIUserNotificationTypeSound)
                                            categories:nil];
    
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
  }
  
  
  return YES;
}

// ---- methods to support the push notifications ----
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
  [[Appboy sharedInstance] registerPushToken:
   [NSString stringWithFormat:@"%@", deviceToken]];
}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
  [[Appboy sharedInstance] registerApplication:application
                  didReceiveRemoteNotification:userInfo
                        fetchCompletionHandler:completionHandler];
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center
didReceiveNotificationResponse:(UNNotificationResponse *)response
         withCompletionHandler:(void (^)(void))completionHandler
API_AVAILABLE(ios(10.0)) {
  [[Appboy sharedInstance] userNotificationCenter:center
                   didReceiveNotificationResponse:response
                            withCompletionHandler:completionHandler];
}

// display foreground push notifications as notifications
- (void)userNotificationCenter:(UNUserNotificationCenter *)center
       willPresentNotification:(UNNotification *)notification
         withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler
API_AVAILABLE(ios(10.0)) {
  completionHandler(UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert | UNNotificationPresentationOptionBadge);
}

@end
