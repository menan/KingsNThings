//
//  ArmyScene.m
//  KingsNThings
//
//  Created by aob on 3/28/2014.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import "ArmyScene.h"
#import "MyScene.h"

@implementation ArmyScene{
    
    SKSpriteNode *background;
    
    MyScene* sender;
    
}

@synthesize player,army;

- (id)initWithSize:(CGSize)size andSender: (id) s Army:(Army*)arm forPlayer:(Player*)p{
    self = [super init];
    if(self){
        sender = s;
    background = [[SKSpriteNode alloc]initWithColor:[SKColor blackColor] size:size];
    background.anchorPoint = CGPointZero;
    background.position = CGPointMake(0,0);
    //background.size = size;
    [background setColorBlendFactor:0.7];
    //self.backgroundColor = [SKColor blackColor];
        army = arm;
        player = p;
        NSLog(@"inside army scene");
    [self addChild:background];
}
return self;
}


/*- (void) drawElements{
    
    int i  = 0;
    Creature* previous;
    for(Creature* creature in [army creatures]){
        
        creature.size = CGSizeMake(50,80);
        
        
        if(i >= 5){
            [creature setPosition:CGPointMake())
             ];
            
        }
        else {
            [node setPosition:CGPointMake(lableAttaker.position.x ,lableAttaker.position.y - (100 *i))
             ];
        }
        
        [self addChild:node];
    
}
*/


/*- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
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
    else if ([touchedNode.name isEqualToString:@"collection"]){
        int totalRoll = diceOneLabel.text.intValue + diceTwoLabel.text.intValue;
        int remaining = (creature.combatValue * 2 - totalRoll) * 5;
        
        Board* board = (Board *) [sender getBoard];
        
        NSLog(@"User balance before withdrawal %d",[player getBankBalance]);
        NSLog(@"Bank balance before deposition %d",[board.bank getBalance]);
        
        if ([[player bank] withdraw:remaining]) {
            [board.bank deposit:remaining];
            
            NSLog(@"User balance before withdrawal %d",[player getBankBalance]);
            NSLog(@"Bank balance after deposition %d",[board.bank getBalance]);
            
            NSLog(@"so every thing is fine now.");
            
            [self grantCreature];
        }
        else{
            
            UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Insufficient funds" message: @"Unfortunately you don't have enough money to modify this roll" delegate: self                                       cancelButtonTitle:@"Okay" otherButtonTitles:nil];
            
            [error show];
            NSLog(@"Error pulling money out of his bank account. Must be in sufficient funds.");
        }
    }
    
    if (rolled == 2) {
        [self doneRolling];
    }
    NSLog(@"just touched");
}
*/

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        NSLog(@"user pressed OK");
        [self.scene.view presentScene:sender];
    }
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
        /* Called when a touch begins */
    UITouch *touch = [touches anyObject];
    CGPoint positionInScene = [touch locationInNode:self];
    NSLog(@"Positiotn is x %f , y %f",positionInScene.x,positionInScene.y);
    
}
/*
- (void) grantCreature{
    [self.scene.view presentScene:sender];
    
    Board* board = (Board *) [sender getBoard];
    GamePlay* game = (GamePlay *) [sender getGame];
    
    //Terrain *temp = [game findTerrainAt:creature.node.position];
    //[board creaturesMoved:creature.node AtTerrain:temp];
    Terrain *temp = [game findTerrainAt:creature.position];
    [board creaturesMoved:creature AtTerrain:temp];
}
 */
@end
