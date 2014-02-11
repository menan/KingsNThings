//
//  CombatScene.m
//  KingsNThings
//
//  Created by aob on 2/7/2014.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import "CombatScene.h"
#import "MyScene.h"
#import "Army.h"
#import "Player.h"
#import "Creature.h"

@implementation CombatScene{
   
    MyScene* sce;
    Army* attacker;
    Army* defender;
    SKSpriteNode* background;
    
}

-(id)initWithSize:(CGSize)size withAttacker:(Army*)att andDefender:(Army*)def andSender:(id) sender {
    if (self = [super initWithSize:size]) {
        
        sce = sender;
        
        background = [[SKSpriteNode alloc]initWithImageNamed:@"combat.jpg"];
        background.anchorPoint = CGPointZero;
        background.position = CGPointMake(0,0);
        background.size = size;
        [background setColorBlendFactor:0.7];
        self.backgroundColor = [SKColor blackColor];
        
        [self addChild:background];
        //SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        
        attacker = att;
        defender = def;
        /*myLabel.text = @"Tap go back";
        myLabel.fontSize = 15;
        myLabel.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
        
        [self addChild:myLabel];*/
        
        [self drawArmies];
    }
    return self;
}
-(void) drawArmies{
    
    SKLabelNode *lblTitle = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    lblTitle.text = @"COMBAT";
    lblTitle.fontSize = 20;
    lblTitle.position = CGPointMake(381,976);
    [self addChild:lblTitle];
    
    SKLabelNode *lblDone = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    lblDone.name = @"done";
    lblDone.text = @"Done";
    lblDone.fontSize = 20;
    lblDone.position = CGPointMake(366,48);
    [self addChild:lblDone];
    
    
    SKLabelNode *lableAttaker = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    lableAttaker.text = @"Attacker";
    lableAttaker.fontSize = 18;
    lableAttaker.position = CGPointMake(254,905);
    [self addChild:lableAttaker];
    
    SKLabelNode *lableDefender = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    lableDefender.text = @"Defender";
    lableDefender.fontSize = 18;
    lableDefender.position = CGPointMake(515,905);
    [self addChild:lableDefender];
    int i = 1 ;
    for(Creature* creature in [attacker creatures]){
        SKSpriteNode* node =[[SKSpriteNode alloc]initWithImageNamed:[creature imageName]];
        [node setName:[creature name]];
        [node setPosition:CGPointMake(lableAttaker.position.x ,lableAttaker.position.y - (100 *i))
         ];
        node.size = CGSizeMake(50,80);
        [self addChild:node];
        ++i;
        
    }
    int j = 1;
    for(Creature* creature in [defender creatures]){
        SKSpriteNode* node =[[SKSpriteNode alloc]initWithImageNamed:[creature imageName]];
        [node setName:[creature name]];
        [node setPosition:CGPointMake(lableDefender.position.x ,lableDefender.position.y - (100 *j))
         ];
        node.size = CGSizeMake(50,80);
        [self addChild:node];
        ++i;
        
    }
    
    
    
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint positionInScene = [touch locationInNode:self];
    SKSpriteNode *touchedNode = (SKSpriteNode *)[self nodeAtPoint:positionInScene];
    
    NSLog(@"point are %@  ", NSStringFromCGPoint(positionInScene));
    
    if ([touchedNode.name isEqualToString:@"done"])
        [self.scene.view presentScene:sce];
    
}

@end
