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

-(id)initWithSize:(CGSize)size withAttacker:(Army*)att andDefender:(Army*)def {
    if (self = [super initWithSize:size]) {
        
        
        
        background = [SKSpriteNode spriteNodeWithImageNamed:@"combat.jpg"];
        background.anchorPoint = CGPointZero;
        background.position = CGPointMake(0,225);
        background.size = CGSizeMake(size.width, 576.0f);
       
        //self.backgroundColor = [SKColor blackColor];
         [background setColorBlendFactor:0.8];
        //[background d]
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
        [node setPosition:CGPointMake(lableAttaker.position.x ,lableAttaker.position.y + (80 *i))
         ];
         node.size = CGSizeMake(50,50);
        [background addChild:node];
        ++i;
        
     
    }*/
    
   
    
    
}

-(void)backTo:(MyScene*)sc{
    
    sce = sc;
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint positionInScene = [touch locationInNode:self];
    NSLog(@"point are %@  ", NSStringFromCGPoint(positionInScene));
    
    /*
     MyScene* home = [[MyScene alloc] initWithSize:CGSizeMake(CGRectGetMaxX(self.frame), CGRectGetMaxY(self.frame))];
     [self.scene.view presentScene:home];*/
    //[self.scene.view presentScene:sce];
    
}

@end
