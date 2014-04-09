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
    int position;
    int numberofTimes;

}

@synthesize combatValue,isSpecial, isBluff, isFly,name,inBowl,imageName, terrainType,combatType,initialPoint,stepsMoved,creatureName;

//@synthesize node;

- (id)initWithBoard: (SKSpriteNode *) aBoard atPoint: (CGPoint) aPoint imageNamed: (NSString *) image andCreatureName: (NSString *) cName withCombatValue: (int) value forTerrainType: (NSString *) terrain isSpecial:(BOOL) iSpecial andCombatType:(NSString *) cType
{
    self = [super initWithImageNamed:image];
    if (self) {
        initialPoint = aPoint;
        self.position = aPoint;
        board = aBoard;
        imageName = image;
        name = cName;
        isBluff = NO;
        inBowl = YES;
        
        terrainType = terrain;
        combatValue = value;
        numberofTimes = 1;
        isSpecial = iSpecial;
        stepsMoved = 0;
        combatType = NONE;
        self.size = CGSizeMake(37,37);
    }
    return self;
}
- (id) initWithBoard:(SKSpriteNode *)aBoard atPoint:(CGPoint)aPoint fromString:(NSString *)string{
    self = [super initWithImageNamed:[NSString stringWithFormat:@"%@.jpg",string]];
    if (self) {
        initialPoint = aPoint;
        self.position = aPoint;
        board = aBoard;
        imageName = string;
        isBluff = NO;
        inBowl = YES;
        numberofTimes = 1;
        stepsMoved = 0;
        combatType = NONE;
        self.size = CGSizeMake(37,37);
        [self setValuesFromString:string];
    }
    return self;
}


- (id) initWithBoard:(SKSpriteNode *)aBoard atPoint:(CGPoint)aPoint fromString:(NSString *)string isSpecial: (BOOL) s{
    self = [super initWithImageNamed:[NSString stringWithFormat:@"%@.jpg",string]];
    if (self) {
        initialPoint = aPoint;
        self.position = aPoint;
        board = aBoard;
        imageName = string;
       isBluff = NO;
        inBowl = YES;
        numberofTimes = 1;
       isSpecial = s;
        stepsMoved = 0;
        combatType = NONE;
        self.size = CGSizeMake(37,37);
        [self setValuesFromString:string];
    }
    return self;
}

- (id) initWithImage:(NSString*)image atPoint:(CGPoint)aPoint{
    self = [super initWithImageNamed:[NSString stringWithFormat:@"%@.jpg",image]];
    if (self) {
      initialPoint = aPoint;
        self.position = aPoint;
        imageName = image;
       isBluff = NO;
        inBowl = NO;
        numberofTimes = 1;
      
        isFly = NO;
        stepsMoved = 0;
        combatType = NONE;
        self.size = CGSizeMake(37,37);
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
            creatureName = [trimmed substringFromIndex:2];
            name = [trimmed substringFromIndex:2];
//            NSLog(@"Name: %@", name);
        }
        else if ([trimmed hasPrefix:@"t"]){
            terrainType = [trimmed substringFromIndex:2];
//            NSLog(@"terrainType: %@", terrainType);
        }
        else if ([trimmed hasPrefix:@"s"]){
            
            if([[trimmed substringFromIndex:2] isEqualToString:@"Magic"])
                combatType = isMagic;
           else if([[trimmed substringFromIndex:2] isEqualToString:@"Range"])
               combatType = isRanged;
           else if([[trimmed substringFromIndex:2] isEqualToString:@"Charge"])
                combatType = isCharge;
            
            isFly = [[trimmed substringFromIndex:2] isEqualToString:@"Fly"];
            //isMelee = [[trimmed substringFromIndex:2] isEqualToString:@"Melee"];
           // symbol = [trimmed substringFromIndex:2];
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
    if(combatType != isMagic && combatType != isRanged && combatType != isCharge){
        combatType = isMelee;
    }
    isBluff = YES;
    
}

- (void) remove{
    [[board childNodeWithName:[NSString stringWithFormat:@"%@.jpg",imageName]] removeFromParent];
}

- (void) draw{
    [self remove];
    
    self.name = [NSString stringWithFormat:@"%@.jpg",imageName];
    
    if (inBowl && isSpecial == NO) {
       self.color = [SKColor blackColor];
       self.colorBlendFactor = .85;
    }
    else{
        self.colorBlendFactor = 0;
    }
    
    [board addChild:self];
}


- (void) drawAtPoint:(SKSpriteNode*)location{
    self.name = [NSString stringWithFormat:@"%@.jpg",imageName];
    self.size = CGSizeMake(37,37);
    [location addChild:self];
}


- (NSDictionary *) getDict{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:[NSNumber numberWithFloat:initialPoint.x] forKey:@"X"];
    [dict setObject:[NSNumber numberWithFloat:initialPoint.y] forKey:@"Y"];
    [dict setObject:[NSNumber numberWithFloat:isBluff] forKey:@"isBluff"];
    [dict setObject:imageName forKey:@"imageName"];
    [dict setObject:[NSNumber numberWithInt:NO] forKey:@"si"];
    return dict;
}
@end
