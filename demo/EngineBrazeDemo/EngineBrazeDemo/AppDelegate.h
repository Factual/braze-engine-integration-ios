//
//  AppDelegate.h
//  EngineBrazeDemo
//
//  Created by Sevada Abraamyan on 1/25/18.
//  Copyright © 2018 Factual Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FactualEngine.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,FactualEngineDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (class, readwrite) FactualEngine *engine;

@end

