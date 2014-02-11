//
//  Army.m
//  KingsNThings
//
//  Created by aob on 2/6/2014.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import "Army.h"
#import "Creature.h"

@implementation Army

@synthesize creatures,position,belongsToP1,belongsToP2,belongsToP3,belongsToP4,imageIsDrawn,terrain,image,armyNumber,playerNumber;



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
            break;
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
    
    //SKSpriteNode* sprite = [SKSpriteNode spriteNodeWithColor:[SKColor redColor] size:CGSizeMake(128,128)];
    
    [self setImage:[SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(36,36)]];
    image.position = [self position];
    [image setAccessibilityValue:@"army"];
    [image setName:[NSString stringWithFormat:@"%i", [self playerNumber]]];
    [image setAccessibilityLabel:[NSString stringWithFormat:@"%i", [self armyNumber]]];
    
    [aBoard addChild:image];
    
    NSString* str = @"Army";
    str = [str stringByAppendingString:[NSString stringWithFormat:@"%i", [self armyNumber]]];
    [self addDescription: NSLocalizedString(str, @"") toSprite:image];
    
    
}

- (void)addDescription:(NSString *)description toSprite:(SKSpriteNode *)sprite
{
    SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    myLabel.text = description;
    myLabel.fontSize = 14;
    myLabel.fontColor = [SKColor redColor];
    myLabel.position = CGPointMake(0,sprite.size.height/2 - 30);
    
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
