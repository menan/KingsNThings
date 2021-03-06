//
//  MyScene.m
//  KingsNThings
//
// Created by Areej Ba Salamah and Menan Vadivel on 1/16/2014.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import "GameScene.h"
#import "CombatScene.h"
#import "Army.h"
#import "Creature.h"
#import "SpecialRecruitmentScene.h"
#import "Board.h"

#import "AdvancePhaseScene.h"

@implementation GameScene{
     SKTransition* transitionDoorsCloseHorizontal;
    SKTransition* transitionRevealWithDirectionUp;
    CombatScene* combat;
    SpecialRecruitmentScene *recruitment;
    Board *gameBoard;
}

@synthesize controller;
-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        
        gameBoard = [[Board alloc] initWithScene:self atPoint:CGPointMake(0,225) withSize:CGSizeMake(size.width, 576.0f)];
        [gameBoard draw];
         [[gameBoard getGamePlay] assignScene:self];
        
        
    }
   
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [gameBoard.game assignScene:self];
    /* Called when a touch begins */
    UITouch *touch = [touches anyObject];
    CGPoint positionInScene = [touch locationInNode:self];
    [self selectNodeForTouch:positionInScene];
    
}


- (void)selectNodeForTouch:(CGPoint)touchLocation {
    //1
    SKSpriteNode *touchedNode = (SKSpriteNode *)[self nodeAtPoint:touchLocation];
    //2
    
    //    NSLog(@"old node class %@", _selectedNode.class);
    
    if (![touchedNode.parent.name isEqualToString:@"subMenu"]) {
        [[[gameBoard getBoard] childNodeWithName:@"subMenu"] removeFromParent];
    }
    
    if ([_selectedNode isKindOfClass:[Army class]]) {
            _selectedNode.color = [SKColor blackColor];
    }
    
    if ([touchedNode isKindOfClass:[Army class]]){
        [gameBoard showArmyCreatures:(Army*)touchedNode];
        
    }
    
	if([gameBoard canSelectNode:touchedNode]){
        if (![_selectedNode isEqual:touchedNode]) {
            [_selectedNode removeAllActions];
            _selectedNode.colorBlendFactor = 0;
        }
        		_selectedNode = touchedNode;
//       NSLog(@"node tapped:%@,  %f, %f", _selectedNode.class, _selectedNode.position.x, _selectedNode.position.y);
        
        _selectedNode.color = [SKColor redColor];
        _selectedNode.colorBlendFactor = 0.5;
	}
    
    
}

- (void)panForTranslation:(CGPoint)translation {
    CGPoint position = [_selectedNode position];
    CGPoint moveTo = CGPointMake(position.x + translation.x, position.y + translation.y);
    
    /*if(CGPointEqualToPoint(position, moveTo) && [_selectedNode isKindOfClass:[Army class]]){
        Army* arm = (Army*) _selectedNode;
        [self tranitToArmyScene:arm forPlayer:[gameBoard.game findPlayerByTerrain:arm.terrain]];
    }*/
    if([gameBoard canMoveNode:_selectedNode]) {
        [_selectedNode setPosition:moveTo];
    }
   
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
	CGPoint positionInScene = [touch locationInNode:self];
	CGPoint previousPosition = [touch previousLocationInNode:self];
    
	CGPoint translation = CGPointMake(positionInScene.x - previousPosition.x, positionInScene.y - previousPosition.y);
    
    
    if (translation.x == 0 && translation.y == 0) {
        NSLog(@"just tapped");
    }
	[self panForTranslation:translation];
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
	UITouch *touch = [touches anyObject];
	CGPoint positionInScene = [touch locationInNode:self];
    [gameBoard nodeMoved:_selectedNode nodes:[self nodesAtPoint:positionInScene]];
    if (![_selectedNode isKindOfClass:[Army class]]) {
        _selectedNode = NULL;
    }
}

CGPoint mult(const CGPoint v, const CGFloat s) {
	return CGPointMake(v.x*s, v.y*s);
}

- (void) transitToCombat:(id)attacker andDefender:(id)defender andCombatFunction:(id) combatfun{
    NSLog(@"inside transit combat");
    transitionDoorsCloseHorizontal = [SKTransition doorsCloseHorizontalWithDuration:1];
    //CGRect screenRect = [[UIScreen mainScreen] bounds];
    //CIVector  *extent = [CIVector vectorWithX:0  Y:0  Z:screenRect.size.width  W:screenRect.size.height];
    
    combat = [[CombatScene alloc] initWithSize:[self size] withAttacker:attacker andDefender:defender andSender:self andCombat:combatfun];
             
             //initWithSize:[self size] withAttacker:attacker andDefender:defender andSender:self ];
    
    [self.scene.view presentScene:combat transition:transitionDoorsCloseHorizontal];
    //[self removeUIKitViews];
    NSLog(@"combat finished");
    
}

- (void) transitToRecruitmentScene: (Creature *) c forPlayer: (Player *) p{
    recruitment = [[SpecialRecruitmentScene alloc] initWithSize:[self size] andSender:self];
    
    recruitment.player = p;
    recruitment.creature = c;
    
    [recruitment drawElements];
    
    [self.scene.view presentScene:recruitment transition:transitionDoorsCloseHorizontal];
    
    NSLog(@"presenting recruitment view");

}

- (void) transitToPhaseChange:(NSString *)phase{
    AdvancePhaseScene* aps = [[AdvancePhaseScene alloc] initWithSize:self.size andPhaseString:phase andTitle:@"Advancing phase to" andSender:self];
    [self.scene.view presentScene:aps transition:transitionDoorsCloseHorizontal];
    
    
}

- (void) transitWinnerScene:(NSString *)player{
    
    AdvancePhaseScene* aps = [[AdvancePhaseScene alloc] initWithSize:self.size andPhaseString:player andTitle:@"And the winner is..." andSender:self];
    [self.scene.view presentScene:aps transition:transitionDoorsCloseHorizontal];
    
    
}

//- (void) startSecondCombat{
//    [gameBoard.game initiateCombat:[gameBoard.game.players objectAtIndex:2]];
//}
-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

- (id) getGame{
    return gameBoard.game;
}
- (id) getBoard{
    return gameBoard;
}
+ (void) wiggle: (SKSpriteNode *) node{
    SKAction *sequence = [SKAction sequence:@[[SKAction scaleBy:1.2 duration:0.1],
                                              [SKAction scaleBy:1/1.2 duration:0.1]]];
    [node runAction:[SKAction repeatAction:sequence count:2]];
}

float degToRad(float degree) {
	return degree / 180.0f * M_PI;
}

@end
