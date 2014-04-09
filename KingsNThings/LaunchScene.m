//
//  LaunchScene.m
//  kingsnthings
//
//  Created by Menan Vadivel on 2014-04-08.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import "LaunchScene.h"

@implementation LaunchScene{
    GameScene* sender;
    ViewController *view;
}

- (NSData *) getHardCodedElements{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    
    //==================== markers
    
    
    NSMutableArray *markersArray = [[NSMutableArray alloc] init];
    
    
    
    [markersArray addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithFloat:363.000000],@"X",[NSNumber numberWithFloat:(106.250000)],@"Y",[NSNumber numberWithInt:0],@"playerId", nil]];
    [markersArray addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithFloat:301.000000],@"X",[NSNumber numberWithFloat:(72.500000)],@"Y",[NSNumber numberWithInt:0],@"playerId", nil]];
    [markersArray addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithFloat:424.750000],@"X",[NSNumber numberWithFloat:(141.500000)],@"Y",[NSNumber numberWithInt:0],@"playerId", nil]];
    [markersArray addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithFloat:302.500000],@"X",[NSNumber numberWithFloat:(143.750000)],@"Y",[NSNumber numberWithInt:0],@"playerId", nil]];
    [markersArray addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithFloat:363.250000],@"X",[NSNumber numberWithFloat:(177.500000)],@"Y",[NSNumber numberWithInt:0],@"playerId", nil]];
    [markersArray addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithFloat:426.000000],@"X",[NSNumber numberWithFloat:(212.750000)],@"Y",[NSNumber numberWithInt:0],@"playerId", nil]];
    [markersArray addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithFloat:241.000000],@"X",[NSNumber numberWithFloat:(179.750000)],@"Y",[NSNumber numberWithInt:0],@"playerId", nil]];
    [markersArray addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithFloat:303.000000],@"X",[NSNumber numberWithFloat:(213.500000)],@"Y",[NSNumber numberWithInt:0],@"playerId", nil]];
    [markersArray addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithFloat:364.500000],@"X",[NSNumber numberWithFloat:(248.750000)],@"Y",[NSNumber numberWithInt:0],@"playerId", nil]];
    [markersArray addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithFloat:426.250000],@"X",[NSNumber numberWithFloat:(283.250000)],@"Y",[NSNumber numberWithInt:0],@"playerId", nil]];
    
    
    
    
    
    [markersArray addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithFloat:305.250000],@"X",[NSNumber numberWithFloat:(428.750000)],@"Y",[NSNumber numberWithInt:1],@"playerId", nil]];
    [markersArray addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithFloat:366.000000],@"X",[NSNumber numberWithFloat:(391.250000)],@"Y",[NSNumber numberWithInt:1],@"playerId", nil]];
    [markersArray addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithFloat:427.500000],@"X",[NSNumber numberWithFloat:(354.500000)],@"Y",[NSNumber numberWithInt:1],@"playerId", nil]];
    [markersArray addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithFloat:242.250000],@"X",[NSNumber numberWithFloat:(394.250000)],@"Y",[NSNumber numberWithInt:1],@"playerId", nil]];
    [markersArray addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithFloat:303.750000],@"X",[NSNumber numberWithFloat:(356.750000)],@"Y",[NSNumber numberWithInt:1],@"playerId", nil]];
    [markersArray addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithFloat:365.500000],@"X",[NSNumber numberWithFloat:(320.000000)],@"Y",[NSNumber numberWithInt:1],@"playerId", nil]];
    [markersArray addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithFloat:303.250000],@"X",[NSNumber numberWithFloat:(284.750000)],@"Y",[NSNumber numberWithInt:1],@"playerId", nil]];
    [markersArray addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithFloat:241.500000],@"X",[NSNumber numberWithFloat:(250.250000)],@"Y",[NSNumber numberWithInt:1],@"playerId", nil]];
    
    
    
    
    [markersArray addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithFloat:181.500000],@"X",[NSNumber numberWithFloat:(430.250000)],@"Y",[NSNumber numberWithInt:2],@"playerId", nil]];
    [markersArray addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithFloat:119.250000],@"X",[NSNumber numberWithFloat:(395.750000)],@"Y",[NSNumber numberWithInt:2],@"playerId", nil]];
    [markersArray addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithFloat:57.750000],@"X",[NSNumber numberWithFloat:(359.000000)],@"Y",[NSNumber numberWithInt:2],@"playerId", nil]];
    [markersArray addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithFloat:118.500000],@"X",[NSNumber numberWithFloat:(323.750000)],@"Y",[NSNumber numberWithInt:2],@"playerId", nil]];
    [markersArray addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithFloat:57.000000],@"X",[NSNumber numberWithFloat:(288.500000)],@"Y",[NSNumber numberWithInt:2],@"playerId", nil]];
    [markersArray addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithFloat:180.250000],@"X",[NSNumber numberWithFloat:(358.250000)],@"Y",[NSNumber numberWithInt:2],@"playerId", nil]];
    [markersArray addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithFloat:56.500000],@"X",[NSNumber numberWithFloat:(217.250000)],@"Y",[NSNumber numberWithInt:2],@"playerId", nil]];
    
    
    
    [markersArray addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithFloat:177.750000],@"X",[NSNumber numberWithFloat:(74.000000)],@"Y",[NSNumber numberWithInt:3],@"playerId", nil]];
    [markersArray addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithFloat:238.500000],@"X",[NSNumber numberWithFloat:(38.000000)],@"Y",[NSNumber numberWithInt:3],@"playerId", nil]];
    [markersArray addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithFloat:239.500000],@"X",[NSNumber numberWithFloat:(109.250000)],@"Y",[NSNumber numberWithInt:3],@"playerId", nil]];
    [markersArray addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithFloat:178.500000],@"X",[NSNumber numberWithFloat:(145.250000)],@"Y",[NSNumber numberWithInt:3],@"playerId", nil]];
    [markersArray addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithFloat:179.500000],@"X",[NSNumber numberWithFloat:(216.500000)],@"Y",[NSNumber numberWithInt:3],@"playerId", nil]];
    [markersArray addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithFloat:117.750000],@"X",[NSNumber numberWithFloat:(110.750000)],@"Y",[NSNumber numberWithInt:3],@"playerId", nil]];
    
    
    [dict setObject:markersArray forKey:@"markers"];
    
    
    // ================= buildings
    
    
    NSMutableArray *buildingsMainArray = [[NSMutableArray alloc] init];
    NSMutableArray *buildingsArray = [[NSMutableArray alloc] init];
    
    
    NSString *tower = @"-n Tower -a 1.jpg";
    NSString *keep = @"-n Keep -a 2.jpg";
    NSString *castle = @"-n Castle -a 3.jpg";
    NSString *citadel = @"-n Citadel -a 4.jpg";
    
    
    
    NSMutableDictionary *dictBuilding1 = [[NSMutableDictionary alloc] init];
    [dictBuilding1 setObject:[NSNumber numberWithFloat:303.250000] forKey:@"X"];
    [dictBuilding1 setObject:[NSNumber numberWithFloat:284.750000] forKey:@"Y"];
    [dictBuilding1 setObject:tower forKey:@"imageName"];
    [buildingsArray addObject:dictBuilding1];
    
    
    dictBuilding1 = [[NSMutableDictionary alloc] init];
    [dictBuilding1 setObject:[NSNumber numberWithFloat:303.000000] forKey:@"X"];
    [dictBuilding1 setObject:[NSNumber numberWithFloat:213.500000] forKey:@"Y"];
    [dictBuilding1 setObject:tower forKey:@"imageName"];
    [buildingsArray addObject:dictBuilding1];
    
    dictBuilding1 = [[NSMutableDictionary alloc] init];
    [dictBuilding1 setObject:[NSNumber numberWithFloat:177.750000] forKey:@"X"];
    [dictBuilding1 setObject:[NSNumber numberWithFloat:74.000000] forKey:@"Y"];
    [dictBuilding1 setObject:keep forKey:@"imageName"];
    [buildingsArray addObject:dictBuilding1];
    
    dictBuilding1 = [[NSMutableDictionary alloc] init];
    [dictBuilding1 setObject:[NSNumber numberWithFloat:363.250000] forKey:@"X"];
    [dictBuilding1 setObject:[NSNumber numberWithFloat:177.500000] forKey:@"Y"];
    [dictBuilding1 setObject:keep forKey:@"imageName"];
    [buildingsArray addObject:dictBuilding1];
    
    dictBuilding1 = [[NSMutableDictionary alloc] init];
    [dictBuilding1 setObject:[NSNumber numberWithFloat:302.500000] forKey:@"X"];
    [dictBuilding1 setObject:[NSNumber numberWithFloat:143.750000] forKey:@"Y"];
    [dictBuilding1 setObject:castle forKey:@"imageName"];
    [buildingsArray addObject:dictBuilding1];
    
    dictBuilding1 = [[NSMutableDictionary alloc] init];
    [dictBuilding1 setObject:[NSNumber numberWithFloat:364.500000] forKey:@"X"];
    [dictBuilding1 setObject:[NSNumber numberWithFloat:248.750000] forKey:@"Y"];
    [dictBuilding1 setObject:keep forKey:@"imageName"];
    [buildingsArray addObject:dictBuilding1];
    
    dictBuilding1 = [[NSMutableDictionary alloc] init];
    [dictBuilding1 setObject:[NSNumber numberWithFloat:426.250000] forKey:@"X"];
    [dictBuilding1 setObject:[NSNumber numberWithFloat:283.250000] forKey:@"Y"];
    [dictBuilding1 setObject:keep forKey:@"imageName"];
    [buildingsArray addObject:dictBuilding1];
    
    dictBuilding1 = [[NSMutableDictionary alloc] init];
    [dictBuilding1 setObject:[NSNumber numberWithFloat:427.500000] forKey:@"X"];
    [dictBuilding1 setObject:[NSNumber numberWithFloat:354.500000] forKey:@"Y"];
    [dictBuilding1 setObject:castle forKey:@"imageName"];
    [buildingsArray addObject:dictBuilding1];
    
    dictBuilding1 = [[NSMutableDictionary alloc] init];
    [dictBuilding1 setObject:[NSNumber numberWithFloat:365.500000] forKey:@"X"];
    [dictBuilding1 setObject:[NSNumber numberWithFloat:320.000000] forKey:@"Y"];
    [dictBuilding1 setObject:tower forKey:@"imageName"];
    [buildingsArray addObject:dictBuilding1];
    
    dictBuilding1 = [[NSMutableDictionary alloc] init];
    [dictBuilding1 setObject:[NSNumber numberWithFloat:303.750000] forKey:@"X"];
    [dictBuilding1 setObject:[NSNumber numberWithFloat:356.750000] forKey:@"Y"];
    [dictBuilding1 setObject:castle forKey:@"imageName"];
    [buildingsArray addObject:dictBuilding1];
    
    
    
    dictBuilding1 = [[NSMutableDictionary alloc] init];
    [dictBuilding1 setObject:[NSNumber numberWithFloat:119.250000] forKey:@"X"];
    [dictBuilding1 setObject:[NSNumber numberWithFloat:395.750000] forKey:@"Y"];
    [dictBuilding1 setObject:castle forKey:@"imageName"];
    [buildingsArray addObject:dictBuilding1];
    
    dictBuilding1 = [[NSMutableDictionary alloc] init];
    [dictBuilding1 setObject:[NSNumber numberWithFloat:57.750000] forKey:@"X"];
    [dictBuilding1 setObject:[NSNumber numberWithFloat:359.000000] forKey:@"Y"];
    [dictBuilding1 setObject:keep forKey:@"imageName"];
    [buildingsArray addObject:dictBuilding1];
    
    
    dictBuilding1 = [[NSMutableDictionary alloc] init];
    [dictBuilding1 setObject:[NSNumber numberWithFloat:118.500000] forKey:@"X"];
    [dictBuilding1 setObject:[NSNumber numberWithFloat:323.750000] forKey:@"Y"];
    [dictBuilding1 setObject:tower forKey:@"imageName"];
    [buildingsArray addObject:dictBuilding1];
    
    dictBuilding1 = [[NSMutableDictionary alloc] init];
    [dictBuilding1 setObject:[NSNumber numberWithFloat:241.500000] forKey:@"X"];
    [dictBuilding1 setObject:[NSNumber numberWithFloat:250.250000] forKey:@"Y"];
    [dictBuilding1 setObject:keep forKey:@"imageName"];
    [buildingsArray addObject:dictBuilding1];
    
    
    [buildingsMainArray addObject:buildingsArray];
    
    [dict setObject:buildingsMainArray forKey:@"buildings"];
    
    
    
    
    //==================== armies
    
    NSArray *playerOneCreatures = @[@"-n Crocodiles -t Jungle -a 2",@"-n Mountain Men -c 2 -t Mountain -a 1", @"-n Nomads -c 2 -t Desert -a 1",@"-n Giant Spider -t Desert -a 1",@"-n Killer Racoon -t Forest -a 2",@"-n Farmers -c 4 -t Plains -a 1", @"-n Ice Giant -t Frozen Waste -s Range -a 5",@"-n White Dragon -t Frozen Waste -s Magic -a 5",@"-n Mammoth -t Frozen Waste -s Charge -a 5",@"-n Head Hunter -t Jungle -s Range -a 2"];
    
    NSMutableArray *armiesMainArray = [[NSMutableArray alloc] init];
    
    NSMutableDictionary *dict1 = [[NSMutableDictionary alloc] init];
    
    [dict1 setObject:[NSNumber numberWithFloat:303.000000] forKey:@"X"];
    [dict1 setObject:[NSNumber numberWithFloat:213.500000] forKey:@"Y"];
    [dict1 setObject:[NSNumber numberWithInt:0] forKey:@"playerId"];
    
    NSMutableArray *creaturesArray = [[NSMutableArray alloc] init];
    NSMutableArray *armiesArray = [[NSMutableArray alloc] init];
    
    NSMutableDictionary *creaturesDictionary = [[NSMutableDictionary alloc] init];
    
    for (NSString *stringC in playerOneCreatures) {
        
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [dict setObject:[NSNumber numberWithFloat:303.000000] forKey:@"X"];
        [dict setObject:[NSNumber numberWithFloat:213.500000] forKey:@"Y"];
        [dict setObject:stringC forKey:@"imageName"];
        [dict setObject:[NSNumber numberWithInt:NO] forKey:@"si"];
        
        [armiesArray addObject:dict];
    }
    [creaturesDictionary setObject:armiesArray forKey:@"creatures"];
    [creaturesDictionary setObject:[NSNumber numberWithFloat:303.000000] forKey:@"X"];
    [creaturesDictionary setObject:[NSNumber numberWithFloat:213.500000] forKey:@"Y"];
    
    [creaturesArray addObject:creaturesDictionary];
    
    [dict1 setObject:creaturesArray forKey:@"armies"];
    
    [armiesMainArray addObject:dict1];
    
    [dict setObject:armiesMainArray forKey:@"stacks"];
    
    
    
    //==== stack 2
    
    NSArray *playerTwoCreatures = @[@"-n Thing -t Swamp -a 2",@"-n Giant Lizard -c 2 -t Swamp -a 2", @"-n Swamp Rat -t Swamp -a 1", @"-n Unicorn -t Forest -a 4",@"-n Bears -t Forest -a 2",@"-n Camel Corps -t Desert -a 3", @"-n Sandworm -t Desert -a 3", @"-n Black Knight -t Swamp -s Charge -a 3", @"-n Dervish -c 2 -t Desert -s Magic -a 2",@"-n Forester -t Forest -s Range -a 2"];
    
    
    NSMutableDictionary *dict2 = [[NSMutableDictionary alloc] init];
    
    [dict2 setObject:[NSNumber numberWithFloat:303.250000] forKey:@"X"];
    [dict2 setObject:[NSNumber numberWithFloat:284.750000] forKey:@"Y"];
    [dict2 setObject:[NSNumber numberWithInt:1] forKey:@"playerId"];
    
    NSMutableArray *creatures2Array = [[NSMutableArray alloc] init];
    NSMutableArray *armies2Array = [[NSMutableArray alloc] init];
    
    NSMutableDictionary *creatures2Dictionary = [[NSMutableDictionary alloc] init];
    
    for (NSString *stringC in playerTwoCreatures) {
        
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [dict setObject:[NSNumber numberWithFloat:303.250000] forKey:@"X"];
        [dict setObject:[NSNumber numberWithFloat:284.750000] forKey:@"Y"];
        [dict setObject:stringC forKey:@"imageName"];
        [dict setObject:[NSNumber numberWithInt:NO] forKey:@"si"];
        
        [armies2Array addObject:dict];
    }
    [creatures2Dictionary setObject:armies2Array forKey:@"creatures"];
    [creatures2Dictionary setObject:[NSNumber numberWithFloat:303.250000] forKey:@"X"];
    [creatures2Dictionary setObject:[NSNumber numberWithFloat:284.750000] forKey:@"Y"];
    
    [creatures2Array addObject:creatures2Dictionary];
    
    [dict2 setObject:creatures2Array forKey:@"armies"];
    
    [armiesMainArray addObject:dict2];
    
    [dict setObject:armiesMainArray forKey:@"stacks"];
    
    
    
    
    // === rack
    
    NSMutableArray *rackMainArray = [[NSMutableArray alloc] init];
    NSArray *playerOneSI = @[@"-n Diamond Field -t Desert -a 1", @"-n Peat Bog -t Swamp -a 1"];
    
    NSMutableDictionary* dict1Rack = [[NSMutableDictionary alloc] init];
    
    [dict1Rack setObject:[NSNumber numberWithFloat:303.250000] forKey:@"X"];
    [dict1Rack setObject:[NSNumber numberWithFloat:284.750000] forKey:@"Y"];
    [dict1Rack setObject:[NSNumber numberWithInt:0] forKey:@"playerId"];
    
    NSMutableArray* armies1RackArray = [[NSMutableArray alloc] init];
    
    
    for (NSString *stringC in playerOneSI) {
        
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [dict setObject:[NSNumber numberWithFloat:303.250000] forKey:@"X"];
        [dict setObject:[NSNumber numberWithFloat:284.750000] forKey:@"Y"];
        [dict setObject:stringC forKey:@"imageName"];
        [dict setObject:[NSNumber numberWithInt:YES] forKey:@"si"];
        
        [armies1RackArray addObject:dict];
    }
    
    [dict1Rack setObject:armies1RackArray forKey:@"armies"];
    
    [rackMainArray addObject:dict1Rack];
    
    
    
    
    NSArray *playerTwoSI = @[@"-n Copper Mine -t Mountain -a 1",@"-n Gold Mine -t Mountain -a 3",@"-n Ruby -t Treasure -a 10.jpg"];

    
    NSMutableDictionary* dict2Rack = [[NSMutableDictionary alloc] init];
    
    [dict2Rack setObject:[NSNumber numberWithFloat:303.250000] forKey:@"X"];
    [dict2Rack setObject:[NSNumber numberWithFloat:284.750000] forKey:@"Y"];
    [dict2Rack setObject:[NSNumber numberWithInt:1] forKey:@"playerId"];
    
    NSMutableArray* armies2RackArray = [[NSMutableArray alloc] init];
    
    
    for (NSString *stringC in playerTwoSI) {
        
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [dict setObject:[NSNumber numberWithFloat:303.250000] forKey:@"X"];
        [dict setObject:[NSNumber numberWithFloat:284.750000] forKey:@"Y"];
        [dict setObject:stringC forKey:@"imageName"];
        [dict setObject:[NSNumber numberWithInt:YES] forKey:@"si"];
        
        [armies2RackArray addObject:dict];
    }
    
    [dict2Rack setObject:armies2RackArray forKey:@"armies"];
    [rackMainArray addObject:dict2Rack];
    
    
    [dict setObject:rackMainArray forKey:@"racks"];
    
    // ============= special income counters
    
    
    NSString *village = @"-n Village -a 1.jpg";
    NSString *city = @"-n City -a 2.jpg";
    
    NSMutableDictionary* sicDictionary = [[NSMutableDictionary alloc] init];
    
    [sicDictionary setObject:[NSNumber numberWithInt:-1] forKey:@"playerId"];
    
    NSMutableArray* sicArray = [[NSMutableArray alloc] init];
    NSMutableArray* countersArray = [[NSMutableArray alloc] init];
    
    
    NSMutableDictionary *dictCounter = [[NSMutableDictionary alloc] init];
    [dictCounter setObject:[NSNumber numberWithFloat:426.000000] forKey:@"X"];
    [dictCounter setObject:[NSNumber numberWithFloat:212.750000] forKey:@"Y"];
    [dictCounter setObject:village forKey:@"imageName"];
    [countersArray addObject:dictCounter];
    
    
    dictCounter = [[NSMutableDictionary alloc] init];
    [dictCounter setObject:[NSNumber numberWithFloat:305.250000] forKey:@"X"];
    [dictCounter setObject:[NSNumber numberWithFloat:428.750000] forKey:@"Y"];
    [dictCounter setObject:village forKey:@"imageName"];
    [countersArray addObject:dictCounter];
    
    
    dictCounter = [[NSMutableDictionary alloc] init];
    [dictCounter setObject:[NSNumber numberWithFloat:117.750000] forKey:@"X"];
    [dictCounter setObject:[NSNumber numberWithFloat:110.750000] forKey:@"Y"];
    [dictCounter setObject:city forKey:@"imageName"];
    [countersArray addObject:dictCounter];
    
    
    dictCounter = [[NSMutableDictionary alloc] init];
    [dictCounter setObject:[NSNumber numberWithFloat:57.000000] forKey:@"X"];
    [dictCounter setObject:[NSNumber numberWithFloat:288.500000] forKey:@"Y"];
    [dictCounter setObject:village forKey:@"imageName"];
    [countersArray addObject:dictCounter];
    
    [sicDictionary setObject:countersArray forKey:@"counters"];
    [sicArray addObject:sicDictionary];
    [dict setObject:sicArray forKey:@"sics"];
    
    
    
    //sets phase to gold collection
    [dict setObject:[NSNumber numberWithInt:6] forKey:@"phase"];
    
    
    NSMutableArray* arraySettings = [[NSMutableArray alloc] init];
    
    for (int i = 0; i <= 3; i++) {
        
        NSMutableDictionary *playerDict = [[NSMutableDictionary alloc] init];
        [playerDict setObject:[NSNumber numberWithInt:i] forKey:@"playerId"];
        [playerDict setObject:[NSNumber numberWithInt:0] forKey:@"recruitsRemaining"];
        [playerDict setObject:[NSNumber numberWithInt:0] forKey:@"specialRecruitsRemaining"];
        [arraySettings addObject:playerDict];
    }
    
    [dict setObject:arraySettings forKey:@"user-settings"];
    
    
    
    return [NSKeyedArchiver archivedDataWithRootObject:dict];
    
}


- (NSData *) getHardCodedV2Elements{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    
    //==================== markers
    
    
    NSMutableArray *markersArray = [[NSMutableArray alloc] init];
    
    
    
    [markersArray addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithFloat:363.000000],@"X",[NSNumber numberWithFloat:(106.250000)],@"Y",[NSNumber numberWithInt:0],@"playerId", nil]];
    [markersArray addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithFloat:301.000000],@"X",[NSNumber numberWithFloat:(72.500000)],@"Y",[NSNumber numberWithInt:0],@"playerId", nil]];
    [markersArray addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithFloat:424.750000],@"X",[NSNumber numberWithFloat:(141.500000)],@"Y",[NSNumber numberWithInt:0],@"playerId", nil]];
    [markersArray addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithFloat:302.500000],@"X",[NSNumber numberWithFloat:(143.750000)],@"Y",[NSNumber numberWithInt:0],@"playerId", nil]];
    [markersArray addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithFloat:363.250000],@"X",[NSNumber numberWithFloat:(177.500000)],@"Y",[NSNumber numberWithInt:0],@"playerId", nil]];
    [markersArray addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithFloat:426.000000],@"X",[NSNumber numberWithFloat:(212.750000)],@"Y",[NSNumber numberWithInt:0],@"playerId", nil]];
    [markersArray addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithFloat:241.000000],@"X",[NSNumber numberWithFloat:(179.750000)],@"Y",[NSNumber numberWithInt:0],@"playerId", nil]];
    [markersArray addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithFloat:303.000000],@"X",[NSNumber numberWithFloat:(213.500000)],@"Y",[NSNumber numberWithInt:0],@"playerId", nil]];
    [markersArray addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithFloat:364.500000],@"X",[NSNumber numberWithFloat:(248.750000)],@"Y",[NSNumber numberWithInt:0],@"playerId", nil]];
    [markersArray addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithFloat:426.250000],@"X",[NSNumber numberWithFloat:(283.250000)],@"Y",[NSNumber numberWithInt:0],@"playerId", nil]];
    
    
    
    
    
    [markersArray addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithFloat:305.250000],@"X",[NSNumber numberWithFloat:(428.750000)],@"Y",[NSNumber numberWithInt:1],@"playerId", nil]];
    [markersArray addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithFloat:366.000000],@"X",[NSNumber numberWithFloat:(391.250000)],@"Y",[NSNumber numberWithInt:1],@"playerId", nil]];
    [markersArray addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithFloat:427.500000],@"X",[NSNumber numberWithFloat:(354.500000)],@"Y",[NSNumber numberWithInt:1],@"playerId", nil]];
    [markersArray addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithFloat:242.250000],@"X",[NSNumber numberWithFloat:(394.250000)],@"Y",[NSNumber numberWithInt:1],@"playerId", nil]];
    [markersArray addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithFloat:303.750000],@"X",[NSNumber numberWithFloat:(356.750000)],@"Y",[NSNumber numberWithInt:1],@"playerId", nil]];
    [markersArray addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithFloat:365.500000],@"X",[NSNumber numberWithFloat:(320.000000)],@"Y",[NSNumber numberWithInt:1],@"playerId", nil]];
    [markersArray addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithFloat:303.250000],@"X",[NSNumber numberWithFloat:(284.750000)],@"Y",[NSNumber numberWithInt:1],@"playerId", nil]];
    [markersArray addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithFloat:241.500000],@"X",[NSNumber numberWithFloat:(250.250000)],@"Y",[NSNumber numberWithInt:1],@"playerId", nil]];
    
    
    
    
    [markersArray addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithFloat:181.500000],@"X",[NSNumber numberWithFloat:(430.250000)],@"Y",[NSNumber numberWithInt:2],@"playerId", nil]];
    [markersArray addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithFloat:119.250000],@"X",[NSNumber numberWithFloat:(395.750000)],@"Y",[NSNumber numberWithInt:2],@"playerId", nil]];
    [markersArray addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithFloat:57.750000],@"X",[NSNumber numberWithFloat:(359.000000)],@"Y",[NSNumber numberWithInt:2],@"playerId", nil]];
    [markersArray addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithFloat:118.500000],@"X",[NSNumber numberWithFloat:(323.750000)],@"Y",[NSNumber numberWithInt:2],@"playerId", nil]];
    [markersArray addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithFloat:57.000000],@"X",[NSNumber numberWithFloat:(288.500000)],@"Y",[NSNumber numberWithInt:2],@"playerId", nil]];
    [markersArray addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithFloat:180.250000],@"X",[NSNumber numberWithFloat:(358.250000)],@"Y",[NSNumber numberWithInt:2],@"playerId", nil]];
    [markersArray addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithFloat:56.500000],@"X",[NSNumber numberWithFloat:(217.250000)],@"Y",[NSNumber numberWithInt:2],@"playerId", nil]];
    
    
    
    [markersArray addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithFloat:177.750000],@"X",[NSNumber numberWithFloat:(74.000000)],@"Y",[NSNumber numberWithInt:3],@"playerId", nil]];
    [markersArray addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithFloat:238.500000],@"X",[NSNumber numberWithFloat:(38.000000)],@"Y",[NSNumber numberWithInt:3],@"playerId", nil]];
    [markersArray addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithFloat:239.500000],@"X",[NSNumber numberWithFloat:(109.250000)],@"Y",[NSNumber numberWithInt:3],@"playerId", nil]];
    [markersArray addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithFloat:178.500000],@"X",[NSNumber numberWithFloat:(145.250000)],@"Y",[NSNumber numberWithInt:3],@"playerId", nil]];
    [markersArray addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithFloat:179.500000],@"X",[NSNumber numberWithFloat:(216.500000)],@"Y",[NSNumber numberWithInt:3],@"playerId", nil]];
    [markersArray addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithFloat:117.750000],@"X",[NSNumber numberWithFloat:(110.750000)],@"Y",[NSNumber numberWithInt:3],@"playerId", nil]];
    
    
    [dict setObject:markersArray forKey:@"markers"];
    
    
    // ================= buildings
    
    
    NSMutableArray *buildingsMainArray = [[NSMutableArray alloc] init];
    NSMutableArray *buildingsArray = [[NSMutableArray alloc] init];
    
    
    NSString *tower = @"-n Tower -a 1.jpg";
    NSString *keep = @"-n Keep -a 2.jpg";
    NSString *castle = @"-n Castle -a 3.jpg";
    NSString *citadel = @"-n Citadel -a 4.jpg";
    
    
    
    NSMutableDictionary *dictBuilding1 = [[NSMutableDictionary alloc] init];
    [dictBuilding1 setObject:[NSNumber numberWithFloat:303.250000] forKey:@"X"];
    [dictBuilding1 setObject:[NSNumber numberWithFloat:284.750000] forKey:@"Y"];
    [dictBuilding1 setObject:tower forKey:@"imageName"];
    [buildingsArray addObject:dictBuilding1];
    
    
    dictBuilding1 = [[NSMutableDictionary alloc] init];
    [dictBuilding1 setObject:[NSNumber numberWithFloat:303.000000] forKey:@"X"];
    [dictBuilding1 setObject:[NSNumber numberWithFloat:213.500000] forKey:@"Y"];
    [dictBuilding1 setObject:tower forKey:@"imageName"];
    [buildingsArray addObject:dictBuilding1];
    
    dictBuilding1 = [[NSMutableDictionary alloc] init];
    [dictBuilding1 setObject:[NSNumber numberWithFloat:177.750000] forKey:@"X"];
    [dictBuilding1 setObject:[NSNumber numberWithFloat:74.000000] forKey:@"Y"];
    [dictBuilding1 setObject:keep forKey:@"imageName"];
    [buildingsArray addObject:dictBuilding1];
    
    dictBuilding1 = [[NSMutableDictionary alloc] init];
    [dictBuilding1 setObject:[NSNumber numberWithFloat:363.250000] forKey:@"X"];
    [dictBuilding1 setObject:[NSNumber numberWithFloat:177.500000] forKey:@"Y"];
    [dictBuilding1 setObject:keep forKey:@"imageName"];
    [buildingsArray addObject:dictBuilding1];
    
    dictBuilding1 = [[NSMutableDictionary alloc] init];
    [dictBuilding1 setObject:[NSNumber numberWithFloat:302.500000] forKey:@"X"];
    [dictBuilding1 setObject:[NSNumber numberWithFloat:143.750000] forKey:@"Y"];
    [dictBuilding1 setObject:castle forKey:@"imageName"];
    [buildingsArray addObject:dictBuilding1];
    
    dictBuilding1 = [[NSMutableDictionary alloc] init];
    [dictBuilding1 setObject:[NSNumber numberWithFloat:364.500000] forKey:@"X"];
    [dictBuilding1 setObject:[NSNumber numberWithFloat:248.750000] forKey:@"Y"];
    [dictBuilding1 setObject:keep forKey:@"imageName"];
    [buildingsArray addObject:dictBuilding1];
    
    dictBuilding1 = [[NSMutableDictionary alloc] init];
    [dictBuilding1 setObject:[NSNumber numberWithFloat:426.250000] forKey:@"X"];
    [dictBuilding1 setObject:[NSNumber numberWithFloat:283.250000] forKey:@"Y"];
    [dictBuilding1 setObject:keep forKey:@"imageName"];
    [buildingsArray addObject:dictBuilding1];
    
    dictBuilding1 = [[NSMutableDictionary alloc] init];
    [dictBuilding1 setObject:[NSNumber numberWithFloat:427.500000] forKey:@"X"];
    [dictBuilding1 setObject:[NSNumber numberWithFloat:354.500000] forKey:@"Y"];
    [dictBuilding1 setObject:castle forKey:@"imageName"];
    [buildingsArray addObject:dictBuilding1];
    
    dictBuilding1 = [[NSMutableDictionary alloc] init];
    [dictBuilding1 setObject:[NSNumber numberWithFloat:365.500000] forKey:@"X"];
    [dictBuilding1 setObject:[NSNumber numberWithFloat:320.000000] forKey:@"Y"];
    [dictBuilding1 setObject:tower forKey:@"imageName"];
    [buildingsArray addObject:dictBuilding1];
    
    dictBuilding1 = [[NSMutableDictionary alloc] init];
    [dictBuilding1 setObject:[NSNumber numberWithFloat:303.750000] forKey:@"X"];
    [dictBuilding1 setObject:[NSNumber numberWithFloat:356.750000] forKey:@"Y"];
    [dictBuilding1 setObject:castle forKey:@"imageName"];
    [buildingsArray addObject:dictBuilding1];
    
    
    
    dictBuilding1 = [[NSMutableDictionary alloc] init];
    [dictBuilding1 setObject:[NSNumber numberWithFloat:119.250000] forKey:@"X"];
    [dictBuilding1 setObject:[NSNumber numberWithFloat:395.750000] forKey:@"Y"];
    [dictBuilding1 setObject:castle forKey:@"imageName"];
    [buildingsArray addObject:dictBuilding1];
    
    dictBuilding1 = [[NSMutableDictionary alloc] init];
    [dictBuilding1 setObject:[NSNumber numberWithFloat:57.750000] forKey:@"X"];
    [dictBuilding1 setObject:[NSNumber numberWithFloat:359.000000] forKey:@"Y"];
    [dictBuilding1 setObject:keep forKey:@"imageName"];
    [buildingsArray addObject:dictBuilding1];
    
    
    dictBuilding1 = [[NSMutableDictionary alloc] init];
    [dictBuilding1 setObject:[NSNumber numberWithFloat:118.500000] forKey:@"X"];
    [dictBuilding1 setObject:[NSNumber numberWithFloat:323.750000] forKey:@"Y"];
    [dictBuilding1 setObject:tower forKey:@"imageName"];
    [buildingsArray addObject:dictBuilding1];
    
    dictBuilding1 = [[NSMutableDictionary alloc] init];
    [dictBuilding1 setObject:[NSNumber numberWithFloat:241.500000] forKey:@"X"];
    [dictBuilding1 setObject:[NSNumber numberWithFloat:250.250000] forKey:@"Y"];
    [dictBuilding1 setObject:keep forKey:@"imageName"];
    [buildingsArray addObject:dictBuilding1];
    
    
    [buildingsMainArray addObject:buildingsArray];
    
    [dict setObject:buildingsMainArray forKey:@"buildings"];
    
    
    
    
    //==================== armies
    
    NSArray *playerOneCreatures = @[@"-n Crocodiles -t Swamp -a 2",@"-n Giant Lizard -c 2 -t Swamp -a 2", @"-n Swamp Beast -t Swamp -a 3",@"-n Mountain Men -c 2 -t Mountain -a 1", @"-n Killer Racoon -t Forest -a 2",@"-n Wild Cat -t Forest -a 2", @"-n Dryad -t Forest -s Magic -a 1"];
    
    NSMutableArray *armiesMainArray = [[NSMutableArray alloc] init];
    
    NSMutableDictionary *dict1 = [[NSMutableDictionary alloc] init];
    
    [dict1 setObject:[NSNumber numberWithFloat:303.000000] forKey:@"X"];
    [dict1 setObject:[NSNumber numberWithFloat:213.500000] forKey:@"Y"];
    [dict1 setObject:[NSNumber numberWithInt:0] forKey:@"playerId"];
    
    NSMutableArray *creaturesArray = [[NSMutableArray alloc] init];
    NSMutableArray *armiesArray = [[NSMutableArray alloc] init];
    
    NSMutableDictionary *creaturesDictionary = [[NSMutableDictionary alloc] init];
    
    for (NSString *stringC in playerOneCreatures) {
        
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [dict setObject:[NSNumber numberWithFloat:303.000000] forKey:@"X"];
        [dict setObject:[NSNumber numberWithFloat:213.500000] forKey:@"Y"];
        [dict setObject:stringC forKey:@"imageName"];
        [dict setObject:[NSNumber numberWithInt:NO] forKey:@"si"];
        
        [armiesArray addObject:dict];
    }
    [creaturesDictionary setObject:armiesArray forKey:@"creatures"];
    [creaturesDictionary setObject:[NSNumber numberWithFloat:303.000000] forKey:@"X"];
    [creaturesDictionary setObject:[NSNumber numberWithFloat:213.500000] forKey:@"Y"];
    
    [creaturesArray addObject:creaturesDictionary];
    
    [dict1 setObject:creaturesArray forKey:@"armies"];
    
    [armiesMainArray addObject:dict1];
    
    [dict setObject:armiesMainArray forKey:@"stacks"];
    
    
    
    //==== stack 2
    
    NSArray *playerTwoCreatures = @[@"-n Thing -t Swamp -a 2",@"-n Giant Lizard -c 2 -t Swamp -a 2",@"-n Swamp Rat -t Swamp -a 1", @"-n Crocodiles -t Swamp -a 2",@"-n Unicorn -t Forest -a 4",@"-n Bears -t Forest -a 2",@"-n Giant Spider -t Desert -a 1",@"-n Camel Corps -t Desert -a 3",@"-n Sandworm -t Desert -a 3"];
    
    
    NSMutableDictionary *dict2 = [[NSMutableDictionary alloc] init];
    
    [dict2 setObject:[NSNumber numberWithFloat:303.250000] forKey:@"X"];
    [dict2 setObject:[NSNumber numberWithFloat:284.750000] forKey:@"Y"];
    [dict2 setObject:[NSNumber numberWithInt:1] forKey:@"playerId"];
    
    NSMutableArray *creatures2Array = [[NSMutableArray alloc] init];
    NSMutableArray *armies2Array = [[NSMutableArray alloc] init];
    
    NSMutableDictionary *creatures2Dictionary = [[NSMutableDictionary alloc] init];
    
    int creatureId = 0;
    
    for (NSString *stringC in playerTwoCreatures) {
        
        
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [dict setObject:[NSNumber numberWithFloat:303.250000] forKey:@"X"];
        [dict setObject:[NSNumber numberWithFloat:284.750000] forKey:@"Y"];
        [dict setObject:stringC forKey:@"imageName"];
        [dict setObject:[NSNumber numberWithInt:NO] forKey:@"si"];
        
        if (creatureId == 2 || creatureId == 3) {
            [dict setObject:[NSNumber numberWithInt:YES] forKey:@"isBluff"];
        }
        else{
            [dict setObject:[NSNumber numberWithInt:NO] forKey:@"isBluff"];
        }
        
        
        creatureId++;
        [armies2Array addObject:dict];
    }
    [creatures2Dictionary setObject:armies2Array forKey:@"creatures"];
    [creatures2Dictionary setObject:[NSNumber numberWithFloat:303.250000] forKey:@"X"];
    [creatures2Dictionary setObject:[NSNumber numberWithFloat:284.750000] forKey:@"Y"];
    
    [creatures2Array addObject:creatures2Dictionary];
    
    [dict2 setObject:creatures2Array forKey:@"armies"];
    
    [armiesMainArray addObject:dict2];
    
    [dict setObject:armiesMainArray forKey:@"stacks"];
    
    
    
    
    // === rack
    
    NSMutableArray *rackMainArray = [[NSMutableArray alloc] init];
    NSArray *playerOneSI = @[@"-n Diamond Field -t Desert -a 1", @"-n Peat Bog -t Swamp -a 1"];
    
    NSMutableDictionary* dict1Rack = [[NSMutableDictionary alloc] init];
    
    [dict1Rack setObject:[NSNumber numberWithFloat:303.250000] forKey:@"X"];
    [dict1Rack setObject:[NSNumber numberWithFloat:284.750000] forKey:@"Y"];
    [dict1Rack setObject:[NSNumber numberWithInt:0] forKey:@"playerId"];
    
    NSMutableArray* armies1RackArray = [[NSMutableArray alloc] init];
    
    
    for (NSString *stringC in playerOneSI) {
        
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [dict setObject:[NSNumber numberWithFloat:303.250000] forKey:@"X"];
        [dict setObject:[NSNumber numberWithFloat:284.750000] forKey:@"Y"];
        [dict setObject:stringC forKey:@"imageName"];
        [dict setObject:[NSNumber numberWithInt:YES] forKey:@"si"];
        
        [armies1RackArray addObject:dict];
    }
    
    [dict1Rack setObject:armies1RackArray forKey:@"armies"];
    
    [rackMainArray addObject:dict1Rack];
    
    
    
    
    NSArray *playerTwoSI = @[@"-n Copper Mine -t Mountain -a 1",@"-n Gold Mine -t Mountain -a 3",@"-n Ruby -t Treasure -a 10.jpg"];
    
    
    NSMutableDictionary* dict2Rack = [[NSMutableDictionary alloc] init];
    
    [dict2Rack setObject:[NSNumber numberWithFloat:303.250000] forKey:@"X"];
    [dict2Rack setObject:[NSNumber numberWithFloat:284.750000] forKey:@"Y"];
    [dict2Rack setObject:[NSNumber numberWithInt:1] forKey:@"playerId"];
    
    NSMutableArray* armies2RackArray = [[NSMutableArray alloc] init];
    
    
    for (NSString *stringC in playerTwoSI) {
        
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [dict setObject:[NSNumber numberWithFloat:303.250000] forKey:@"X"];
        [dict setObject:[NSNumber numberWithFloat:284.750000] forKey:@"Y"];
        [dict setObject:stringC forKey:@"imageName"];
        [dict setObject:[NSNumber numberWithInt:YES] forKey:@"si"];
        
        [armies2RackArray addObject:dict];
    }
    
    [dict2Rack setObject:armies2RackArray forKey:@"armies"];
    [rackMainArray addObject:dict2Rack];
    
    
    [dict setObject:rackMainArray forKey:@"racks"];
    
    
    //sets phase to gold collection
    [dict setObject:[NSNumber numberWithInt:6] forKey:@"phase"];
    
    
    NSMutableArray* arraySettings = [[NSMutableArray alloc] init];
    
    for (int i = 0; i <= 3; i++) {
        
        NSMutableDictionary *playerDict = [[NSMutableDictionary alloc] init];
        [playerDict setObject:[NSNumber numberWithInt:i] forKey:@"playerId"];
        [playerDict setObject:[NSNumber numberWithInt:0] forKey:@"recruitsRemaining"];
        [playerDict setObject:[NSNumber numberWithInt:0] forKey:@"specialRecruitsRemaining"];
        [arraySettings addObject:playerDict];
    }
    
    [dict setObject:arraySettings forKey:@"user-settings"];
    
    
    
    return [NSKeyedArchiver archivedDataWithRootObject:dict];
    
}


-(id)initWithSize:(CGSize)size andSender:(GameScene *) s forView:(ViewController *) v {
    if (self = [super initWithSize:size]) {
        sender = s;
        view = v;
        SKSpriteNode *background = [[SKSpriteNode alloc]initWithImageNamed:@"combat.jpg"];
        background.anchorPoint = CGPointZero;
        background.position = CGPointMake(0,0);
        background.size = size;
        [background setColorBlendFactor:0.7];
        self.backgroundColor = [SKColor blackColor];
        
        [self addChild:background];
        
        SKLabelNode *lblTitle = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        lblTitle.text = @"Please choose a version below to run:";
        lblTitle.fontSize = 20;
        lblTitle.position = CGPointMake(381,576);
        [self addChild:lblTitle];
        
        
        SKLabelNode *lblV1 = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        lblV1.name = @"v2";
        lblV1.text = @"Predefined Board 1";
        lblV1.fontSize = 20;
        lblV1.position = CGPointMake(166,448);
        [self addChild:lblV1];
        
        SKLabelNode *lblV2 = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        lblV2.name = @"v1";
        lblV2.text = @"Predefined Board 2";
        lblV2.fontSize = 20;
        lblV2.position = CGPointMake(556,448);
        [self addChild:lblV2];
        
        
        SKLabelNode *lblV3 = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        lblV3.name = @"v3";
        lblV3.text = @"Empty Board";
        lblV3.fontSize = 20;
        lblV3.position = CGPointMake(366,378);
        [self addChild:lblV3];
        
    }
    return self;
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint positionInScene = [touch locationInNode:self];
    SKSpriteNode *touchedNode = (SKSpriteNode *)[self nodeAtPoint:positionInScene];
    
    
    if ([touchedNode.name isEqualToString:@"v1"]){
        [view processData: [self getHardCodedElements]];
        [self.scene.view presentScene:sender];
    }
    else if ([touchedNode.name isEqualToString:@"v2"]){
        [view processData: [self getHardCodedV2Elements]];
        [self.scene.view presentScene:sender];
    }
    else if ([touchedNode.name isEqualToString:@"v3"]){
        [self.scene.view presentScene:sender];
        
    }
    
}

@end
