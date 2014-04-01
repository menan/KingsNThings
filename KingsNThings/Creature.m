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
    //NSString* combatType;
    int position;
    int numberofTimes;

}

@synthesize combatValue,isSpecial, isBluff, isFly,name,inBowl,imageName, terrainType,combatType,initialPoint;

//@synthesize node;

- (id)initWithBoard: (SKSpriteNode *) aBoard atPoint: (CGPoint) aPoint imageNamed: (NSString *) image andCreatureName: (NSString *) cName withCombatValue: (int) value forTerrainType: (NSString *) terrain isSpecial:(BOOL) iSpecial andCombatType:(NSString *) cType
{
    self = [super initWithImageNamed:image];
    if (self) {
       initialPoint = aPoint;
        board = aBoard;
        imageName = image;
        name = cName;
        isBluff = NO;
        inBowl = YES;
        
        terrainType = terrain;
        combatValue = value;
        numberofTimes = 1;
       isSpecial = iSpecial;
    }
    return self;
}
- (id) initWithBoard:(SKSpriteNode *)aBoard atPoint:(CGPoint)aPoint fromString:(NSString *)string{
    //self = [super init];
    self = [super initWithImageNamed:[NSString stringWithFormat:@"%@.jpg",string]];
    if (self) {
        initialPoint = aPoint;
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
    self = [super initWithImageNamed:[NSString stringWithFormat:@"%@.jpg",string]];
    if (self) {
        initialPoint = aPoint;
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
    self = [super initWithImageNamed:[NSString stringWithFormat:@"%@.jpg",image]];
    if (self) {
      initialPoint = aPoint;
        
        imageName = [NSString stringWithFormat:@"%@.jpg",image];
       isBluff = NO;
        inBowl = NO;
        numberofTimes = 1;
      
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
    if(!isMagic && !isRanged){
        combatType = isMelee;
    }
    
    
}

- (void) draw{
    [self removeFromParent]; //makes sure that it removes it to prevent duplications
    //self.spriteNodeWithImageNamed = imageName;
    
    self.name = name;
    //self.accessibilityValue = @"creatures";
    self.size = CGSizeMake(37,37);
    self.position = initialPoint;
    if (inBowl && isSpecial == NO) {
       self.color = [SKColor blackColor];
       self.colorBlendFactor = .85;
    }
    else{
        
        //self.color = [SKColor grayColor];
        self.colorBlendFactor = 0;
    }
    [board addChild:self];
}
- (void) drawAtPoint:(SKSpriteNode*)location{
    //[self removeFromParent]; //makes sure that it removes it to prevent duplications
    //self.spriteNodeWithImageNamed = imageName;
    
    self.name = name;
    //self.accessibilityValue = @"creatures";
    self.size = CGSizeMake(37,37);
    //self.position = initialPoint;
    
    [location addChild:self];
}
/*- (void) draw{
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
}*/


- (NSDictionary *) getDict{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:[NSNumber numberWithFloat:initialPoint.x] forKey:@"X"];
    [dict setObject:[NSNumber numberWithFloat:initialPoint.y] forKey:@"Y"];
    [dict setObject:imageName forKey:@"imageName"];
    return dict;
}
@end
