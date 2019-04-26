//
//  EngineDelegate.m
//  BrazeFactualEngineDemo
//
//  Created by Nathan Lamb on 4/26/19.
//  Copyright © 2019 Factual Inc. All rights reserved.
//

#import "AppDelegate.h"
#import "BrazeEngine.h"
#import "EngineDelegate.h"

@implementation EngineDelegate

FactualEngine *_engine = nil;

+ (FactualEngine *)engine {
    return _engine;
}

- (void)engineDidStartWithInstance:(FactualEngine *)engine {
    NSLog(@"Engine started.");
    [engine syncWithGarage];
    _engine = engine;
    [BrazeEngine trackCircumstancesWithEngine:engine];
    [BrazeEngine trackUserJourneySpans];
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

- (void)engineDidReportDiagnosticMessage:(NSString *)diagnosticMessage{
    NSLog(@"Engine diagnostic message: %@", diagnosticMessage);
}

@end
