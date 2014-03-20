//
//  specialIncome.m
//  KingsNThings
//
//  Created by Areej Ba Salamah and Menan Vadivel  on 2/3/2014.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import "SpecialIncome.h"

@implementation SpecialIncome{
CGPoint point;
SKSpriteNode *board;

int position;


}

@synthesize goldValue,symbol,name,inBowl,imageName,isKeyedToTerrain,isTreasure,terrainType;

@synthesize node;

- (id)initWithBoard: (SKSpriteNode *) aBoard atPoint: (CGPoint) aPoint imageNamed: (NSString *) image andCounterName: (NSString *) cName withGoldValue: (int) value forTerrainType: (NSString *) terrain{
    self = [super init];
    if (self) {
        point = aPoint;
        board = aBoard;
        imageName = image;
        name = cName;
       
        inBowl = YES;
        
        terrainType = terrain;
        goldValue = value;
       
        
    }
    return self;
}
- (id) initWithBoard:(SKSpriteNode *)aBoard atPoint:(CGPoint)aPoint fromString:(NSString *)string{
    self = [super init];
    if (self) {
        point = aPoint;
        board = aBoard;
        imageName = [NSString stringWithFormat:@"%@.jpg",string];
       
        inBowl = YES;
        
        [self setValuesFromString:string];
    }
    return self;
}



- (id) initWithImage:(NSString*)image atPoint:(CGPoint)aPoint{
    self = [super init];
    if (self) {
        point = aPoint;
        
        imageName = [NSString stringWithFormat:@"%@.jpg",image];
        
        inBowl = NO;
      
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
            if([[trimmed substringFromIndex:2] isEqualToString:@"Treasure"]){
                isTreasure = YES;
                isKeyedToTerrain = NO;
                
            }
            else{
                isKeyedToTerrain = YES;
                isTreasure = NO;
                terrainType = [trimmed substringFromIndex:2];
            }
        }
      
        else if ([trimmed hasPrefix:@"a"]){
            goldValue = [[trimmed substringFromIndex:2] integerValue];
           
        }
      
        else {
            //            NSLog(@"something else occured: %@",trimmed);
        }
        
    }
    
}

- (void) draw{
    [node removeFromParent]; //makes sure that it removes it to prevent duplications
    node = [SKSpriteNode spriteNodeWithImageNamed:imageName];
    node.name = name;
    node.accessibilityLabel = @"specialIncome";
    if(isTreasure){
    node.accessibilityValue = @"treasure";
    }
    node.size = CGSizeMake(37,37);
    node.position = point;
    if (inBowl ) {
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
