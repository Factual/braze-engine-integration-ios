# Factual / Braze SDK for iOS

This repository contains the code for an integration between [Factual's Engine SDK](https://www.factual.com/products/engine/)
and [Braze SDK](https://www.braze.com/). Using this library you can configure Factual's Location Engine SDK to send custom
events to Braze to better understand users in the physical world and build personalized experiences to drive user
engagement and revenue.

### Integration with Braze UI

see: [braze-engine-integration](https://github.com/Factual/braze-engine-integration)

# Installation

### Cocoapods

```ruby
source 'https://github.com/Factual/cocoapods.git'
source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '8.0'

target 'YourApp' do
  pod 'BrazeEngine'
end
```

### Manual installation
Download the library from [Bintray](https://factual.bintray.com/files/) and add it to your Xcode project. Note that the Engine SDK must be added to your Xcode project in order to use this library. Please refer to the [Factual Developer Docs](http://developer.factual.com)

# Usage

### Requirements
* Configured and started `Engine` client. [see here](http://developer.factual.com/engine/ios/)
* Configured `Braze` client. [see here](https://www.braze.com/documentation/iOS/#initial-sdk-setup)

### Tracking Factual Engine Circumstances

Start tracking Engine's Circumstance events after receiving the Engine started callback within the FactualEngineDelegate.

```objective-c
- (void)engineDidStartWithInstance:(FactualEngine *)engine {
  NSLog(@"Engine started.");

  // Max number of "engine_circumstance_at_place" events that should be sent per "engine_circumstance_met"
  // default is set to 10.
  int maxAtPlaceEvents = 3;

  // Max number of "engine_circumstance_at_place" events that should be sent per "engine_circumstance_met"
  // default is set to 10.
  int maxNearPlaceEvents = 5;

  [BrazeEngine trackCircumstancesWithEngine:engine
        withMaxAtPlaceEventsPerCircumstance:maxAtPlaceEvents
      withMaxNearPlaceEventsPerCircumstance:maxNearPlaceEvents];
}
```

### Tracking Factual Engine User Journey Spans

Start tracking User Journey Spans by first adding the `BrazeEngineUserJourneyHandler` delegate on
`[FactualEngine startWithApiKey:delegate:userJourneyDelegate:]`

```objective-c
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

  ...

  // Max number of "engine_span_attached_place" events that should be sent per "engine_span_occurred"
  // default is 20.
  int maxAttachedPlaces = 10;
  [FactualEngine startWithApiKey:[Configuration engineApiKey]
                        delegate:[self engineDelegate]
             userJourneyDelegate:[[BrazeEngineUserJourneyHandler alloc] initWithMaxAttachedPlaceEventsPerEvent:maxAttachedPlaces]];

  return YES;
}
```

Then in the Engine started callback within the FactualEngineDelegate add the line `[BrazeEngine trackUserJourneySpans];`

```objective-c
- (void)engineDidStartWithInstance:(FactualEngine *)engine {
  NSLog(@"Engine started.");
  [BrazeEngine trackUserJourneySpans];
}
```


```objective-c
- (void)engineDidStartWithInstance:(FactualEngine *)engine {
  //track only circumstance events
  [BrazeEngine trackCircumstancesWithEngine:engine withUserJourneyEnabled:false]
}
```

Please refer to the [Factual Developer Docs](http://developer.factual.com) for more information about Engine.

# Example App

A example app is included in this repository to demonstrate the usage of this library, see [./example](./example) for documentation and usage instructions.
