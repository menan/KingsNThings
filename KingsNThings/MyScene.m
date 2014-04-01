//
//  MyScene.m
//  KingsNThings
//
// Created by Areej Ba Salamah and Menan Vadivel on 1/16/2014.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import "MyScene.h"
#import "CombatScene.h"
#import "Army.h"
#import "Creature.h"
#import "SpecialRecruitmentScene.h"
#import "Board.h"
#import "ArmyScene.h"

@implementation MyScene{
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

/*-(void) respondToGesture:(CGPoint)location{
    
    SKSpriteNode *touchedNode = (SKSpriteNode *)[self nodeAtPoint:location];
    
    NSLog(@"long press detected at location x %f , y %f ",location.x,location.y);
    NSLog(@"long press detected at node  %@",touchedNode.name);
    
}*/

-(void) longPressDetected:(UIGestureRecognizer *)gestureRecognizer{
    
    CGPoint location = _selectedNode.position;
    
    if([_selectedNode isKindOfClass:[Army class]]){
        [gameBoard showArmyCreatures:(Army*)_selectedNode];
    }
  
}

- (void)selectNodeForTouch:(CGPoint)touchLocation {
    //1
    SKSpriteNode *touchedNode = (SKSpriteNode *)[self nodeAtPoint:touchLocation];
    //2
    
    
    
	if([gameBoard canSelectNode:touchedNode]){
        if (![_selectedNode isEqual:touchedNode]) {
            [_selectedNode removeAllActions];
            _selectedNode.colorBlendFactor = 0;
        }
        		_selectedNode = touchedNode;
//        NSLog(@"node tapped: %@",[_selectedNode name]);
        
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
    _selectedNode = NULL;
}

CGPoint mult(const CGPoint v, const CGFloat s) {
	return CGPointMake(v.x*s, v.y*s);
}

- (void) transitToCombat:(id)attacker andDefender:(id)defender andCombatFunction:(id) combatfun{
    NSLog(@"inside transit combat");
    transitionDoorsCloseHorizontal = [SKTransition doorsCloseHorizontalWithDuration:1];
    //CGRect screenRect = [[UIScreen mainScreen] bounds];
    //CIVector  *extent = [CIVector vectorWithX:0  Y:0  Z:screenRect.size.width  W:screenRect.size.height];
    
    combat= [[CombatScene alloc] initWithSize:[self size] withAttacker:attacker andDefender:defender andSender:self andCombat:combatfun];
             
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
-(void) tranitToArmyScene:(Army*) army forPlayer:(Player*)p{
   
    //CGSize s = CGSizeMake(self.size.width/4, self.size.height/2);
    CGSize s = CGSizeMake(10, 10);
    //ArmyScene* armyscene = [[ArmyScene alloc]initWithSize:s andSender:self Army:army forPlayer:p];
    //transitionRevealWithDirectionUp = [SKTransition revealWithDirection:SKTransitionDirectionUp duration:1];
        //initWithSize:[self size] withAttacker:attacker andDefender:defender andSender:self ];
    
    //[self.scene.view presentScene:armyscene transition:transitionRevealWithDirectionUp];
    
}

- (void) startSecondCombat{
    [gameBoard.game initiateCombat:[gameBoard.game.players objectAtIndex:2]];
}
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
