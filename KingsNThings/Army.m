//
//  Army.m
//  KingsNThings
//
//  Created by aob on 2/6/2014.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import "Army.h"
#import "Creature.h"
#import "Building.h"

@implementation Army

@synthesize creatures,point,imageIsDrawn,terrain,armyNumber,playerNumber,building;



-(id) init{
    
    self = [super initWithColor:[SKColor blackColor] size:CGSizeMake(36,36)];
    
    if(self){
        creatures = [[NSMutableArray alloc]init];
       // image = [[SKSpriteNode alloc]init];
    }
    return self;
}
    
    

-(id) initWithPoint:(CGPoint) aPoint{
    self = [super initWithColor:[SKColor blackColor] size:CGSizeMake(36,36)];
    if(self){
        creatures = [[NSMutableArray alloc]init];
        [self setPosition:aPoint];
        point = aPoint;
        //image = [[SKSpriteNode alloc]init];
    }
    return self;
}

-(void) addCreatures:(Creature*)creature{
    if([creatures count]>10){
        [creatures addObject:creature];
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
        }
    }
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

- (void)drawImage:(SKSpriteNode *) aBoard
{
    //image = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(36,36)];
    //self.position = [self position];
    //[self setAccessibilityValue:@"army"];
    [self setName:[NSString stringWithFormat:@"%i", [self playerNumber]]];
    [self setAccessibilityLabel:[NSString stringWithFormat:@"%i", [self armyNumber]]];
    
    [aBoard addChild:self];
    
    [self addDescription: [NSString stringWithFormat:@"ARMY %d",armyNumber] toSprite:self];
    
    
}

- (void)addDescription:(NSString *)description toSprite:(SKSpriteNode *)sprite
{
    SKLabelNode *myLabel = [SKLabelNode node];
    myLabel.text = description;
    myLabel.name = @"bowl";
    myLabel.fontSize = 10;
    myLabel.fontColor = [SKColor whiteColor];
    myLabel.position = CGPointMake(0,sprite.size.height/2 - 35);
    
    [sprite addChild:myLabel];
}

/*
-(void) drawImage:(SKSpriteNode *) aBoard{
    
   SKSpriteNode*  node = [SKSpriteNode spriteNodeWithImageNamed:image];
    [node setName:@"army"];
    [node setAccessibilityLabel:@"army"];
    node.size = CGSizeMake(88,88);
    [node setPosition:point];
    [board addChild:node];
    
    
}
 */
@end
