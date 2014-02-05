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
#import "Player.h"
#import "NSMutableArrayShuffling.h"

@implementation Board{
    NSArray * nonMovables;
    
    NSArray *terrainNames;
    
    NSMutableArray *terrains;
    NSMutableArray *creatures;
    
    NSMutableArray *players;
    
    SKSpriteNode *board;
    SKScene *scene;
    CGPoint point;
    CGSize size;
    Bank *bank;
    
    SKLabelNode* balanceLabel;
    SKLabelNode* balanceText;
    SKLabelNode* diceLabel;
    
    int playersCount;
    
    int rollValue;
    
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
        rollValue = 0;
        nonMovables = @[@"board", @"bowl", @"rack", @"Gold 1", @"Gold 2", @"Gold 5", @"Gold 10", @"Gold 15", @"Gold 20", @"My Gold 1", @"My Gold 2", @"My Gold 5", @"My Gold 10", @"My Gold 15", @"My Gold 20", @"dice"];
        terrainNames = @[@"Desert", @"Forest", @"Frozen Waste", @"Jungle", @"Mountains", @"Plains", @"Sea", @"Swamp"];
        
        terrains = [[NSMutableArray alloc] init];
        players = [[NSMutableArray alloc] init];
        bank = [[Bank alloc]init];
        
        Player *player1 = [[Player alloc] init];
        Player *player2 = [[Player alloc] init];
        Player *player3 = [[Player alloc] init];
        Player *player4 = [[Player alloc] init];
        
        [players addObject:player1];
        [players addObject:player2];
        [players addObject:player3];
        [players addObject:player4];
        
        
        NSLog(@"player 1 balance: %d and stage of building: %d", [player1 getBankBalance], [player1 getStage]);
        
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
    
//    [self initTerrains:CGPointMake(45.0f, (size.height) - 40)];
//    [self initTerrains:CGPointMake(130.0f, (size.height) - 40)];
    
    [self hardCodeTerrains];
    
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
    
    NSLog(@"Placing terrains at : %f,%f", tPoint.x, tPoint.y );
//    [terrains removeAllObjects];
    // 2) Loading the images
    NSArray *images = @[@"desert", @"forest", @"frozenWaste", @"jungle", @"mountains", @"plains", @"sea", @"swamp"];
    NSArray *imageNames = @[@"Desert", @"Forest", @"Frozen Waste", @"Jungle", @"Mountains", @"Plains", @"Sea", @"Swamp"];
    
    for (int i = 0; i <= 2; i++) {
        for(int i = 0; i < [imageNames count]; ++i) {
            NSString *image = [images objectAtIndex:i];
            NSString *imageName = [imageNames objectAtIndex:i];
            
            Terrain * terrain = [[Terrain alloc] initWithBoard:board atPoint:tPoint imageNamed:image andTerrainName:imageName];
            [terrains addObject:terrain];
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
    
    [self drawThings:aPoint];
}

- (void) drawThings:(CGPoint) aPoint{
    NSArray *creatureList = @[@"-n Baby Dragon -t Desert -s Fly -a 3", @"-n Giant Spider -t Desert -a 1", @"-n Sandworm -t Desert -a 3", @"-n Camel Corps -t Desert -a 3", @"-n Giant Wasp -t Desert -s Fly -a 2", @"-n Skletons -c 2 -t Desert -a 1", @"-n Dervish -c 2 -t Desert -s Magic -a 2", @"-n Giant Wasp -t Desert -s Fly -a 4", @"-n Sphinx -t Desert -s Magic -a 4", @"-n Desert Bat -t Desert -s Fly -a 1", @"-n Griffon -t Desert -s Fly -a 2", @"-n Vultures -c 2 -t Desert -s Fly -a 1", @"-n Dust Devil -t Desert -s Fly -a 4", @"-n Nomads -c 2 -t Desert -a 1", @"-n Yellow Knight -t Desert -s Charge -a 3", @"-n Genie -t Desert -s Magic -a 4", @"-n Old Dragon -s Fly -s Magic -a 4", @"-n Bandits -t Forest -a 2", @"-n Elves -t Forest -s Range -a 3", @"-n Pixies -c 2 -t Forest -s Fly -a 1", @"-n Bears -t Forest -a 2", @"-n Flying Squirrel -t Forest -s Fly -a 1", @"-n Unicorn -t Forest -a 4", @"-n Big Foot -t Forest -a 5", @"-n Flying Squirrel -t Forest -s Fly -a 2", @"-n Walking Tree -t Forest -a 5", @"-n Druid -t Forest -s Magic -a 3", @"-n Forester -t Forest -s Range -a 2", @"-n Wild Cat -t Forest -a 2", @"-n Dryad -t Forest -s Magic -a 1", @"-n Great Owl -t Forest -s Fly -a 2", @"-n Wyvern -t Forest -s Fly -a 3", @"-n Elf Mage -t Forest -s Magic -a 2", @"-n Green Knight -t Forest -s Charge -a 4", @"-n Elves -c 2 -t Forest -s Range -a 2", @"-n Killer Racoon -t Forest -a 2", @"-n Bird Of Paradise -t Jungle -s Fly -a 1", @"-n Head Hunter -t Jungle -s Range -a 2", @"-n Crawling Vines -t Jungle -a 6", @"-n Pterodactyl Warriors -c 2 -t Jungle -s Fly -s Range -a 2", @"-n Crocodiles -t Jungle -a 2", @"-n Pygmies -t Jungle -a 2", @"-n Dinasaur -t Jungle -a 4", @"-n Tigers -c 2 -t Jungle -a 3", @"-n Elephant -t Jungle -s Charge -a 4", @"-n Watusi -t Jungle -s 2", @"-n Giant Ape -c 2 -t Jungle -a 5", @"-n Witch Doctor -t Jungle -s Magic -a 2", @"-n Giant Snake -t Jungle -s 3", @"-n Dragon Rider -t Frozen Waste -s Fly -s Range -a 3", @"-n Killer Puffins -t Frozen Waste -s Fly -a 2", @"-n Elk Herd -t Frozen Waste -a 2", @"-n Mammoth -t Frozen Waste -s Charge -a 5", @"-n Eskimos -c 4 -t Frozen Waste -a 2", @"-n North Wind -t Frozen Waste -s Fly -s Magic -a 2", @"-n Ice Bats -t Frozen Waste -s Fly -a 1", @"-n Walrus -t Frozen Waste -a 4", @"-n Ice Giant -t Frozen Waste -s Range -a 5", @"-n White Brea -t Frozen Waste -a 4", @"-n Iceworm -t Frozen Waste -s Magic -a 4", @"-n White Dragon -t Frozen Waste -s Magic -a 5", @"-n Killer Penguins -t Frozen Waste -a 3", @"-n Wolves -t Frozen Waste -a 3", @"-n Brown Dragon -t Mountain -s Fly -a 3", @"-n Gaint Roc -t Mountain -s Fly -a 3", @"-n Little Roc -t Mountain -s Fly -a 2", @"-n Brown Knight -t Mountain -s Charge -a 4", @"-n Giant -t Mountain -s Range -a 4", @"-n Mountain Lion -t Mountain -a 2", @"-n Cyclops -t Mountain -a 5", @"-n Giant Condor -t Mountain -s Fly -a 3", @"-n Mountain Men -c 2 -t Mountain -a 1", @"-n Dwarves -t Mountain -s Charge -a 3", @"-n Goblins -c 4 -t Mountain -a 1", @"-n Orge Mountain -t Mountain -a 2", @"-n Dwarves -t Mountain -s Range -a 2", @"-n Great Eagle -t Mountain -s Fly -a 2", @"-n Troll -t Mountain -a 4", @"-n Dwarves -t Mountain -s Range -a 3", @"-n Great Hawk -t Mountain -s Fly -a 1", @"-n Buffalo Herd -t Plains -a 3", @"-n Giant Beetle -t Plains -s Fly -a 2", @"-n Pegasus -t Plains -s Fly -a 2", @"-n Buffalo Herd -t Plains -a 4", @"-n Great Hawk -t Plains -s Fly -a 2", @"-n Pterodactyl -t Plains -s Fly -a 3", @"-n Centaur -t Plains -a 2", @"-n Greathunter -t Plains -s Range -a 4", @"-n Tribesmen -c 2 -t Plains -a 2", @"-n Dragonfly -t Plains -s Fly -a 2", @"-n Gypsies -t Plains -s Magic -a 1", @"-n Villains -t Plains -a 2", @"-n Eagles -t Plains -s Fly -a 2", @"-n Gypsies -t Plains -s Magic -a 2", @"-n White Knight -t Plains -s Charge -a 3", @"-n Farmers -c 4 -t Plains -a 1", @"-n Hunter -t Plains -s Range -a 1", @"-n Wolf Pack -t Plains -a 3", @"-n Flying Buffalo -t Plains -s Fly -a 2", @"-n Lion Ride -t Plains -a 3", @"-n Tribesmen -t Plains -s Range -a 1", @"-n Basilisk -t Swamp -s Magic -a 3", @"-n Giant-Snake -t Swamp -a 3", @"-n Swamp Gas -t Swamp -s Fly -a 1", @"-n Black Knight -t Swamp -s Charge -a 3", @"-n Huge Leech -t Swamp -a 2", @"-n Swamp Rat -t Swamp -a 1", @"-n Crocodiles -t Swamp -a 2", @"-n Pirates -t Swamp -a 2", @"-n Thing -t Swamp -a 2", @"-n Dark Wizard -t Swamp -s Fly -s Magic -a 1", @"-n Poison Frog -t Swamp -a 1", @"-n Vampire Bat -t Swamp -s Fly -a 4", @"-n Ghost -c 4 -t Swamp -s Fly -a 1", @"-n Spirit -t Swamp -s Magic -a 2", @"-n Watersanke -t Swamp -a 1", @"-n Giant Lizard -c 2 -t Swamp -a 2", @"-n Sprote -t Swamp -s Magic -a 1", @"-n Will_O_Wisp -t Swamp -s Magic -a 2", @"-n Giant Mosquito -t Swamp -s Fly -a 2", @"-n Swamp Beast -t Swamp -a 3", @"-n Winged Pirhana -t Swamp -s Fly -a 3" ];
    creatures = [[NSMutableArray alloc] init];
    for (NSString *str in creatureList) {
        Creature *creature = [[Creature alloc] initWithBoard:board atPoint:aPoint fromString:str];
        [creatures addObject:creature];
    }
    NSLog(@"creatures count: %d", creatures.count);
    
    [creatures shuffle];
    [creatures shuffle];
    [creatures shuffle];
    [creatures shuffle];
    for (Creature * creature in creatures) {
        [creature draw];
    }
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
    
    for (int i = 0; i <= 5; i++) {
        
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
//    [creatures removeAllObjects];
    int i;
    for (i = 0; i < names.count; i++) {
        int myint = i + 1;
        NSString *imageName = [NSString stringWithFormat:@"sc_%d",myint];
        NSString *name = [names objectAtIndex:i];
        
        
        float imageSize = 36;
        float offsetFraction = aPoint.x + ((imageSize + 1) * (i + 1));
        Creature* creature = [[Creature alloc] initWithBoard:board atPoint:CGPointMake(offsetFraction, aPoint.y) imageNamed:imageName andCreatureName:name withCombatValue:0 forTerrainType:@"" isSpecial:YES andCombatType:@"melee"];
        [creatures addObject:creature];
        [creature draw];
        
    }
    NSArray *names2 = @[@"Arch Cleric", @"Assassin Primus", @"Elf Lord", @"Mountain King", @"Grand Duke"];
    
    for (int j = 0; j < names2.count; j++) {
        int myint = j + names2.count;
        NSString *imageName = [NSString stringWithFormat:@"sc_%d",myint];
        NSString *name = [names2 objectAtIndex:j];
        
        float imageSize = 36;
        float offsetFraction = aPoint.x + ((imageSize + 1) * (j + 1));
        Creature* creature = [[Creature alloc] initWithBoard:board atPoint:CGPointMake(offsetFraction, aPoint.y - 37) imageNamed:imageName andCreatureName:name withCombatValue:0 forTerrainType:@"" isSpecial:YES andCombatType:@"melee"];
        [creatures addObject:creature];
        [creature draw];
    }
    
    
    NSString *imageName = @"bc";
    NSString *name = @"Black Cloud";
    
    float imageSize = 36;
    float offsetFraction = aPoint.x + ((imageSize + 1) * 6);
    Creature* creature = [[Creature alloc] initWithBoard:board atPoint:CGPointMake(offsetFraction, aPoint.y - 37) imageNamed:imageName andCreatureName:name withCombatValue:0 forTerrainType:@"" isSpecial:YES andCombatType:@"melee"];
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
    int r = (arc4random() % 10) + 2;
    diceLabel.text = [NSString stringWithFormat:@"%d",r];
    rollValue = r;
    
}

- (void) hardCodeTerrains{
    
    [terrains addObject:[[Terrain alloc] initWithBoard:board atPoint: CGPointMake(303.000000,213.500000) imageNamed:@"Plains" andTerrainName:@"Plains"]];
    [terrains addObject:[[Terrain alloc] initWithBoard:board atPoint: CGPointMake(303.750000,356.750000) imageNamed:@"Mountains" andTerrainName:@"Mountains"]];
    [terrains addObject:[[Terrain alloc] initWithBoard:board atPoint: CGPointMake(426.250000,283.250000) imageNamed:@"Plains" andTerrainName:@"Plains"]];
    [terrains addObject:[[Terrain alloc] initWithBoard:board atPoint: CGPointMake(57.750000,359.000000) imageNamed:@"Desert" andTerrainName:@"Desert"]];
    [terrains addObject:[[Terrain alloc] initWithBoard:board atPoint: CGPointMake(301.000000,72.500000) imageNamed:@"Mountains" andTerrainName:@"Mountains"]];
    [terrains addObject:[[Terrain alloc] initWithBoard:board atPoint: CGPointMake(366.000000,391.250000) imageNamed:@"Plains" andTerrainName:@"Plains"]];
    [terrains addObject:[[Terrain alloc] initWithBoard:board atPoint: CGPointMake(238.500000,38.000000) imageNamed:@"Desert" andTerrainName:@"Desert"]];
    [terrains addObject:[[Terrain alloc] initWithBoard:board atPoint: CGPointMake(242.250000,322.250000) imageNamed:@"Forest" andTerrainName:@"Forest"]];
    [terrains addObject:[[Terrain alloc] initWithBoard:board atPoint: CGPointMake(117.750000,110.750000) imageNamed:@"Jungle" andTerrainName:@"Jungle"]];
    [terrains addObject:[[Terrain alloc] initWithBoard:board atPoint: CGPointMake(57.000000,145.250000) imageNamed:@"Mountains" andTerrainName:@"Mountains"]];
    [terrains addObject:[[Terrain alloc] initWithBoard:board atPoint: CGPointMake(424.750000,141.500000) imageNamed:@"frozenWaste" andTerrainName:@"Frozen Waste"]];
    [terrains addObject:[[Terrain alloc] initWithBoard:board atPoint: CGPointMake(180.250000,287.750000) imageNamed:@"Swamp" andTerrainName:@"Swamp"]];
    [terrains addObject:[[Terrain alloc] initWithBoard:board atPoint: CGPointMake(244.000000,465.500000) imageNamed:@"Jungle" andTerrainName:@"Jungle"]];
    [terrains addObject:[[Terrain alloc] initWithBoard:board atPoint: CGPointMake(363.250000,177.500000) imageNamed:@"Desert" andTerrainName:@"Desert"]];
    [terrains addObject:[[Terrain alloc] initWithBoard:board atPoint: CGPointMake(57.000000,288.500000) imageNamed:@"frozenWaste" andTerrainName:@"Frozen Waste"]];
    [terrains addObject:[[Terrain alloc] initWithBoard:board atPoint: CGPointMake(365.500000,320.000000) imageNamed:@"frozenWaste" andTerrainName:@"Frozen Waste"]];
    [terrains addObject:[[Terrain alloc] initWithBoard:board atPoint: CGPointMake(177.750000,74.000000) imageNamed:@"Plains" andTerrainName:@"Plains"]];
    [terrains addObject:[[Terrain alloc] initWithBoard:board atPoint: CGPointMake(241.500000,250.250000) imageNamed:@"frozenWaste" andTerrainName:@"Frozen Waste"]];
    [terrains addObject:[[Terrain alloc] initWithBoard:board atPoint: CGPointMake(118.500000,323.750000) imageNamed:@"Jungle" andTerrainName:@"Jungle"]];
    [terrains addObject:[[Terrain alloc] initWithBoard:board atPoint: CGPointMake(426.000000,212.750000) imageNamed:@"Forest" andTerrainName:@"Forest"]];
    [terrains addObject:[[Terrain alloc] initWithBoard:board atPoint: CGPointMake(302.500000,143.750000) imageNamed:@"Swamp" andTerrainName:@"Swamp"]];
    [terrains addObject:[[Terrain alloc] initWithBoard:board atPoint: CGPointMake(118.000000,181.250000) imageNamed:@"Plains" andTerrainName:@"Plains"]];
    [terrains addObject:[[Terrain alloc] initWithBoard:board atPoint: CGPointMake(179.500000,216.500000) imageNamed:@"Forest" andTerrainName:@"Forest"]];
    [terrains addObject:[[Terrain alloc] initWithBoard:board atPoint: CGPointMake(364.500000,248.750000) imageNamed:@"Swamp" andTerrainName:@"Swamp"]];
    [terrains addObject:[[Terrain alloc] initWithBoard:board atPoint: CGPointMake(180.250000,358.250000) imageNamed:@"Plains" andTerrainName:@"Plains"]];
    [terrains addObject:[[Terrain alloc] initWithBoard:board atPoint: CGPointMake(242.250000,394.250000) imageNamed:@"frozenWaste" andTerrainName:@"Frozen Waste"]];
    [terrains addObject:[[Terrain alloc] initWithBoard:board atPoint: CGPointMake(427.500000,354.500000) imageNamed:@"Forest" andTerrainName:@"Forest"]];
    [terrains addObject:[[Terrain alloc] initWithBoard:board atPoint: CGPointMake(239.500000,109.250000) imageNamed:@"Forest" andTerrainName:@"Forest"]];
    [terrains addObject:[[Terrain alloc] initWithBoard:board atPoint: CGPointMake(241.000000,179.750000) imageNamed:@"Sea" andTerrainName:@"Sea"]];
    [terrains addObject:[[Terrain alloc] initWithBoard:board atPoint: CGPointMake(118.000000,252.500000) imageNamed:@"Mountains" andTerrainName:@"Mountains"]];
    [terrains addObject:[[Terrain alloc] initWithBoard:board atPoint: CGPointMake(178.500000,145.250000) imageNamed:@"Desert" andTerrainName:@"Desert"]];
    [terrains addObject:[[Terrain alloc] initWithBoard:board atPoint: CGPointMake(363.000000,106.250000) imageNamed:@"Jungle" andTerrainName:@"Jungle"]];
    [terrains addObject:[[Terrain alloc] initWithBoard:board atPoint: CGPointMake(56.500000,217.250000) imageNamed:@"Forest" andTerrainName:@"Forest"]];
    [terrains addObject:[[Terrain alloc] initWithBoard:board atPoint: CGPointMake(181.500000,430.250000) imageNamed:@"Mountains" andTerrainName:@"Mountains"]];
    [terrains addObject:[[Terrain alloc] initWithBoard:board atPoint: CGPointMake(303.250000,284.750000) imageNamed:@"Jungle" andTerrainName:@"Jungle"]];
    [terrains addObject:[[Terrain alloc] initWithBoard:board atPoint: CGPointMake(119.250000,395.750000) imageNamed:@"Swamp" andTerrainName:@"Swamp"]];
    [terrains addObject:[[Terrain alloc] initWithBoard:board atPoint: CGPointMake(305.250000,428.750000) imageNamed:@"Swamp" andTerrainName:@"Swamp"]];
    
    
    
    [terrains addObject:[[Terrain alloc] initWithBoard:board atPoint: CGPointMake(130,536) imageNamed:@"Sea" andTerrainName:@"Sea"]];
    [terrains addObject:[[Terrain alloc] initWithBoard:board atPoint: CGPointMake(130,536) imageNamed:@"Swamp" andTerrainName:@"Swamp"]];
    [terrains addObject:[[Terrain alloc] initWithBoard:board atPoint: CGPointMake(45,536) imageNamed:@"Jungle" andTerrainName:@"Jungle"]];
    [terrains addObject:[[Terrain alloc] initWithBoard:board atPoint: CGPointMake(45,536) imageNamed:@"Mountains" andTerrainName:@"Mountains"]];
    [terrains addObject:[[Terrain alloc] initWithBoard:board atPoint: CGPointMake(45,536) imageNamed:@"Desert" andTerrainName:@"Desert"]];
    [terrains addObject:[[Terrain alloc] initWithBoard:board atPoint: CGPointMake(45,536) imageNamed:@"Desert" andTerrainName:@"Desert"]];
    [terrains addObject:[[Terrain alloc] initWithBoard:board atPoint: CGPointMake(45,536) imageNamed:@"frozenWaste" andTerrainName:@"Frozen Waste"]];
    [terrains addObject:[[Terrain alloc] initWithBoard:board atPoint: CGPointMake(45,536) imageNamed:@"Sea" andTerrainName:@"Sea"]];
    [terrains addObject:[[Terrain alloc] initWithBoard:board atPoint: CGPointMake(45,536) imageNamed:@"Sea" andTerrainName:@"Sea"]];
    [terrains addObject:[[Terrain alloc] initWithBoard:board atPoint: CGPointMake(45,536) imageNamed:@"Sea" andTerrainName:@"Sea"]];
    [terrains addObject:[[Terrain alloc] initWithBoard:board atPoint: CGPointMake(45,536) imageNamed:@"Sea" andTerrainName:@"Sea"]];
    
    
    for (Terrain * terrain in terrains) {
        [terrain draw];
    }
}

- (Terrain *) findTerrainAt:(CGPoint) thisPoint{
    for (Terrain * terrain in terrains) {
//        NSLog(@"finding terrain at location: %f, %f <==> %f,%f",thisPoint.x, thisPoint.y, terrain.node.position.x, terrain.node.position.y);
        if (terrain.node.position.x == thisPoint.x && terrain.node.position.y == thisPoint.y) {
            NSLog(@"Found!: terrain: %@", terrain.type);
            return terrain;
        }
    }
    return NULL;
}

- (void) nodeTapped:(SKSpriteNode*) node{
    [textLabel setText:[node name]];
}
- (void) nodeMoving:(SKSpriteNode*) node to:(CGPoint) movedTo{
    [node setPosition:movedTo];
}

- (void) nodeMoved:(SKSpriteNode *)node nodes:(NSArray *)nodes{
    node.colorBlendFactor = 0;
    [self resetText];
    CGPoint terrainPoint;
    for (SKSpriteNode *nodeTerrain in nodes) {
        if ([terrainNames containsObject:nodeTerrain.name]) {
            terrainPoint = nodeTerrain.position;
        }
    }
    
    if ([node.name isEqualToString:@"Player 1"]) {
        Player *p = (Player *)[players objectAtIndex:0];
        if ([p setTerritory:[self findTerrainAt:terrainPoint]]){
            NSLog(@"set territory");
            node.name = @"bowl";
        }
        else{
            [node setPosition:CGPointMake(380.0f, 25.0f)];
        }
    }
    else if ([node.name isEqualToString:@"Player 2"]) {
        Player *p = (Player *)[players objectAtIndex:1];
        if ([p setTerritory:[self findTerrainAt:terrainPoint]]){
            NSLog(@"set territory");
            node.name = @"bowl";
        }
        else{
            [node setPosition:CGPointMake(380.0f + 43.0f, 25.0f)];
        }
    }
    else if ([node.name isEqualToString:@"Player 3"]) {
        Player *p = (Player *)[players objectAtIndex:2];
        if ([p setTerritory:[self findTerrainAt:terrainPoint]]){
            NSLog(@"set territory");
            node.name = @"bowl";
        }
        else{
            [node setPosition:CGPointMake(380.0f  + 86.0f, 25.0f)];
        }
    }
    else if ([node.name isEqualToString:@"Player 4"]) {
        Player *p = (Player *)[players objectAtIndex:3];
        if ([p setTerritory:[self findTerrainAt:terrainPoint]]){
            NSLog(@"set territory");
            node.name = @"bowl";
        }
        else{
            [node setPosition:CGPointMake(380.0f + 129.0f, 25.0f)];
        }
    }
//    NSLog(@"%@ Moved to : %f,%f", node.name, node.position.x, node.position.y);
    
}

@end
