//
//  Player.m
//  KingsNThings
//
//  Created by Menan Vadivel on 1/28/2014.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import "Player.h"
#import "Creature.h"

@implementation Player{
    int income;
    int orderOfPlay;
    Stage stageOfBuilding;
    Bank* bank;
    
    //NSMutableArray* armies; // collection of armies
    //NSMutableArray* singleArmy; // single armies (eg stack one )
    NSMutableArray* armies;
    NSMutableArray* territories;
    NSMutableArray* specialCharacters;
    NSMutableArray* specialIncome;
    NSMutableArray* buildings;
    
    

}

@synthesize armies,singleArmy,playingOrder,p1Stack1,p1Stack2,p2Stack1,p3Stack1,p3Stack2,p3Stack3,p4Stack1,p4Stack2,p4Stack3;

- (id)init
{
    self = [super init];
    if (self) {
        bank = [[Bank alloc] initWithOneGolds:0 twoGolds:0 fivesGolds:0 tenGolds:1 fifteenGolds:0 twentyGolds:0];
        stageOfBuilding = Tower;
        territories = [[NSMutableArray alloc] init];
        specialCharacters = [[NSMutableArray alloc] init];
        armies = [[NSMutableArray alloc] init];
        specialIncome = [[NSMutableArray alloc] init];
        [self updateIncome];
    }
    return self;
}
-(id) initWithArmy{
    
    self = [super init];
    if (self) {
        p1Stack1 = @[ @"-n Giant Spider -t Desert -a 1",@"-n Elephant -t Jungle -s Charge -a 4",@"-n Giant Spider -t Desert -a 1",@"-n Brown Knight -t Mountain -s Charge -a 4",@"-n Giant -t Mountain -s Range -a 4",@"-n Dwarves -t Mountain -s Range -a 2"];
       p1Stack2 = @[@"-n Skletons -c 2 -t Desert -a 1",@"-n Watusi -t Jungle -s 2",@"-n Goblins -c 4 -t Mountain -a 1",@"-n Orge Mountain -t Mountain -a 2"];
        p2Stack1 = @[@"-n Pterodactyl Warriors -c 2 -t Jungle -s Fly -s Range -a 2",@"-n Green Knight -t Forest -s Charge -a 4",@"-n Dervish -c 2 -t Desert -s Magic -a 2",@"-n Crocodiles -t Jungle -a 2",@"-n Nomads -c 2 -t Desert -a 1",@"-n Druid -t Forest -s Magic -a 3",@"-n Walking Tree -t Forest -a 5",@"-n Crawling Vines -t Jungle -a 6",@"-n Bandits -t Forest -a 2"];
       p3Stack1 = @[@"-n Centaur -t Plains -a 2",@"-n Camel Corps -t Desert -a 3",@"-n Farmers -c 4 -t Plains -a 1",@"-n Farmers -c 4 -t Plains -a 1"];
      p3Stack2 = @[@"-n Genie -t Desert -s Magic -a 4",@"-n Skletons -c 2 -t Desert -a 1",@"-n Pygmies -t Jungle -a 2"];
        p3Stack3 = @[@"-n Great Hunter -t Plains -s Range -a 4",@"-n Nomads -c 2 -t Desert -a 1",@"-n Witch Doctor -t Jungle -s Magic -a 2"];
       p4Stack1 = @[@"-n Tribesmen -c 2 -t Plains -a 2",@"-n Giant Lizard -c 2 -t Swamp -a 2",@"-n Villains -t Plains -a 2",@"-n Tigers -c 2 -t Jungle -a 3"];
      p4Stack2 = @[@"-n Vampire Bat -t Swamp -s Fly -a 4",@"-n Tribesmen -c 2 -t Plains -a 2",@"-n Dark Wizard -t Swamp -s Fly -s Magic -a 1",@"-n Black Knight -t Swamp -s Charge -a 3"];
       p4Stack3 = @[@"-n Giant Ape -c 2 -t Jungle -a 5",@"-n Buffalo Herd -t Plains -a 3"];
        
        bank = [[Bank alloc] initWithOneGolds:0 twoGolds:0 fivesGolds:0 tenGolds:1 fifteenGolds:0 twentyGolds:0];
        
        stageOfBuilding = Tower;
        
        
    }
    return self;
 
}

- (void) depositGold:(int) goldType{
    [bank depositGold:goldType];
}

- (BOOL) withdrawGold:(int) goldType{
    return [bank depositGold:goldType];
}

- (BOOL) setTerritory: (Terrain *) territory{
    
    BOOL result = NO;
    if(territory != Nil){
    NSLog(@"Adding territory: %@", territory.type);
    if ([territories count] <= 10){
        [territories addObject:territory];
        NSLog(@"player territory is set for : %@ %d", territory.node.name, [territories count]);
        [self updateIncome];
        result =  YES;
    }
    else{
        result =  NO;
        NSLog(@"3 territories set already :)");
    }
    }
    return result;
}

- (void) updateBank: (Bank *) myBank{
    bank = myBank;
}

- (Bank *) getBank{
    return bank;
}
- (int) getBankBalance{
    return [bank getBalance];
}

- (Stage) getStage{
    return stageOfBuilding;
}

- (void) updateIncome{
    // add combat values of buildings and special income counters
    income = territories.count + specialCharacters.count + (stageOfBuilding + 1) + [self getSpecialCreatureIncome];
    NSLog(@"Income is %d", income);
}

- (int) getSpecialCreatureIncome{
    int _income = 0;
    for(Creature *army in armies){
        if (army.special){
            _income++;
        }
    }
    
    return _income;
}

- (NSMutableArray *) getTerritories{
    return territories;
}

- (NSMutableArray *) getArmies{
    return armies;
}

-(void) constructArmy:(NSMutableArray *) army{
    
    [armies addObjectsFromArray:army];
    [self updateIncome];
}

@end
