//
//  AdvancePhaseScene.m
//  kingsnthings
//
//  Created by Menan Vadivel on 2014-04-06.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import "AdvancePhaseScene.h"

@implementation AdvancePhaseScene{
    GameScene* sender;
}



-(id)initWithSize:(CGSize)size andPhaseString:(NSString*)phase andTitle:(NSString *) title andSender:(GameScene *) s {
    if (self = [super initWithSize:size]) {
        sender = s;
        SKSpriteNode *background = [[SKSpriteNode alloc]initWithImageNamed:@"combat.jpg"];
        background.anchorPoint = CGPointZero;
        background.position = CGPointMake(0,0);
        background.size = size;
        [background setColorBlendFactor:0.7];
        self.backgroundColor = [SKColor blackColor];
        
        [self addChild:background];
        
        SKLabelNode *lblTitle = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        lblTitle.text = title;
        lblTitle.fontSize = 20;
        lblTitle.position = CGPointMake(381,976);
        [self addChild:lblTitle];
        
        SKLabelNode *lblName = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        lblName.text = phase;
        lblName.fontSize = 20;
        lblName.color = [SKColor redColor];
        lblName.position = CGPointMake(381,836);
        [self addChild:lblName];
        
        
        SKLabelNode *lblDone = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        lblDone.name = @"done";
        lblDone.text = @"Done";
        lblDone.fontSize = 20;
        lblDone.position = CGPointMake(366,48);
        [self addChild:lblDone];
        
        
        
    }
    return self;
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint positionInScene = [touch locationInNode:self];
    SKSpriteNode *touchedNode = (SKSpriteNode *)[self nodeAtPoint:positionInScene];
    
    
    if ([touchedNode.name isEqualToString:@"done"]){
        [self.scene.view presentScene:sender];
    }
    
}

@end
