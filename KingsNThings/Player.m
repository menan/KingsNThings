//
//  Player.m
//  KingsNThings
//
// Created by Areej Ba Salamah and Menan Vadivel on 1/28/2014.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import "Player.h"
#import "Creature.h"

@implementation Player{
//    int income;
    int orderOfPlay;
    
    //NSMutableArray* armies; // collection of armies
    //NSMutableArray* singleArmy; // single armies (eg stack one )
    //NSMutableArray* armies;
    NSMutableArray* territories;
    NSMutableArray* specialCharacters;
    NSMutableArray* specialIncome;
    NSMutableArray* buildings;
    
    

}

static NSInteger counter = 0;

@synthesize armies,playingOrder,bank,army, balance,recruitsRemaining,hasWonCombat,isWaitingCombat,combat;

-(id) initWithArmy{
    
    self = [super init];
    if (self) {
       
        
        bank = [[Bank alloc] initWithOneGolds:0 twoGolds:0 fivesGolds:2 tenGolds:0 fifteenGolds:0 twentyGolds:0];
        
        buildings = [[NSMutableArray alloc] init];
        territories = [[NSMutableArray alloc] init];
        specialCharacters = [[NSMutableArray alloc] init];
        armies = [[NSMutableArray alloc] init];
        specialIncome = [[NSMutableArray alloc] init];
        combat = [[NSMutableDictionary alloc] init];
        army = [[Army alloc]init];
        recruitsRemaining = 10;
        counter +=1;
        balance = 0;
        playingOrder =counter;
        hasWonCombat = NO;
        isWaitingCombat = NO;
        
    }
    return self;
 
}


- (BOOL) setTerritory: (Terrain *) territory{
    
    BOOL result = NO;
    if(territory != NULL){
//    NSLog(@"Adding territory: %@", territory.type);
    if ([territories count] <= 10){
        [territories addObject:territory];
        NSLog(@"player territory is set for : %@ %d , player is %d ", territory.node.name, [territories count],playingOrder);
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

- (void) justPaid:(int) amount{
    NSLog(@"justPaid Amount : %d, Balance: %d, recruits remaining: %d",amount, balance, recruitsRemaining);
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
    NSLog(@"justGotPaid Amount : %d, Balance: %d, recruits remaining: %d",amount, balance, recruitsRemaining);
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
    return (territories.count + [self getBuildingIncome] + [self getSpecialCreatureIncome]);
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



-(NSInteger) numberOfArmies{
    return [armies count];
}

// to construct new army (stack) every time a players drag a creature to new territory
-(Army*) constructNewArmy:(id)creatur atPoint:(CGPoint) aPoint withTerrain:(Terrain*)terrain{
    
    recruitsRemaining--;
    if (recruitsRemaining >= 0) {
        
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
    else{
        NSLog(@"You don't have anymore recruits left.");
        return NULL;
    }
   
}



-(void) printArmy{
    
    for (int i = 0 ; i<[armies count];i++){
        NSLog(@"Army %d , has Creature in army  ",i);
        
    for(Creature* cre in [[armies objectAtIndex:i] creatures])
        NSLog(@" : %@  ",[cre name]);
              
    }
}

-(BOOL) addCreatureToArmy:(id)creature inArmy:(Army*)force{
    
    recruitsRemaining--;
    if (recruitsRemaining >= 0) {
        
        [force addCreatures:creature];
        return YES;
        NSLog(@"Creature is added and %d more recruits remaining", recruitsRemaining);
    }
    else{
        return NO;
        NSLog(@"You don't have anymore recruits left.");
    }
    
}


-(Army*) hasCreature:(id)creature{
    
    Army* a;
    if([armies count] >0){
        for (int i = 0 ; i<[armies count];i++){
            //NSLog(@"Army %d , has Creature in army  ",i);
            if([[armies objectAtIndex:i] containCreature:creature]){
                a =[armies objectAtIndex:i];
                break;
            }
        }
        
    }
        else
            a = nil;
    
    return a;
}

-(Army*) findArmyOnTerrain:(Terrain*)terrain{
    Army* a;
    for (int i = 0 ; i<[armies count];i++){
        //NSLog(@"Army %d , has Creature in army  ",i);
        if([[[armies objectAtIndex:i] terrain]isEqual:terrain]){
            a =[armies objectAtIndex:i];
            break;
        }
    }
    return a;
    
}

-(Building*) getBuildingOnTerrain:(Terrain*)ter{
    Building* building;
    for (Building *b in buildings) {
        if([[b terrain] isEqual:ter]){
            building = b;
            NSLog(@"building is found %@",building.imageName);
            //return b;
        }
    }
    
    return building;
}
-(BOOL) removeBuilding:(Building*) oldBuilding;
{
    if([buildings count] > 0){
     [buildings removeObject:oldBuilding];
        NSLog(@"Building removed is %@",oldBuilding.imageName);
        return true;
    }
    
    return false;
}

@end
