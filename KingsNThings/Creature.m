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
    
    //BOOL inBowl;
    int position;
    //NSString* imageName;
   
    //NSString* name;
    
    int numberofTimes;

}

@synthesize combatValue,isSpecial, isBluff, symbol,isFly, isMagic, isMelee, isRanged , isCharge,name,inBowl,imageName, terrainType;

@synthesize node;

- (id)initWithBoard: (SKSpriteNode *) aBoard atPoint: (CGPoint) aPoint imageNamed: (NSString *) image andCreatureName: (NSString *) cName withCombatValue: (int) value forTerrainType: (NSString *) terrain isSpecial:(BOOL) iSpecial andCombatType:(NSString *) cType
{
    self = [super init];
    if (self) {
        point = aPoint;
        board = aBoard;
        imageName = image;
        name = cName;
        isBluff = NO;
        inBowl = YES;
        symbol = cType;
        terrainType = terrain;
        combatValue = value;
        numberofTimes = 1;
       isSpecial = iSpecial;
    }
    return self;
}
- (id) initWithBoard:(SKSpriteNode *)aBoard atPoint:(CGPoint)aPoint fromString:(NSString *)string{
    self = [super init];
    if (self) {
        point = aPoint;
        board = aBoard;
        imageName = [NSString stringWithFormat:@"%@.jpg",string];
       isBluff = NO;
        inBowl = YES;
        numberofTimes = 1;
        [self setValuesFromString:string];
    }
    return self;
}


- (id) initWithBoard:(SKSpriteNode *)aBoard atPoint:(CGPoint)aPoint fromString:(NSString *)string isSpecial: (BOOL) s{
    self = [super init];
    if (self) {
        point = aPoint;
        board = aBoard;
        imageName = [NSString stringWithFormat:@"%@.jpg",string];
       isBluff = NO;
        inBowl = YES;
        numberofTimes = 1;
       isSpecial = s;
        [self setValuesFromString:string];
    }
    return self;
}

- (id) initWithImage:(NSString*)image atPoint:(CGPoint)aPoint{
    self = [super init];
    if (self) {
       point = aPoint;
        
        imageName = [NSString stringWithFormat:@"%@.jpg",image];
       isBluff = NO;
        inBowl = NO;
        numberofTimes = 1;
        isCharge = NO;
        isMagic = NO;
        isMelee = NO;
        isRanged = NO;
        isFly = NO;
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
//            NSLog(@"Name: %@", name);
        }
        else if ([trimmed hasPrefix:@"t"]){
            terrainType = [trimmed substringFromIndex:2];
//            NSLog(@"terrainType: %@", terrainType);
        }
        else if ([trimmed hasPrefix:@"s"]){
            
            isMagic = [[trimmed substringFromIndex:2] isEqualToString:@"Magic"];
            isRanged = [[trimmed substringFromIndex:2] isEqualToString:@"Range"];
            isCharge = [[trimmed substringFromIndex:2] isEqualToString:@"Charge"];
            isFly = [[trimmed substringFromIndex:2] isEqualToString:@"Fly"];
            //isMelee = [[trimmed substringFromIndex:2] isEqualToString:@"Melee"];
            symbol = [trimmed substringFromIndex:2];
//            NSLog(@"symbol: %@", symbol);
        }
        else if ([trimmed hasPrefix:@"a"]){
            combatValue = [[trimmed substringFromIndex:2] integerValue];
//            NSLog(@"combatValue: %d", combatValue);
        }
        else if ([trimmed hasPrefix:@"c"]){
            
            numberofTimes = [[trimmed substringFromIndex:2] integerValue];
//            NSLog(@"numberofTimes: %d", numberofTimes);
        }
        else if ([trimmed hasPrefix:@"p"]){
            isSpecial = YES;
        }
        else {
//            NSLog(@"something else occured: %@",trimmed);
        }
        
    }
    if(!isMagic && !isRanged){
        isMelee = YES;
    }
    
    
}

- (void) draw{
    [node removeFromParent]; //makes sure that it removes it to prevent duplications
    node = [SKSpriteNode spriteNodeWithImageNamed:imageName];
    node.name = name;
    node.accessibilityValue = @"creatures";
    node.size = CGSizeMake(37,37);
    node.position = point;
    if (inBowl && isSpecial == NO) {
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
