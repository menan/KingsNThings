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
        
        background = [SKSpriteNode spriteNodeWithImageNamed:@"combat.jpg"];
        background.anchorPoint = CGPointZero;
<<<<<<< HEAD
        background.position = CGPointMake(0,225);
        background.size = CGSizeMake(size.width, 576.0f);
       
        //self.backgroundColor = [SKColor blackColor];
         [background setColorBlendFactor:0.8];
        //[background d]
=======
        background.position = CGPointMake(0,0);
        background.size = size;
        [background setColorBlendFactor:0.7];
        self.backgroundColor = [SKColor blackColor];
        
>>>>>>> 2cc17d1aa9e6fbafbd877e6307d54fce8755abc1
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
    
<<<<<<< HEAD
=======
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
>>>>>>> 2cc17d1aa9e6fbafbd877e6307d54fce8755abc1
    
    
    SKLabelNode *lableAttaker = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    lableAttaker.text = @"Attacker";
    lableAttaker.fontSize = 18;
    lableAttaker.position = CGPointMake(221.25, 890.66669);
    [background addChild:lableAttaker];
    
    SKLabelNode *lableDefender = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    lableDefender.text = @"Defender";
    lableDefender.fontSize = 18;
    lableDefender.fontColor = [UIColor whiteColor];
    lableDefender.position = CGPointMake(134.25, 890.66669);
    [background addChild:lableDefender];
    int i = 1 ;
    /*
    for(Creature* creature in [attacker creatures]){
        SKSpriteNode* node =[SKSpriteNode spriteNodeWithImageNamed:[creature imageName]];
        [node setName:[creature name]];
<<<<<<< HEAD
        [node setPosition:CGPointMake(lableAttaker.position.x ,lableAttaker.position.y + (80 *i))
         ];
         node.size = CGSizeMake(50,50);
        [background addChild:node];
        ++i;
        
     
    }*/
=======
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
    
>>>>>>> 2cc17d1aa9e6fbafbd877e6307d54fce8755abc1
    
   
    
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint positionInScene = [touch locationInNode:self];
    SKSpriteNode *touchedNode = (SKSpriteNode *)[self nodeAtPoint:positionInScene];
    
    NSLog(@"point are %@  ", NSStringFromCGPoint(positionInScene));
    
<<<<<<< HEAD
    /*
     MyScene* home = [[MyScene alloc] initWithSize:CGSizeMake(CGRectGetMaxX(self.frame), CGRectGetMaxY(self.frame))];
     [self.scene.view presentScene:home];*/
    //[self.scene.view presentScene:sce];
=======
    if ([touchedNode.name isEqualToString:@"done"])
        [self.scene.view presentScene:sce];
>>>>>>> 2cc17d1aa9e6fbafbd877e6307d54fce8755abc1
    
}

@end
