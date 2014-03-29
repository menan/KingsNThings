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

@synthesize creatures,position,terrain,image,armyNumber,playerNumber,building;



-(id) init{
    
    self = [super init];
    
    if(self){
        creatures = [[NSMutableArray alloc]init];
        image = [[SKSpriteNode alloc]init];
    }
    return self;
}
    
    

-(id) initWithPoint:(CGPoint) aPoint{
    self = [super init];
    if(self){
        creatures = [[NSMutableArray alloc]init];
        [self setPosition:aPoint];
        image = [[SKSpriteNode alloc]init];
    }
    return self;
}

- (NSDictionary *) getDict{
    
    return [[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithFloat:image.position.x],@"X",[NSNumber numberWithFloat:image.position.y],@"Y",[NSNumber numberWithFloat:image.position.y],@"Y",[NSNumber numberWithFloat:armyNumber],@"armyNumber",[NSNumber numberWithFloat:armyNumber],@"armyNumber", nil];
}



- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        position = CGPointMake([[decoder decodeObjectForKey:@"pointX"] floatValue], [[decoder decodeObjectForKey:@"pointY"] floatValue]);
        creatures = [decoder decodeObjectForKey:@"creatures"];
        armyNumber = [[decoder decodeObjectForKey:@"armyNumber"] integerValue];
        armyNumber = [decoder decodeObjectForKey:@"armyNumber"];
        terrain = [decoder decodeObjectForKey:@"terrain"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:[NSNumber numberWithFloat:point.x] forKey:@"pointX"];
    [encoder encodeObject:[NSNumber numberWithFloat:point.y] forKey:@"pointY"];
    [encoder encodeObject:board forKey:@"board"];
    [encoder encodeObject:imageName forKey:@"imageName"];
    [encoder encodeObject:type forKey:@"type"];
    [encoder encodeObject:[NSNumber numberWithBool:flipped] forKey:@"flipped"];
    [encoder encodeObject:[NSNumber numberWithBool:hasArmyOnIt] forKey:@"hasArmyOnIt"];
    [encoder encodeObject:[NSNumber numberWithInteger:location] forKey:@"location"];
    [encoder encodeObject:[NSNumber numberWithBool:hasSpecialIncome] forKey:@"hasSpecialIncome"];
}

-(void) addCreatures:(Creature*)creature{
    [creatures addObject:creature];
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
    image = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(36,36)];
    image.position = [self position];
    [image setAccessibilityValue:@"army"];
    [image setName:[NSString stringWithFormat:@"%i", [self playerNumber]]];
    [image setAccessibilityLabel:[NSString stringWithFormat:@"%i", [self armyNumber]]];
    
    [aBoard addChild:image];
    
    [self addDescription: [NSString stringWithFormat:@"ARMY %d",[self armyNumber]] toSprite:image];
    
    
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
