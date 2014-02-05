//
//  Player.m
//  KingsNThings
//
//  Created by Menan Vadivel on 1/28/2014.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import "Player.h"

@implementation Player{
    int income;
    int orderOfPlay;
    int stageOfBuilding;
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
@synthesize armies,singleArmy,playingOrder;

- (id)init
{
    self = [super init];
    if (self) {
        bank = [[Bank alloc] initWithOneGolds:0 twoGolds:0 fivesGolds:0 tenGolds:1 fifteenGolds:0 twentyGolds:0];
        stageOfBuilding = Tower;
        territories = [[NSMutableArray alloc] init];
        specialCharacters = [[NSMutableArray alloc] init];
        armies = [[NSMutableArray alloc] init];
        treasures = [[NSMutableArray alloc] init];
        [self updateIncome];
    }
    return self;
}
-(id) initWithArmy:(NSArray *)army{
    
    self = [super init];
    if (self) {
        
        bank = [[Bank alloc] initWithOneGolds:0 twoGolds:0 fivesGolds:0 tenGolds:1 fifteenGolds:0 twentyGolds:0];
        
        stageOfBuilding = 1;
        
        
        [self updateIncome];
    }
    return self;
 
}

- (BOOL) setTerritory: (Terrain *) territory{
    NSLog(@"Adding territory: %@", territory.type);
    if ([territories count] < 3){
        [territories addObject:territory];
        NSLog(@"player territory is set for : %@", territory.node.name);
        [self updateIncome];
        return YES;
    }
    else{
        return NO;
        NSLog(@"3 territories set already :)");
    }
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
    income = territories.count + specialCharacters.count;
}

- (NSMutableArray *) getTerritories{
    return territories;
}

- (NSMutableArray *) getArmies{
    return armies;
}

-(void) constructArmy:(NSMutableArray *) army{
    
    [armies addObject:army];
}

@end
