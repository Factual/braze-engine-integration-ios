//
//  EngineDelegate.h
//  BrazeFactualEngineDemo
//
//  Created by Nathan Lamb on 4/26/19.
//  Copyright © 2019 Factual Inc. All rights reserved.
//

#ifndef EngineDelegate_h
#define EngineDelegate_h

#import "FactualEngine.h"

@interface EngineDelegate : NSObject <FactualEngineDelegate>
@property (class, readonly) FactualEngine *engine;
@end

#endif /* EngineDelegate_h */
