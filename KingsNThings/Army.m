//
//  Army.m
//  KingsNThings
//
//  Created by aob on 2/6/2014.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import "Army.h"
#import "Building.h"
#import "NSMutableArrayDictionize.h"

@implementation Army

@synthesize creatures,imageIsDrawn,terrain,armyNumber,playerNumber,building,stepsMoved;



-(id) init{
    
    self = [super initWithColor:[SKColor blackColor] size:CGSizeMake(36,36)];
    
    if(self){
        creatures = [[NSMutableArray alloc]init];
        stepsMoved = 0;
    }
    return self;
}
    
    

-(id) initWithPoint:(CGPoint) aPoint{
    self = [super initWithColor:[SKColor blackColor] size:CGSizeMake(36,36)];
    if(self){
        creatures = [[NSMutableArray alloc]init];
        self.position = aPoint;
        stepsMoved = 0;
    }
    return self;
}

-(BOOL) addCreatures:(Creature*)creature{
    if (![creatures containsObject:creature]) {
        [creatures addObject:creature];
        return YES;
    }
    else{
        NSLog(@"army already has a %@ present in the a stack, so avoided it.", creature.name);
        return NO;
    }
}
-(NSInteger) getTerrainLocation{
    return [terrain location];
}

-(void) removeCreature:(id)creature{
    [creatures removeObject:creature];
}

-(void) removeCreatureWithName:(NSString*)name{
    for(Creature* cre in creatures){
        if([[cre name] isEqualToString:name]){
            [self removeCreature:cre];
            
            break;
        }
    }
}


- (NSMutableArray *) getCreaturesOfType:(CombatStrength) type{

    NSMutableArray *returnCreatures = [[NSMutableArray alloc] init];
    
    for(Creature* c in creatures){
        if (c.combatType == type) {
            [returnCreatures addObject:c];
        }
    }
    return returnCreatures;
}



-(BOOL)containCreature:(id)creature{
    if([creatures containsObject:creature])
        return YES;
    else
        return NO;
    
}

-(NSInteger) creaturesInArmy{
    return [creatures count];
}
-(void)updateMovingSteps:(NSInteger)steps{
    for(Creature* cre in creatures){
        NSLog(@"creature: %@",cre.name);
        
        [cre setStepsMoved:(cre.stepsMoved+steps)];
    }
    
    stepsMoved += steps;
}
-(void)resetMovingSteps{
    
    for(Creature* cre in creatures){
        [cre setStepsMoved:0];
    }
    [self setStepsMoved:0];
}

- (void)drawImage:(SKSpriteNode *) aBoard
{
    NSString *imageNames = [NSString stringWithFormat:@"stack"];
    
    SKSpriteNode* node = (SKSpriteNode*) [aBoard nodeAtPoint:self.position];
    if([node isKindOfClass:[Army class]]){
        [node removeFromParent];
    }
    
    [self setName:imageNames];
    [aBoard addChild:self];
    
    [self addDescription: [NSString stringWithFormat:@"STACK %d",armyNumber] toSprite:self];
    
    
}

- (void)addDescription:(NSString *)description toSprite:(SKSpriteNode *)sprite
{
    SKLabelNode *myLabel = [SKLabelNode node];
    myLabel.text = description;
    myLabel.name = @"bowl";
    myLabel.fontSize = 9;
    myLabel.fontColor = [SKColor whiteColor];
    myLabel.position = CGPointMake(0,sprite.size.height/2 - 35);
    
    [sprite addChild:myLabel];
}

- (NSDictionary *) getDict{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:[NSNumber numberWithFloat:self.position.x] forKey:@"X"];
    [dict setObject:[NSNumber numberWithFloat:self.position.y] forKey:@"Y"];
    [dict setObject:[creatures dictionize] forKey:@"creatures"];
    return dict;
}


@end
