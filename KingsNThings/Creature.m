//
//  Creature.m
//  KingsNThings
//
//  Created by Mac5 on 1/28/2014.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import "Creature.h"

@implementation Creature{
    CGPoint point;
    SKSpriteNode *board;
    NSString* combatType;
    NSString* terrainType;
    int combatValue;
    BOOL special;
    BOOL bluff;
    BOOL inBowl;
    int position;
    NSString* imageName;
    NSString* symbol;
    NSString* name;
    
    int numberofTimes;

}

- (id)initWithBoard: (SKSpriteNode *) aBoard atPoint: (CGPoint) aPoint imageNamed: (NSString *) image andCreatureName: (NSString *) cName withCombatValue: (int) value forTerrainType: (NSString *) terrain isSpecial:(BOOL) iSpecial andCombatType:(NSString *) cType
{
    self = [super init];
    if (self) {
        point = aPoint;
        board = aBoard;
        imageName = image;
        name = cName;
        bluff = NO;
        inBowl = YES;
        combatType = cType;
        terrainType = terrain;
        combatValue = value;
        numberofTimes = 1;
        special = iSpecial;
    }
    return self;
}
- (id) initWithBoard:(SKSpriteNode *)aBoard atPoint:(CGPoint)aPoint fromString:(NSString *)string{
    self = [super init];
    if (self) {
        point = aPoint;
        board = aBoard;
        imageName = [NSString stringWithFormat:@"%@.jpg",string];
        bluff = NO;
        inBowl = YES;
        numberofTimes = 1;
        [self setValuesFromString:string];
    }
    return self;
}

- (void) setValuesFromString:(NSString *) values{
    NSMutableArray *array = [[values componentsSeparatedByString:@"-"] mutableCopy];
    [array removeObjectAtIndex:0];
    
    for(NSString *value in array){
        NSString *trimmed = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//        NSLog(@"parsing string : %@",trimmed);
        if ([trimmed hasPrefix:@"n"]){
            name = [trimmed substringFromIndex:2];
        }
        else if ([trimmed hasPrefix:@"t"]){
            terrainType = [trimmed substringFromIndex:2];
        }
        else if ([trimmed hasPrefix:@"s"]){
            symbol = [trimmed substringFromIndex:2];
        }
        else if ([trimmed hasPrefix:@"a"]){
            combatValue = [[trimmed substringFromIndex:2] integerValue];
        }
        else if ([trimmed hasPrefix:@"c"]){
            numberofTimes = [[trimmed substringFromIndex:2] integerValue];
        }
        else{
            NSLog(@"something else occured: %@",trimmed);
        }
    }
    
}

- (void) draw{
    SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:imageName];
    [sprite setName:name];
    sprite.size = CGSizeMake(36,36);
    [sprite setPosition:point];
    if (inBowl && special == NO) {
        sprite.color = [SKColor blackColor];
        sprite.colorBlendFactor = .85;
    }
    else{
        
        sprite.color = [SKColor grayColor];
        sprite.colorBlendFactor = 0;
    }
    [board addChild:sprite];
}
@end
