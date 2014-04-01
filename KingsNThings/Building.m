//
//  Building.m
//  KingsNThings
//
//  Created by Areej Ba Salamah and Menan Vadivel 
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import "Building.h"

@implementation Building{
    
    SKSpriteNode* board;
}

@synthesize terrain, stage,combatValue,point,imageName,name,currentCombatValue,isNeutralised,cost,imageNode,combat;


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

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:[NSNumber numberWithFloat:point.x] forKey:@"pointX"];
    [encoder encodeObject:[NSNumber numberWithFloat:point.y] forKey:@"pointY"];
    [encoder encodeObject:terrain forKey:@"terrain"];
    [encoder encodeObject:imageName forKey:@"imageName"];
    [encoder encodeObject:[NSNumber numberWithFloat:stage] forKey:@"type"];
    [encoder encodeObject:[NSNumber numberWithBool:cost] forKey:@"cost"];
    [encoder encodeObject:[NSNumber numberWithBool:combatValue] forKey:@"combatValue"];
    [encoder encodeObject:[NSNumber numberWithBool:combatValue] forKey:@"combatValue"];
}


//- (id)initWithCoder:(NSCoder *)decoder {
//    if (self = [super init]) {
//        point = CGPointMake([[decoder decodeObjectForKey:@"pointX"] floatValue], [[decoder decodeObjectForKey:@"pointY"] floatValue]);
//        board = [decoder decodeObjectForKey:@"board"];
//        imageName = [decoder decodeObjectForKey:@"imageName"];
//        type = [decoder decodeObjectForKey:@"type"];
//        flipped = [[decoder decodeObjectForKey:@"flipped"] boolValue];
//        hasArmyOnIt = [[decoder decodeObjectForKey:@"hasArmyOnIt"]boolValue];
//        hasSpecialIncome = [[decoder decodeObjectForKey:@"hasSpecialIncome"]boolValue];
//        location += [[decoder decodeObjectForKey:@"location"] integerValue];
//    }
//    return self;
//}


- (id) initWithImage:(NSString*)image atPoint:(CGPoint)aPoint andStage:(Stage) s andTerrain: (Terrain *) t {
    self = [super initWithImageNamed:image];
    if (self) {
        point = aPoint;
        
        //imageName = [NSString stringWithFormat:@"%@.jpg",image];
        imageName = image;
      
        
        terrain = t;
        stage = s;
        cost = 5;
       
        [self setValuesFromString:image];
    }
    return self;
    
    
}
- (id) initWithBoard:(SKSpriteNode *)aBoard atPoint:(CGPoint)aPoint fromImage:(NSString *)image{
    
    self = [super initWithImageNamed:image];
    if(self){
        
        board = aBoard;
        point = aPoint;
        
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
            
                /*isCity =[[trimmed substringFromIndex:2] isEqualToString:@"City"];
                isVillage = [[trimmed substringFromIndex:2] isEqualToString:@"Village"];
                 */
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
    if(stage == Tower || stage == Keep){
        combat =  Melee;
    }
    else if (stage == Castle)
        combat = Ranged ;
    else
        combat = Magic ;
    
    currentCombatValue = combatValue;
}

-(BOOL)checkIfConstructionPossible:(Building*) newBuilding{

//    if([node.accessibilityLabel isEqualToString:@"keep"] && [imageNode.accessibilityLabel isEqualToString:@"tower"])
//        return YES;
//    if([node.accessibilityLabel isEqualToString:@"castle"] && [imageNode.accessibilityLabel isEqualToString:@"keep"])
//        return YES;
//    if([node.accessibilityLabel isEqualToString:@"citadel"] && [imageNode.accessibilityLabel isEqualToString:@"castle"])
    if((newBuilding.stage - self.stage) == 1)
        return YES;
    else
       return NO;
    
}


- (NSDictionary *) getDict{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:[NSNumber numberWithFloat:self.position.x] forKey:@"X"];
    [dict setObject:[NSNumber numberWithFloat:self.position.y] forKey:@"Y"];
    [dict setObject:[creatures dictionize] forKey:@"creatures"];
    return dict;
}


@end
