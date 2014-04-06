//
//  specialIncome.m
//  KingsNThings
//
//  Created by Areej Ba Salamah and Menan Vadivel  on 2/3/2014.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import "SpecialIncome.h"

@implementation SpecialIncome{
    SKSpriteNode *board;
    int position;
    NSString *imageName;
}

@synthesize goldValue,inBowl,terrainType,type,terrain,initialPoint,combatValue;

//@synthesize node;

- (id)initWithBoard: (SKSpriteNode *) aBoard atPoint: (CGPoint) aPoint imageNamed: (NSString *) image andCounterName: (NSString *) cName withGoldValue: (int) value forTerrainType: (NSString *) ter{
    self = [super initWithImageNamed:image];
    if (self) {
        initialPoint = aPoint;
        board = aBoard;
        //name = cName;
       
        inBowl = YES;
        
        terrainType = ter;
        goldValue = value;
        self.size = CGSizeMake(37,37);
        combatValue = goldValue;
       
        
    }
    return self;
}
- (id) initWithBoard:(SKSpriteNode *)aBoard atPoint:(CGPoint)aPoint fromString:(NSString *)string{
    self = [super initWithImageNamed:[NSString stringWithFormat:@"%@.jpg",string]];
    if (self) {
        
        initialPoint = aPoint;
        board = aBoard;
        imageName = string;
        
        inBowl = YES;
        self.size = CGSizeMake(37,37);
        
        [self setValuesFromString:string];
    }
    return self;
}



- (id) initWithImage:(NSString*)image atPoint:(CGPoint)aPoint{
    self = [super initWithImageNamed:[NSString stringWithFormat:@"%@.jpg",image]];
    if (self) {
        initialPoint = aPoint;
        
        inBowl = NO;
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
            super.name = [trimmed substringFromIndex:2];
            
           if([[trimmed substringFromIndex:2] isEqualToString:@"City"])
               type = City;
            else if ([[trimmed substringFromIndex:2] isEqualToString:@"Village"])
                type = Village;
           
        }
        else if ([trimmed hasPrefix:@"t"]){
            if([[trimmed substringFromIndex:2] isEqualToString:@"Treasure"]){
                
                type = Treasure;
                
            }
            else if([[trimmed substringFromIndex:2] isEqualToString:@"Magic"]){
                type = MagicItem;
            }
            else if([[trimmed substringFromIndex:2] isEqualToString:@"Event"]){
                type = Event;
            }
            
            else{
            
                type = Docked;
                
                terrainType = [trimmed substringFromIndex:2];
            
            }
        }
      
        else if ([trimmed hasPrefix:@"a"]){
            goldValue = [[trimmed substringFromIndex:2] integerValue];
           
        }
        else {
            NSLog(@"something else occured: %@",trimmed);
        }
        
    }
    
    if(type == Village || type == City)
        combatValue = goldValue;
}

- (void) draw{
    [[board childNodeWithName:self.name] removeFromParent]; //makes sure that it removes it to prevent duplications

    self.position = initialPoint;
    if (inBowl) {
        self.color = [SKColor blackColor];
        self.colorBlendFactor = .85;
    }
    else{
        
        self.color = [SKColor grayColor];
        self.colorBlendFactor = 0;
    }
    [board addChild:self];
}

- (NSDictionary *) getDict{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:[NSNumber numberWithFloat:self.position.x] forKey:@"X"];
    [dict setObject:[NSNumber numberWithFloat:self.position.y] forKey:@"Y"];
    [dict setObject:imageName forKey:@"imageName"];
    [dict setObject:[NSNumber numberWithInt:YES] forKey:@"si"];
    return dict;
}

@end
