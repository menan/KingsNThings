//
//  Board.m
//  KingsNThings
//
// Created by Areej Ba Salamah and Menan Vadivel on 1/28/2014.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import "Board.h"
#import "Terrain.h"
#import "Creature.h"
#import "SpecialIncome.h"
#import "Bank.h"
#import "Player.h"
#import "GamePlay.h"
#import "NSMutableArrayShuffling.h"


@implementation Board{
    NSArray *terrainNames;
    
    //NSMutableArray *terrain;
    NSMutableArray *bowl;
    NSArray* markers;
    
    SKSpriteNode *board;
    MyScene *scene;
    CGPoint point;
    CGSize size;
//    GamePlay *game;
    
    SKLabelNode* balanceLabel;
    SKLabelNode *myBalance;
    
    SKLabelNode* balanceText;
    
    SKLabelNode* diceOneLabel;
    SKLabelNode* diceTwoLabel;
    
    int playersCount;
    
}
static NSString * const defaultText = @"KingsNThings - Team24";

@synthesize textLabel,dicesClicked,creaturesInBowl,recruitLabel,game,disabled,nonMovables,bank,bowlLocaiton;
- (id)initWithScene: (MyScene *) aScene atPoint: (CGPoint) aPoint withSize: (CGSize) aSize
{
    self = [super init];
    if (self) {
        point = aPoint;
        size = aSize;
        scene = aScene;
        playersCount = 7;
        nonMovables = @[@"board", @"bowl", @"rack", @"Gold 1", @"Gold 2", @"Gold 5", @"Gold 10", @"Gold 15", @"Gold 20", @"My Gold 1", @"My Gold 2", @"My Gold 5", @"My Gold 10", @"My Gold 15", @"My Gold 20", @"diceOne", @"diceTwo", @"collection", @"labels", @"Bank", @"My Stash", @"P4 Stash", @"P3 Stash", @"P2 Stash", @"balance",@"coins"];
        disabled = @[@"labels", @"Bank", @"My Stash", @"P4 Stash", @"P3 Stash", @"P2 Stash", @"bowl", @"board", @"rack"];
        
        terrainNames = @[@"Desert", @"Forest", @"Frozen Waste", @"Jungle", @"Mountains", @"Plains", @"Sea", @"Swamp"];
        
        //terrains = [[NSMutableArray alloc] init];
        bank = [[Bank alloc]init];
        
        game = [[GamePlay alloc] initWithBoard:self];
        creaturesInBowl = 0;
        dicesClicked = 0;
        
        markers = @[@"p_yellow.jpg",@"p_grey.jpg",@"p_green.jpg",@"p_red.jpg"];
        
        
        
    }
    return self;
}
-(GamePlay*)getGamePlay{
    return game;
    
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
    
    [self updateBank];
    
    
    
//    [self initTerrains:CGPointMake(45.0f, (size.height) - 40)];
//    [self initTerrains:CGPointMake(130.0f, (size.height) - 40)];
    
    [self hardCodeTerrains];
    
    [self drawMarkers];
    
    //    [self drawRack:CGPointMake(620.0f, (size.height) - 55)];
    //    [self drawRack:CGPointMake(620.0f, (size.height) - 150)];
    [self drawRack:CGPointMake(620.0f, (size.height) - 240)];
    //    [self drawRack:CGPointMake(620.0f, (size.height) - 330)];
    
    
    
    [self drawBowlwithThings:CGPointMake(450.0f, (size.height) - 120)];
    
//    [self drawHradCodedThings:CGPointMake(450.0f, (size.height) - 120)];
    
    
    
    
    
    
    [self drawForts:CGPointMake(23.0f, (size.height) - 100)];
    
    [self drawSpecialCreatures:CGPointMake(160.0f, (size.height) - 20)];
    
    [self drawDice:CGPointMake(25.0f, 25.0f)];
}

- (void) resetText{
    textLabel.text = defaultText;
}

- (void) drawText{
    textLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    textLabel.name = @"labels";
    textLabel.text = defaultText;
    textLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
    textLabel.fontSize = 15;
    textLabel.position = CGPointMake(point.x + size.width - 5,5);
    [board addChild:textLabel];
    
    recruitLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    recruitLabel.name = @"labels";
    recruitLabel.text = [NSString stringWithFormat:@"%d Recruits Remaining", [game currentPlayer].recruitsRemaining];
    recruitLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
    recruitLabel.fontSize = 15;
    recruitLabel.position = CGPointMake(point.x + size.width - 5,25);
    [board addChild:recruitLabel];
}

- (void) initTerrains:(CGPoint) tPoint{
    NSMutableArray* terrains= [[NSMutableArray alloc]init];
    
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
    
    [game setTerrains:terrains];
}

- (void) drawBowlwithThings:(CGPoint) aPoint{
    SKSpriteNode *bowlNode = [SKSpriteNode spriteNodeWithImageNamed:@"bowl"];
    [bowlNode setName:@"bowl"];
    [bowlNode setPosition:aPoint];
    [board addChild:bowlNode];
    bowlLocaiton = aPoint;
    [self drawThings:aPoint];
}

- (void) drawThings:(CGPoint) aPoint{
    NSArray *creatureList = @[@"-n Baby Dragon -t Desert -s Fly -a 3", @"-n Giant Spider -t Desert -a 1", @"-n Sandworm -t Desert -a 3", @"-n Camel Corps -t Desert -a 3", @"-n Giant Wasp -t Desert -s Fly -a 2", @"-n Skletons -c 2 -t Desert -a 1", @"-n Dervish -c 2 -t Desert -s Magic -a 2", @"-n Giant Wasp -t Desert -s Fly -a 4", @"-n Sphinx -t Desert -s Magic -a 4", @"-n Desert Bat -t Desert -s Fly -a 1", @"-n Griffon -t Desert -s Fly -a 2", @"-n Vultures -c 2 -t Desert -s Fly -a 1", @"-n Dust Devil -t Desert -s Fly -a 4", @"-n Nomads -c 2 -t Desert -a 1", @"-n Yellow Knight -t Desert -s Charge -a 3", @"-n Genie -t Desert -s Magic -a 4", @"-n Old Dragon -s Fly -s Magic -a 4", @"-n Bandits -t Forest -a 2", @"-n Elves -t Forest -s Range -a 3", @"-n Pixies -c 2 -t Forest -s Fly -a 1", @"-n Bears -t Forest -a 2", @"-n Flying Squirrel -t Forest -s Fly -a 1", @"-n Unicorn -t Forest -a 4", @"-n Big Foot -t Forest -a 5", @"-n Flying Squirrel -t Forest -s Fly -a 2", @"-n Walking Tree -t Forest -a 5", @"-n Druid -t Forest -s Magic -a 3", @"-n Forester -t Forest -s Range -a 2", @"-n Wild Cat -t Forest -a 2", @"-n Dryad -t Forest -s Magic -a 1", @"-n Great Owl -t Forest -s Fly -a 2", @"-n Wyvern -t Forest -s Fly -a 3", @"-n Elf Mage -t Forest -s Magic -a 2", @"-n Green Knight -t Forest -s Charge -a 4", @"-n Elves -c 2 -t Forest -s Range -a 2", @"-n Killer Racoon -t Forest -a 2", @"-n Bird Of Paradise -t Jungle -s Fly -a 1", @"-n Head Hunter -t Jungle -s Range -a 2", @"-n Crawling Vines -t Jungle -a 6", @"-n Pterodactyl Warriors -c 2 -t Jungle -s Fly -s Range -a 2", @"-n Crocodiles -t Jungle -a 2", @"-n Pygmies -t Jungle -a 2", @"-n Dinasaur -t Jungle -a 4", @"-n Tigers -c 2 -t Jungle -a 3", @"-n Elephant -t Jungle -s Charge -a 4", @"-n Watusi -t Jungle -s 2", @"-n Giant Ape -c 2 -t Jungle -a 5", @"-n Witch Doctor -t Jungle -s Magic -a 2", @"-n Giant Snake -t Jungle -s 3", @"-n Dragon Rider -t Frozen Waste -s Fly -s Range -a 3", @"-n Killer Puffins -t Frozen Waste -s Fly -a 2", @"-n Elk Herd -t Frozen Waste -a 2", @"-n Mammoth -t Frozen Waste -s Charge -a 5", @"-n Eskimos -c 4 -t Frozen Waste -a 2", @"-n North Wind -t Frozen Waste -s Fly -s Magic -a 2", @"-n Ice Bats -t Frozen Waste -s Fly -a 1", @"-n Walrus -t Frozen Waste -a 4", @"-n Ice Giant -t Frozen Waste -s Range -a 5", @"-n White Brea -t Frozen Waste -a 4", @"-n Iceworm -t Frozen Waste -s Magic -a 4", @"-n White Dragon -t Frozen Waste -s Magic -a 5", @"-n Killer Penguins -t Frozen Waste -a 3", @"-n Wolves -t Frozen Waste -a 3", @"-n Brown Dragon -t Mountain -s Fly -a 3", @"-n Gaint Roc -t Mountain -s Fly -a 3", @"-n Little Roc -t Mountain -s Fly -a 2", @"-n Brown Knight -t Mountain -s Charge -a 4", @"-n Giant -t Mountain -s Range -a 4", @"-n Mountain Lion -t Mountain -a 2", @"-n Cyclops -t Mountain -a 5", @"-n Giant Condor -t Mountain -s Fly -a 3", @"-n Mountain Men -c 2 -t Mountain -a 1", @"-n Dwarves -t Mountain -s Charge -a 3", @"-n Goblins -c 4 -t Mountain -a 1", @"-n Orge Mountain -t Mountain -a 2", @"-n Dwarves -t Mountain -s Range -a 2", @"-n Great Eagle -t Mountain -s Fly -a 2", @"-n Troll -t Mountain -a 4", @"-n Dwarves -t Mountain -s Range -a 3", @"-n Great Hawk -t Mountain -s Fly -a 1", @"-n Buffalo Herd -t Plains -a 3", @"-n Giant Beetle -t Plains -s Fly -a 2", @"-n Pegasus -t Plains -s Fly -a 2", @"-n Buffalo Herd -t Plains -a 4", @"-n Great Hawk -t Plains -s Fly -a 2", @"-n Pterodactyl -t Plains -s Fly -a 3", @"-n Centaur -t Plains -a 2", @"-n Greathunter -t Plains -s Range -a 4", @"-n Tribesmen -c 2 -t Plains -a 2", @"-n Dragonfly -t Plains -s Fly -a 2", @"-n Gypsies -t Plains -s Magic -a 1", @"-n Villains -t Plains -a 2", @"-n Eagles -t Plains -s Fly -a 2", @"-n Gypsies -t Plains -s Magic -a 2", @"-n White Knight -t Plains -s Charge -a 3", @"-n Farmers -c 4 -t Plains -a 1", @"-n Hunter -t Plains -s Range -a 1", @"-n Wolf Pack -t Plains -a 3", @"-n Flying Buffalo -t Plains -s Fly -a 2", @"-n Lion Ride -t Plains -a 3", @"-n Tribesmen -c 2 -t Plains -a 2", @"-n Basilisk -t Swamp -s Magic -a 3", @"-n Giant Snake -t Swamp -a 3", @"-n Swamp Gas -t Swamp -s Fly -a 1", @"-n Black Knight -t Swamp -s Charge -a 3", @"-n Huge Leech -t Swamp -a 2", @"-n Swamp Rat -t Swamp -a 1", @"-n Crocodiles -t Swamp -a 2", @"-n Pirates -t Swamp -a 2", @"-n Thing -t Swamp -a 2", @"-n Dark Wizard -t Swamp -s Fly -s Magic -a 1", @"-n Poison Frog -t Swamp -a 1", @"-n Vampire Bat -t Swamp -s Fly -a 4", @"-n Ghost -c 4 -t Swamp -s Fly -a 1", @"-n Spirit -t Swamp -s Magic -a 2", @"-n Watersanke -t Swamp -a 1", @"-n Giant Lizard -c 2 -t Swamp -a 2", @"-n Sprote -t Swamp -s Magic -a 1", @"-n Will_O_Wisp -t Swamp -s Magic -a 2", @"-n Giant Mosquito -t Swamp -s Fly -a 2", @"-n Swamp Beast -t Swamp -a 3", @"-n Winged Pirhana -t Swamp -s Fly -a 3" ];
    NSArray *specialIncome= @[@"-n Copper Mine -t Mountain -a 1",@"-n Diamond -t Treasure -a 5",@"-n Diamond Field -t Desert -a 1",@"-n Elephants Graveyard -t Jungle -a 3",@"-n Emerald -t Treasure -a 10",@"-n Farmlands -t Plains -a 1",@"-n Gold Mine -t Mountain -a 3",@"-n Oil Field -t Frozen Waste -a 3",@"-n Pearl -t Treasure -a 5",@"-n Peat Bog -t Swamp -a 1",@"-n Ruby -t Treasure -a 10",@"-n Sapphire -t Treasure -a 5",@"-n Silver Mine -t Mountain -a 2-43",@"-n Silver Mine -t Mountain -a 2",@"-n Treasure Chest -t Treasure -a 20",@"-n Timberland -t Forest -a 1"];
    
    bowl = [[NSMutableArray alloc] init];
    
    /*for (NSString *str in creatureList) {
        Creature *creature = [[Creature alloc] initWithBoard:board atPoint:aPoint fromString:str];
        [bowl addObject:creature];
    }*/
    for (NSString *str in specialIncome) {
        SpecialIncome *spIncome = [[SpecialIncome alloc] initWithBoard:board atPoint:aPoint fromString:str];
        [bowl addObject:spIncome];
    }
    
    [self redrawCreatures];
    
//    for (NSString *string in creatureList){
//        NSString* imageName = [NSString stringWithFormat:@"%@.jpg",string];
//        SKSpriteNode* node = [SKSpriteNode spriteNodeWithImageNamed:imageName];
//        [node setName:imageName];
//        node.accessibilityValue = @"creatures";
//        node.size = CGSizeMake(36,36);
//        [node setPosition:aPoint];
//        node.color = [SKColor blackColor];
//        node.colorBlendFactor = .85;
//        [self setCreaturesInBowl:([self creaturesInBowl]+1)];
//        [board addChild:node];
//        
//        
//    }
//    NSLog(@"number of creatures in Bowl %d",[self creaturesInBowl]);
    
}

// only for iteration 1 demo-- order is very important
//-(void) drawHradCodedThings:(CGPoint)aPoint{
//    NSArray* others = @[@"-n Cyclops -t Mountain -a 5",@"-n Mountain Men -c 2 -t Mountain -a 1",@"-n Goblins -c 4 -t Mountain -a 1",@"-n Giant Condor -t Mountain -s Fly -a 3"];
//    
//    [self drawHardCodeArmy:others withPoint:aPoint];
//    [self drawHardCodeArmy:[game p4Stack3] withPoint: aPoint];
//    [self drawHardCodeArmy:[game p4Stack2] withPoint: aPoint];
//    [self drawHardCodeArmy:[game p4Stack1] withPoint: aPoint];
//    
//    [self drawHardCodeArmy:[game p3Stack3] withPoint:aPoint];
//    [self drawHardCodeArmy:[game p3Stack2] withPoint:aPoint];
//    [self drawHardCodeArmy:[game p3Stack1] withPoint: aPoint];
// 
//    [self drawHardCodeArmy:[game p2Stack1] withPoint:aPoint];
//  
//    [self drawHardCodeArmy:[game p1Stack2] withPoint: aPoint];
//    [self drawHardCodeArmy:[game p1Stack1] withPoint: aPoint];
//    
//    
//    
//}
//
//- (void) drawHardCodeArmy:(NSArray*)army withPoint:(CGPoint) aPoint {
//    
//       for (NSString *string in army){
//           
//               NSString* imageName = [NSString stringWithFormat:@"%@.jpg",string];
//           
//               SKSpriteNode* node = [SKSpriteNode spriteNodeWithImageNamed:imageName];
//               [node setName:imageName];
//               node.accessibilityValue = @"creatures";
//               // [node setGroup:@"creature"];
//               node.size = CGSizeMake(36,36);
//               [node setPosition:aPoint];
//               node.color = [SKColor blackColor];
//               node.colorBlendFactor = .85;
//               [self setCreaturesInBowl:([self creaturesInBowl]+1)];
//               [board addChild:node];
//           
//           
//        
//       }
//    NSLog(@"number of creatures in Bowl %d",[self creaturesInBowl]);
//    
//}


- (NSString *) getNameFromString:(NSString *) values{
    NSMutableArray *array = [[values componentsSeparatedByString:@"-"] mutableCopy];
    [array removeObjectAtIndex:0];
    
    for(NSString *value in array){
        NSString *trimmed = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if ([trimmed hasPrefix:@"n"]){
            return [trimmed substringFromIndex:2];
        }
    }
    return NULL;
    
}
    


- (void) drawRack:(CGPoint) aPoint{
    SKSpriteNode *rack = [SKSpriteNode spriteNodeWithImageNamed:@"rack"];
    [rack setName:@"rack"];
    [rack setPosition:aPoint];
    [board addChild:rack];
}

- (void) drawDice:(CGPoint) aPoint{
    
    SKSpriteNode *diceOne = [SKSpriteNode spriteNodeWithImageNamed:@"dice"];
    [diceOne setName:@"diceOne"];
    diceOne.size = CGSizeMake(40, 40);
    [diceOne setPosition:aPoint];
    [board addChild:diceOne];
    
    SKSpriteNode *diceTwo = [SKSpriteNode spriteNodeWithImageNamed:@"dice"];
    [diceTwo setName:@"diceTwo"];
    diceTwo.size = CGSizeMake(40, 40);
    [diceTwo setPosition:CGPointMake(aPoint.x + 40.0f,aPoint.y)];
    [board addChild:diceTwo];
    
    SKSpriteNode *goldCollect = [SKSpriteNode spriteNodeWithImageNamed:@"goldCollect"];
    [goldCollect setName:@"collection"];
    goldCollect.size = CGSizeMake(40, 40);
    [goldCollect setPosition:CGPointMake(aPoint.x + 90.0f,aPoint.y)];
    [board addChild:goldCollect];
    
    SKSpriteNode *battle = [SKSpriteNode spriteNodeWithImageNamed:@"battle.jpg"];
    [battle setName:@"battle"];
    battle.size = CGSizeMake(40, 40);
    [battle setPosition:CGPointMake(aPoint.x + 420.0f,aPoint.y + 50)];
    [board addChild:battle];
    
    
    diceOneLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    diceOneLabel.name = @"labels";
    diceOneLabel.text = @"0";
    diceOneLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    diceOneLabel.fontSize = 25;
    diceOneLabel.position = CGPointMake(aPoint.x,aPoint.y + 30);
    [board addChild:diceOneLabel];
    
    diceTwoLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    diceTwoLabel.name = @"labels";
    diceTwoLabel.text = @"0";
    diceTwoLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    diceTwoLabel.fontSize = 25;
    diceTwoLabel.position = CGPointMake(aPoint.x + 40.0f,aPoint.y + 30);
    [board addChild:diceTwoLabel];
    
    
}
- (void) drawForts:(CGPoint) aPoint{
    
    for (int i = 0; i < playersCount; i++) {
        
        SKSpriteNode* tower = [SKSpriteNode spriteNodeWithImageNamed:@"-n Tower -a 1.jpg"];
        [tower setName:@"-n Tower -a 1.jpg"];
        [tower setAccessibilityValue:@"fort"];
        [tower setAccessibilityLabel:@"tower"];
        tower.size = CGSizeMake(40,40);
        [tower setPosition:CGPointMake(aPoint.x + 43, aPoint.y)];
        [board addChild:tower];
        
        
        SKSpriteNode *keep = [SKSpriteNode spriteNodeWithImageNamed:@"-n Keep -a 2.jpg"];
        [keep setName:@"-n Keep -a 2.jpg"];
        [keep setAccessibilityValue:@"fort"];
        [keep setAccessibilityLabel:@"keep"];
        keep.size = CGSizeMake(40,40);
        [keep setPosition:CGPointMake(aPoint.x + 43, aPoint.y - 43 )];
        [board addChild:keep];
        
        SKSpriteNode *castle = [SKSpriteNode spriteNodeWithImageNamed:@"-n Castle -a 3.jpg"];
        [castle setName:@"-n Castle -a 3.jpg"];
        [castle setAccessibilityValue:@"fort"];
        [castle setAccessibilityLabel:@"castle"];
        castle.size = CGSizeMake(40,40);
        [castle setPosition:aPoint];
        [board addChild:castle];
        
        
        SKSpriteNode *citadel = [SKSpriteNode spriteNodeWithImageNamed:@"-n Citadel -a 4.jpg"];
        [citadel setName:@"-n Citadel -a 4.jpg"];
        [citadel setAccessibilityValue:@"fort"];
        [citadel setAccessibilityLabel:@"citadel"];
        citadel.size = CGSizeMake(40,40);
        [citadel setPosition:CGPointMake(aPoint.x, aPoint.y - 43 )];
        [board addChild:citadel];
    }
    
}
- (void) drawMarkers{
    for (int j = 0; j < [[game players] count]; j++) {
        [self drawMarkersForPlayer:j];
    }
    
}

- (void) drawMarkersForPlayer:(int) j{
    CGPoint aPoint = CGPointMake(360.0f, 25.0f);
    NSArray *images = @[@"p_yellow.jpg",@"p_gray.jpg",@"p_green.jpg",@"p_red.jpg"];
    float offset = 43;
    
    for (int i = 0; i <= 50; i++) {
        SKSpriteNode *playerNode = [SKSpriteNode spriteNodeWithImageNamed:[images objectAtIndex:j]];
        [playerNode setName:[NSString stringWithFormat:@"Player %d",j + 1]];
        playerNode.size = CGSizeMake(40,40);
        [playerNode setPosition:CGPointMake(aPoint.x + (j * offset), aPoint.y )];
        [board addChild:playerNode];
    }
}

- (void) drawSpecialCreatures:(CGPoint) aPoint{
    
     NSArray *namesString = @[@"-n Arch Cleric -s Magic -a 5 -p Special.jpg",@"-n Arch Mage -s Magic -a 6 -p Special.jpg",@"-n Assassin Primus -a 4 -p Special.jpg",@"-n Baron Munchausen -a 4 -p Special.jpg",@"-n Deerhunter -a 4 -p Special.jpg",@"-n Desert Master -a 4 -p Special.jpg",@"-n Dwarf King -a 5 -p Special.jpg",@"-n Elfe Lord -s Range -a 6 -p Special.jpg",@"-n Forest King -a 4 -p Special.jpg",@"-n Ghaog II -s Fly -a 6 -p Special.jpg",@"-n Grand Duke -a 4 -p Special.jpg",@"-n Ice Lord -a 4 -p Special.jpg",@"-n Jungle Lord -a 4 -p Special.jpg",@"-n Lord Of Eagles -s Fly -a 5 -p Special.jpg",@"-n Marksman -s Range -a 2 -a 5 -p Special.jpg",@"-n Master Theif -a 4 -p Special.jpg",@"-n Mountain King -a 4 -p Special.jpg",@"-n Plains Lord -a 4 -p Special.jpg",@"-n Sir Lancealot -s Charge -a 5 -p Special.jpg",@"-n Swamp King -a 4 -p Special.jpg",@"-n Swordmaster -a 4 -p Special.jpg",@"-n Warlord -a 5 -p Special.jpg"];
    
    for (int i = 0; i < namesString.count/2; i++) {
        
        NSString *imageName = [namesString objectAtIndex:i];
        float imageSize = 36;
        float offsetFraction = aPoint.x + ((imageSize + 1) * (i + 1));
        
        SKSpriteNode* node = [SKSpriteNode spriteNodeWithImageNamed:imageName];
        [node setName:imageName];
        node.accessibilityValue = @"creature";
        node.accessibilityLabel = @"special";
        node.size = CGSizeMake(36,36);
        [node setPosition:CGPointMake(offsetFraction, aPoint.y)];
        [board addChild:node];
    }

    for (int j = namesString.count/2; j < namesString.count; j++) {
        NSString *imageName = [namesString objectAtIndex:j];
        
        int num = j - namesString.count/2;
        
        float imageSize = 36;
        
        float offsetFraction = aPoint.x + ((imageSize + 1) * (num + 1));
        
        SKSpriteNode* node = [SKSpriteNode spriteNodeWithImageNamed:imageName];
        [node setName:imageName];
        node.accessibilityLabel = @"special";
        node.accessibilityValue = @"creature";
        node.size = CGSizeMake(36,36);
        [node setPosition:CGPointMake(offsetFraction, aPoint.y - 37)];
        [board addChild:node];
        
    }
    
}


//redraws the creatures in the after additions bowl
- (void) redrawCreatures{
    
    [bowl shuffle];
    [bowl shuffle];
    [bowl shuffle];
    [bowl shuffle];
    NSLog(@"creatures count: %d", bowl.count);
    /*for (Creature * creature in bowl) {
        [creature draw];
    }*/
    for (SpecialIncome * spIncome in bowl) {
        [spIncome draw];
    }
}

- (void) updateBank{
    float left = 600.0f;
    float offset = 105.0f;
    [self drawBank:bank at:CGPointMake(left, (size.height) - 480) andWithTitle:@"Bank"];
    for (int j = 0; j < 1; j++) {
        Player *p = [[game players] objectAtIndex:j];
        NSLog(@"drawing bank for player %d, left: %d", j, p.playerLeft);
        NSString *title = [NSString stringWithFormat:@"P%d Stash",j + 1];
        if (j == 0)
            title = @"My Stash";
        if (!p.playerLeft) {
            [self drawBank:[p getBank] at:CGPointMake(left, (size.height) - 375 + (offset * j)) andWithTitle:title];
        }
        else{
            
            [[board childNodeWithName:title] removeFromParent];
        }
    }
}


-(void) drawBank:(Bank *) aBank at:(CGPoint) position andWithTitle:(NSString *)title
{
    [[board childNodeWithName:title] removeFromParent];
    SKSpriteNode *gold = [SKSpriteNode spriteNodeWithColor:[UIColor colorWithRed:255 green:255 blue:255 alpha:.1] size:CGSizeMake(150, 100)];
    [gold setName:title];
    [gold setPosition:position];
    [board addChild:gold];
    
    NSString *name = @"My Gold";
    
    if ([title isEqualToString:@"Bank"]) {
        name = @"Gold";
    }
    
    float y = 25;
    for (int i = 0; i < aBank.oneGold; i++) {
        SKSpriteNode *one = [aBank goldsWithImage:@"GoldOne.jpg"];
        [one setName:[NSString stringWithFormat:@"%@ 1",name]];
        one.size = CGSizeMake(40,41);
        [one setPosition:CGPointMake(-50, y)];
        [gold addChild:one];
    }
    
    for (int i = 0; i < aBank.twoGold; i++) {
        SKSpriteNode *two = [aBank goldsWithImage:@"GoldTwo.jpg"];
        [two setName:[NSString stringWithFormat:@"%@ 2",name]];
        two.size = CGSizeMake(40,41);
        [two setPosition:CGPointMake(0, y)];
        [gold addChild:two];
        
    }
    for (int i = 0; i < aBank.fiveGold; i++) {
        SKSpriteNode *five = [aBank goldsWithImage:@"GoldFive.jpg"];
        [five setName:[NSString stringWithFormat:@"%@ 5",name]];
        five.size = CGSizeMake(40,41);
        [five setPosition:CGPointMake(50, y)];
        [gold addChild:five];
        
    }
    for (int i = 0; i < aBank.tenGold; i++) {
        SKSpriteNode *ten = [aBank goldsWithImage:@"GoldTen.jpg"];
        [ten setName:[NSString stringWithFormat:@"%@ 10",name]];
        ten.size = CGSizeMake(40,41);
        [ten setPosition:CGPointMake(-50, -1 * y)];
        [gold addChild:ten];
        
    }
    for (int i = 0; i < aBank.fifteenGold; i++) {
        SKSpriteNode *fifteen = [aBank goldsWithImage:@"GoldFifteen.jpg"];
        [fifteen setName:[NSString stringWithFormat:@"%@ 15",name]];
        fifteen.size = CGSizeMake(40,41);
        [fifteen setPosition:CGPointMake(0, -1 * y)];
        [gold addChild:fifteen];
        
    }
    for (int i = 0; i < aBank.twentyGold; i++) {
        SKSpriteNode *twenty = [aBank goldsWithImage:@"GoldTwenty.jpg"];
        [twenty setName:[NSString stringWithFormat:@"%@ 20",name]];
        twenty.size = CGSizeMake(40,41);
        [twenty setPosition:CGPointMake(50, -1 * y)];
        [gold addChild:twenty];
        
    }
    
    
    if([title isEqualToString:@"Bank"]){
    
        SKSpriteNode* chest = [[SKSpriteNode alloc]initWithImageNamed:@"chest-1.png"];
        chest.position = CGPointMake(120,10);
        chest.name = title;
        chest.size= CGSizeMake(60,60);
        [gold addChild:chest];
        
        
        
        NSString *balance = [NSString stringWithFormat: @"%d", [aBank getBalance]];
        balanceText = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        balanceText.fontColor = [SKColor colorWithRed:227 green:190 blue:0 alpha:1.0];
        balanceText.name = @"balance";
        balanceText.text = balance;
        balanceText.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        balanceText.fontSize = 15;
        balanceText.position = CGPointMake(120,-40);
        
        
        [gold addChild:balanceText];
        
    }
    /*balanceLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    balanceLabel.name = @"labels";
    balanceLabel.text = title;
    balanceLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    balanceLabel.fontSize = 15;
    balanceLabel.position = CGPointMake(120,10);
     */
    else{
    SKSpriteNode* coins = [[SKSpriteNode alloc]initWithImageNamed:@"coins.png"];
    coins.position = CGPointMake(100,-10);
    coins.name = @"coins";
    coins.size= CGSizeMake(30,30);
    [gold addChild:coins];
    
    NSString *balance = [NSString stringWithFormat: @"%d", [aBank getBalance]];
    balanceText = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    balanceText.name = @"balance";
    balanceText.text = balance;
    balanceText.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    balanceText.fontSize = 15;
    balanceText.position = CGPointMake(120,-15);
    
    //[gold addChild:balanceLabel];
    [gold addChild:balanceText];
    }
}


-(void)withdrawFromBank:(NSInteger)goldNum
{
    Player *p = [game.players objectAtIndex:0];
    if ([bank withdrawGold:goldNum andCount:1]){
        [p.bank depositGold:goldNum andCount:1];
        if(game.phase == Recruitment){
            [p justGotPaid:goldNum];
            recruitLabel.text = [NSString stringWithFormat: @"%d Recruits Remaining", p.recruitsRemaining];
        }
    }
}

-(void)depositToBank:(NSInteger)goldNum
{
    Player *p = [game.players objectAtIndex:0];
    if ([p.bank withdrawGold:goldNum andCount:1]){
        [bank depositGold:goldNum andCount:1];
        if(game.phase == Recruitment){
            [p justPaid:goldNum];
            recruitLabel.text = [NSString stringWithFormat: @"%d Recruits Remaining", p.recruitsRemaining];
        }
    }
}

- (void) rollDiceOne{
    int r = (arc4random() % 6) + 1;
    diceOneLabel.text = [NSString stringWithFormat:@"%d",r];
    
    [game setOneDice:r];
}
- (void) rollDiceTwo{
    
    int r = 6; //(arc4random() % 6) + 1 ;
    diceTwoLabel.text = [NSString stringWithFormat:@"%d",r];
   
    [game setSecondDice:r];
    
}



- (void) hardCodeTerrains{
    NSMutableArray* terrains = [game terrains];
    
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
        terrain.node.name = @"bowl";
        [terrain draw];
    }
}

- (Creature *) findCreatureByName:(NSString *) name{
    //    NSLog(@"trying to located node wiht name %@",name);
    for (Creature *c in bowl) {
        if ([c.name isEqualToString:name]) {
            return c;
        }
    }
    for (Creature *c in [[game currentPlayer] rack]) {
        if ([c.name isEqualToString:name]) {
            return c;
        }
    }
    return nil;
}

- (BOOL) removeCreatureByName:(NSString *) name{
    for (Creature *c in bowl) {
        if ([c.name isEqualToString:name]) {
            [bowl removeObject:c];
            NSLog(@"just removed %@ from the bowl",name);
            return YES;
        }
    }
    for (Creature *c in [[game currentPlayer] rack]) {
        if ([c.name isEqualToString:name]) {
            [bowl removeObject:c];
            [game currentPlayer].recruitsRemaining++;
            [self updateRecruitLabel:[game currentPlayer]];
            NSLog(@"just removed %@ from the player rack",name);
            return YES;
        }
    }
    return NO;
}


//- (void) nodeTapped:(SKSpriteNode*) node{
//        [textLabel setText:[node name]];
//    if([node.accessibilityLabel isEqualToString:@"special"]){
//        [node removeAllActions];
//        SKAction *sequence = [SKAction sequence:@[[SKAction rotateByAngle:degToRad(-4.0f) duration:0.1],[SKAction rotateByAngle:0.0 duration:0.1],[SKAction rotateByAngle:degToRad(4.0f) duration:0.1]]];
//        [node runAction:[SKAction repeatActionForever:sequence]];
//        [self recruiteSpecial:node];
//        
//    }
//}
//float degToRad(float degree) {
//	return degree / 180.0f * M_PI;
//}

- (void) nodeMoving:(SKSpriteNode*) node to:(CGPoint) movedTo{
    [node setPosition:movedTo];
}

- (void) nodeMoved:(SKSpriteNode *)node nodes:(NSArray *)nodes{
    node.colorBlendFactor = 0;
//    [self resetText];
    CGPoint terrainPoint = CGPointMake(0, 0);
    BOOL terrainLocated = NO;
    
    
    for (SKSpriteNode *nodeTerrain in nodes) {
        if ([terrainNames containsObject:nodeTerrain.name]) {
            terrainPoint = nodeTerrain.position;
            terrainLocated = YES;
        }
    }
    
    
    float sizeNode = 26;
    //    float towerSizeNode = sizeNode + 4;
    
    if([node.accessibilityValue isEqualToString:@"creatures"])
    {
        BOOL bowled = NO;
        for (SKSpriteNode *nodeTerrain in nodes) {
            if ([nodeTerrain.name isEqualToString:@"bowl"]) { //dude droppped it back in the cup
                bowled = YES;
            }
        }
        
        if (bowled) {
            Creature *c = [[game currentPlayer] findCreatureOnRackByName:node.name];
            if (c){
                [bowl addObject:c];
                [[game currentPlayer] returnedACreature];
                [self updateRecruitLabel:[game currentPlayer]];
                [self redrawCreatures];
                [[game currentPlayer] removeCreatureFromRackByName:node.name];
                
                NSLog(@"Added the creature back to the bowl and redrew things.");
            }
            
        }
        else{
            Terrain *temp = [game findTerrainAt:terrainPoint];
            [self creaturesMoved:node AtTerrain:temp];
            [self removeCreatureByName:node.name]; //removes the creature from the bowl, if it got added to the army or rack
        }
    }
    else if ([node.accessibilityValue isEqualToString:@"army"]){
         NSLog(@"army moved");
        Terrain *temp = [game findTerrainAt:terrainPoint];
        Player *tempPlayer = [game findPlayerByOrder:[node.name integerValue]];
        
        Army* ar = [tempPlayer getArmyAtIndex:[node.accessibilityLabel integerValue]- 1];
        [ar setTerrain:temp];
        [ar setPosition:node.position];
        NSLog(@"army moved player is %d",[tempPlayer playingOrder]);
        [game movementPhase:tempPlayer withArmy:ar];
        
    }
    else if (terrainLocated && [node.name isEqualToString:@"Player 1"]) {
        Terrain* temp = [game findTerrainAt:terrainPoint];
        Player *p = [[game players] objectAtIndex:0];
        if([game phase] == Initial){
        
            if([game validateHex:temp forPlayer:p]){
            
                if ([p setTerritory:temp]){
                    
                    [temp setBelongsToP1:YES];
                    [temp setHasArmyOnIt:NO];
                    
                    
                    node.name = @"bowl";
                    [node setSize:CGSizeMake(sizeNode, sizeNode)];
                    [node setPosition:CGPointMake(temp.node.position.x + 10, temp.node.position.y + 22)];
                }
            }
            
            else{
                [node setPosition:CGPointMake(380.0f, 25.0f)];
            }
        }
        else{
            if ([p setTerritory:temp]){
                
                [temp setBelongsToP1:YES];
                [temp setHasArmyOnIt:NO];
                
                
                node.name = @"bowl";
                [node setSize:CGSizeMake(sizeNode, sizeNode)];
                [node setPosition:CGPointMake(temp.node.position.x + 10, temp.node.position.y + 22)];
            }
        }
        
    }
    else if (terrainLocated && [node.name isEqualToString:@"Player 2"]) {
        Terrain* temp = [game findTerrainAt:terrainPoint];
        Player *p = [[game players] objectAtIndex:1];
        
        if([game phase] == Initial){
            
            if([game validateHex:temp forPlayer:p]){
                
                if ([p setTerritory:temp]){
                    
                    [temp setBelongsToP1:YES];
                    [temp setHasArmyOnIt:NO];
                    
                    
                    node.name = @"bowl";
                    [node setSize:CGSizeMake(sizeNode, sizeNode)];
                    [node setPosition:CGPointMake(temp.node.position.x + 10, temp.node.position.y + 22)];
                }
            }
            else{
                [node setPosition:CGPointMake(380.0f + 43.0f, 25.0f)];
            }
            
        }
        else{
            if ([p setTerritory:temp]){
                
                [temp setBelongsToP1:YES];
                [temp setHasArmyOnIt:NO];
                
                
                node.name = @"bowl";
                [node setSize:CGSizeMake(sizeNode, sizeNode)];
                [node setPosition:CGPointMake(temp.node.position.x + 10, temp.node.position.y + 22)];
            }
        }
        }
   
    else if (terrainLocated && [node.name isEqualToString:@"Player 3"]) {
        Terrain* temp = [game findTerrainAt:terrainPoint];
        Player *p = [[game players] objectAtIndex:2];
        
        if([game phase] == Initial){
            
            if([game validateHex:temp forPlayer:p]){
                
                if ([p setTerritory:temp]){
                    
                    [temp setBelongsToP1:YES];
                    [temp setHasArmyOnIt:NO];
                    
                    
                    node.name = @"bowl";
                    [node setSize:CGSizeMake(sizeNode, sizeNode)];
                    [node setPosition:CGPointMake(temp.node.position.x + 10, temp.node.position.y + 22)];
                }
            }

            else{
            [node setPosition:CGPointMake(380.0f  + 86.0f, 25.0f)];
            }
        }
        else{
            if ([p setTerritory:temp]){
                
                [temp setBelongsToP1:YES];
                [temp setHasArmyOnIt:NO];
                
                
                node.name = @"bowl";
                [node setSize:CGSizeMake(sizeNode, sizeNode)];
                [node setPosition:CGPointMake(temp.node.position.x + 10, temp.node.position.y + 22)];
            }
        }
    }
    else if (terrainLocated && [node.name isEqualToString:@"Player 4"]) {
        Terrain* temp = [game findTerrainAt:terrainPoint];
        Player *p = [[game players] objectAtIndex:3];
        
        if([game phase] == Initial){
            
            if([game validateHex:temp forPlayer:p]){
                
                if ([p setTerritory:temp]){
                    
                    [temp setBelongsToP1:YES];
                    [temp setHasArmyOnIt:NO];
                    
                    
                    node.name = @"bowl";
                    [node setSize:CGSizeMake(sizeNode, sizeNode)];
                    [node setPosition:CGPointMake(temp.node.position.x + 10, temp.node.position.y + 22)];
                }
            }

            else{
                [node setPosition:CGPointMake(380.0f + 129.0f, 25.0f)];
            }
        }
        else{
            if ([p setTerritory:temp]){
                
                [temp setBelongsToP1:YES];
                [temp setHasArmyOnIt:NO];
                
                
                node.name = @"bowl";
                [node setSize:CGSizeMake(sizeNode, sizeNode)];
                [node setPosition:CGPointMake(temp.node.position.x + 10, temp.node.position.y + 22)];
            }
        }
    }
    else if ([node.name isEqualToString:@"Gold 1"]) {
        [self withdrawFromBank:1];
        [self updateBank];
    }
    else if ([node.name isEqualToString:@"Gold 2"]){
        [self withdrawFromBank:2];
        [self updateBank];
    }
    else if ([node.name isEqualToString:@"Gold 5"]){
        [self withdrawFromBank:5];
        [self updateBank];
    }
    else if ([node.name isEqualToString:@"Gold 10"]){
        [self withdrawFromBank:10];
        [self updateBank];
    }
    else if ([node.name isEqualToString:@"Gold 15"]){
        [self withdrawFromBank:15];
        [self updateBank];
    }
    else if ([node.name isEqualToString:@"Gold 20"]){
        [self withdrawFromBank:20];
        [self updateBank];
    }
    else if ([node.name isEqualToString:@"My Gold 1"] && [node.parent.name isEqualToString:@"My Stash"]) {
        [self depositToBank:1];
        [self updateBank];
    }
    else if ([node.name isEqualToString:@"My Gold 2"] && [node.parent.name isEqualToString:@"My Stash"]){
        [self depositToBank:2];
        [self updateBank];
    }
    else if ([node.name isEqualToString:@"My Gold 5"] && [node.parent.name isEqualToString:@"My Stash"]){
        [self depositToBank:5];
        [self updateBank];
    }
    else if ([node.name isEqualToString:@"My Gold 10"] && [node.parent.name isEqualToString:@"My Stash"]){
        [self depositToBank:10];
        [self updateBank];
    }
    else if ([node.name isEqualToString:@"My Gold 15"] && [node.parent.name isEqualToString:@"My Stash"]){
        [self depositToBank:15];
        [self updateBank];
    }
    else if ([node.name isEqualToString:@"My Gold 20"] && [node.parent.name isEqualToString:@"My Stash"]){
        [self depositToBank:20];
        [self updateBank];
    }
    else if ([node.name isEqualToString:@"diceOne"]){
        [self rollDiceOne];
    }
    else if ([node.name isEqualToString:@"diceTwo"]){
        [self rollDiceTwo];
    }
    else if ([node.name isEqualToString:@"collection"]){
        [game setIsInitialPhase:NO];
        [self initiateGoldCollection];
    }
    else if ([node.accessibilityValue isEqualToString:@"fort"]){
        
        Terrain* t = [game findTerrainAt:terrainPoint];
        Player* owner = [game findPlayerByTerrain:t];
        
        if (terrainLocated && owner != nil) {
            [self constructBuilding:owner withBuilding:node onTerrain:t];
        }
        else{
            [node setPosition:CGPointMake(23.0f + 43, (size.height) - 100)];
        }
                //[node setPosition:CGPointMake(23.0f + 43, (size.height) - 100)];
    }
    
    

   
    else if ([node.name isEqualToString:@"battle"]){
        //you can access all players on the current terrain by calling [game findPlayersByTerrain:t] n use them to go at war with each other
        [game initiateCombat:[game.players objectAtIndex:0]];
    }
    else if([node.accessibilityLabel isEqualToString:@"special"]){
        [self recruiteSpecial:node];
    }

    else if ([node.accessibilityLabel isEqualToString:@"specialIncome"]){
        Terrain* t = [game findTerrainAt:terrainPoint];
        /********** here is the problem  the following doesnt work *************/
        if([node.accessibilityValue isEqualToString:@"treasure"]){
            //SpecialIncome *sp = [[SpecialIncome alloc]initWithImage:node.name atPoint:node.position];
            if([game.currentPlayer findSpecialIncomeOnRackByName:node.name]){
            //NSArray* nodes = [board nodesAtPoint:node.position];
            for(SKSpriteNode* n in nodes){
                if([n.name isEqualToString:@"Bank"]){
                    [self playTreasure:node];
                    break;
                }
            }
                
        }
            else{
                [self recruiteSpecialIncome:node onTerrain:t];
            }
        
        }
        else{
            [self recruiteSpecialIncome:node onTerrain:t];
        }
        if([game phase] == Recruitment){
            //[self recruiteSpecialIncome:node onTerrain:t
        }
  
    }
}
- (void) updateRecruitLabel:(Player *) p{
    recruitLabel.text = [NSString stringWithFormat: @"%d Recruits Remaining", p.recruitsRemaining];
}

- (void) creaturesMoved:(SKSpriteNode *) n AtTerrain:(Terrain *) t{
    
    NSLog(@"Node is %@ , number of players at the terrain: %d" , n.name, [[game findPlayersByTerrain:t] count]);
    //checks if any player owns the territory and the terrain is found
    if(t && [[game findPlayersByTerrain:t] count] > 0){
        Player *currentPlayer = [[game findPlayersByTerrain:t] objectAtIndex:0];
        Creature *creature = [self findCreatureByName:n.name];
        
        Army *a = [currentPlayer armyByCreature:creature];
        
        if(a != nil){
            [a removeCreature:creature];
        }
        
        if(![t hasArmyOnIt]){
            a = [currentPlayer constructNewArmy:creature atPoint:n.position withTerrain:t];
            if (a != nil) {
                [a drawImage:board];

                [n removeFromParent];
                [t setHasArmyOnIt:YES];
                [self setCreaturesInBowl:creaturesInBowl-1];
            }
            else{
                //must've reached the limit of charecters
                [n setPosition:CGPointMake(480.0f, (size.height) - 175.0f)];
            }
        }
        else {
            //else would take care of if theres no army :)
            for(Army *army in [currentPlayer armies]){
                if([army getTerrainLocation] == [t location]){
                    if([currentPlayer addCreatureToArmy:creature inArmy:army ]){
                        [n removeFromParent];
                        [MyScene wiggle:army.image];

                    }
                    else{
                        //must've reached the limit of charecters
                        [n setPosition:CGPointMake(480.0f, (size.height) - 175.0f)];
                    }
                }
            }
        }
    }
    else{
        Creature *creature = [self findCreatureByName:n.name];
        [self addToRack:creature];
    }
    Player *currentPlayer;
    if ([[game findPlayersByTerrain:t] count] == 0) {
        currentPlayer = [game currentPlayer];
    }
    else{
        currentPlayer = [[game findPlayersByTerrain:t] objectAtIndex:0];
    }
    currentPlayer.recruitsRemaining--;
    [self updateRecruitLabel:currentPlayer];
    [game checkInitalRecruitmentComplete]; //double checks to see if everyone finished recruiting so that we can move to next phase
    
    

}

- (void) addToRack: (id) item{
    if ([game currentPlayer].rack.count <= 10) {
        SKSpriteNode *itemNode;
        
        //to make it work for both si and creature
        if ([item isKindOfClass:[SpecialIncome class]]) {
            SpecialIncome* itemC = (SpecialIncome *)item;
            itemNode = itemC.node;
        }
        else{
            Creature* itemC = (Creature *)item;
            itemNode = itemC.node;
        }
        
        
//        [self removeCreatureByName:itemNode.name]; //removes the creature from the bowl
        
        if (item && ![[game currentPlayer].rack containsObject:item]) {
            [[game currentPlayer].rack addObject:item];
        }
        
        float offset = ([game currentPlayer].rack.count - 1) * itemNode.size.width;
        [itemNode setPosition:CGPointMake(540.0f + offset, (size.height) - 225)];
//        [self redrawCreatures];
    }
    
    else{
        UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Rack is Full" message: @"Sorry, but you already have 10 items on your rack." delegate: self                                       cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        
        [error show];
        
    }
}


- (BOOL) initiateGoldCollection{
    int totalIncome = 0;
    
//    [game presentGCTurnViewController:self];
    
    [game checkBluffForPlayer:[game currentPlayer]];
    
    for(Player * p in game.players){
        totalIncome += [p getIncome];
    }
    //checks if the phase is intial and theres moeny in the bank for everyone before proceeding.
    if (game.phase == GoldCollection && totalIncome <= [bank getBalance]) {
        for(Player * p in game.players){
            
            [bank withdraw:[p getIncome]];
            [p.bank deposit:[p getIncome]];
            
//            NSLog(@"Player balance %d after deposition and income was %d", [p.bank getBalance], [p getIncome]);
            p.recruitsRemaining = 2;
            recruitLabel.text = [NSString stringWithFormat: @"%d Recruits Remaining", p.recruitsRemaining];
        }
        
//        NSLog(@"bank balance after collection phase completion %d", [bank getBalance]);
        [self updateBank];
        
        [game advancePhase:Recruitment];
        return YES;
    }
    else{
        NSLog(@"the stage was neither initial or theres not enough balance in the bank to accomodate gold collection for all users, so it wasnt initiated");
        return NO;
    }
}


-(void) constructBuilding:(Player*)owner withBuilding:(SKSpriteNode*)node onTerrain:(Terrain*)t{
    float sizeNode = 26;
    float towerSizeNode = sizeNode + 4;
    
    if([game isInitialPhase]){
        if(![node.accessibilityLabel isEqualToString:@"tower"]){
            UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Invalid Move" message: @"na'aa you can't cheat;) first thing to build is tower" delegate: self                                       cancelButtonTitle:@"GOT IT !" otherButtonTitles:nil];
            
            [error show];
            [node removeFromParent];
        }
        else{
            Building *b = [[Building alloc] initWithImage:node.name atPoint:node.position andStage:Tower andTerrain:t];
            [t setHasBuilding:YES];
            if ([owner setBuilding:b]){
                [b setImageNode:node];
                node.name = @"bowl";
                [node setSize:CGSizeMake(towerSizeNode, towerSizeNode)];
                [node setPosition:CGPointMake(t.node.position.x - 10, t.node.position.y + 22)];
            }
        }
    }
    // /else if([game isConstructionPhase]){
    else{
        if([t hasBuilding]){
            
            Building *currentBuilding = [owner getBuildingOnTerrain:t];
            
            NSLog(@"Current building %@ ",[owner getBuildingOnTerrain:t].imageNode);
            
            if([node.name isEqualToString:currentBuilding.imageName]){
                UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Invalid Move" message: @"You can't have two forts of same type on one terrain" delegate: self                                       cancelButtonTitle:@"GOT IT !" otherButtonTitles:nil];
                
                [error show];
                [node removeFromParent];
                //[node setPosition:CGPointMake(23.0f + 43, (size.height) - 100)];
                
                
            }
            else {
                
                if([[owner bank] getBalance] >= 5){
                    
                    UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Money deducted" message: @"This operation will automaticlly deduct gold from your bank: 20 Gold for Citadel, 5 Gold for other forts" delegate: self                                       cancelButtonTitle:@"GOT IT !" otherButtonTitles:nil];
                    
                    [error show];

                    Building* newBuilding = [[Building alloc] initWithImage:node.name atPoint:node.position andStage:NONE andTerrain:t];
                    
                    //Building *currentBuilding = [owner getBuildingOnTerrain:t];

                    NSLog(@"Current building %@ , new Buildign %@",[currentBuilding.imageNode accessibilityLabel],node.accessibilityLabel);

                    if([currentBuilding checkIfConstructionPossible:node]){
                       
                        if ([node.accessibilityLabel isEqualToString:@"citadel"]) {
                            if([[owner bank] getBalance] >= 20){
                                if(![owner hasBuiltCitadel]){
                                    if ([owner setBuilding:newBuilding]){
                                        
                                        [owner removeBuilding:currentBuilding];
                                        [newBuilding setImageNode:node];
                                        [[currentBuilding imageNode] removeFromParent];
                                        
                                        node.name = @"bowl";
                                        [node setSize:CGSizeMake(towerSizeNode, towerSizeNode)];
                                        [node setPosition:CGPointMake(t.node.position.x - 10, t.node.position.y + 7)];
                                        [owner setHasBuiltCitadel:YES];
                                        
                                    }
                                }
                                else {
                                    UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Citadel Building" message: @"You cannot build more than one Citadel" delegate: self                                       cancelButtonTitle:@"GOT IT !" otherButtonTitles:nil];
                                    
                                    [error show];
                                }
                            }
                            else{
                                UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"insufficient Balance" message: @"You do not have enough money to build a Citadel!!" delegate: self                                       cancelButtonTitle:@"GOT IT !" otherButtonTitles:nil];
                                
                                [error show];
                                [node removeFromParent];
                            }
                        }
                        else{//building other than citadel
                            
                                if ([owner setBuilding:newBuilding]){
                                    [node setPosition:[[currentBuilding imageNode] position]];
                                    [[currentBuilding imageNode] removeFromParent];
                                    [newBuilding setImageNode:node];

                                    [owner removeBuilding:currentBuilding];
                                    node.name = @"bowl";
                                    [node setSize:CGSizeMake(towerSizeNode, towerSizeNode)];
                                    
                                    
                                    [self depositToBank:5];
                                    [self updateBank];

                                    //[node setPosition:CGPointMake(t.node.position.x - 10, t.node.position.y + 7)];
                                }
                        }
                    }
                    else{
                        UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Invalid Move" message: @"To Build forts you should go from stage to stage:Tower->Keep->Castle->Citadel!!" delegate: self                                       cancelButtonTitle:@"GOT IT !" otherButtonTitles:nil];
                        
                        [error show];
                        [node removeFromParent];

                    }
                }
                else{
                    UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"insufficient Balance" message: @"You do not have enough money to build a fort!!" delegate: self                                       cancelButtonTitle:@"GOT IT !" otherButtonTitles:nil];
                    
                    [error show];
                    [node removeFromParent];
                }
                
            }
        }
        else{
            if(![node.accessibilityLabel isEqualToString:@"tower"]){
                UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Invalid Move" message: @"na'aa you can't cheat;) first thing to build is tower" delegate: self                                       cancelButtonTitle:@"GOT IT !" otherButtonTitles:nil];
                
                [error show];
                [node removeFromParent];
            }
            else{
                Building *b = [[Building alloc] initWithImage:node.name atPoint:node.position andStage:Tower andTerrain:t];
                [t setHasBuilding:YES];
                if ([owner setBuilding:b]){
                    [b setImageNode:node];
                    node.name = @"bowl";
                    [node setSize:CGSizeMake(towerSizeNode, towerSizeNode)];
                    [node setPosition:CGPointMake(t.node.position.x - 10, t.node.position.y + 22)];
                }
            }
        }
    }

}

-(void) recruiteSpecial:(SKSpriteNode*)node{
    
    NSLog(@"Inside recruite special");
    
    Creature* special = [[Creature alloc]initWithImage:node.name atPoint:node.position];
    
    Player *p = [game currentPlayer];
    
    
    [scene transitToRecruitmentScene:special forPlayer:p];
    
    
}

- (BOOL) canMoveNode:(SKSpriteNode*) node{
    if ([game recruitmentComplete]  && [node.accessibilityValue isEqualToString:@"creatures"] && node.position.x == 450 &&node.position.y == 456)
        return NO;
    else
        return ![nonMovables containsObject: node.name];
}

- (BOOL) canSelectNode:(SKSpriteNode*) node{
    NSLog(@"node positoin: %f,%f",node.position.x,node.position.y);
    if ([game recruitmentComplete] && [node.accessibilityValue isEqualToString:@"creatures"] && node.position.x == 450 &&node.position.y == 456)
        return NO;
    else
        return ![disabled containsObject:node.name];
}

-(void) captureHex:(Player*)player atTerrain:(Terrain*)terrian {
    
    //Terrain* temp = [self findTerrainAt:aPoint];
    
    if ([player setTerritory:terrian]){
        NSLog(@"captureHEx");
        
        [terrian setHasArmyOnIt:YES];
        SKSpriteNode* node = [[SKSpriteNode alloc]initWithImageNamed:[markers objectAtIndex:([player playingOrder]-1)]];
        node.name = @"bowl";
        //[node setPosition:terrian.point];
        [node setSize:CGSizeMake(26.0f, 26.0f)];
        [node setPosition:CGPointMake(terrian.node.position.x + 10, terrian.node.position.y + 22)];
        [board addChild:node];
        
    }

    
}
/*
 ----Not Complete ----
 account for random events and magic
 */
-(Army*) createRandomArmy:(NSInteger) number atPoint:(CGPoint)aPoint andTerrain:(Terrain*)terrain{
    
    Army *a = [[Army alloc]init];
    SpecialIncome* tempCounter;
   /**
    
    Another way of doing this is to pick the things then evaluate them one by one without getting replacment for them
    */
    
    /*NSMutableIndexSet *picks = [NSMutableIndexSet indexSet];
    do {
        [picks addIndex:arc4random() % bowl.count];
    } while (picks.count != number);
    
    //picks stuff randomly from the bowl and then later redraws it to reflect the changes.
    [picks enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
        NSLog(@"Element at index %ud: %@", idx, [bowl objectAtIndex:idx]);
        Creature* cre = [[Creature alloc]initWithImage:[bowl objectAtIndex:idx] atPoint:aPoint];
        [a addCreatures:cre];
        [bowl removeObject:cre];
    }];
    
    
    [self redrawCreatures];
    */
    
    while (number > 0){
        int index = (arc4random() % [bowl count]);
        //Creature* cre = [[Creature alloc]initWithImage:[creatureList objectAtIndex:index] atPoint:aPoint];
        
        if([[bowl objectAtIndex:index] isKindOfClass:[SpecialIncome class]]){
            
            SpecialIncome* temp = [bowl objectAtIndex:index];
            
            if(temp.isKeyedToTerrain){
                if(!tempCounter){
                    if([temp.terrainType isEqualToString:terrain.type]){ // if thing belongs to terrain
                        [a addCreatures:[bowl objectAtIndex:index]];
                        [bowl removeObjectAtIndex:index];
                        number-=1;
                        tempCounter = temp;
                         [self redrawCreatures];
                    }
                }
                else{
                    if(temp.goldValue > tempCounter.goldValue){
                        //nothing should be done
                        [bowl addObject:tempCounter];
                        [a addCreatures:temp];
                        [bowl removeObject:tempCounter];
                        [self redrawCreatures];
                        number-=1;
                    }
                    // else do nothing
                
                }
                
            }
            else if (temp.isTreasure){
                [a addCreatures:[bowl objectAtIndex:index]];
                [bowl removeObjectAtIndex:index];
                number-=1;
                
                [self redrawCreatures];
            }
        }
        else{// thing is a creature
            [a addCreatures:[bowl objectAtIndex:index]];
            [bowl removeObjectAtIndex:index];
            
            number-=1;
            [self redrawCreatures];
        }
        
        //condition for magic thing
        //random events must be returned to bowl
    }
    
    return a;
    

}
-(void) recruiteSpecialIncome:(SKSpriteNode*)node onTerrain:(Terrain*)t{
    SpecialIncome *temp ;
    for(SpecialIncome* s in bowl){
        if ([s.name isEqualToString:node.name]){
            temp = s;
            break;
        }
    }
    
    if([temp isTreasure]){
        [self addToRack:temp];
        [bowl removeObject:temp];
    }
    else{
        if([temp.terrainType isEqualToString:t.type]){
            if([t hasSpecialIncome]){
                [self addToRack:temp];
                [bowl removeObject:temp];
            }
            else {
                [bowl removeObject:temp];
                [game.currentPlayer addSpecialIncome:temp];
                game.currentPlayer.recruitsRemaining--;
                [t setHasSpecialIncome:YES];
                [self redrawCreatures];
            }
        }
        else{
            [self addToRack:temp];
            [bowl removeObject:temp];
 
        }
    }
   
}

-(void) playTreasure:(SKSpriteNode*)node{
 
    for(SpecialIncome* sp in [game.currentPlayer rack]){
        if([sp.name isEqualToString:node.name]){
            
            [self withdrawFromBank:sp.goldValue];
            [self updateBank];
            [bowl addObject:sp];
            [node removeFromParent];
            [[game.currentPlayer rack] removeObject:sp];
            [self redrawCreatures];
            break;
            
        }
    }
    
}
@end