//
//  CombatScene.m
//  KingsNThings
//
//  Created by Areej Ba Salamah and Menan Vadivel on 2/7/2014.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import "CombatScene.h"
#import "MyScene.h"
#import "Army.h"
#import "Player.h"
#import "Creature.h"
#import "GamePlay.h"
#import "CombatPhase.h"

@implementation CombatScene{
   
    MyScene* sce;
    Army* attacker;
    Army* defender;
    SKSpriteNode* background;
    SKLabelNode* combatRound;
    //GamePlay* game;
    CombatPhase* combat;
    SKLabelNode *diceOneLabel ;
    SKLabelNode *diceTwoLabel;
    SKLabelNode *instructionLable;
    NSInteger numberOfrolls;
    //UITextField *textField;
    UITextView *textView;
    
    
}

-(id)initWithSize:(CGSize)size withAttacker:(Army*)att andDefender:(Army*)def andSender:(id) sender andCombat:(id)com {
    if (self = [super initWithSize:size]) {
        
        sce = sender;
        combat = com;
        
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
         [self drawDices];
       
    }
    return self;
}
-(void) drawArmies{
    NSLog(@"Inside drwing combatscene");
    
    SKLabelNode *lblTitle = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
     lblTitle.name = @"start";
    lblTitle.text = @"START COMBAT";
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
    
   
    
    combatRound = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    combatRound.fontSize = 18;
    combatRound.position = CGPointMake(375.75f, 884.0f);
        [self addChild:combatRound];
    
    int i = 1 ;
    for(Creature* creature in [attacker creatures]){
        SKSpriteNode* node =[[SKSpriteNode alloc]initWithImageNamed:[creature imageName]];
        [node setName:[creature name]];
         [node setAccessibilityLabel:@"attacker"];
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
        [node setAccessibilityLabel:@"defender"];
        [node setPosition:CGPointMake(lableDefender.position.x ,lableDefender.position.y - (100 *j))
         ];
        node.size = CGSizeMake(50,80);
        [self addChild:node];
        ++j;
        
    }
    
    NSLog(@"j is in draw %d",j);
    
    if([combat building] != nil){
    
        NSLog(@"Bulding image name %@",[[combat building] imageName]);
    SKSpriteNode* node =[[SKSpriteNode alloc]initWithImageNamed: [[combat building] imageName]];
    [node setName:[combat building].name];
    [node setAccessibilityLabel:@"building"];
    [node setPosition:CGPointMake(lableDefender.position.x ,lableDefender.position.y - (100 *j))
     ];
    node.size = CGSizeMake(50,80);
    [self addChild:node];
    }
    
}

- (void) drawDices{
    
    SKSpriteNode *diceOne = [SKSpriteNode spriteNodeWithImageNamed:@"dice"];
    [diceOne setName:@"diceOne"];
    diceOne.size = CGSizeMake(50,80);
    [diceOne setPosition:CGPointMake(50.0f,70.0f)];
    [self addChild:diceOne];
    
    SKSpriteNode *diceTwo = [SKSpriteNode spriteNodeWithImageNamed:@"dice"];
    [diceTwo setName:@"diceTwo"];
    diceTwo.size = CGSizeMake(50, 80);
    [diceTwo setPosition:CGPointMake(110.0f,70.0f)];
    [self addChild:diceTwo];
    
    
    diceOneLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    diceOneLabel.text = @"0";
    diceOneLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    diceOneLabel.fontSize = 25;
    diceOneLabel.position = CGPointMake(50.0f, 120.0f);
    [self addChild:diceOneLabel];
    
    diceTwoLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    diceTwoLabel.text = @"0";
    diceTwoLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    diceTwoLabel.fontSize = 25;
    diceTwoLabel.position = CGPointMake(110.0f,120.0f);
    [self addChild:diceTwoLabel];
    
    
}

-(void)setRoundLable:(NSString*)txt{
    
    [combatRound setText:txt];
    
}

- (void) rollDiceOne{
    int r = (arc4random() % 6) + 1;
    diceOneLabel.text = [NSString stringWithFormat:@"%d",r];
    
    if([combat isAttacker]){
    [[combat attackerRolledDice]addObject:[NSNumber numberWithInt:r]];
        numberOfrolls -= 1;
        //diceOneLabel.text = @"0";
    }
    else{
        [[combat defenderRolledDice]addObject:[NSNumber numberWithInt:r]];
        numberOfrolls -= 1;
        //diceOneLabel.text = @"0";
    }
}
- (void) rollDiceTwo{
    
    int r = (arc4random() % 6) + 1 ;
    diceTwoLabel.text = [NSString stringWithFormat:@"%d",r];
    
    if([combat isAttacker]){
        [[combat attackerRolledDice]addObject:[NSNumber numberWithInt:r]];
        numberOfrolls -= 1;
        //diceTwoLabel.text = @"0";
    }
    else{
        [[combat defenderRolledDice]addObject:[NSNumber numberWithInt:r]];
        numberOfrolls -= 1;
        //diceTwoLabel.text = @"0";
    }
}

/*
-(void) highlightImage{
    
    if([combat isMagicRound]){
    
        if([combat isAttacker]){
            
            for(Creature *creature in [[combat attackerArmy]creatures]){
                if([creature isMagic]){
                    SKNode* node  =[self childNodeWithName:[creature name]];
                    
                    SKAction *sequence = [SKAction sequence:@[[SKAction rotateByAngle:degToRad(-4.0f) duration:0.1],
                                                              [SKAction rotateByAngle:0.0 duration:0.1],
                                                              [SKAction rotateByAngle:degToRad(4.0f) duration:0.1]]];
                    [node runAction:[SKAction repeatActionForever:sequence]];
            }
        }
            
                
    }
   
    
}


}//end of function

float degToRad(float degree) {
	return degree / 180.0f * M_PI;
}
*/
-(void) drawNeutralised:(SKNode*)node{
    
    
    if([node.name isEqualToString:@"City"]){
        SKSpriteNode* n =[[SKSpriteNode alloc]initWithImageNamed: @"-n City -s Neutralised.jpg"];
        [n setName:node.name];
        [n setAccessibilityLabel:@"defender"];
        [n setPosition:node.position];
        n.size = CGSizeMake(50,80);
        [self addChild:n];
        }
    else if([node.name isEqualToString:@"Village"]){
                SKSpriteNode* n =[[SKSpriteNode alloc]initWithImageNamed: @"-n Village -s Neutralised.jpg"];
                [n setName:node.name];
                [n setAccessibilityLabel:@"defender"];
                [n setPosition:node.position];
                n.size = CGSizeMake(50,80);
                [self addChild:n];
            }
    
    else if ([node.name isEqualToString:@"Tower"]){
        SKSpriteNode* n =[[SKSpriteNode alloc]initWithImageNamed: @"-n Tower -s Neutralised.jpg"];
        [n setName:node.name];
        [n setAccessibilityLabel:@"defender"];
        [n setPosition:node.position];
        n.size = CGSizeMake(50,80);
        [self addChild:n];
    }
    
    else if ([node.name isEqualToString:@"Keep"]){
        SKSpriteNode* n =[[SKSpriteNode alloc]initWithImageNamed: @"-n Keep -s Neutralised.jpg"];
        [n setName:node.name];
        [n setAccessibilityLabel:@"defender"];
        [n setPosition:node.position];
        n.size = CGSizeMake(50,80);
        [self addChild:n];
    }
    else if ([node.name isEqualToString:@"Castle"]){
        SKSpriteNode* n =[[SKSpriteNode alloc]initWithImageNamed: @"-n Castle -s Neutralised.jpg"];
        [n setName:node.name];
        [n setAccessibilityLabel:@"defender"];
        [n setPosition:node.position];
        n.size = CGSizeMake(50,80);
        [self addChild:n];
    }
    else if ([node.name isEqualToString:@"Citadel"]){
        SKSpriteNode* n =[[SKSpriteNode alloc]initWithImageNamed: @"-n Citadel -s Neutralised.jpg"];
        [n setName:node.name];
        [n setAccessibilityLabel:@"defender"];
        [n setPosition:node.position];
        n.size = CGSizeMake(50,80);
        [self addChild:n];
    }

}


-(void) collectDiceResult{
    
    NSRunLoop *loop = [NSRunLoop currentRunLoop];
    
    if([combat isMagicRound]){
        
        if([combat isAttacker])
                numberOfrolls = [[combat attackerMagicCreature] count];
        
        else{
            
                numberOfrolls = [[combat defenderMagicCreature] count];
                if([combat building] && [[combat building] isMagic])
                    numberOfrolls += 1 ;
        }
        
    }
    
    else if ([combat isRangedRound]){
        
        if([combat isAttacker])
            numberOfrolls = [[combat attackerRangedCreature] count];
        
        else{
            numberOfrolls = [[combat defenderRangedCreature] count];
            
           
            if([combat building] && [[combat building] isRanged])
                numberOfrolls += 1 ;
        }
       
    }
    
    else {
        
        if([combat isAttacker])
            numberOfrolls = ([[combat attackerMeleeCreature] count] + [combat attakerChargeCreatures]);
        
        else{
            numberOfrolls = ([[combat defenderMeleeCreature] count] +[combat defenderChargeCreatures]);
            
           
            if([combat building] && [[combat building] isMelee])
                numberOfrolls += 1 ;
        }
    }
    
    while ((numberOfrolls > 0) &&
           ([loop runMode:NSDefaultRunLoopMode beforeDate:[NSDate
                                                           distantFuture]]))
    {}
    
    //[self setInstructionText:@"Attacker roll dice for "]
    
    
}

-(void) applyHits{
    
    /*NSString* str = @"Attacker and Defender : remove creatures to take hits";
    
    [self setInstructionText:str];*/
    
    NSRunLoop *loop = [NSRunLoop currentRunLoop];
    
    
    
    while ((([combat attackerNumberOfHits] > 0) || ([combat defenderNumberOfHits ] > 0)) &&
           ([loop runMode:NSDefaultRunLoopMode beforeDate:[NSDate
                                                           distantFuture]]))
    {
    }
    
    
    
}

-(void)setInstructionText:(NSString*)txt{
    //instructionLable.text = txt;
    [textView setText:txt];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint positionInScene = [touch locationInNode:self];
    SKSpriteNode *touchedNode = (SKSpriteNode *)[self nodeAtPoint:positionInScene];
    
    //NSLog(@"point are %@  ", NSStringFromCGPoint(positionInScene));
    
    
    if( [touchedNode.name isEqualToString:@"start"]){
        
        [combat startCombat:self];
        
    }
    if ([touchedNode.name isEqualToString:@"done"]){
         [textView removeFromSuperview];
        [self.scene.view presentScene:sce];
        [sce startSecondCombat];
       
    }
    else if([touchedNode.name isEqualToString:@"diceOne"])
        [self rollDiceOne];
    else if ([touchedNode.name isEqualToString:@"diceTwo"])
        [self rollDiceTwo];
    else if ([touchedNode.accessibilityLabel isEqualToString:@"attacker" ]){
        
        [touchedNode removeFromParent];
        [combat updateArmy:touchedNode.name andPlayerType:@"attacker"];
        [combat setDefenderNumberOfHits:[combat defenderNumberOfHits] -1 ];
        [[combat attackerArmy]removeCreatureWithName:touchedNode.name];
        
    }
    else if ([touchedNode.accessibilityLabel isEqualToString:@"defender" ]){
        
        
        [touchedNode removeFromParent];
        [combat updateArmy:touchedNode.name andPlayerType:@"defender"];
        [combat setAttackerNumberOfHits:([combat attackerNumberOfHits] -1) ];
        [[combat defenderArmy]removeCreatureWithName:touchedNode.name];
        
    }
    else if ([touchedNode.accessibilityLabel isEqualToString:@"building"]){
        
        [[combat building] setCurrentCombatValue:[[combat building] currentCombatValue] -1] ;
        if([touchedNode.name isEqualToString:@"Tower"] || [touchedNode.name isEqualToString:@"Keep"] ){
            [[combat building] setCombatValue:[[combat building] currentCombatValue]];
            
        }
        [combat setAttackerNumberOfHits:([combat attackerNumberOfHits] -1) ];
        
        if([[combat building] currentCombatValue] <= 0){
            [[combat building] setIsNeutralised:YES];
            [self drawNeutralised:touchedNode];
            
        }
        
        
        
    }
    
}

-(void)didMoveToView:(SKView *)view {
    textView =[[UITextView alloc]initWithFrame:CGRectMake(45,200, 250, 250)];
    //[[UItextView alloc] initWithFrame:CGRectMake(50,100, 200, 200)];
    
    //textView.center = self.view.center;
    //textView.borderStyle = UITextBorderStyleRoundedRect;
    textView.textColor = [UIColor whiteColor];
    textView.font = [UIFont fontWithName:@"Chalkduster" size:17.0f];
    //textView.placeholder = @"Enter your name here";
    textView.backgroundColor = [UIColor clearColor];
   
    //textView.autocorrectionType = UITextAutocorrectionTypeYes;
    //textField.keyboardType = UIKeyboardTypeDefault;
    //textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    //textField.delegate = self.delegate;
    textView.editable = NO;
    [self.view addSubview:textView];
}

@end
