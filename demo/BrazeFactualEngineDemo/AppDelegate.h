/*
 * Use of this software is subject to the terms and
 * conditions of the license agreement between you
 * and Factual Inc
 *
 * Copyright © 2017 Factual Inc. All rights reserved.
 */

#import <UIKit/UIKit.h>
#import "FactualEngine.h"
#import "Appboy_iOS_SDK/AppboyKit.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, FactualEngineDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (class, readwrite) FactualEngine *engine;

@end

