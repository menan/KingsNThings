
//  GamePlay.m
//  KingsNThings
//
//  Created by Menan Vadivel on 2/1/2014.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import "GamePlay.h"
#import "Player.h"
#import "Creature.h"
#import "Bank.h"
#import "MyScene.h"
#import "CombatPhase.h"

@implementation GamePlay{
    MyScene *scene;
    
}

@synthesize player1,player2,player3,player4,oneDice,secondDice,goldCollectionCompleted, players;

@synthesize p1Stack1,p1Stack2,p2Stack1,p3Stack1,p3Stack2,p3Stack3,p4Stack1,p4Stack2,p4Stack3,goldPhase,terrains, isMovementPhase , isThingRecrPahse, isComabtPahse,scene;


-(id) initWith4Players{
    
    self = [super init];
    if(self){
        goldCollectionCompleted = NO;
        player1 = [[Player alloc] initWithArmy];
        player2 = [[Player alloc] initWithArmy];
        player3 = [[Player alloc] initWithArmy];
        player4 = [[Player alloc] initWithArmy];
        
        players = [[NSMutableArray alloc] initWithObjects:player1, player2, player3, player4, nil];
        terrains = [[NSMutableArray alloc]init];
       
        
        //[self setPlayerArmy];
        p1Stack1 = [[NSArray alloc]init];
        
        p1Stack2  = [[NSArray alloc]init];
        p1Stack2  = [[NSArray alloc]init];
        
        p2Stack1  = [[NSArray alloc]init];
        
        p3Stack1  = [[NSArray alloc]init];
        p3Stack2  = [[NSArray alloc]init];
        p3Stack3  = [[NSArray alloc]init];
        
        p4Stack1  = [[NSArray alloc]init];
        p4Stack2  = [[NSArray alloc]init];
        p4Stack3  = [[NSArray alloc]init];
    
        goldPhase = NO;
        isMovementPhase = NO;
        isThingRecrPahse = NO;
        isComabtPahse = NO;
        
        
        
        p1Stack1 = @[@"-n Old Dragon -s Fly -s Magic -a 4",@"-n Elephant -t Jungle -s Charge -a 4",@"-n Giant Spider -t Desert -a 1",@"-n Brown Knight -t Mountain -s Charge -a 4",@"-n Giant -t Mountain -s Range -a 4",@"-n Dwarves -t Mountain -s Range -a 2"];
        
        
        
       
        p1Stack2 = @[@"-n Skletons -c 2 -t Desert -a 1",@"-n Watusi -t Jungle -s 2",@"-n Goblins -c 4 -t Mountain -a 1",@"-n Orge Mountain -t Mountain -a 2"];
        p2Stack1 = @[@"-n Pterodactyl Warriors -c 2 -t Jungle -s Fly -s Range -a 2",@"-n Green Knight -t Forest -s Charge -a 4",@"-n Dervish -c 2 -t Desert -s Magic -a 2",@"-n Crocodiles -t Jungle -a 2",@"-n Nomads -c 2 -t Desert -a 1",@"-n Druid -t Forest -s Magic -a 3",@"-n Walking Tree -t Forest -a 5",@"-n Crawling Vines -t Jungle -a 6",@"-n Bandits -t Forest -a 2"];
        p3Stack1 = @[@"-n Centaur -t Plains -a 2",@"-n Camel Corps -t Desert -a 3",@"-n Farmers -c 4 -t Plains -a 1",@"-n Farmers -c 4 -t Plains -a 1"];
        p3Stack2 = @[@"-n Genie -t Desert -s Magic -a 4",@"-n Skletons -c 2 -t Desert -a 1",@"-n Pygmies -t Jungle -a 2"];
        p3Stack3 = @[@"-n Great Hunter -t Plains -s Range -a 4",@"-n Nomads -c 2 -t Desert -a 1",@"-n Witch Doctor -t Jungle -s Magic -a 2"];
        p4Stack1 = @[@"-n Tribesmen -c 2 -t Plains -a 2",@"-n Giant Lizard -c 2 -t Swamp -a 2",@"-n Villains -t Plains -a 2",@"-n Tigers -c 2 -t Jungle -a 3"];
        p4Stack2 = @[@"-n Vampire Bat -t Swamp -s Fly -a 4",@"-n Tribesmen -c 2 -t Plains -a 2",@"-n Dark Wizard -t Swamp -s Fly -s Magic -a 1",@"-n Black Knight -t Swamp -s Charge -a 3"];
        p4Stack3 = @[@"-n Giant Ape -c 2 -t Jungle -a 5",@"-n Buffalo Herd -t Plains -a 3"];
        
    }
    
    return self;
    
}
-(void) assignScene:(MyScene*)sce{
//    NSLog(@"inside assignScene");
    scene = sce;
    
}
-(Terrain*) findTerrainAt:(CGPoint)thisPoint{
    NSLog(@"FindTerrain");
for (Terrain *terrain in terrains) {
    if (terrain.node.position.x == thisPoint.x && terrain.node.position.y == thisPoint.y) {
        return terrain;
    }
}
return NULL;
}

- (Player *) findPlayerByTerrain:(Terrain *) terrain{
    NSLog(@"findPlayer");
    for (Player *p in players) {
        if ([[p getTerritories] containsObject:terrain]) {
            return p;
        }
    }
    return NULL;
}
/*
-(void) setPlayerArmy{
    
    NSArray *p1Stack1 = @[ @"-n Old Dragon -s Fly -s Magic -a 4",@"-n Elephant -t Jungle -s Charge -a 4",@"-n Giant Spider -t Desert -a 1",@"-n Brown Knight -t Mountain -s Charge -a 4",@"-n Giant -t Mountain -s Range -a 4",@"-n Dwarves -t Mountain -s Range -a 2"];
    NSArray* p1Stack2 = @[@"-n Skletons -c 2 -t Desert -a 1",@"-n Watusi -t Jungle -s 2",@"-n Goblins -c 4 -t Mountain -a 1",@"-n Orge Mountain -t Mountain -a 2"];
    NSArray *p2Stack1 = @[@"-n Pterodactyl Warriors -c 2 -t Jungle -s Fly -s Range -a 2",@"-n Green Knight -t Forest -s Charge -a 4",@"-n Dervish -c 2 -t Desert -s Magic -a 2",@"-n Crocodiles -t Jungle -a 2",@"-n Nomads -c 2 -t Desert -a 1",@"-n Druid -t Forest -s Magic -a 3",@"-n Walking Tree -t Forest -a 5",@"-n Crawling Vines -t Jungle -a 6",@"-n Bandits -t Forest -a 2"];
    NSArray *p3Stack1 = @[@"-n Centaur -t Plains -a 2",@"-n Camel Corps -t Desert -a 3",@"-n Farmers -c 4 -t Plains -a 1",@"-n Farmers -c 4 -t Plains -a 1"];
    NSArray *p3Stack2 = @[@"-n Genie -t Desert -s Magic -a 4",@"-n Skletons -c 2 -t Desert -a 1",@"-n Pygmies -t Jungle -a 2"];
    NSArray *p3Stack3 = @[@"-n Great Hunter -t Plains -s Range -a 4",@"-n Nomads -c 2 -t Desert -a 1",@"-n Witch Doctor -t Jungle -s Magic -a 2"];
    NSArray *p4Stack1 = @[@"-n Tribesmen -c 2 -t Plains -a 2",@"-n Giant Lizard -c 2 -t Swamp -a 2",@"-n Villains -t Plains -a 2",@"-n Tigers -c 2 -t Jungle -a 3"];
    NSArray *p4Stack2 = @[@"-n Vampire Bat -t Swamp -s Fly -a 4",@"-n Tribesmen -c 2 -t Plains -a 2",@"-n Dark Wizard -t Swamp -s Fly -s Magic -a 1",@"-n Black Knight -t Swamp -s Charge -a 3"];
    NSArray *p4Stack3 = @[@"-n Giant Ape -c 2 -t Jungle -a 5",@"-n Buffalo Herd -t Plains -a 3"];
    
    
    NSMutableArray *p1S1 = [[NSMutableArray alloc]init];
    
    for (NSString *str in p1Stack1) {
        Creature *creature = [[Creature alloc] initWithImage:str];
        
        [p1S1 addObject:creature];
    }
    //[p1S1 addObjectsFromArray:p1Stack1];
    
    NSMutableArray *p1S2 = [[NSMutableArray alloc]init];
    for (NSString *str in p1Stack2) {
         Creature *creature = [[Creature alloc] initWithImage:str];
        
        [p1S2 addObject:creature];
    }
    //[p1S2 addObjectsFromArray:p1Stack2];
    
    NSMutableArray *p2S1 = [[NSMutableArray alloc]init];
    for (NSString *str in p2Stack1) {
        Creature *creature = [[Creature alloc] initWithImage:str];
        
        [p2S1 addObject:creature];
    }
    //[p2S1 addObjectsFromArray:p2Stack1];
    
    NSMutableArray *p3S1 = [[NSMutableArray alloc]init];
    
    for (NSString *str in p3Stack1) {
        Creature *creature = [[Creature alloc] initWithImage:str];
        
        [p3S1 addObject:creature];
    }
    
    //[p3S1 addObjectsFromArray:p3Stack1];
    
    NSMutableArray *p3S2 = [[NSMutableArray alloc]init];
    for (NSString *str in p3Stack2) {
        Creature *creature = [[Creature alloc] initWithImage:str];
        
        [p3S2 addObject:creature];
    }
    //[p3S2 addObjectsFromArray:p3Stack2];
    
    NSMutableArray *p3S3 = [[NSMutableArray alloc]init];
    for (NSString *str in p3Stack3) {
        Creature *creature = [[Creature alloc] initWithImage:str];
        
        [p3S3 addObject:creature];
    }
    //[p3S3 addObjectsFromArray:p3Stack3];
    
    NSMutableArray *p4S1 = [[NSMutableArray alloc]init];
    for (NSString *str in p4Stack1) {
        Creature *creature = [[Creature alloc] initWithImage:str];
        
        [p4S1 addObject:creature];
    }
    //[p4S1 addObjectsFromArray:p4Stack1];
    
    
    NSMutableArray *p4S2 = [[NSMutableArray alloc]init];
    for (NSString *str in p4Stack2) {
        Creature *creature = [[Creature alloc] initWithImage:str];
        
        [p4S2 addObject:creature];
    }
    //[p4S2 addObjectsFromArray:p4Stack2];
    
    NSMutableArray *p4S3 = [[NSMutableArray alloc]init];
    for (NSString *str in p4Stack3) {
        Creature *creature = [[Creature alloc] initWithImage:str];
        
        [p4S3 addObject:creature];
    }
    //[p4S3 addObjectsFromArray:p4Stack3];
    
    [player1 constructArmy:p1S1];
    [player1 constructArmy:p1S2];
    [player2 constructArmy:p2S1];
    [player3 constructArmy:p3S1];
    [player3 constructArmy:p3S2];
    [player3 constructArmy:p3S3];
    [player4 constructArmy:p4S1];
    [player4 constructArmy:p4S2];
    [player4 constructArmy:p4S3];
    
    
}*/
-(Terrain*) findTerrainAtLocation:(NSInteger) location{
    
    for(Terrain* terr in terrains){
        
        if([terr location ] == location )
            return terr;
    }
    
    return NULL;
}
-(Player*)findPlayerByOrder:(NSInteger)order{
    
    for(Player* p in players){
        if([p playingOrder] == order)
            return p;
    }
    return NULL;
}

-(void) movementPhase:(Player *)player withArmy:(Army*)army{
    NSLog(@"inside movementPhase");
    
    NSLog(@" player is %d",[player playingOrder]);
    Terrain* terrain = [army terrain];
    
    Player *tempPlayer = [self findPlayerByTerrain:terrain];
    
    
    
    NSLog(@"tempPlayer is %d , player is %d",[tempPlayer playingOrder],[player playingOrder]);
    
    if([player isEqual:tempPlayer]){
        
        NSLog(@"tinside if players are equal");
        if([terrain hasArmyOnIt]){
            Army *a = [player findArmyOnTerrain:terrain];
            
            if(([a creaturesInArmy] + [army creaturesInArmy]) > 10)
                NSLog(@"Invalid move cannot have more than 10 creatures on one terrain");
            
        }
    }
    
    else{
        if([terrain hasArmyOnIt]){
            
            Army *defArmy = [tempPlayer findArmyOnTerrain:terrain];
             NSLog(@"tinside if players are NOT equal");
            
            [self combatPhase:player withArmy:army andPlayer:tempPlayer withArmy:defArmy ];
        }
    
    
    }
}



-(void) combatPhase:(Player *)attacker withArmy:(Army*)attackerArmy andPlayer:(Player*)defender withArmy:(Army*)defenderArmy{
    
     NSLog(@"inside Combat phase");
    
    CombatPhase* combat = [[CombatPhase alloc]initWithAttacker:attacker andDefender:defender andAttackerArmy:attackerArmy andDefenderArmy:defenderArmy andMainScene:scene];
    
    [combat drawScene];
    
   /*
  
   NSMutableArray* attackerRolledDice = [[NSMutableArray alloc]init];
    NSMutableArray* defenderRolledDice = [[NSMutableArray alloc]init];
    
    NSMutableArray* attackerMagicCreature = [[NSMutableArray alloc]init];
    NSMutableArray* defenderMagicCreature = [[NSMutableArray alloc]init];
    NSMutableArray* attackerRangedCreature = [[NSMutableArray alloc]init];
    NSMutableArray* defenderRangedCreature = [[NSMutableArray alloc]init];
    NSMutableArray* attackerMeleeCreature = [[NSMutableArray alloc]init];
    NSMutableArray* defenderMeleeCreature = [[NSMutableArray alloc]init];
    //NSMutableArray* attackerChargeCreature = [[NSMutableArray alloc]init];
   // NSMutableArray* defenderChargeCreature = [[NSMutableArray alloc]init];

    
    NSInteger attackerNumberOfHits = 0 , defenderNumberOfHits = 0;
    
    for(Creature *creature in [attackerArmy creatures])
    {
        if([creature isMagic] )
            [attackerMagicCreature addObject:creature];
        else if ([creature isRanged] )
            [attackerRangedCreature addObject:creature];
        else if ([creature isMelee] || [creature isCharge] )
            [attackerMeleeCreature addObject:creature];
       
    }
    
    for(Creature *creature in [defenderArmy creatures])
    {
        if([creature isMagic] )
            [defenderMagicCreature addObject:creature];
        else if ([creature isRanged] )
            [defenderRangedCreature addObject:creature];

        else if ([creature isMelee] || [creature isCharge] )
            [defenderMeleeCreature addObject:creature];
       
    }
    
    // now keep fighting until one loses
    //while ([attackerArmy count] !=0 && [defenderArmy count] != 0 ){
        //Magic round
    attackerNumberOfHits = 0;
    defenderNumberOfHits = 0;
    
    
    
        for(int i = 0 ; i < [attackerMagicCreature count]; i++){
            
            NSLog(@"Player atacker roll dice for %d ",[attackerMagicCreature count]);
            [self setOneDice: (arc4random() % 6) + 1];
            [attackerRolledDice addObject:[NSNumber numberWithInteger:[self oneDice]]];
        }
        
        
        for(int i = 0 ; i < [defenderMagicCreature count]; i++){
            
            NSLog(@"Player defender roll dice for %d ",[defenderMagicCreature count]);
            [self setOneDice: (arc4random() % 6) + 1];

            [defenderRolledDice addObject:[NSNumber numberWithInteger:[self oneDice]]];
        }
        
        for(int i = 0 ; i < [attackerMagicCreature count] ; i++){
                                           
        if([[attackerMagicCreature objectAtIndex: i] combatValue] >= [[attackerRolledDice objectAtIndex:i] integerValue] )
            
                attackerNumberOfHits += 1;
        
        
            }
        
        NSLog(@"Attacker can apply %d hits, in Magic round",attackerNumberOfHits);
        
    
        for(int i = 0 ; i < [defenderMagicCreature count] ; i++){
            
            if([[defenderMagicCreature objectAtIndex: i] combatValue] >= [[defenderRolledDice objectAtIndex:i] integerValue] )
                
                    defenderNumberOfHits += 1;
       }
    
        NSLog(@"defender can apply %d hits, in Magic round",attackerNumberOfHits);
    
        //Ranged round
    attackerNumberOfHits = 0;
    defenderNumberOfHits = 0;
    for(int i = 0 ; i < [attackerRangedCreature count]; i++){
        
        NSLog(@"Player atacker roll dice for %d ",[attackerRangedCreature count]);
        [self setOneDice: (arc4random() % 6) + 1];
        [attackerRolledDice addObject:[NSNumber numberWithInteger:[self oneDice]]];
    }
    
    
    for(int i = 0 ; i < [defenderRangedCreature count]; i++){
        
        NSLog(@"Player defender roll dice for %d ",[defenderRangedCreature count]);
        [self setOneDice: (arc4random() % 6) + 1];
        
        [defenderRolledDice addObject:[NSNumber numberWithInteger:[self oneDice]]];
    }
    
    for(int i = 0 ; i < [attackerRangedCreature count] ; i++){
        
        if([[attackerRangedCreature objectAtIndex: i] combatValue] >= [[attackerRolledDice objectAtIndex:i] integerValue] )
            
            attackerNumberOfHits += 1;
        
        
    }
    
    NSLog(@"Attacker can apply %d hits, in Ranged round",attackerNumberOfHits);
    
    
    for(int i = 0 ; i < [defenderRangedCreature count] ; i++){
        
        if([[defenderRangedCreature objectAtIndex: i] combatValue] >= [[defenderRolledDice objectAtIndex:i] integerValue] )
            
            defenderNumberOfHits += 1;
    }
    
    NSLog(@"defender can apply %d hits, in Ranged round",attackerNumberOfHits);
    
    
    //melee round
    attackerNumberOfHits = 0;
    defenderNumberOfHits = 0;
    for(int i = 0 ; i < [attackerMeleeCreature count]; i++){
        int r = 0;
        NSLog(@"Player atacker roll dice for %d ",[attackerMeleeCreature count]);
        if([[attackerMeleeCreature objectAtIndex:i] isCharge]){
            [self setOneDice: (arc4random() % 6) + 1];
            [self setSecondDice: (arc4random() % 6) + 1];
            r = oneDice + secondDice;
            
        }
        else {
               [self setOneDice: (arc4random() % 6) + 1];
            r = oneDice;
            
        }
        
        [attackerRolledDice addObject:[NSNumber numberWithInteger:r]];
    }
    
    
    for(int i = 0 ; i < [defenderMeleeCreature count]; i++){
        
        NSLog(@"Player defender roll dice for %d ",[defenderMeleeCreature count]);
        int r = 0;
        if([[defenderMeleeCreature objectAtIndex:i] isCharge]){
            [self setOneDice: (arc4random() % 6) + 1];
            [self setSecondDice: (arc4random() % 6) + 1];
            r = oneDice + secondDice;
            
        }
        else {
            [self setOneDice: (arc4random() % 6) + 1];
            r = oneDice;
            
        }
        [self setOneDice: (arc4random() % 6) + 1];
        
        [defenderRolledDice addObject:[NSNumber numberWithInteger:r]];
    }
    
    for(int i = 0 ; i < [attackerMeleeCreature count] ; i++){
        
        if([[attackerMeleeCreature objectAtIndex: i] isCharge])
        {
            int d1 = 0;
            int d2 = 0;
            d1 = [[attackerRolledDice objectAtIndex:i] integerValue]/2;
            d2 = [[attackerRolledDice objectAtIndex:i] integerValue] - d1;
            if([[attackerMeleeCreature objectAtIndex: i] combatValue] >= d1 )
                attackerNumberOfHits += 1;
            if([[attackerMeleeCreature objectAtIndex: i] combatValue] >= d2 )
                attackerNumberOfHits += 1;
        }
        
        else{
            if([[attackerMeleeCreature objectAtIndex: i] combatValue] >= [[attackerRolledDice objectAtIndex:i] integerValue] )
            
            attackerNumberOfHits += 1;
        }
        
        
    }
    
    NSLog(@"Attacker can apply %d hits, in Melee round",attackerNumberOfHits);
    
    
    for(int i = 0 ; i < [defenderMeleeCreature count] ; i++){
        
        if([[defenderMeleeCreature objectAtIndex: i] isCharge])
        {
            int d1 = 0;
            int d2 = 0;
            d1 = [[defenderRolledDice objectAtIndex:i] integerValue]/2;
            d2 = [[defenderRolledDice objectAtIndex:i] integerValue] - d1;
            if([[defenderMeleeCreature objectAtIndex: i] combatValue] >= d1 )
                defenderNumberOfHits += 1;
            if([[defenderMeleeCreature objectAtIndex: i] combatValue] >= d2 )
                defenderNumberOfHits += 1;
        }
        
        else{
            if([[defenderMeleeCreature objectAtIndex: i] combatValue] >= [[defenderRolledDice objectAtIndex:i] integerValue] )
                
                defenderNumberOfHits += 1;
        }
    }
    
    NSLog(@"defender can apply %d hits, in Melee round",defenderNumberOfHits);
    
    
    //
    
    
    
    
    
    
    //}//end while
    
    
}//end function

*/
}

@end
