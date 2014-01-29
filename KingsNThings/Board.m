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
#import "Bank.h"

@implementation Board{
    NSArray * nonMovables;
    
    NSMutableArray *terrains;
    NSMutableArray *creatures;
    
    SKSpriteNode *board;
    SKScene *scene;
    CGPoint point;
    CGSize size;
    Bank *bank;
    
    SKLabelNode* Baltext;
    SKLabelNode* BalLabel;
    
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
        bank = [[Bank alloc]init];
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
    
    [self drawBank];
    
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

-(void) drawBank
{
    if([bank getBalance] == 710){
    
        for (int i = 0 ; i < 20 ; i++){
    
            SKSpriteNode *one = [bank goldsWithImage:@"GoldOne.jpg"];
            [one setName:@"One"];
            one.size = CGSizeMake(40,41);
            //one.centerRect = CGRectMake(12.0/430.0,12.0/440.0,4.0/430.0,4.0/440.0);
            [one setPosition:CGPointMake(535.0f, (size.height) - 420)];
            
            SKSpriteNode *two = [bank goldsWithImage:@"GoldTwo.jpg"];
            [two setName:@"Two"];
            two.size = CGSizeMake(40,41);
            //one.centerRect = CGRectMake(12.0/430.0,12.0/440.0,4.0/430.0,4.0/440.0);
            [two setPosition:CGPointMake(585.0f, (size.height) - 420)];
            
            SKSpriteNode *five = [bank goldsWithImage:@"GoldFive.jpg"];
            [five setName:@"Five"];
            five.size = CGSizeMake(40,41);
            //one.centerRect = CGRectMake(12.0/430.0,12.0/440.0,4.0/430.0,4.0/440.0);
            [five setPosition:CGPointMake(635.0f, (size.height) - 420)];
    
            SKSpriteNode *ten = [bank goldsWithImage:@"GoldTen.jpg"];
            [ten setName:@"Ten"];
            ten.size = CGSizeMake(40,41);
            //one.centerRect = CGRectMake(12.0/430.0,12.0/440.0,4.0/430.0,4.0/440.0);
            [ten setPosition:CGPointMake(535.0f, (size.height) - 481)];
            
            if(i <= 9 ){
                
    
                SKSpriteNode *fifteen = [bank goldsWithImage:@"GoldFifteen.jpg"];
                [fifteen setName:@"Fifteen"];
                fifteen.size = CGSizeMake(40,41);
                //one.centerRect = CGRectMake(12.0/430.0,12.0/440.0,4.0/430.0,4.0/440.0);
                [fifteen setPosition:CGPointMake(585.0f, (size.height) - 481)];
    
                SKSpriteNode *twenty = [bank goldsWithImage:@"GoldTwenty.jpg"];
                [twenty setName:@"Twenty"];
                twenty.size = CGSizeMake(40,41);
                //one.centerRect = CGRectMake(12.0/430.0,12.0/440.0,4.0/430.0,4.0/440.0);
                [twenty setPosition:CGPointMake(635.0f, (size.height) - 481)];
                
                
                [board addChild:fifteen];
                [board addChild:twenty];
            }
            [board addChild:one];
            [board addChild:two];
            [board addChild:five];
            [board addChild:ten];
        }
    
    }
    
    
    
    
    
    Baltext = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    Baltext.text = @"Balance: ";
    Baltext.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
    Baltext.fontSize = 15;
    Baltext.position = CGPointMake(630.0f,(size.height) - 530.0f);

    
    NSString *balance = [NSString stringWithFormat: @"%d", (int)[bank getBalance]];
    
    BalLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    BalLabel.text = balance;
    BalLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
    BalLabel.fontSize = 15;
    BalLabel.position = CGPointMake(660.0f,(size.height) - 530.0f);
    
    
    
    [board addChild:Baltext];
    [board addChild:BalLabel];
    
}

-(void)drawPlayerGold:(NSString*)goldType andPoint:(CGPoint)location{
    
    SKSpriteNode *gold = [bank goldsWithImage:goldType];
    [gold setName:goldType];
    gold.size = CGSizeMake(40,41);
    //one.centerRect = CGRectMake(12.0/430.0,12.0/440.0,4.0/430.0,4.0/440.0);
    [gold setPosition:CGPointMake(670.0f,(size.height) - 530.0f)];
      [board addChild:gold];
    
    
}
-(void)updateBankBalance:(NSInteger)goldNum
{
    if(goldNum == 1)
        [bank setOneGold:[bank oneGold]-1];
    else if(goldNum == 2)
        [bank setTwoGold:[bank twoGold]-1];
    else if(goldNum == 5)
        [bank setFiveGold:[bank fiveGold]-1];
    else if(goldNum == 10)
        [bank setTenGold:[bank tenGold]-1];
    else if(goldNum == 15)
        [bank setFifteenGold:[bank fifteenGold]-1];
    else if(goldNum == 20)
        [bank setTwentyGold:[bank twentyGold]-1];
    
    
    [bank updateBalance];
    
    NSString *balance = [NSString stringWithFormat: @"%d", (int)[bank getBalance]];

    BalLabel.text = balance;
}

@end
