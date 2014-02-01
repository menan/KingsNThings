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
#import "NSMutableArrayShuffling.h"

@implementation Board{
    NSArray * nonMovables;
    
    NSMutableArray *terrains;
    NSMutableArray *creatures;
    
    SKSpriteNode *board;
    SKScene *scene;
    CGPoint point;
    CGSize size;
    Bank *bank;
    
    SKLabelNode* balanceLabel;
    SKLabelNode* balanceText;
    SKLabelNode* diceLabel;
    
    int playersCount;
    
    int rollValue = 0;
    
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
        playersCount = 4;
        nonMovables = @[@"board", @"bowl", @"rack", @"Gold 1", @"Gold 2", @"Gold 5", @"Gold 10", @"Gold 15", @"Gold 20", @"My Gold 1", @"My Gold 2", @"My Gold 5", @"My Gold 10", @"My Gold 15", @"My Gold 20", @"dice"];
        terrains = [[NSMutableArray alloc] init];
        bank = [[Bank alloc]init];
    }
    return self;
}

- (SKSpriteNode *) getBoard{
    return board;
}
- (NSArray *) getNonMovables{
    return nonMovables;
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
    
    [self drawDice:CGPointMake(25.0f, 25.0f)];
    
    [self initTerrains:CGPointMake(45.0f, (size.height) - 40)];
    [self initTerrains:CGPointMake(130.0f, (size.height) - 40)];
    
    [self drawBowlwithThings:CGPointMake(450.0f, (size.height) - 40)];
    
    [self drawRack:CGPointMake(620.0f, (size.height) - 55)];
    [self drawRack:CGPointMake(620.0f, (size.height) - 150)];
    [self drawRack:CGPointMake(620.0f, (size.height) - 240)];
    [self drawRack:CGPointMake(620.0f, (size.height) - 330)];
    
    [self drawMarkers:CGPointMake(380.0f, 25.0f)];
    [self drawCitadels:CGPointMake(23.0f, (size.height) - 100)];
    
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
    
    for (int i = 0; i <= playersCount; i++) {
        for(int i = 0; i < [imageNames count]; ++i) {
            NSString *image = [images objectAtIndex:i];
            NSString *imageName = [imageNames objectAtIndex:i];
            
            Terrain * terrain = [[Terrain alloc] initWithBoard:board atPoint:tPoint imageNamed:image andTerrainName:imageName];
            [terrains addObject:terrain];
//            [terrain draw];
            
            
        }
    }
    [terrains shuffle];
    [terrains shuffle];
    [terrains shuffle];
    [terrains shuffle];
    for (Terrain * terrain in terrains) {
        [terrain draw];
    }
}

- (void) drawBowlwithThings:(CGPoint) aPoint{
    SKSpriteNode *bowl = [SKSpriteNode spriteNodeWithImageNamed:@"bowl"];
    [bowl setName:@"bowl"];
    [bowl setPosition:aPoint];
    [board addChild:bowl];
}

- (void) drawRack:(CGPoint) aPoint{
    SKSpriteNode *rack = [SKSpriteNode spriteNodeWithImageNamed:@"rack"];
    [rack setName:@"rack"];
    [rack setPosition:aPoint];
    [board addChild:rack];
}

- (void) drawDice:(CGPoint) aPoint{
    
    SKSpriteNode *dice = [SKSpriteNode spriteNodeWithImageNamed:@"dice"];
    [dice setName:@"dice"];
    dice.size = CGSizeMake(40, 40);
    [dice setPosition:aPoint];
    [board addChild:dice];
    
    
    diceLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    diceLabel.text = @"0";
    diceLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    diceLabel.fontSize = 25;
    diceLabel.position = CGPointMake(aPoint.x + 40.0f,aPoint.y - 10);
    [board addChild:diceLabel];
}
- (void) drawCitadels:(CGPoint) aPoint{
    
    for (int i = 0; i < playersCount; i++) {
        
        SKSpriteNode *castle = [SKSpriteNode spriteNodeWithImageNamed:@"castle"];
        [castle setName:@"Castle"];
        castle.size = CGSizeMake(40,40);
        [castle setPosition:aPoint];
        [board addChild:castle];
        
        
        SKSpriteNode *citadel = [SKSpriteNode spriteNodeWithImageNamed:@"citadel"];
        [citadel setName:@"Citadel"];
        citadel.size = CGSizeMake(40,40);
        [citadel setPosition:CGPointMake(aPoint.x, aPoint.y - 43 )];
        [board addChild:citadel];
        
        SKSpriteNode *tower = [SKSpriteNode spriteNodeWithImageNamed:@"tower"];
        [tower setName:@"Tower"];
        tower.size = CGSizeMake(40,40);
        [tower setPosition:CGPointMake(aPoint.x + 43, aPoint.y)];
        [board addChild:tower];
        
        
        SKSpriteNode *keep = [SKSpriteNode spriteNodeWithImageNamed:@"keep"];
        [keep setName:@"Keep"];
        keep.size = CGSizeMake(40,40);
        [keep setPosition:CGPointMake(aPoint.x + 43, aPoint.y - 43 )];
        [board addChild:keep];
    }
    
}
- (void) drawMarkers:(CGPoint) aPoint{
    
    for (int i = 0; i <= 2; i++) {
        
        SKSpriteNode *player1 = [SKSpriteNode spriteNodeWithImageNamed:@"p_red.jpg"];
        [player1 setName:@"Player 1"];
        player1.size = CGSizeMake(40,40);
        [player1 setPosition:aPoint];
        [board addChild:player1];
        
        
        SKSpriteNode *player2 = [SKSpriteNode spriteNodeWithImageNamed:@"p_green.jpg"];
        [player2 setName:@"Player 2"];
        player2.size = CGSizeMake(40,40);
        [player2 setPosition:CGPointMake(aPoint.x + 43, aPoint.y )];
        [board addChild:player2];
        
        
        SKSpriteNode *player3 = [SKSpriteNode spriteNodeWithImageNamed:@"p_yellow.jpg"];
        [player3 setName:@"Player 3"];
        player3.size = CGSizeMake(40,40);
        [player3 setPosition:CGPointMake(aPoint.x + 86, aPoint.y )];
        [board addChild:player3];
        
        SKSpriteNode *player4 = [SKSpriteNode spriteNodeWithImageNamed:@"p_gray.jpg"];
        [player4 setName:@"Player 3"];
        player4.size = CGSizeMake(40,40);
        [player4 setPosition:CGPointMake(aPoint.x + 129, aPoint.y )];
        [board addChild:player4];
    }
    
    
}

- (void) drawSpecialCreatures:(CGPoint) aPoint{
    NSArray *names = @[@"Desert Master", @"Sir Lance-A-Lot", @"Forest King", @"Dwarf King", @"Master Thief", @"Arch Mage"];
    [creatures removeAllObjects];
    int i;
    for (i = 0; i < names.count; i++) {
        int myint = i + 1;
        NSString *imageName = [NSString stringWithFormat:@"sc_%d",myint];
        NSString *name = [names objectAtIndex:i];
        
        
        float imageSize = 36;
        float offsetFraction = aPoint.x + ((imageSize + 1) * (i + 1));
        Creature* creature = [[Creature alloc] initWithBoard:board atPoint:CGPointMake(offsetFraction, aPoint.y) imageNamed:imageName andCreatureName:name withCombatValue:0 forTerrainType:@"" isSpecial:NO andCombatType:@"melee"];
        [creatures addObject:creature];
        [creature draw];
        
    }
    NSArray *names2 = @[@"Arch Cleric", @"Assassin Primus", @"Elf Lord", @"Mountain King", @"Grand Duke"];
    
    for (int j = 0; j < names2.count; j++) {
        int myint = j + names2.count;
        NSString *imageName = [NSString stringWithFormat:@"sc_%d",myint];
        NSLog(@"image: %@",imageName);
        NSString *name = [names2 objectAtIndex:j];
        
        float imageSize = 36;
        float offsetFraction = aPoint.x + ((imageSize + 1) * (j + 1));
        Creature* creature = [[Creature alloc] initWithBoard:board atPoint:CGPointMake(offsetFraction, aPoint.y - 37) imageNamed:imageName andCreatureName:name withCombatValue:0 forTerrainType:@"" isSpecial:NO andCombatType:@"melee"];
        [creatures addObject:creature];
        [creature draw];
    }
    
    
    NSString *imageName = @"bc";
    NSString *name = @"Black Cloud";
    
    float imageSize = 36;
    float offsetFraction = aPoint.x + ((imageSize + 1) * 6);
    Creature* creature = [[Creature alloc] initWithBoard:board atPoint:CGPointMake(offsetFraction, aPoint.y - 37) imageNamed:imageName andCreatureName:name withCombatValue:0 forTerrainType:@"" isSpecial:NO andCombatType:@"melee"];
    [creatures addObject:creature];
    [creature draw];
    
    
    
}

-(void) drawBank
{
    if([bank getBalance] == 710){
    
        for (int i = 0 ; i < 20 ; i++){
    
            SKSpriteNode *one = [bank goldsWithImage:@"GoldOne.jpg"];
            [one setName:@"Gold 1"];
            one.size = CGSizeMake(40,41);
            //one.centerRect = CGRectMake(12.0/430.0,12.0/440.0,4.0/430.0,4.0/440.0);
            [one setPosition:CGPointMake(535.0f, (size.height) - 420)];
            
            SKSpriteNode *two = [bank goldsWithImage:@"GoldTwo.jpg"];
            [two setName:@"Gold 2"];
            two.size = CGSizeMake(40,41);
            //one.centerRect = CGRectMake(12.0/430.0,12.0/440.0,4.0/430.0,4.0/440.0);
            [two setPosition:CGPointMake(585.0f, (size.height) - 420)];
            
            SKSpriteNode *five = [bank goldsWithImage:@"GoldFive.jpg"];
            [five setName:@"Gold 5"];
            five.size = CGSizeMake(40,41);
            //one.centerRect = CGRectMake(12.0/430.0,12.0/440.0,4.0/430.0,4.0/440.0);
            [five setPosition:CGPointMake(635.0f, (size.height) - 420)];
    
            SKSpriteNode *ten = [bank goldsWithImage:@"GoldTen.jpg"];
            [ten setName:@"Gold 10"];
            ten.size = CGSizeMake(40,41);
            //one.centerRect = CGRectMake(12.0/430.0,12.0/440.0,4.0/430.0,4.0/440.0);
            [ten setPosition:CGPointMake(535.0f, (size.height) - 481)];
            
            if(i <= 9 ){
                
    
                SKSpriteNode *fifteen = [bank goldsWithImage:@"GoldFifteen.jpg"];
                [fifteen setName:@"Gold 15"];
                fifteen.size = CGSizeMake(40,41);
                //one.centerRect = CGRectMake(12.0/430.0,12.0/440.0,4.0/430.0,4.0/440.0);
                [fifteen setPosition:CGPointMake(585.0f, (size.height) - 481)];
    
                SKSpriteNode *twenty = [bank goldsWithImage:@"GoldTwenty.jpg"];
                [twenty setName:@"Gold 20"];
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
    
    
    
    float bankLeft = 590.0f;
    
    balanceLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    balanceLabel.text = @"Balance";
    balanceLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    balanceLabel.fontSize = 15;
    balanceLabel.position = CGPointMake(bankLeft,(size.height) - 520.0f);

    
    NSString *balance = [NSString stringWithFormat: @"%d", (int)[bank getBalance]];
    balanceText = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    balanceText.text = balance;
    balanceText.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    balanceText.fontSize = 15;
    balanceText.position = CGPointMake(bankLeft,(size.height - balanceLabel.frame.size.height) - 520.0f);
    
    
    SKLabelNode *myStash = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    myStash.text = @"My Stash";
    myStash.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    myStash.fontSize = 15;
    myStash.position = CGPointMake(bankLeft + 120,(size.height - balanceLabel.frame.size.height) - 400.0f);
    [board addChild:myStash];
    
    SKLabelNode *myBalance = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    myBalance.text = @"0";
    myBalance.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    myBalance.fontSize = 15;
    myBalance.position = CGPointMake(bankLeft + 120,(size.height - balanceLabel.frame.size.height) - 475.0f);
    [board addChild:myBalance];
    
    [board addChild:balanceLabel];
    [board addChild:balanceText];
    
}

-(void)drawPlayerGold:(NSString*)goldType withName:(NSString *)name andPoint:(CGPoint)location{
    
    SKSpriteNode *gold = [bank goldsWithImage:goldType];
    [gold setName:name];
    gold.size = CGSizeMake(40,41);
    //one.centerRect = CGRectMake(12.0/430.0,12.0/440.0,4.0/430.0,4.0/440.0);
    [gold setPosition:CGPointMake(710.0f,(size.height) - 450.0f)];
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

    balanceText.text = balance;
}

- (void) rollDice{
    int r = (arc4random() % 11) + 1;
    diceLabel.text = [NSString stringWithFormat:@"%d",r];
    rollValue = r;
}


@end
