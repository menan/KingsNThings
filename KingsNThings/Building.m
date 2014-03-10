//
//  Building.m
//  KingsNThings
//
//  Created by Areej Ba Salamah and Menan Vadivel 
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import "Building.h"

@implementation Building

@synthesize terrain, stage,combatValue,isCity,isVillage,isMagic,isMelee,isRanged,point,imageName,name,currentCombatValue,isNeutralised,cost,imageNode;


- (id)initWithStage:(Stage) s andTerrain: (Terrain *) t
{
    self = [super init];
    if (self) {
        terrain = t;
        stage = s;
        cost = 5;
    }
    return self;
}

- (id) initWithImage:(NSString*)image atPoint:(CGPoint)aPoint andStage:(Stage) s andTerrain: (Terrain *) t {
    self = [super init];
    if (self) {
        point = aPoint;
        
        //imageName = [NSString stringWithFormat:@"%@.jpg",image];
        imageName = image;
      
        isMagic = NO;
        isMelee = NO;
        isRanged = NO;
        
        terrain = t;
        stage = s;
        cost = 5;
       
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
            
                isCity =[[trimmed substringFromIndex:2] isEqualToString:@"City"];
                isVillage = [[trimmed substringFromIndex:2] isEqualToString:@"Village"];
                if([[trimmed substringFromIndex:2] isEqualToString:@"Tower"])
                    stage = Tower;
                else if ([[trimmed substringFromIndex:2] isEqualToString:@"Keep"])
                    stage = Keep;
                else if ([[trimmed substringFromIndex:2] isEqualToString:@"Castle"])
                    stage = Castle;
                else
                    stage = Citadel;
            
        }
               else if ([trimmed hasPrefix:@"a"]){
            combatValue = [[trimmed substringFromIndex:2] integerValue];
            
        }
        
        
    }
    if(isCity || isVillage || stage == Tower || stage == Keep){
        isMelee = YES;
    }
    else if (stage == Castle)
        isRanged = YES;
    else
        isMagic = YES;
    
    currentCombatValue = combatValue;
}

-(BOOL)checkIfConstructionPossible:(SKNode*) node{

    if([node.accessibilityLabel isEqualToString:@"keep"] && [imageNode.accessibilityLabel isEqualToString:@"tower"])
        return YES;
    if([node.accessibilityLabel isEqualToString:@"castle"] && [imageNode.accessibilityLabel isEqualToString:@"keep"])
        return YES;
    if([node.accessibilityLabel isEqualToString:@"citadel"] && [imageNode.accessibilityLabel isEqualToString:@"castle"])
       return YES;
       
    else
       return NO;
    
}


@end
