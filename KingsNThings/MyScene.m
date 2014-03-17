//
//  MyScene.m
//  KingsNThings
//
// Created by Areej Ba Salamah and Menan Vadivel on 1/16/2014.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import "MyScene.h"
#import "Board.h"
#import "CombatScene.h"
#import "Army.h"
#import "Creature.h"
#import "SpecialRecruitmentScene.h"

@implementation MyScene{
     SKTransition* transitionDoorsCloseHorizontal;
    CombatScene* combat;
    SpecialRecruitmentScene *recruitment;
    NSArray * nonMovables;
    Board *gameBoard;
}

@synthesize controller;
-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        
        gameBoard = [[Board alloc] initWithScene:self atPoint:CGPointMake(0,225) withSize:CGSizeMake(size.width, 576.0f)];
        [gameBoard draw];
        nonMovables = [gameBoard getNonMovables];
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
    
	if(![_selectedNode isEqual:touchedNode]) {
		[_selectedNode removeAllActions];
        _selectedNode.colorBlendFactor = 0;
		[_selectedNode runAction:[SKAction rotateToAngle:0.0f duration:0.1]];
        
		_selectedNode = touchedNode;
        NSLog(@"node tapped: %@",[_selectedNode name]);
//        if ([nonMovables containsObject: [_selectedNode name]])
//            [gameBoard resetText];
//        else{
//            [gameBoard nodeTapped:touchedNode];
//        }
        
		if([gameBoard.disabled containsObject: [_selectedNode name]] == NO) {
            _selectedNode.color = [SKColor redColor];
            _selectedNode.colorBlendFactor = 0.5;
        }
	}
    
}

/*float degToRad(float degree) {
	return degree / 180.0f * M_PI;
}*/
- (CGPoint)boundLayerPos:(CGPoint)newPos {
    CGSize winSize = self.size;
    CGPoint retval = newPos;
    retval.x = MIN(retval.x, 0);
    retval.x = MAX(retval.x, - self.frame.size.width+ winSize.width);
    retval.y = [self position].y;
    return retval;
}

- (void)panForTranslation:(CGPoint)translation {
    CGPoint position = [_selectedNode position];
    CGPoint moveTo = CGPointMake(position.x + translation.x, position.y + translation.y);
    if([nonMovables containsObject: [_selectedNode name]] == NO) {
        [_selectedNode setPosition:moveTo];
    }
   
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
	CGPoint positionInScene = [touch locationInNode:self];
	CGPoint previousPosition = [touch previousLocationInNode:self];
    
	CGPoint translation = CGPointMake(positionInScene.x - previousPosition.x, positionInScene.y - previousPosition.y);
    
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

- (void) startSecondCombat{
    [gameBoard.game initiateCombat:[gameBoard.game.players objectAtIndex:2]];
}
-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

- (id) getGame{
    return gameBoard.game;
}

@end
