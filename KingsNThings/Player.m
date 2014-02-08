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

@synthesize armies,playingOrder,bank,army;

- (id)init
{
    self = [super init];
    if (self) {
        bank = [[Bank alloc] initWithOneGolds:0 twoGolds:0 fivesGolds:0 tenGolds:1 fifteenGolds:0 twentyGolds:0];
        buildings = [[NSMutableArray alloc] init];
        territories = [[NSMutableArray alloc] init];
        specialCharacters = [[NSMutableArray alloc] init];
        armies = [[NSMutableArray alloc] init];
        specialIncome = [[NSMutableArray alloc] init];
        army = [[Army alloc]init];
        counter +=1;
        playingOrder =counter;
        
    }
    return self;
}
-(id) initWithArmy{
    
    self = [super init];
    if (self) {
       
        
        bank = [[Bank alloc] initWithOneGolds:0 twoGolds:0 fivesGolds:0 tenGolds:1 fifteenGolds:0 twentyGolds:0];
        
        buildings = [[NSMutableArray alloc] init];
        territories = [[NSMutableArray alloc] init];
        specialCharacters = [[NSMutableArray alloc] init];
        armies = [[NSMutableArray alloc] init];
        specialIncome = [[NSMutableArray alloc] init];
        army = [[Army alloc]init];
        counter +=1;
        playingOrder =counter;
        
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
    for(Creature *army in armies){
        if (army.special){
            sIncome++;
        }
    }
    
    return sIncome;
}

- (int) getBuildingIncome{
    int i = 0;
    for (Building *b in buildings) {
        i += (b.stage + 1);
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
    
    Army* arm = [[Army alloc]initWithPoint:aPoint];
    [arm addCreatures:creatur];
    [arm setTerrain:terrain];
    [arm setArmyNumber:[self numberOfArmies]+1];
    [arm setPlayerNumber:[self playingOrder]];
    
    //[arm setPosition:aPoint];
    
    [armies addObject:arm];
     NSLog(@"went in construct New Army");
   
    return arm;
}



-(void) printArmy{
    
    for (int i = 0 ; i<[armies count];i++){
        NSLog(@"Army %d , has Creature in army  ",i);
        
    for(Creature* cre in [[armies objectAtIndex:i] creatures])
        NSLog(@" : %@  ",[cre name]);
              
    }
}

-(void) addCreatureToArmy:(id)creature inArmy:(Army*)force{
    
    [force addCreatures:creature];
    NSLog(@"CREature is added");
    
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

@end
