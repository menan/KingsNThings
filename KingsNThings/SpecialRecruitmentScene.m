//
//  SpecialRecruitmentScene.m
//  KingsNThings
//
//  Created by Menan Vadivel on 2014-03-17.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import "SpecialRecruitmentScene.h"
#import "MyScene.h"
#import "Dice.h"

@implementation SpecialRecruitmentScene{
    SKSpriteNode *background,*diceOne, *diceTwo;
    SKLabelNode *diceOneLabel,*diceTwoLabel, *lblCValue;
    MyScene* sender;
    int rolled;
    
}

@synthesize creature,player;

- (id)initWithSize:(CGSize)size andSender: (id) s {
    if (self = [super initWithSize:size]) {
        
        sender = s;
        background = [[SKSpriteNode alloc]initWithImageNamed:@"combat.jpg"];
        background.anchorPoint = CGPointZero;
        background.position = CGPointMake(0,0);
        background.size = size;
        [background setColorBlendFactor:0.7];
        self.backgroundColor = [SKColor blackColor];
        rolled = 0;
        [self addChild:background];
    }
    return self;
}


- (void) drawElements{
    
    
    SKLabelNode *lblTitle = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    lblTitle.text = @"Special Character Recruitment";
    lblTitle.fontSize = 20;
    lblTitle.position = CGPointMake(381,976);
    [self addChild:lblTitle];
    
    SKLabelNode *lblName = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    lblName.text = creature.name;
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
    
    
    lblCValue = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    lblCValue.text = [NSString stringWithFormat: @"roll a total of %d", creature.combatValue * 2];
    lblCValue.fontSize = 20;
    lblCValue.color = [SKColor redColor];
    lblCValue.position = CGPointMake(381,606);
    [self addChild:lblCValue];
    
    diceOne = [SKSpriteNode spriteNodeWithImageNamed:@"dice"];
    [diceOne setName:@"diceOne"];
    diceOne.size = CGSizeMake(50,80);
    diceOne.position = CGPointMake(320,170);
    [self addChild:diceOne];
    
    diceTwo = [SKSpriteNode spriteNodeWithImageNamed:@"dice"];
    [diceTwo setName:@"diceTwo"];
    diceTwo.size = CGSizeMake(50, 80);
    diceTwo.position = CGPointMake(400,170);
    [self addChild:diceTwo];
    
    
    diceOneLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    diceOneLabel.text = @"0";
    diceOneLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    diceOneLabel.fontSize = 25;
    diceOneLabel.position = CGPointMake(320, 220.0f);
    [self addChild:diceOneLabel];
    
    diceTwoLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    diceTwoLabel.text = @"0";
    diceTwoLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    diceTwoLabel.fontSize = 25;
    diceTwoLabel.position = CGPointMake(400,220.0f);
    [self addChild:diceTwoLabel];
    
    
}

- (void) doneRolling{
    int totalRoll = diceOneLabel.text.intValue + diceTwoLabel.text.intValue;
    if (totalRoll >= creature.combatValue * 2) {
        lblCValue.text = [NSString stringWithFormat: @"Congratulation! %@ is all yours :D", creature.name];
//        [player addCreatureToArmy:<#(id)#> inArmy:<#(Army *)#>]
        
        
        //finish this up for me Areej :)
    }
    else{
        int remaining = creature.combatValue * 2 - totalRoll;
        lblCValue.text =  [NSString stringWithFormat: @"oops, now you gotta pay %d gold or forget about %@", remaining * 5, creature.name];
        
        //to be completed
    }
    
    NSLog(@"gotta do the calculations here for %d",totalRoll);
}


- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint positionInScene = [touch locationInNode:self];
    SKSpriteNode *touchedNode = (SKSpriteNode *)[self nodeAtPoint:positionInScene];
    
    
    if ([touchedNode.name isEqualToString:@"done"]){
        [self.scene.view presentScene:sender];
    }
    else if([touchedNode.name isEqualToString:@"diceOne"]){
        NSString * roll = [NSString stringWithFormat:@"%d", [Dice roll]];
        do {
            roll = [NSString stringWithFormat:@"%d", [Dice roll]];
        } while ([roll isEqualToString:diceOneLabel.text]);
        rolled++;
        diceOneLabel.text = roll;
        diceOne.name = @"";
        
    }
    else if ([touchedNode.name isEqualToString:@"diceTwo"]){
        NSString * roll = [NSString stringWithFormat:@"%d", [Dice roll]];
        do {
            roll = [NSString stringWithFormat:@"%d", [Dice roll]];
        } while ([roll isEqualToString:diceTwoLabel.text]);
        rolled++;
        diceTwoLabel.text = roll;
        diceTwo.name = @"";
    }
    
    if (rolled == 2) {
        [self doneRolling];
    }
    NSLog(@"just touched");
}
@end
