//
//  Player.m
//  KingsNThings
//
// Created by Areej Ba Salamah and Menan Vadivel on 1/28/2014.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import "Player.h"

@implementation Player{
//    int income;
    int orderOfPlay;
    //NSMutableArray* armies; // collection of armies
    //NSMutableArray* singleArmy; // single armies (eg stack one )
    //NSMutableArray* armies;
    NSMutableArray* territories;
    NSMutableArray* specialCharacters;
    //NSMutableArray* specialIncome;
    NSMutableArray* buildings;
    
    

}

static int counter = 0;

@synthesize armies,playingOrder,bank,army,returnedCreatures, balance,recruitsRemaining,hasWonCombat,isWaitingCombat,combat,playerLeft,movementsRemaining,rack,hasBuiltCitadel,specialIncome;

-(id) init{
    
    self = [super init];
    if (self) {
        bank = [[Bank alloc] initWithOneGolds:0 twoGolds:0 fivesGolds:5 tenGolds:0 fifteenGolds:0 twentyGolds:0];
        buildings = [[NSMutableArray alloc] init];
        territories = [[NSMutableArray alloc] init];
        specialCharacters = [[NSMutableArray alloc] init];
        armies = [[NSMutableArray alloc] init];
        specialIncome = [[NSMutableArray alloc] init];
        
        combat = [[NSMutableDictionary alloc] init];
        army = [[Army alloc]init];
        rack = [[NSMutableArray alloc]init];
        recruitsRemaining = 10;
        movementsRemaining = 4;
        returnedCreatures = 0;
        counter +=1;
        balance = 0;
        playingOrder = counter;
        hasWonCombat = NO;
        isWaitingCombat = NO;
        playerLeft = NO;
        hasBuiltCitadel = NO;
    }
    return self;
 
}


- (BOOL) setTerritory: (Terrain *) territory{
    if(territory != nil){
        [territories addObject:territory];
        NSLog(@"player territory is set for : %@ %d , player is %d ", territory.node.name, [territories count],playingOrder);
        return YES;
    }
    return NO;
}

- (void) updateBank: (Bank *) myBank{
    bank = myBank;
}

- (void) justPaid:(int) amount{
//    NSLog(@"justPaid Amount : %d, Balance: %d, recruits remaining: %d",amount, balance, recruitsRemaining);
    amount = amount + balance;
    if (amount >= 5) {
        recruitsRemaining += (int)(amount / 5);
        balance = amount % 5;
    }
    else{
        balance = amount;
    }
}
- (void) justGotPaid:(int) amount{
//    NSLog(@"justGotPaid Amount : %d, Balance: %d, recruits remaining: %d",amount, balance, recruitsRemaining);
    amount = amount + balance;
    if (amount >= 5) {
        recruitsRemaining -= (int)(amount / 5);
        balance = amount % 5;
    }
    else{
        balance = amount;
    }
}


- (Bank *) getBank{
    return bank;
}
- (int) getBankBalance{
    return [bank getBalance];
}

- (void) addBuildings{
    
}

- (int) getSpecialCreatureIncome{
    int sIncome = 0;
    for(Army *a in armies){
        for(Creature *c in a.creatures){
            if (c.isSpecial){
                sIncome++;
            }
        }
    }
    
    return sIncome;
}
-(int) getSpecialIncomeValue{
    int value = 0;
    for(SpecialIncome* sp in specialIncome){
        value += [sp goldValue];
    }
    return value;
}

- (int) getBuildingIncome{
    int i = 0;
    for (Building *b in buildings) {
        i += (b.stage + 1);
        // i = [b combatValue];
    }
    return i;
}

- (BOOL) setBuilding: (Building *) building{
    NSLog(@"Just added building %d", building.stage);
    [buildings addObject:building];
    return YES;
}

- (int) getIncome{
    return (territories.count + [self getBuildingIncome] + [self getSpecialCreatureIncome] + [self getSpecialIncomeValue]);
}

- (NSMutableArray *) getTerritories{
    return territories;
}

- (Army *) getArmyAtIndex:(NSInteger)index{
    
    if([armies count] > 0)
        return [armies objectAtIndex:index];
    else
        return nil;
}

- (void) returnedACreature{
    returnedCreatures++;
    if (returnedCreatures == 2) {
        recruitsRemaining++;
        returnedCreatures = 0;
    }
}

-(NSInteger) numberOfArmies{
    return [armies count];
}

// to construct new army (stack) every time a players drag a creature to new territory
-(Army*) constructNewArmy:(id)creatur atPoint:(CGPoint) aPoint withTerrain:(Terrain*)terrain{
    
    Army* arm = [[Army alloc]initWithPoint:aPoint];
    [arm addCreatures:creatur];
    [arm setTerrain:terrain];
    [arm setArmyNumber:[self numberOfArmies]+1];
    [arm setPlayerNumber:[self playingOrder]];
    
    //[arm setPosition:aPoint];
    [armies addObject:arm];
    NSLog(@"went in construct New Army and %d more recruits remaining", recruitsRemaining);
    return arm;
   
}

-(void) printArmy{
    
    for (int i = 0 ; i<[armies count];i++){
        NSLog(@"Army %d , has Creature in army  ",i);
        
    for(Creature* cre in [[armies objectAtIndex:i] creatures])
        NSLog(@" : %@  ",[cre name]);
              
    }
}

-(BOOL) addCreatureToArmy:(id)creature inArmy:(Army*)force{
    [force addCreatures:creature];
    return YES;
    NSLog(@"Creature is added and %d more recruits remaining", recruitsRemaining);
}


-(Army*) armyByCreature:(id)creature{
    if([armies count] >0){
        for (int i = 0 ; i<[armies count];i++){
            //NSLog(@"Army %d , has Creature in army  ",i);
            if([[armies objectAtIndex:i] containCreature:creature]){
                return [armies objectAtIndex:i];
            }
        }
        
    }
    
    return nil;
}

-(Army*) findArmyOnTerrain:(Terrain*)terrain{
    for (int i = 0 ; i<[armies count];i++){
        //NSLog(@"Army %d , has Creature in army  ",i);
        if([[[armies objectAtIndex:i] terrain]isEqual:terrain]){
            return [armies objectAtIndex:i];
        }
    }
    return nil;
    
}

-(Building*) getBuildingOnTerrain:(Terrain*)ter{
    for (Building *b in buildings) {
        if([[b terrain] isEqual:ter]){
            NSLog(@"building is found %@",b.imageName);
            return b;
        }
    }
    return nil;
}
/*-(SpecialIncome*) getSpecialIncomeOnTerrain:(Terrain*)ter{
    
    for (SpecialIncome *sp in specialIncome) {
        if([[sp terrain] isEqual:ter]){
                        return sp;
        }
    }
    return nil;
}*/

-(BOOL) removeBuilding:(Building*) oldBuilding;
{
    if([buildings count] > 0){
     [buildings removeObject:oldBuilding];
        NSLog(@"Building removed is %@",oldBuilding.imageName);
        return true;
    }
    
    return false;
}

- (void) hasLeft:(BOOL) left{
    playerLeft = left;
}

- (Creature *) findCreatureOnRackByName:(NSString *) name{
    
    NSLog(@"trying to located node from rack with name %@",name);
    for (Creature *c in rack) {
        if ([c.name isEqualToString:name]) {
            return c;
        }
    }
    return nil;
}
-(SpecialIncome *) findSpecialIncomeOnRackByName:(NSString *) name{
    
    NSLog(@"trying to located node from rack with name %@",name);
    for (SpecialIncome *c in rack) {
        if ([c.name isEqualToString:name]) {
            return c;
        }
    }
    return nil;
}

- (BOOL) removeCreatureFromRackByName:(NSString *) name{
    
    NSLog(@"trying to remove node from rack with name %@",name);
    for (Creature *c in rack) {
        if ([c.name isEqualToString:name]) {
            [rack removeObject:c];
            return YES;
        }
    }
    return NO;
}

-(void) addSpecialIncome:(SpecialIncome*)sp{
    
    [specialIncome addObject:sp];
    
}

@end
