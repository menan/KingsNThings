//
//  GamePlay.h
//  KingsNThings
//
//  Created by Menan Vadivel on 2/1/2014.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"

@interface GamePlay : NSObject

@property Player *player1;
@property Player *player2;
@property Player *player3;
@property Player *player4;
@property NSInteger oneDice;
@property NSInteger secondDice;
@property NSMutableArray *players;

@property BOOL goldCollectionCompleted;

-(id) initWith4Players;
-(void) combatPhase:(Player *)attacker withArmy:(NSMutableArray*)attackerArmy andPlayer:(Player*)defender withArmy:(NSMutableArray*)defenderArmy;
//- (BOOL) initiateGoldCollection;
@end
