//
//  Building.m
//  KingsNThings
//
//  Created by Mac5 on 2/6/2014.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import "Building.h"

@implementation Building

@synthesize terrain, stage,combatValue,isCity,isVillage,isMagic,isMelee,isRanged,point,imageName,name,currentCombatValue,isNeutralised;


- (id)initWithStage:(Stage) s andTerrain: (Terrain *) t
{
    self = [super init];
    if (self) {
        terrain = t;
        stage = s;
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
    if(isCity || !isVillage || stage == Tower || stage == Keep){
        isMelee = YES;
    }
    else if (stage == Castle)
        isRanged = YES;
    else
        isMagic = YES;
    
    currentCombatValue = combatValue;
}


@end
