//
//  MyScene.m
//  KingsNThings
//
//  Created by Menan Vadivel on 1/16/2014.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import "MyScene.h"

@implementation MyScene{
    NSArray * nonMovables;
}
static NSString * const defaultText = @"KingsNThings - Team24";

@synthesize myLabel,board;

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        
        nonMovables = @[@"board", @"bowl", @"rack"];
        board = [SKSpriteNode spriteNodeWithImageNamed:@"board"];
        [board setName:@"board"];
        board.anchorPoint = CGPointZero;
        board.position = CGPointMake(0,225);
        board.size = CGSizeMake(size.width, 576.0f);
        [self addChild:board];
        
        
        myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        
        myLabel.text = defaultText;
        myLabel.fontSize = 15;
        myLabel.position = CGPointMake(CGRectGetMaxX(self.frame) - (myLabel.frame.size.width/2) - 5,5);
        
        [board addChild:myLabel];
        [self drawTerrains:CGPointMake(45.0f, (self.frame.size.height / 2) + 25)];
        [self drawTerrains:CGPointMake(130.0f, (self.frame.size.height / 2) + 25)];
        
        [self drawBowlwithThings:CGPointMake(450.0f, (self.frame.size.height / 2) + 15)];
        
        [self drawRack:CGPointMake(620.0f, (self.frame.size.height / 2) + 15)];
        [self drawRack:CGPointMake(620.0f, (self.frame.size.height / 2) - 80)];
        [self drawRack:CGPointMake(620.0f, (self.frame.size.height / 2) - 170)];
        [self drawRack:CGPointMake(620.0f, (self.frame.size.height / 2) - 260)];
        
        
        [self drawCitadels:CGPointMake(25.0f, (self.frame.size.height / 2) - 40)];
        
        [self drawSpecialCreatures:CGPointMake(160.0f, (self.frame.size.height / 2) + 47)];
    }
    return self;
}

- (void) drawTerrains:(CGPoint) point{
    
    // 2) Loading the images
    NSArray *images = @[@"desert", @"forest", @"frozenWaste", @"jungle", @"mountains", @"plains", @"sea", @"swamp"];
    NSArray *imageNames = @[@"Desert", @"Forest", @"Frozen Waste", @"Jungle", @"Mountains", @"Plains", @"Sea", @"Swamp"];
    
    for(int i = 0; i < [imageNames count]; ++i) {
        NSString *image = [images objectAtIndex:i];
        NSString *imageName = [imageNames objectAtIndex:i];
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:image];
        [sprite setName:imageName];
        
        [sprite setPosition:point];
        [board addChild:sprite];
    }
}

- (void) drawBowlwithThings:(CGPoint) point{
    SKSpriteNode *bowl = [SKSpriteNode spriteNodeWithImageNamed:@"bowl"];
    [bowl setName:@"bowl"];
    [bowl setPosition:point];
    [board addChild:bowl];
}

- (void) drawRack:(CGPoint) point{
    SKSpriteNode *rack = [SKSpriteNode spriteNodeWithImageNamed:@"rack"];
    [rack setName:@"rack"];
    [rack setPosition:point];
    [board addChild:rack];
}

- (void) drawCitadels:(CGPoint) point{
    
    SKSpriteNode *castle = [SKSpriteNode spriteNodeWithImageNamed:@"castle"];
    [castle setName:@"Castle"];
    [castle setPosition:point];
    [board addChild:castle];
    
    
    SKSpriteNode *citadel = [SKSpriteNode spriteNodeWithImageNamed:@"citadel"];
    [citadel setName:@"Citadel"];
    [citadel setPosition:CGPointMake(point.x, point.y - 40 )];
    [board addChild:citadel];
    
    SKSpriteNode *tower = [SKSpriteNode spriteNodeWithImageNamed:@"tower"];
    [tower setName:@"Tower"];
    [tower setPosition:CGPointMake(point.x + 40, point.y)];
    [board addChild:tower];
    
    
    SKSpriteNode *keep = [SKSpriteNode spriteNodeWithImageNamed:@"keep"];
    [keep setName:@"Keep"];
    [keep setPosition:CGPointMake(point.x + 40, point.y - 40 )];
    [board addChild:keep];
    
}

- (void) drawSpecialCreatures:(CGPoint) point{
    NSArray *names = @[@"Desert Master", @"Sir Lance-A-Lot", @"Forest King", @"Dwarf King", @"Master Thief", @"Arch Mage"];
    
    int i;
    for (i = 0; i < names.count; i++) {
        int myint = i + 1;
        NSString *imageName = [NSString stringWithFormat:@"sc_%d",myint];
        NSString *name = [names objectAtIndex:i];
        SKSpriteNode *sc = [SKSpriteNode spriteNodeWithImageNamed:imageName];
        [sc setName:name];
        //        [sc setPosition:CGPointMake(point.x + 40, point.y)];
        
        
        NSLog(@"image size: %f",sc.size.width);
        float offsetFraction = point.x + ((sc.size.width + 1) * (i + 1));
        [sc setPosition:CGPointMake(offsetFraction, point.y)];
        
        [board addChild:sc];
        
    }
    NSArray *names2 = @[@"Arch Cleric", @"Assassin Primus", @"Elf Lord", @"Mountain King", @"Grand Duke"];
    
    for (int j = 0; j < names2.count; j++) {
        int myint = j + names2.count;
        NSString *imageName = [NSString stringWithFormat:@"sc_%d",myint];
        NSLog(@"image: %@",imageName);
        NSString *name = [names2 objectAtIndex:j];
        SKSpriteNode *sc = [SKSpriteNode spriteNodeWithImageNamed:imageName];
        [sc setName:name];
        float offsetFraction = point.x + ((sc.size.width + 1) * (j + 1));
        [sc setPosition:CGPointMake(offsetFraction, point.y - 37)];
        [board addChild:sc];
    }
    
    SKSpriteNode *bc = [SKSpriteNode spriteNodeWithImageNamed:@"bc"];
    [bc setName:@"Black Cloud"];
    float offsetFraction = point.x + ((bc.size.width + 1) * 6);
    [bc setPosition:CGPointMake(offsetFraction, point.y - 37)];
    [board addChild:bc];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
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
        if ([nonMovables containsObject: [_selectedNode name]])
            [myLabel setText:defaultText];
        else
            [myLabel setText:[touchedNode name]];
            
		//3
		if([nonMovables containsObject: [_selectedNode name]] == NO) {
            _selectedNode.color = [SKColor redColor];
            _selectedNode.colorBlendFactor = 0.5;
			SKAction *sequence = [SKAction sequence:@[[SKAction rotateByAngle:degToRad(-4.0f) duration:0.1],
													  [SKAction rotateByAngle:0.0 duration:0.1],
													  [SKAction rotateByAngle:degToRad(4.0f) duration:0.1]]];
			[_selectedNode runAction:[SKAction repeatActionForever:sequence]];
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
    retval.x = MAX(retval.x, -[board size].width+ winSize.width);
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
