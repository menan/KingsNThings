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
#import "SpecialIncome.h"



@interface CombatPhase : NSObject

typedef enum CreatureCombatType : NSUInteger {
    exploration,
    defendingHex

}CreatureCombatType;

typedef enum Rtreated:NSUInteger{
    attackerRetreated,
    defenderRetreated,
    NoOne
}Retreated;

typedef enum Round: NSUInteger{
    MagicRound,
    MeleeRound,
    RangedRound
    
}Round;

@property CreatureCombatType type;
@property Round round;
@property Retreated whoRetreated;

@property NSMutableArray* attackerMagicCreature ;
@property NSMutableArray* defenderMagicCreature;
@property NSMutableArray* attackerRangedCreature;
@property NSMutableArray* defenderRangedCreature;
@property NSMutableArray* attackerMeleeCreature;
@property NSMutableArray* defenderMeleeCreature ;
@property SKSpriteNode* battle;
@property NSMutableArray* thingsToBeReturned;
@property NSMutableArray* specialIncomeCounters;
@property SpecialIncome* specialIncomeDefend;

@property Building* building;


@property int attackerNumberOfHits,defenderNumberOfHits;

@property int diceOne, diceTwo;
@property NSMutableArray* attackerRolledDice, *defenderRolledDice;
@property int attakerChargeCreatures ,defenderChargeCreatures;




//@property BOOL isMagicRound,isRangedRound,isMeleeRound;
@property BOOL isAttacker;

@property Player* attacker,*defender;
@property Army* attackerArmy,*defenderArmy;

-(id) initWithMarkerAtPoint:(CGPoint) aPoint onBoard:(id) aBoard andMainScene:(id)sce ;
-(id) initWithAttacker:(Player*)att andDefender:(Player*)def andAttackerArmy:(id)attArmy andDefenderArmy:(id)defArmy andMainScene:(id)sce ofType:(CreatureCombatType) type;
-(void) startCombat:(CombatScene*) combatScene;
-(void)drawScene;
-(void)updateArmy:(NSString*)creatureName andPlayerType:(NSString*)player;
-(Terrain*) adjacentHexToRetreat:(Player*) player;

@end
