//
//  Player.m
//  KingsNThings
//
// Created by Areej Ba Salamah and Menan Vadivel on 1/28/2014.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import "Player.h"
#import "math.h"

@implementation Player{
    NSMutableArray* territories;
    NSMutableArray* specialCharacters;
}

static int counter = -1;

@synthesize stacks,playingOrder,bank,army,returnedCreatures, balance,recruitsRemaining,hasWonCombat,isWaitingCombat,combat,playerLeft,movementsRemaining,rack,specialIncome,doneTurn,buildings, specialRecruitsRemaining;

-(id) init{
    
    self = [super init];
    if (self) {
        bank = [[Bank alloc] initWithOneGolds:0 twoGolds:0 fivesGolds:2 tenGolds:0 fifteenGolds:0 twentyGolds:0];
        buildings = [[NSMutableArray alloc] init];
        territories = [[NSMutableArray alloc] init];
        specialCharacters = [[NSMutableArray alloc] init];
        stacks = [[NSMutableArray alloc] init];
        specialIncome = [[NSMutableArray alloc] init];
        
        combat = [[NSMutableDictionary alloc] init];
        army = [[Army alloc]init];
        rack = [[NSMutableArray alloc]init];
        recruitsRemaining = 10;
        specialRecruitsRemaining = 1;
        movementsRemaining = 4;
        returnedCreatures = 0;
        counter +=1;
        balance = 0;
        playingOrder = counter;
        hasWonCombat = NO;
        isWaitingCombat = NO;
        playerLeft = NO;
      
        doneTurn = NO;
    }
    return self;
 
}

- (BOOL) containsTerrain: (Terrain *) terrain{
    for (Terrain *myTerrain in territories) {
        if (myTerrain.position.x == terrain.position.x && myTerrain.position.y == terrain.position.y) {
            return YES;
        }
    }
    return NO;
    
}

//finds how much of free recruits can be awarded to this player
- (int) freeRecruitsCount{
    float recruitsFloat = (float)territories.count/2;
    int freeRecruits = (int) ceilf(recruitsFloat);
    return freeRecruits;
}


- (BOOL) setTerritory: (Terrain *) territory{
    if(territory != nil && ![self containsTerrain:territory]){
        [territories addObject:territory];
//        NSLog(@"player territory is set for : %@ %d , player is %d ", territory.name, [territories count],playingOrder);
        return YES;
    }
    else{
        NSLog(@"this territory must already be present to this user");
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


- (int) getSpecialCreatureIncome{
    int sIncome = 0;
    for(Army *a in stacks){
        for(id c in a.creatures){
            if ([c isKindOfClass:[SpecialIncome class]]) {
                NSLog(@"creature special creature income: %@", c);
                sIncome++;
            }
//            else{
//                Creature *myCreature = c;
//                if (myCreature.isSpecial){
//                    sIncome++;
//                }
//            }
            
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

//the other built in function doesnt work since it's not the same object were testing it again :(
- (BOOL) containsBuilding:(Building *) b{
    for (Building *myBuilding in buildings) {
        if (myBuilding.position.x == b.position.x && myBuilding.position.y == b.position.y) {
            return YES;
        }
    }
    return NO;
}

- (BOOL) setBuilding: (Building *) building{
//    NSLog(@"setBuilding: %@", building.terrain.name );
    if (![self containsBuilding:building]) {
        [buildings addObject:building];
        return YES;
    }
    else{
        NSLog(@"he seems to already have the building tho");
        return NO;
    }
}

- (int) getIncome{
    NSLog(@"territories %d: %d ", [self playingOrder],[self getBuildingIncome] );
    return (territories.count + [self getBuildingIncome] + [self getSpecialIncomeValue]);
}

- (NSMutableArray *) getTerritories{
    return territories;
}

- (Army *) getStackAtIndex:(NSInteger)index{
    
    if([stacks count] > 0)
        return [stacks objectAtIndex:index];
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

-(BOOL) reachedArmyLimit{
    int limit = 0;
    
    for(Army* a in stacks){
        limit += a.creatures.count;
    }
    NSLog(@"limit :%d", limit);
    if(limit >= 10)
        return YES;
    else
        return NO;
}

// to construct new army (stack) every time a players drag a creature to new territory
-(Army*) constructNewStack:(id)creatur atPoint:(CGPoint) aPoint withTerrain:(Terrain*)terrain{
    NSLog(@"terrain: %@", terrain.type);
    Army* arm ;
    
//    if(![self reachedArmyLimit]){
        arm = [[Army alloc]initWithPoint:aPoint];
        [arm addCreatures:creatur];
        [arm setTerrain:terrain];
        [arm setArmyNumber:stacks.count + 1];
        [arm setPlayerNumber:[self playingOrder]];
        
        //[arm setPosition:aPoint];
        [stacks addObject:arm];
//        NSLog(@"went in construct New Army and %d more recruits remaining", recruitsRemaining);
//    }
//    else{
//        NSLog(@"reached the army limit tho");
//    }
    return arm;
   
}

-(void) printArmy{
    
    for (int i = 0 ; i<[stacks count];i++){
//        NSLog(@"Army %d , has Creature in army  ",i);
        
//    for(Creature* cre in [[stacks objectAtIndex:i] creatures])
//        NSLog(@" : %@  ",[cre name]);
//              
    }
}

-(BOOL) addCreatureToArmy:(id)creature inArmy:(Army*)force{
    return [force addCreatures:creature];
}


-(Army*) armyByCreature:(id)creature{
    if([stacks count] >0){
        for (int i = 0 ; i<[stacks count];i++){
            //NSLog(@"Army %d , has Creature in army  ",i);
            if([[stacks objectAtIndex:i] containCreature:creature]){
                return [stacks objectAtIndex:i];
            }
        }
        
    }
    
    return nil;
}

-(Army*) findArmyOnTerrain:(Terrain*)terrain{
    for (int i = 0 ; i<[stacks count];i++){
        //NSLog(@"Army %d , has Creature in army  ",i);
        if([[[stacks objectAtIndex:i] terrain]isEqual:terrain]){
            return [stacks objectAtIndex:i];
        }
    }
    return nil;
    
}

-(Building*) getBuildingOnTerrain:(Terrain*)ter{
    for (Building *b in buildings) {
        if([b.terrain isEqual:ter]){
            NSLog(@"building is found %@",b.imageName);
            return b;
        }
    }
    return nil;
}
-(SpecialIncome *) getSpecialIncomeOnTerrain:(Terrain*)terrain{
    
    for (SpecialIncome *sp in specialIncome) {
        if([[sp terrain] isEqual:terrain]){
            return sp;
        }
    }
    return nil;
}

-(BOOL) removeBuilding:(Building*) oldBuilding;
{
    if([buildings containsObject:oldBuilding]){
     [buildings removeObject:oldBuilding];
        NSLog(@"Building removed is %@",oldBuilding.imageName);
        return true;
    }
    else{
        NSLog(@"failed removing the building because it was not present in the array.");
    }
    
    return false;
}

-(void) removeTerrainfromTerritories:(Terrain*)terrain{
    
    [territories removeObject:terrain];
    
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
-(void) removeSpecialIncomeOnRack:(SpecialIncome *) sp{
    
    [rack removeObject:sp];
  
}
- (BOOL) hasBuilding:(Building *)b{
    for (Building *nyB in buildings) {
        if ([b.name isEqualToString:nyB.name] && b.position.x == nyB.position.x && b.position.x == nyB.position.y ) {
            return YES;
        }
    }
    return NO;
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
-(void) removeStack:(Army*)stack{
    [stacks removeObject:stack];
    [stack removeFromParent];
}

-(void) addSpecialIncome:(SpecialIncome*)sp{
    [specialIncome addObject:sp];
}


- (BOOL) canAdvanceToGold{
    NSLog(@"territories: %d, buildings: %d, recruitmentsRem: %d", territories.count, buildings.count, recruitsRemaining);
    if (territories.count >= 3 && buildings.count > 0 && recruitsRemaining <= 0)
        return YES;
    else
        return NO;
}


-(BOOL) hasSpecialIncomeOnTerrain:(Terrain*)terrain{
    //BOOL result = NO;
    for(SpecialIncome* sp in specialIncome){
        if([sp.terrain isEqual:terrain]){
            return YES;
        }
    }
    
    return NO;
    
}

-(BOOL) hasBuildingOnTerrain:(Terrain*)terrain{
    BOOL result = NO;
    for(Building* b in buildings){
        if([b.terrain isEqual:terrain]){
            result = YES;
            break;
        }
    }
    
    return result;
    
}
-(BOOL)hasCitadel{
    
    for(Building* b in buildings){
          if(b.stage == Citadel)
            return YES;
    }
    return NO;
}
@end
