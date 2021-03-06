//
//  Creature.h
//  KingsNThings
//
//  Created by Mac5 on 1/28/2014.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@interface Creature : SKSpriteNode

typedef enum CombatStrength:NSUInteger{
    isMagic,
    isMelee,
    isRanged,
    isCharge,
    NONE
    
}CombatStrength;


@property CombatStrength combatType;
@property int combatValue;
@property BOOL isSpecial;
@property BOOL isBluff, isFly,inBowl ;
@property NSString* symbol;
@property NSString* name, *imageName, *terrainType, *creatureName;
@property CGPoint initialPoint;
@property int stepsMoved;


- (id)initWithBoard: (SKSpriteNode *) aBoard atPoint: (CGPoint) aPoint imageNamed: (NSString *) image andCreatureName: (NSString *) cName withCombatValue: (int) value forTerrainType: (NSString *) terrain isSpecial:(BOOL) special andCombatType:(NSString *) cType;

- (id) initWithBoard:(SKSpriteNode *)aBoard atPoint:(CGPoint)aPoint fromString:(NSString *)string;
- (id) initWithBoard:(SKSpriteNode *)aBoard atPoint:(CGPoint)aPoint fromString:(NSString *)string isSpecial: (BOOL) _special;

- (void) draw;
- (void) remove;


- (id)initWithImage:(NSString*)image atPoint:(CGPoint)aPoint;
- (void) drawAtPoint:(SKSpriteNode*)location;
- (NSDictionary *) getDict;

@end
