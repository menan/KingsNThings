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
    //int combatValue;
    //BOOL special;
    //BOOL bluff;
    BOOL inBowl;
    int position;
    NSString* imageName;
   
    NSString* name;
    
    int numberofTimes;

}

@synthesize combatValue,special, bluff, symbol,isFly, isMagic, isMelee, isRanged , isCharge ;

@synthesize node;

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
        symbol = cType;
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


- (id) initWithBoard:(SKSpriteNode *)aBoard atPoint:(CGPoint)aPoint fromString:(NSString *)string isSpecial: (BOOL) _special{
    self = [super init];
    if (self) {
        point = aPoint;
        board = aBoard;
        imageName = [NSString stringWithFormat:@"%@.jpg",string];
        bluff = NO;
        inBowl = YES;
        numberofTimes = 1;
        special = _special;
        [self setValuesFromString:string];
    }
    return self;
}

- (id) initWithImage:(NSString*)image{
    self = [super init];
    if (self) {
       // point = aPoint;
        //board = aBoard;
        imageName = [NSString stringWithFormat:@"%@.jpg",image];
        bluff = NO;
        inBowl = NO;
        numberofTimes = 1;
        [self setValuesFromString:image];
    }
    return self;
    
    
}


- (void) setValuesFromString:(NSString *) values{
    NSMutableArray *array = [[values componentsSeparatedByString:@"-"] mutableCopy];
    [array removeObjectAtIndex:0];
    
    for(NSString *value in array){
        NSString *trimmed = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if ([trimmed hasPrefix:@"n"]){
            name = [trimmed substringFromIndex:2];
        }
        else if ([trimmed hasPrefix:@"t"]){
            terrainType = [trimmed substringFromIndex:2];
        }
        else if ([trimmed hasPrefix:@"s"]){
            
            if(![trimmed hasPrefix:@"a"])
            {
                isMelee = YES;
                //symbol = @"Melee";
              combatValue = [[trimmed substringFromIndex:2 ]integerValue];
            }
            else
                if([[trimmed substringFromIndex:2] isEqualToString:@"Magic"])
                    isMagic = YES;
            
                if ([[trimmed substringFromIndex:2] isEqualToString:@"Ranged"])
                    isRanged = YES;
                if([[trimmed substringFromIndex:2] isEqualToString:@"Charge"])
                    isCharge = YES;
                if([[trimmed substringFromIndex:2] isEqualToString:@"Fly"])
                    isCharge = YES;
            
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
    node = [SKSpriteNode spriteNodeWithImageNamed:imageName];
    [node setName:name];
    node.size = CGSizeMake(38,38);
    [node setPosition:point];
    if (inBowl && special == NO) {
        node.color = [SKColor blackColor];
        node.colorBlendFactor = .85;
    }
    else{
        
        node.color = [SKColor grayColor];
        node.colorBlendFactor = 0;
    }
    [board addChild:node];
}
@end
