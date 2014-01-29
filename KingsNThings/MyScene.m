//
//  MyScene.m
//  KingsNThings
//
//  Created by Menan Vadivel on 1/16/2014.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import "MyScene.h"
#import "Board.h"

@implementation MyScene{
    NSArray * nonMovables;
    Board *gameBoard;
}

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        
        gameBoard = [[Board alloc] initWithScene:self atPoint:CGPointMake(0,225) withSize:CGSizeMake(size.width, 576.0f)];
        [gameBoard draw];
        nonMovables = @[@"board", @"bowl", @"rack"];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    UITouch *touch = [touches anyObject];
    CGPoint positionInScene = [touch locationInNode:self];
    
    SKNode *node = [self nodeAtPoint:positionInScene];
    
    if ([node.name isEqualToString:@"One"]) {
        
        [gameBoard updateBankBalance:1];
        
    [gameBoard drawPlayerGold:@"GoldOne.jpg" andPoint:(CGPoint)positionInScene];
        
        NSLog(@"Button pressed");
    }
    
    
    else
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
        if ([nonMovables containsObject: [_selectedNode name]])
            [gameBoard resetText];
        else
            [gameBoard.textLabel setText:[touchedNode name]];
            
		//3
		if([nonMovables containsObject: [_selectedNode name]] == NO) {
            _selectedNode.color = [SKColor redColor];
            _selectedNode.colorBlendFactor = 0.5;
//			SKAction *sequence = [SKAction sequence:@[[SKAction rotateByAngle:degToRad(-4.0f) duration:0.1],
//													  [SKAction rotateByAngle:0.0 duration:0.1],
//													  [SKAction rotateByAngle:degToRad(4.0f) duration:0.1]]];
//			[_selectedNode runAction:[SKAction repeatActionForever:sequence]];
		}
	}
    
}

float degToRad(float degree) {
	return degree / 180.0f * M_PI;
}
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
    if([nonMovables containsObject: [_selectedNode name]] == NO) {
        [_selectedNode setPosition:CGPointMake(position.x + translation.x, position.y + translation.y)];
    }
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
	CGPoint positionInScene = [touch locationInNode:self];
	CGPoint previousPosition = [touch previousLocationInNode:self];
    
	CGPoint translation = CGPointMake(positionInScene.x - previousPosition.x, positionInScene.y - previousPosition.y);
    
	[self panForTranslation:translation];
}

- (void)handlePanFrom:(UIPanGestureRecognizer *)recognizer {
    NSLog(@"move changed: %d",recognizer.state);
	if (recognizer.state == UIGestureRecognizerStateBegan) {
        
        CGPoint touchLocation = [recognizer locationInView:recognizer.view];
        
        touchLocation = [self convertPointFromView:touchLocation];
        
        [self selectNodeForTouch:touchLocation];
        
        
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        
        CGPoint translation = [recognizer translationInView:recognizer.view];
        translation = CGPointMake(translation.x, -translation.y);
        [self panForTranslation:translation];
        [recognizer setTranslation:CGPointZero inView:recognizer.view];
        
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        
        if (![nonMovables containsObject: [_selectedNode name]] == NO) {
            float scrollDuration = 0.2;
            CGPoint velocity = [recognizer velocityInView:recognizer.view];
            CGPoint pos = [_selectedNode position];
            CGPoint p = mult(velocity, scrollDuration);
            
            CGPoint newPos = CGPointMake(pos.x + p.x, pos.y + p.y);
            newPos = [self boundLayerPos:newPos];
            [_selectedNode removeAllActions];
            
            SKAction *moveTo = [SKAction moveTo:newPos duration:scrollDuration];
            [moveTo setTimingMode:SKActionTimingEaseOut];
            [_selectedNode runAction:moveTo];
        }
        
    }
}
CGPoint mult(const CGPoint v, const CGFloat s) {
	return CGPointMake(v.x*s, v.y*s);
}
-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
