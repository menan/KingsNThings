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
#import "GamePlay.h"
#import "NSMutableArrayShuffling.h"
#import "Army.h"

@implementation Board{
    NSArray * nonMovables;
    
    NSArray *terrainNames;
    
    NSMutableArray *terrains;
    NSMutableArray *creatures;
    
    SKSpriteNode *board;
    SKScene *scene;
    CGPoint point;
    CGSize size;
    Bank *bank;
    GamePlay *game;
    
    SKLabelNode* balanceLabel;
    SKLabelNode *myBalance;
    
    SKLabelNode* balanceText;
    
    SKLabelNode* diceOneLabel;
    SKLabelNode* diceTwoLabel;
    
    int playersCount;
    
}
static NSString * const defaultText = @"KingsNThings - Team24";

@synthesize textLabel,dicesClicked,creaturesInBowl;
- (id)initWithScene: (SKScene *) aScene atPoint: (CGPoint) aPoint withSize: (CGSize) aSize
{
    self = [super init];
    if (self) {
        point = aPoint;
        size = aSize;
        scene = aScene;
        playersCount = 4;
        nonMovables = @[@"board", @"bowl", @"rack", @"Gold 1", @"Gold 2", @"Gold 5", @"Gold 10", @"Gold 15", @"Gold 20", @"My Gold 1", @"My Gold 2", @"My Gold 5", @"My Gold 10", @"My Gold 15", @"My Gold 20", @"diceOne", @"diceTwo"];
        terrainNames = @[@"Desert", @"Forest", @"Frozen Waste", @"Jungle", @"Mountains", @"Plains", @"Sea", @"Swamp"];
        
        terrains = [[NSMutableArray alloc] init];
        bank = [[Bank alloc]init];
        
        game = [[GamePlay alloc] initWith4Players];
        creaturesInBowl = 0;
        dicesClicked = 0;
        
        
        
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
    
    [self drawMarkers:CGPointMake(380.0f, 25.0f)];
    
    [self drawBowlwithThings:CGPointMake(450.0f, (size.height) - 120)];
    
    [self drawHardCodeThings:[game p1Stack1] withPoint:CGPointMake(450.0f, (size.height) - 120)];
    
    [self drawHardCodeThings:[game p1Stack2] withPoint:CGPointMake(450.0f, (size.height) - 120)];
    
    
    
    
//    [self drawRack:CGPointMake(620.0f, (size.height) - 55)];
//    [self drawRack:CGPointMake(620.0f, (size.height) - 150)];
//    [self drawRack:CGPointMake(620.0f, (size.height) - 240)];
//    [self drawRack:CGPointMake(620.0f, (size.height) - 330)];
    
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
//    NSArray *creatureList = @[@"-n Baby Dragon -t Desert -s Fly -a 3", @"-n Giant Spider -t Desert -a 1", @"-n Sandworm -t Desert -a 3", @"-n Camel Corps -t Desert -a 3", @"-n Giant Wasp -t Desert -s Fly -a 2", @"-n Skletons -c 2 -t Desert -a 1", @"-n Dervish -c 2 -t Desert -s Magic -a 2", @"-n Giant Wasp -t Desert -s Fly -a 4", @"-n Sphinx -t Desert -s Magic -a 4", @"-n Desert Bat -t Desert -s Fly -a 1", @"-n Griffon -t Desert -s Fly -a 2", @"-n Vultures -c 2 -t Desert -s Fly -a 1", @"-n Dust Devil -t Desert -s Fly -a 4", @"-n Nomads -c 2 -t Desert -a 1", @"-n Yellow Knight -t Desert -s Charge -a 3", @"-n Genie -t Desert -s Magic -a 4", @"-n Old Dragon -s Fly -s Magic -a 4", @"-n Bandits -t Forest -a 2", @"-n Elves -t Forest -s Range -a 3", @"-n Pixies -c 2 -t Forest -s Fly -a 1", @"-n Bears -t Forest -a 2", @"-n Flying Squirrel -t Forest -s Fly -a 1", @"-n Unicorn -t Forest -a 4", @"-n Big Foot -t Forest -a 5", @"-n Flying Squirrel -t Forest -s Fly -a 2", @"-n Walking Tree -t Forest -a 5", @"-n Druid -t Forest -s Magic -a 3", @"-n Forester -t Forest -s Range -a 2", @"-n Wild Cat -t Forest -a 2", @"-n Dryad -t Forest -s Magic -a 1", @"-n Great Owl -t Forest -s Fly -a 2", @"-n Wyvern -t Forest -s Fly -a 3", @"-n Elf Mage -t Forest -s Magic -a 2", @"-n Green Knight -t Forest -s Charge -a 4", @"-n Elves -c 2 -t Forest -s Range -a 2", @"-n Killer Racoon -t Forest -a 2", @"-n Bird Of Paradise -t Jungle -s Fly -a 1", @"-n Head Hunter -t Jungle -s Range -a 2", @"-n Crawling Vines -t Jungle -a 6", @"-n Pterodactyl Warriors -c 2 -t Jungle -s Fly -s Range -a 2", @"-n Crocodiles -t Jungle -a 2", @"-n Pygmies -t Jungle -a 2", @"-n Dinasaur -t Jungle -a 4", @"-n Tigers -c 2 -t Jungle -a 3", @"-n Elephant -t Jungle -s Charge -a 4", @"-n Watusi -t Jungle -s 2", @"-n Giant Ape -c 2 -t Jungle -a 5", @"-n Witch Doctor -t Jungle -s Magic -a 2", @"-n Giant Snake -t Jungle -s 3", @"-n Dragon Rider -t Frozen Waste -s Fly -s Range -a 3", @"-n Killer Puffins -t Frozen Waste -s Fly -a 2", @"-n Elk Herd -t Frozen Waste -a 2", @"-n Mammoth -t Frozen Waste -s Charge -a 5", @"-n Eskimos -c 4 -t Frozen Waste -a 2", @"-n North Wind -t Frozen Waste -s Fly -s Magic -a 2", @"-n Ice Bats -t Frozen Waste -s Fly -a 1", @"-n Walrus -t Frozen Waste -a 4", @"-n Ice Giant -t Frozen Waste -s Range -a 5", @"-n White Brea -t Frozen Waste -a 4", @"-n Iceworm -t Frozen Waste -s Magic -a 4", @"-n White Dragon -t Frozen Waste -s Magic -a 5", @"-n Killer Penguins -t Frozen Waste -a 3", @"-n Wolves -t Frozen Waste -a 3", @"-n Brown Dragon -t Mountain -s Fly -a 3", @"-n Gaint Roc -t Mountain -s Fly -a 3", @"-n Little Roc -t Mountain -s Fly -a 2", @"-n Brown Knight -t Mountain -s Charge -a 4", @"-n Giant -t Mountain -s Range -a 4", @"-n Mountain Lion -t Mountain -a 2", @"-n Cyclops -t Mountain -a 5", @"-n Giant Condor -t Mountain -s Fly -a 3", @"-n Mountain Men -c 2 -t Mountain -a 1", @"-n Dwarves -t Mountain -s Charge -a 3", @"-n Goblins -c 4 -t Mountain -a 1", @"-n Orge Mountain -t Mountain -a 2", @"-n Dwarves -t Mountain -s Range -a 2", @"-n Great Eagle -t Mountain -s Fly -a 2", @"-n Troll -t Mountain -a 4", @"-n Dwarves -t Mountain -s Range -a 3", @"-n Great Hawk -t Mountain -s Fly -a 1", @"-n Buffalo Herd -t Plains -a 3", @"-n Giant Beetle -t Plains -s Fly -a 2", @"-n Pegasus -t Plains -s Fly -a 2", @"-n Buffalo Herd -t Plains -a 4", @"-n Great Hawk -t Plains -s Fly -a 2", @"-n Pterodactyl -t Plains -s Fly -a 3", @"-n Centaur -t Plains -a 2", @"-n Greathunter -t Plains -s Range -a 4", @"-n Tribesmen -c 2 -t Plains -a 2", @"-n Dragonfly -t Plains -s Fly -a 2", @"-n Gypsies -t Plains -s Magic -a 1", @"-n Villains -t Plains -a 2", @"-n Eagles -t Plains -s Fly -a 2", @"-n Gypsies -t Plains -s Magic -a 2", @"-n White Knight -t Plains -s Charge -a 3", @"-n Farmers -c 4 -t Plains -a 1", @"-n Hunter -t Plains -s Range -a 1", @"-n Wolf Pack -t Plains -a 3", @"-n Flying Buffalo -t Plains -s Fly -a 2", @"-n Lion Ride -t Plains -a 3", @"-n Tribesmen -c 2 -t Plains -a 2", @"-n Basilisk -t Swamp -s Magic -a 3", @"-n Giant Snake -t Swamp -a 3", @"-n Swamp Gas -t Swamp -s Fly -a 1", @"-n Black Knight -t Swamp -s Charge -a 3", @"-n Huge Leech -t Swamp -a 2", @"-n Swamp Rat -t Swamp -a 1", @"-n Crocodiles -t Swamp -a 2", @"-n Pirates -t Swamp -a 2", @"-n Thing -t Swamp -a 2", @"-n Dark Wizard -t Swamp -s Fly -s Magic -a 1", @"-n Poison Frog -t Swamp -a 1", @"-n Vampire Bat -t Swamp -s Fly -a 4", @"-n Ghost -c 4 -t Swamp -s Fly -a 1", @"-n Spirit -t Swamp -s Magic -a 2", @"-n Watersanke -t Swamp -a 1", @"-n Giant Lizard -c 2 -t Swamp -a 2", @"-n Sprote -t Swamp -s Magic -a 1", @"-n Will_O_Wisp -t Swamp -s Magic -a 2", @"-n Giant Mosquito -t Swamp -s Fly -a 2", @"-n Swamp Beast -t Swamp -a 3", @"-n Winged Pirhana -t Swamp -s Fly -a 3" ];
    
   /* NSArray *creatureList = @[@"-n Cyclops -t Mountain -a 5",@"-n Mountain Men -c 2 -t Mountain -a 1",@"-n Goblins -c 4 -t Mountain -a 1"];
    creatures = [[NSMutableArray alloc] init];
    
    for (NSString *str in creatureList) {
        Creature *creature = [[Creature alloc] initWithBoard:board atPoint:aPoint fromString:str];
        [creature draw];
        [creatures addObject:creature];
    }*/
    
    /*
    NSLog(@"creatures count: %d", creatures.count);
    
    [creatures shuffle];
    [creatures shuffle];
    [creatures shuffle];
    [creatures shuffle];
    for (Creature * creature in creatures) {
        [creature draw];
    }
    for (NSString *string in creatureList){
        NSString* imageName = [NSString stringWithFormat:@"%@.jpg",string];
        SKSpriteNode* node = [SKSpriteNode spriteNodeWithImageNamed:imageName];
        [node setName:imageName];
        node.accessibilityValue = @"creatures";
        node.size = CGSizeMake(36,36);
        [node setPosition:aPoint];
        node.color = [SKColor blackColor];
        node.colorBlendFactor = .85;
        [self setCreaturesInBowl:([self creaturesInBowl]+1)];
        [board addChild:node];
        
        
    }
    NSLog(@"number of creatures in Bowl %d",[self creaturesInBowl]);
    */
}

- (void) drawHardCodeThings:(NSArray*)army withPoint:(CGPoint) aPoint {
    
       for (NSString *string in army){
           
               NSString* imageName = [NSString stringWithFormat:@"%@.jpg",string];
           
               SKSpriteNode* node = [SKSpriteNode spriteNodeWithImageNamed:imageName];
               [node setName:imageName];
               node.accessibilityValue = @"creatures";
               // [node setGroup:@"creature"];
               node.size = CGSizeMake(36,36);
               [node setPosition:aPoint];
               node.color = [SKColor blackColor];
               node.colorBlendFactor = .85;
               [self setCreaturesInBowl:([self creaturesInBowl]+1)];
               [board addChild:node];
        
}
    NSLog(@"number of creatures in Bowl %d",[self creaturesInBowl]);
    
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
    
    
    diceOneLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    diceOneLabel.text = @"0";
    diceOneLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    diceOneLabel.fontSize = 25;
    diceOneLabel.position = CGPointMake(aPoint.x,aPoint.y + 30);
    [board addChild:diceOneLabel];
    
    diceTwoLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    diceTwoLabel.text = @"0";
    diceTwoLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    diceTwoLabel.fontSize = 25;
    diceTwoLabel.position = CGPointMake(aPoint.x + 40.0f,aPoint.y + 30);
    [board addChild:diceTwoLabel];
    
    
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
    
    for (int i = 0; i <= 10; i++) {
        
        SKSpriteNode *player1 = [SKSpriteNode spriteNodeWithImageNamed:@"p_yellow.jpg"];
        [player1 setName:@"Player 1"];
        player1.size = CGSizeMake(40,40);
        [player1 setPosition:aPoint];
        [board addChild:player1];
        
        
        SKSpriteNode *player2 = [SKSpriteNode spriteNodeWithImageNamed:@"p_gray.jpg"];
        [player2 setName:@"Player 2"];
        player2.size = CGSizeMake(40,40);
        [player2 setPosition:CGPointMake(aPoint.x + 43, aPoint.y )];
        [board addChild:player2];
        
        
        SKSpriteNode *player3 = [SKSpriteNode spriteNodeWithImageNamed:@"p_green.jpg"];
        [player3 setName:@"Player 3"];
        player3.size = CGSizeMake(40,40);
        [player3 setPosition:CGPointMake(aPoint.x + 86, aPoint.y )];
        [board addChild:player3];
        
        SKSpriteNode *player4 = [SKSpriteNode spriteNodeWithImageNamed:@"p_red.jpg"];
        [player4 setName:@"Player 4"];
        player4.size = CGSizeMake(40,40);
        [player4 setPosition:CGPointMake(aPoint.x + 129, aPoint.y )];
        [board addChild:player4];
    }
    
    
}

- (void) drawSpecialCreatures:(CGPoint) aPoint{
    NSArray *namesString = @[@"-n Arch Cleric -a 5.jpg",@"-n Forest King -a 4.jpg",@"-n Master Theif -a 4.jpg",@"-n Arch Mage -a 6.jpg",@"-n Ghaog II -s Fly -a 6.jpg",@"-n Mountain King -a 4.jpg",@"-n Assassin Primus -a 4.jpg",@"-n Grand Duke -a 4.jpg",@"-n Plains Lord -a 4.jpg",@"-n Baron Munchausen -a 4.jpg",@"-n Greathunter -t Plains -s Range -a 4.jpg",@"-n Sir Lancealot -s Charge -a 5.jpg",@"-n Deerhunter -a 4.jpg",@"-n Ice Lord -a 4.jpg",@"-n Swamp King -a 4.jpg",@"-n Desert Master -a 4.jpg",@"-n Jungle Lord -a 4.jpg",@"-n Swordmaster -a 4.jpg",@"-n Dwarf King -a 5.jpg",@"-n Lord Of Eagles -s Fly -a 5.jpg",@"-n Warlord -a 5.jpg",@"-n Elfe Lord -s Range -a 6.jpg",@"-n Marksman -s Range -a 2 -a 5.jpg"];
    
    int i;
    
    for (i = 0; i <= 11; i++) {
        NSString *name = [namesString objectAtIndex:i];
        
        
        float imageSize = 36;
        float offsetFraction = aPoint.x + ((imageSize + 1) * (i + 1));
        Creature* creature = [[Creature alloc] initWithBoard:board atPoint:CGPointMake(offsetFraction, aPoint.y) fromString:name isSpecial:YES];
        [creatures addObject:creature];
        [creature draw];
        
    }
    for (int j = 12; j <= 22; j++) {
        NSString *name = [namesString objectAtIndex:j];
        
        int num = j - namesString.count/2;
        
        float imageSize = 36;
        float offsetFraction = aPoint.x + ((imageSize + 1) * (num + 1));
        Creature* creature = [[Creature alloc] initWithBoard:board atPoint:CGPointMake(offsetFraction, aPoint.y - 37) fromString:name isSpecial:YES];
        [creatures addObject:creature];
        [creature draw];
        
    }
    
    
}

-(void) drawBank
{
    if([bank getBalance] == 710){
        
        //draws 20 of 1s, 2s, 5s and 10s
        for (int i = 0 ; i < 20 ; i++){
    
            SKSpriteNode *one = [bank goldsWithImage:@"GoldOne.jpg"];
            [one setName:@"Gold 1"];
            one.size = CGSizeMake(40,41);
            //one.centerRect = CGRectMake(12.0/430.0,12.0/440.0,4.0/430.0,4.0/440.0);
            [one setPosition:CGPointMake(535.0f, (size.height) - 435)];
            
            SKSpriteNode *two = [bank goldsWithImage:@"GoldTwo.jpg"];
            [two setName:@"Gold 2"];
            two.size = CGSizeMake(40,41);
            //one.centerRect = CGRectMake(12.0/430.0,12.0/440.0,4.0/430.0,4.0/440.0);
            [two setPosition:CGPointMake(585.0f, (size.height) - 435)];
            
            SKSpriteNode *five = [bank goldsWithImage:@"GoldFive.jpg"];
            [five setName:@"Gold 5"];
            five.size = CGSizeMake(40,41);
            //one.centerRect = CGRectMake(12.0/430.0,12.0/440.0,4.0/430.0,4.0/440.0);
            [five setPosition:CGPointMake(635.0f, (size.height) - 435)];
    
            SKSpriteNode *ten = [bank goldsWithImage:@"GoldTen.jpg"];
            [ten setName:@"Gold 10"];
            ten.size = CGSizeMake(40,41);
            //one.centerRect = CGRectMake(12.0/430.0,12.0/440.0,4.0/430.0,4.0/440.0);
            [ten setPosition:CGPointMake(535.0f, (size.height) - 481)];
            
            [board addChild:one];
            [board addChild:two];
            [board addChild:five];
            [board addChild:ten];
        }
        //draws 10 of 15s and 20s
        for (int i = 0; i < 10; i++) {
            
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
    }
    
    
    
    float bankLeft = 590.0f;
    
    balanceLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    balanceLabel.text = @"Bank";
    balanceLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    balanceLabel.fontSize = 15;
    balanceLabel.position = CGPointMake(bankLeft,(size.height) - 410.0f);

    
    NSString *balance = [NSString stringWithFormat: @"$%d", [bank getBalance]];
    balanceText = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    balanceText.text = balance;
    balanceText.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    balanceText.fontSize = 15;
    balanceText.position = CGPointMake(bankLeft + 120,(size.height - balanceLabel.frame.size.height) - 450.0f);
    
    
    SKLabelNode *myStash = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    myStash.text = @"My Stash";
    myStash.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    myStash.fontSize = 15;
    myStash.position = CGPointMake(bankLeft - 10,(size.height - balanceLabel.frame.size.height) - 270.0f);
    [board addChild:myStash];
    
    myBalance = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    myBalance.text = [NSString stringWithFormat: @"$%d", [game.player1 getBankBalance]];
    myBalance.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    myBalance.fontSize = 15;
    myBalance.position = CGPointMake(bankLeft + 120,(size.height - balanceLabel.frame.size.height) - 320.0f);
    [board addChild:myBalance];
    [self drawPlayerGold];
    
    [board addChild:balanceLabel];
    [board addChild:balanceText];
    
}


-(void)drawPlayerGold:(NSString*)goldType withName:(NSString *)name{
    
    float margin = - 120.0f;
    
    CGPoint myGold1 = CGPointMake(535.0f, (size.height) - 435 - margin);
    CGPoint myGold2 = CGPointMake(585.0f, (size.height) - 435 - margin);
    CGPoint myGold5 = CGPointMake(635.0f, (size.height) - 435 - margin);
    CGPoint myGold10 = CGPointMake(535.0f, (size.height) - 481 - margin);
    CGPoint myGold15 = CGPointMake(585.0f, (size.height) - 481 - margin);
    CGPoint myGold20 = CGPointMake(635.0f, (size.height) - 481 - margin);

    if ([name isEqualToString:@"My Gold 1"]) {
        
        SKSpriteNode *gold = [SKSpriteNode spriteNodeWithImageNamed:goldType];
        [gold setName:name];
        gold.size = CGSizeMake(40,41);
        [gold setPosition:myGold1];
        [board addChild:gold];
    }
    else if ([name isEqualToString:@"My Gold 2"]) {
        
        SKSpriteNode *gold = [SKSpriteNode spriteNodeWithImageNamed:goldType];
        [gold setName:name];
        gold.size = CGSizeMake(40,41);
        [gold setPosition:myGold2];
        [board addChild:gold];
    }
    else if ([name isEqualToString:@"My Gold 5"]) {
        
        SKSpriteNode *gold = [SKSpriteNode spriteNodeWithImageNamed:goldType];
        [gold setName:name];
        gold.size = CGSizeMake(40,41);
        [gold setPosition:myGold5];
        [board addChild:gold];
    }
    else if ([name isEqualToString:@"My Gold 10"]) {
        
        SKSpriteNode *gold = [SKSpriteNode spriteNodeWithImageNamed:goldType];
        [gold setName:name];
        gold.size = CGSizeMake(40,41);
        [gold setPosition:myGold10];
        [board addChild:gold];
    }
    else if ([name isEqualToString:@"My Gold 15"]) {
        
        SKSpriteNode *gold = [SKSpriteNode spriteNodeWithImageNamed:goldType];
        [gold setName:name];
        gold.size = CGSizeMake(40,41);
        [gold setPosition:myGold15];
        [board addChild:gold];
    }
    else if ([name isEqualToString:@"My Gold 20"]) {
        
        SKSpriteNode *gold = [SKSpriteNode spriteNodeWithImageNamed:goldType];
        [gold setName:name];
        gold.size = CGSizeMake(40,41);
        [gold setPosition:myGold20];
        [board addChild:gold];
    }
    
    
    
}

- (void)drawPlayerGold{
    float margin = - 120.0f;
    
    CGPoint myGold1 = CGPointMake(535.0f, (size.height) - 435 - margin);
    CGPoint myGold2 = CGPointMake(585.0f, (size.height) - 435 - margin);
    CGPoint myGold5 = CGPointMake(635.0f, (size.height) - 435 - margin);
    CGPoint myGold10 = CGPointMake(535.0f, (size.height) - 481 - margin);
    CGPoint myGold15 = CGPointMake(585.0f, (size.height) - 481 - margin);
    CGPoint myGold20 = CGPointMake(635.0f, (size.height) - 481 - margin);
    
    
    
    for (int i = 0; i <[[game.player1 bank] oneGold]; i++) {
        
        SKSpriteNode *gold = [SKSpriteNode spriteNodeWithImageNamed:@"GoldOne.jpg"];
        [gold setName:@"My Gold 1"];
        gold.size = CGSizeMake(40,41);
        [gold setPosition:myGold1];
        [board addChild:gold];
    }
    for (int i = 0; i <[[game.player1 bank] twoGold]; i++) {
        
        SKSpriteNode *gold = [SKSpriteNode spriteNodeWithImageNamed:@"GoldTwo.jpg"];
        [gold setName:@"My Gold 2"];
        gold.size = CGSizeMake(40,41);
        [gold setPosition:myGold2];
        [board addChild:gold];
    }
    for (int i = 0; i <[[game.player1 bank] fiveGold]; i++) {
        
        SKSpriteNode *gold = [SKSpriteNode spriteNodeWithImageNamed:@"GoldFive.jpg"];
        [gold setName:@"My Gold 5"];
        gold.size = CGSizeMake(40,41);
        [gold setPosition:myGold5];
        [board addChild:gold];
    }
    for (int i = 0; i <[[game.player1 bank] tenGold]; i++) {
        
        SKSpriteNode *gold = [SKSpriteNode spriteNodeWithImageNamed:@"GoldTen.jpg"];
        [gold setName:@"My Gold 10"];
        gold.size = CGSizeMake(40,41);
        [gold setPosition:myGold10];
        [board addChild:gold];
    }
    for (int i = 0; i <[[game.player1 bank] fifteenGold]; i++) {
        
        SKSpriteNode *gold = [SKSpriteNode spriteNodeWithImageNamed:@"GoldFifteen.jpg"];
        [gold setName:@"My Gold 15"];
        gold.size = CGSizeMake(40,41);
        [gold setPosition:myGold15];
        [board addChild:gold];
    }
    for (int i = 0; i <[[game.player1 bank] twentyGold]; i++) {
        
        SKSpriteNode *gold = [SKSpriteNode spriteNodeWithImageNamed:@"GoldTwenty.jpg"];
        [gold setName:@"My Gold 20"];
        gold.size = CGSizeMake(40,41);
        [gold setPosition:myGold20];
        [board addChild:gold];
    }
    
}

-(void)updateBankBalance:(NSInteger)goldNum
{
    if ([bank withdrawGold:goldNum andCount:1]){
        [[game.player1 bank] depositGold:goldNum andCount:1];
        balanceText.text = [NSString stringWithFormat: @"$%d", [bank getBalance]];
        myBalance.text = [NSString stringWithFormat: @"$%d", [game.player1 getBankBalance]];
    }
    
}

- (void) rollDiceOne{
    int r = (arc4random() % 6) + 1;
    diceOneLabel.text = [NSString stringWithFormat:@"%d",r];
    
    [game setOneDice:r];
    [self initiateGoldCollection];
    
}
- (void) rollDiceTwo{
    
    int r = (arc4random() % 6) + 1 ;
    diceTwoLabel.text = [NSString stringWithFormat:@"%d",r];
   
    [game setSecondDice:r];
    
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
        terrain.node.name = @"bowl";
        [terrain draw];
    }
}

- (Terrain *) findTerrainAt:(CGPoint) thisPoint{
    for (Terrain * terrain in terrains) {
        if (terrain.node.position.x == thisPoint.x && terrain.node.position.y == thisPoint.y) {
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
    CGPoint terrainPoint = CGPointMake(0, 0);
    BOOL terrainLocated = NO;
    
    
    for (SKSpriteNode *nodeTerrain in nodes) {
        if ([terrainNames containsObject:nodeTerrain.name]) {
            terrainPoint = nodeTerrain.position;
            terrainLocated = YES;
        }
    }
    
    if([node.accessibilityValue isEqualToString:@"creatures"])
    {
        //NSLog(@"creture is moved from bowl");
        
        Terrain *temp =[self findTerrainAt:terrainPoint];
        
        if(temp != nil){
            
            
            Player *tempPlayer = [game findPlayerByTerrain:temp];
            Creature *tempCreature = [[Creature alloc] initWithImage:node.name atPoint:node.position];
            Army *a = [tempPlayer hasCreature:tempCreature];
            
            if(a != nil){
                
                [a removeCreature:tempCreature];
                
            }
            
            if( ![temp hasArmyOnIt]){
                
                [tempPlayer constructNewArmy:tempCreature atPoint:node.position withTerrain:temp];
                [temp setHasArmyOnIt:YES];
                
                            }
            else if ([temp hasArmyOnIt]){
                
                //NSLog(@"inside temp has army");
                for(Army *army in [tempPlayer armies]){
                    
                    if([army getTerrainLocation] == [temp location]){
                        [tempPlayer addCreatureToArmy:[[Creature alloc] initWithImage:node.name atPoint:node.position] inArmy:army ];
                        
                    }
                }
            }
            
                    NSLog(@"Player is %d ",[tempPlayer playingOrder]);
                     [tempPlayer printArmy];
           
                    
        }
    }//end of if creature
            
      
    
    float sizeNode = 28;
    if (terrainLocated && [node.name isEqualToString:@"Player 1"]) {
        
        Terrain* temp = [self findTerrainAt:terrainPoint];
        
        if ([game.player1 setTerritory:temp]){
            [temp setBelongsToP1:YES];
            [temp setHasArmyOnIt:NO];
            
            node.name = @"bowl";
            [node setSize:CGSizeMake(sizeNode, sizeNode)];
        }
        else{
            [node setPosition:CGPointMake(380.0f, 25.0f)];
        }
    }
    else if (terrainLocated && [node.name isEqualToString:@"Player 2"]) {
        Terrain* temp = [self findTerrainAt:terrainPoint];

        if ([game.player2 setTerritory:temp]){
            [temp setBelongsToP2:YES];
            [temp setHasArmyOnIt:NO];
            node.name = @"bowl";
            [node setSize:CGSizeMake(sizeNode, sizeNode)];
        }
        else{
            [node setPosition:CGPointMake(380.0f + 43.0f, 25.0f)];
        }
    }
    else if ([node.name isEqualToString:@"Player 3"]) {
        Terrain* temp = [self findTerrainAt:terrainPoint];
        [temp setBelongsToP3:YES];

        if ([game.player3 setTerritory:temp]){
            node.name = @"bowl";
            [node setSize:CGSizeMake(sizeNode, sizeNode)];
        }
        else{
            [node setPosition:CGPointMake(380.0f  + 86.0f, 25.0f)];
        }
    }
    else if ([node.name isEqualToString:@"Player 4"]) {
        Terrain* temp = [self findTerrainAt:terrainPoint];
        [temp setBelongsToP4:YES];
        if ([game.player4 setTerritory:temp]){
            node.name = @"bowl";
            [node setSize:CGSizeMake(sizeNode, sizeNode)];
        }
        else{
            [node setPosition:CGPointMake(380.0f + 129.0f, 25.0f)];
        }
    }
    else if ([node.name isEqualToString:@"Gold 1"]) {
        [self updateBankBalance:1];
        [self drawPlayerGold:@"GoldOne.jpg" withName:@"My Gold 1"];
        [node removeFromParent];
    }
    else if ([node.name isEqualToString:@"Gold 2"]){
        [self updateBankBalance:2];
        [self drawPlayerGold:@"GoldTwo.jpg" withName:@"My Gold 2"];
        [node removeFromParent];
    }
    else if ([node.name isEqualToString:@"Gold 5"]){
        [self updateBankBalance:5];
        [self drawPlayerGold:@"GoldFive.jpg" withName:@"My Gold 5"];
        [node removeFromParent];
    }
    else if ([node.name isEqualToString:@"Gold 10"]){
        [self updateBankBalance:10];
        [self drawPlayerGold:@"GoldTen.jpg" withName:@"My Gold 10"];
        [node removeFromParent];
    }
    else if ([node.name isEqualToString:@"Gold 15"]){
        [self updateBankBalance:15];
        [self drawPlayerGold:@"GoldFifteen.jpg" withName:@"My Gold 15"];
        [node removeFromParent];
    }
    else if ([node.name isEqualToString:@"Gold 20"]){
        [self updateBankBalance:20];
        [self drawPlayerGold:@"GoldTwenty.jpg" withName:@"My Gold 20"];
        [node removeFromParent];
    }
    else if ([node.name isEqualToString:@"diceOne"]){
        [self rollDiceOne];
    }
    else if ([node.name isEqualToString:@"diceTwo"]){
        [self rollDiceTwo];
    }
    else if ([node.name isEqualToString:@"Tower"]){
        
        Terrain* t = [self findTerrainAt:terrainPoint];
        Player* owner = [game findPlayerByTerrain:t];
        
        if (terrainLocated && owner != (id)[NSNull null]) {
            Building *b = [[Building alloc] initWithStage:Tower andTerrain:t];
            if ([owner setBuilding:b]){
                node.name = @"bowl";
                [node setSize:CGSizeMake(sizeNode, sizeNode)];
            }
            else{
                [node setPosition:CGPointMake(23.0f + 43, (size.height) - 100)];
            }
        }
        
    }
    else if ([node.name isEqualToString:@"Keep"]){
        
        Terrain* t = [self findTerrainAt:terrainPoint];
        Player* owner = [game findPlayerByTerrain:t];
        
        if (terrainLocated && owner != (id)[NSNull null]) {
            Building *b = [[Building alloc] initWithStage:Keep andTerrain:t];
            if ([owner setBuilding:b]){
                node.name = @"bowl";
                [node setSize:CGSizeMake(sizeNode, sizeNode)];
            }
            else{
                [node setPosition:CGPointMake(23.0f + 43, (size.height) - 100 - 43)];
            }
        }
    }
    else if ([node.name isEqualToString:@"Castle"]){
        
        Terrain* t = [self findTerrainAt:terrainPoint];
        Player* owner = [game findPlayerByTerrain:t];
        
        if (terrainLocated && owner != (id)[NSNull null]) {
            Building *b = [[Building alloc] initWithStage:Castle andTerrain:t];
            if ([owner setBuilding:b]){
                node.name = @"bowl";
                [node setSize:CGSizeMake(sizeNode, sizeNode)];
            }
            else{
                [node setPosition:CGPointMake(23.0f, (size.height) - 100 - 43)];
            }
        }
    }
    else if ([node.name isEqualToString:@"Citadel"]){
        
        Terrain* t = [self findTerrainAt:terrainPoint];
        Player* owner = [game findPlayerByTerrain:t];
        
        if (terrainLocated && owner != (id)[NSNull null]) {
            Building *b = [[Building alloc] initWithStage:Citadel andTerrain:t];
            if ([owner setBuilding:b]){
                node.name = @"bowl";
                [node setSize:CGSizeMake(sizeNode, sizeNode)];
            }
            else{
                [node setPosition:CGPointMake(23.0f, (size.height) - 100)];
            }
        }
    }
    else{
        
    }
}

/*-(void) hardeCodeArmies{
    
    
    
    
}*/


- (BOOL) initiateGoldCollection{
    int totalIncome = 0;
    
    for(Player * p in game.players){
        totalIncome += [p getIncome];
    }
    
    if (!game.goldCollectionCompleted && totalIncome) {
        for(Player * p in game.players){
            
            [bank withdraw:[p getIncome]];
            [p.bank deposit:[p getIncome]];
            
            NSLog(@"Player balance %d after deposition and income was %d", [p.bank getBalance], [p getIncome]);
            
        }
        
        NSLog(@"bank balance after collection phase completion %d", [bank getBalance]);
        
        game.goldCollectionCompleted = YES;
        return YES;
    }
    else{
        return NO;
    }
}
/*-(void) startComabt:
{
    
    
    
    
    
    
}*/

@end