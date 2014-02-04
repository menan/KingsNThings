//
//  Player.h
//  KingsNThings
//
//  Created by Menan Vadivel on 1/28/2014.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Bank.h"
#import "Terrain.h"

@interface Player : NSObject


typedef enum Stage : NSUInteger {
    Tower,
    Keep,
    Castle,
    Citadel
}Stage;

- (BOOL) setTerritory: (Terrain *) territory;
- (int) getBankBalance;
- (Stage) getStage;
@end
