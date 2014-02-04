//
//  Player.m
//  KingsNThings
//
//  Created by Menan Vadivel on 1/28/2014.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import "Player.h"
#import "Terrain.h"

@implementation Player{
    int income;
    int orderOfPlay;
    int stageOfBuilding;
    Bank* bank;
    
    NSMutableArray* armies;
    NSMutableArray* territories;
    NSMutableArray* specialCharacters;
    NSMutableArray* treasures;

}

- (id)init
{
    self = [super init];
    if (self) {
        bank = [[Bank alloc] initWithOneGolds:0 twoGolds:0 fivesGolds:0 tenGolds:1 fifteenGolds:0 twentyGolds:0];
        stageOfBuilding = 1;
        [self updateIncome];
    }
    return self;
}

- (void) setTerritory: (Terrain *) territory{
    if ([territories count] < 3){
        [territories addObject:territory];
        [self updateIncome];
    }
    else
        NSLog(@"3 territories set already :)");
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

- (void) updateIncome{
    income = territories.count + specialCharacters.count;
}

- (NSMutableArray *) getTerritories{
    return territories;
}

- (NSMutableArray *) getArmies{
    return armies;
}

@end
