//
//  Creature.h
//  KingsNThings
//
//  Created by Mac5 on 1/28/2014.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@interface Creature : NSObject
@property (nonatomic, strong) SKSpriteNode* node;

@property int combatValue;
@property BOOL isSpecial;
@property BOOL isBluff, isFly, isMagic, isMelee, isRanged , isCharge ,inBowl ;
@property NSString* symbol;
@property NSString* name, *imageName, *terrainType;


- (id)initWithBoard: (SKSpriteNode *) aBoard atPoint: (CGPoint) aPoint imageNamed: (NSString *) image andCreatureName: (NSString *) cName withCombatValue: (int) value forTerrainType: (NSString *) terrain isSpecial:(BOOL) special andCombatType:(NSString *) cType;
- (id) initWithBoard:(SKSpriteNode *)aBoard atPoint:(CGPoint)aPoint fromString:(NSString *)string;
- (id) initWithBoard:(SKSpriteNode *)aBoard atPoint:(CGPoint)aPoint fromString:(NSString *)string isSpecial: (BOOL) _special;
- (void) draw;
- (id)initWithImage:(NSString*)image atPoint:(CGPoint)aPoint;

@end
