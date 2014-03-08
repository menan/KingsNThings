//
//  CombatPhase.h
//  KingsNThings
//
//  Created by Areej Ba Salamah and Menan Vadivel on 2/8/2014.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"

#import "CombatScene.h"


@interface CombatPhase : NSObject

@property NSMutableArray* attackerMagicCreature ;
@property NSMutableArray* defenderMagicCreature;
@property NSMutableArray* attackerRangedCreature;
@property NSMutableArray* defenderRangedCreature;
@property NSMutableArray* attackerMeleeCreature;
@property NSMutableArray* defenderMeleeCreature ;

@property Building* building;

@property NSInteger attackerNumberOfHits,defenderNumberOfHits;

@property NSInteger diceOne, diceTwo;
@property NSMutableArray* attackerRolledDice, *defenderRolledDice;
@property NSInteger attakerChargeCreatures ,defenderChargeCreatures;




@property BOOL isMagicRound,isRangedRound,isMeleeRound,isAttacker,isDefender;

@property Player* attacker,*defender;
@property Army* attackerArmy,*defenderArmy;


-(id) initWithAttacker:(Player*)att andDefender:(Player*)def andAttackerArmy:(id)attArmy andDefenderArmy:(id)defArmy andMainScene:(id)sce;
-(void) startCombat:(CombatScene*) combatScene;
-(void)drawScene;
-(void)updateArmy:(NSString*)creatureName andPlayerType:(NSString*)player;

@end
