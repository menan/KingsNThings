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

@property NSMutableArray* armies; // collection of armies
@property NSMutableArray* singleArmy; // single armies (eg stack one )
@property NSInteger playingOrder;

typedef enum Stage : NSUInteger {
    Tower,
    Keep,
    Castle,
    Citadel
}Stage;

- (BOOL) setTerritory: (Terrain *) territory;
- (int) getBankBalance;
-(id) initWithArmy:(NSMutableArray *)army;
-(void) constructArmy:(NSMutableArray *) army;
- (Stage) getStage;
@end
