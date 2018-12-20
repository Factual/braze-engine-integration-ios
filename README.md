# Description

This repository contains the code for an integration between Factual's Engine SDK and Braze SDK. 
Using this integration library you can configure Factual's Engine SDK to send Braze custom events
when the user is at a known factual place or when an engine circumstance with the actionId ```push-to-braze```
is met. The following is a description of the custom events sent to Braze: 

## User Journey Events

***Name***: engine_user_journey

***Description***: User has visited a known factual place

***Properties***: 
* name (place name)
* factual_id (factual unique identifier for place)
* latitude
* longitude
* user_latitude
* user_longitude 
* place_categories (comma separated factual category ids)

## Circumstance Met Events

***Name***: engine_circumstance_[CIRCUMSTANCE_NAME]

***Description***: A circumstance with actionId ```push-to-braze``` has been met

***Properties***: 
* incidence_id
* user_latitude
* user_longitude

## Circumstance Met At Place

***Name***: engine_circumstance_place_at_[CIRCUMSTANCE_NAME]

***Properties***: 
* incidence_id
* name (place name)
* factual_id (factual unique identifier for place)
* latitude
* longitude
* user_latitude
* user_longitude 
* place_categories (comma separated factual category ids)

***Description***: Additional place related information about place at which the circumstance was met. 
             Based on the specificity of the circumstance rule it is possible that multiple places may
             simultaneously trigger the circumstance. We choose to not include all of the places within the 
             event properties of a single event to simplify the usage within the Braze dashboard. 
             Instead, for each place that triggered the original circumstance we send a slightly 
             different custom event.
             
***Note***: Use incidence_id to map the different Braze circumstance events to a single instance of an Engine circumstance met.

# Installation

## Cocoapods

```ruby
source 'https://github.com/Factual/cocoapods.git'
source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '8.0'

target 'YourApp' do
  pod 'BrazeEngine'
end
```

### Note: Cocoapods and Firebase
Installing both Firebase and Engine through Cocoapods creates a compatibility issue. To work around the issue, remove the line `pod 'BrazeEngine'` from your Podfile, re-run `pod install`, and manually install both Engine and the BrazeEngine integration library according to [Manual Installation](#manual-installation), below.

## Manual installation
Download the BrazeEngine static library from [Bintray](https://factual.bintray.com/files) and add it to your Xcode project. Static library installation is explained at [Copying the Engine SDK to your project](http://developer.factual.com/engine/ios/#copy-the-sdk-to-your-project). Make sure to add both libBrazeEngine.a and libFactualEngine.a (if you do not have it already).

***Note: You must have Engine SDK already added to your Xcode project in order to use the library.***


# Usage Requirements

* Configured and started `Engine` client. [see here](http://developer.factual.com/engine/ios/)
* Configured `Appboy` client. [see here](https://www.braze.com/documentation/iOS/#initial-sdk-setup)

# Usage

Start tracking Factual's Engine UserJourney and Circumstance events after receiving the engine started
callback within FactualEngineDelegate. 

```objective-c
- (void)engineDidStartWithInstance:(FactualEngine *)engine {
  //Track both user journey and circumstance events
  [BrazeEngine trackUserJourneyAndCircumstancesWithEngine:engine]
}
```

```objective-c
- (void)engineDidStartWithInstance:(FactualEngine *)engine {
  //track only circumstance events
  [BrazeEngine trackCircumstancesWithEngine:engine withUserJourneyEnabled:false]
}
```

# Demo App

A demo app is included in this repository to demonstrate the usage of this library. [see here](demo)
