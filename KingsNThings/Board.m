//
//  Board.m
//  KingsNThings
//
//  Created by Menan Vadivel on 1/28/2014.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import "Board.h"
#import "Terrain.h"
#import "Creature.h"

@implementation Board{
    NSArray * nonMovables;
    
    NSMutableArray *terrains;
    NSMutableArray *creatures;
    
    SKSpriteNode *board;
    SKScene *scene;
    CGPoint point;
    CGSize size;
}
static NSString * const defaultText = @"KingsNThings - Team24";

@synthesize textLabel;
- (id)initWithScene: (SKScene *) aScene atPoint: (CGPoint) aPoint withSize: (CGSize) aSize
{
    self = [super init];
    if (self) {
        point = aPoint;
        size = aSize;
        scene = aScene;
        nonMovables = @[@"board", @"bowl", @"rack"];
        terrains = [[NSMutableArray alloc] init];
    }
    return self;
}

- (SKSpriteNode *) getBoard{
    return board;
}

- (void) draw{
    
    board = [SKSpriteNode spriteNodeWithImageNamed:@"board"];
    [board setName:@"board"];
    board.anchorPoint = CGPointZero;
    board.position = CGPointMake(0,225);
    board.size = CGSizeMake(size.width, 576.0f);
    [scene addChild:board];
    
    [self drawText];
    
    [self initTerrains:CGPointMake(45.0f, (size.height) - 40)];
    [self initTerrains:CGPointMake(130.0f, (size.height) - 40)];
    
    [self drawBowlwithThings:CGPointMake(450.0f, (size.height) - 40)];
    
    [self drawRack:CGPointMake(620.0f, (size.height) - 55)];
    [self drawRack:CGPointMake(620.0f, (size.height) - 150)];
    [self drawRack:CGPointMake(620.0f, (size.height) - 240)];
    [self drawRack:CGPointMake(620.0f, (size.height) - 330)];
    
    [self drawCitadels:CGPointMake(25.0f, (size.height) - 100)];
    
    [self drawSpecialCreatures:CGPointMake(160.0f, (size.height) - 20)];
}

- (void) resetText{
    textLabel.text = defaultText;
}

- (void) drawText{
    textLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    textLabel.text = defaultText;
    textLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
    textLabel.fontSize = 15;
    textLabel.position = CGPointMake(point.x + size.width - 5,5);
    [board addChild:textLabel];
}

- (void) initTerrains:(CGPoint) tPoint{
    
    [terrains removeAllObjects];
    // 2) Loading the images
    NSArray *images = @[@"desert", @"forest", @"frozenWaste", @"jungle", @"mountains", @"plains", @"sea", @"swamp"];
    NSArray *imageNames = @[@"Desert", @"Forest", @"Frozen Waste", @"Jungle", @"Mountains", @"Plains", @"Sea", @"Swamp"];
    
    for(int i = 0; i < [imageNames count]; ++i) {
        NSString *image = [images objectAtIndex:i];
        NSString *imageName = [imageNames objectAtIndex:i];
        
        Terrain * terrain = [[Terrain alloc] initWithBoard:board atPoint:tPoint imageNamed:image andTerrainName:imageName];
        [terrains addObject:terrain];
        [terrain draw];
        
        
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

- (void) drawSpecialCreatures:(CGPoint) aPoint{
    NSArray *names = @[@"Desert Master", @"Sir Lance-A-Lot", @"Forest King", @"Dwarf King", @"Master Thief", @"Arch Mage"];
    [creatures removeAllObjects];
    int i;
    for (i = 0; i < names.count; i++) {
        int myint = i + 1;
        NSString *imageName = [NSString stringWithFormat:@"sc_%d",myint];
        NSString *name = [names objectAtIndex:i];
        
        //        [sc setPosition:CGPointMake(point.x + 40, point.y)];
        
        float imageSize = 36;
        float offsetFraction = aPoint.x + (imageSize * (i + 1));
        Creature* creature = [[Creature alloc] initWithBoard:board atPoint:CGPointMake(offsetFraction, aPoint.y) imageNamed:imageName andCreatureName:name withCombatValue:0 forTerrainType:@"" isSpecial:NO andCombatType:@"melee"];
        [creatures addObject:creature];
        [creature draw];
        
//        NSLog(@"image size: %f",sc.size.width);
        
//        [board addChild:sc];
        
    }
    NSArray *names2 = @[@"Arch Cleric", @"Assassin Primus", @"Elf Lord", @"Mountain King", @"Grand Duke"];
    
    for (int j = 0; j < names2.count; j++) {
        int myint = j + names2.count;
        NSString *imageName = [NSString stringWithFormat:@"sc_%d",myint];
        NSLog(@"image: %@",imageName);
        NSString *name = [names2 objectAtIndex:j];
//        SKSpriteNode *sc = [SKSpriteNode spriteNodeWithImageNamed:imageName];
//        [sc setName:name];
//        float offsetFraction = point.x + ((sc.size.width + 1) * (j + 1));
//        [sc setPosition:CGPointMake(offsetFraction, point.y - 37)];
        
        float imageSize = 36;
        float offsetFraction = aPoint.x + (imageSize * (j + 1));
        Creature* creature = [[Creature alloc] initWithBoard:board atPoint:CGPointMake(offsetFraction, aPoint.y - 37) imageNamed:imageName andCreatureName:name withCombatValue:0 forTerrainType:@"" isSpecial:NO andCombatType:@"melee"];
        [creatures addObject:creature];
        [creature draw];
    }
    
//    SKSpriteNode *bc = [SKSpriteNode spriteNodeWithImageNamed:@"bc"];
//    [bc setName:@"Black Cloud"];
//    float offsetFraction = point.x + ((bc.size.width + 1) * 6);
//    [bc setPosition:CGPointMake(offsetFraction, point.y - 37)];
//    [board addChild:bc];
    
    
    NSString *imageName = @"bc";
    NSString *name = @"Black Cloud";
    
    float imageSize = 36;
    float offsetFraction = aPoint.x + (imageSize * 6);
    Creature* creature = [[Creature alloc] initWithBoard:board atPoint:CGPointMake(offsetFraction, aPoint.y - 37) imageNamed:imageName andCreatureName:name withCombatValue:0 forTerrainType:@"" isSpecial:NO andCombatType:@"melee"];
    [creatures addObject:creature];
    [creature draw];
    
    
    
}

@end
