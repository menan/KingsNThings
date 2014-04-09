
//  GamePlay.m
//  KingsNThings
//
// Created by Areej Ba Salamah and Menan Vadivel on 2/1/2014.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import "GamePlay.h"
#import "Player.h"
#import "Creature.h"
#import "Bank.h"
#import "GameScene.h"
#import "CombatPhase.h"
#import "Board.h"
#import "GCTurnBasedMatchHelper.h"
#import "NSMutableArrayDictionize.h"
@implementation GamePlay{
    GameScene *scene;
    NSMutableArray *servers;
    Board *board;
    
}

@synthesize me,oneDice,secondDice,players;

@synthesize terrains,scene,phase,battles,order;


-(id) initWithBoard:(id) b{
    
    self = [super init];
    if(self){
        board = (Board *) b;
        
        players = [[NSMutableArray alloc] initWithObjects:[[Player alloc] init],[[Player alloc] init],[[Player alloc] init],[[Player alloc] init], nil];
        
        terrains = [[NSMutableArray alloc]init];
        battles = [[NSMutableArray alloc]init];
      
        oneDice = 0;
        secondDice = 0;
        phase = Initial;
        order = ClockWise;
    
        
        [self advancePhase:Initial];
        
    }
    
    return self;
    
}


- (int) currentPlayerId{
    return [players indexOfObject: [self currentPlayer]];
}

- (Player *) currentPlayer{
    GKTurnBasedMatch *currentMatch = [[GCTurnBasedMatchHelper sharedInstance] currentMatch];
    int index = [currentMatch.participants indexOfObject:currentMatch.currentParticipant];
//    NSLog(@"index of the player: %d",index);
    return [players objectAtIndex:index];
}

- (int) totalPlayers{
    int totalParticipants = 0;
    GKTurnBasedMatch *currentMatch = [[GCTurnBasedMatchHelper sharedInstance] currentMatch];
    for (GKTurnBasedParticipant *p in currentMatch.participants) {
        if (p.status == GKTurnBasedParticipantStatusActive || p.status == GKTurnBasedParticipantStatusDone || p.status == GKTurnBasedParticipantStatusInvited) {
            totalParticipants++;
        }
    }
    return totalParticipants;
}



-(NSInteger)buildingCost{
    if([players count] == 4)
        return 20;
    else
        return 15;
    
    
}
-(void) assignScene:(GameScene*)sce{
    scene = sce;
}



- (BOOL) recruitmentComplete{
    
    BOOL done = YES;
    int i = 0;
    for (Player *p in players) {
        i++;
        //            NSLog(@"Player %d, done: %d",i, phase);
        done &= p.recruitsRemaining == 0;
    }
    return done;
}

- (void) checkInitalRecruitmentComplete{
    if (phase == Initial) {
        if ([self recruitmentComplete]) {
            [self advancePhase:GoldCollection];
        }
    }
}



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

- (BOOL) validateMove:(Terrain *) oldTerrain withTerrain:(Terrain *) newTerrain{
    
    //Calculate if movement is valid
    
    float dx = [newTerrain getAbsoluteX] - [oldTerrain getAbsoluteX];
    float dy = [newTerrain getAbsoluteY] - [oldTerrain getAbsoluteY];
    
    float distance = sqrt(dx*dx + dy*dy); //uses pythagorean theorem to caculate the distance
    
    if (distance < 75)
        return YES;
    else
        return NO;
}


-(void) movementPhase:(Player *)player withArmy:(Army*)army onTerrian:(Terrain *)newTerrain{
    
    Terrain* oldTerrain = army.terrain;
    Player *defender = [self findPlayerByTerrain:newTerrain];
    
    //to check to see if palyer only moved one hex
    BOOL validMove = [self validateMove:newTerrain withTerrain:oldTerrain];
    
    if (validMove && [army stepsMoved] < 4 ) {
        //must be one hex
        //[army setTerrain:newTerrain];
        
        if([newTerrain.type isEqualToString:@"Swamp"]||
           [newTerrain.type isEqualToString:@"Mountain"]||
           [newTerrain.type isEqualToString:@"Forest"]||
           [newTerrain.type isEqualToString:@"Jungle"]){
            [army updateMovingSteps:2];
            
        }
        
        else{
            [army updateMovingSteps:1];
        }
        //player is the owner of the terrain
        if([player isEqual:defender]){
            int counter = 0;
            for(Army* s in player.stacks){
                if([s.terrain isEqual:newTerrain])
                    counter += [s creaturesInArmy];
            }
            if((counter + [army creaturesInArmy]) > 10){
                NSLog(@"Invalid move cannot have more than 10 creatures on one terrain");
                [army setPosition:oldTerrain.position];
            }
            else
                [army setTerrain:newTerrain];
            
        }
        //else if dude has army to deal with before he acquires this terrain
        else if(![defender isEqual:player] && [self thereAreDefendersOnTerrain:newTerrain]){
            Army *defArmy = [defender findArmyOnTerrain:newTerrain];
            Building* building = [defender getBuildingOnTerrain:newTerrain];
            //SpecialIncome* sp = [defender getSpecialIncomeOnTerrain:newTerrain];
            SpecialIncome* sp = [[SpecialIncome alloc]initWithImage:@"-n City -a 2" atPoint:newTerrain.position];
            
            if(building)
                [defArmy setBuilding:building];
            
            if([sp type] == Village || [sp type] == City)
                [defArmy addCreatures:sp];
            
            CombatPhase* combat = [[CombatPhase alloc]initWithMarkerAtPoint:newTerrain.position onBoard:[board getBoard] andMainScene:[self scene]];
            [combat setDefenderArmy:defArmy];
            
            [combat setDefender: defender];
            [combat setAttacker:player];
            [combat setAttackerArmy:army];
            [combat setType:defendingHex];
            
            [battles addObject:combat];
            
            player.doneTurn=YES;
            if(player.playingOrder == 1)
                [self combatPhase];
        }
        
        
        else if(!defender && ([[self stacksOnTerrain:newTerrain] count] == 0)) { // no one owns terrain
            //dude might fight with random creatures on the terrain since theres no one there.
            
            NSLog(@"Inside explor");
            
            NSRunLoop *loop = [NSRunLoop currentRunLoop];
            oneDice = 0;
            secondDice = 0;
            
            while ( ((oneDice == 0 ) && (secondDice == 0)) && [loop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]])
            {}
            
            if (oneDice == 1 || oneDice == 6 || secondDice == 1 || secondDice == 6){
                
                [army setTerrain:newTerrain];
                [board captureHex:player atTerrain:newTerrain];
                player.doneTurn=YES;
                //[self advancePhase:Combat];
                
            }
            
            else{ // random army should appear
                Army* defending;
                if(oneDice >0){
                    defending = [board createRandomArmy:oneDice atPoint:army.position andTerrain:newTerrain];
                }
                else{
                    defending = [board createRandomArmy:secondDice atPoint:army.position andTerrain:newTerrain];
                }
                
                Player* tempDefender = [[Player alloc] init ];
                [tempDefender setArmy:defending];
                CombatPhase* combat = [[CombatPhase alloc]initWithMarkerAtPoint:newTerrain.position onBoard:[board getBoard] andMainScene:[self scene]];
                [combat setDefenderArmy:defending];
                [combat setDefender: tempDefender];
                [combat setAttacker:player];
                [combat setAttackerArmy:army];
                [combat setType:exploration];
                
                [battles addObject:combat];
                
                //[army setName:@"bowl"];
                
                /* player.isWaitingCombat = YES;
                 [player.combat setObject:army forKey:@"withArmy"];
                 [player.combat setObject:tempDefender forKey:@"andPlayer"];
                 [player.combat setObject:defender forKey:@"andDefenderArmy"];
                 [player.combat setObject:NO forKey:@"isDefinding"];*/
                
            }
        }
    }
    
    /*
     //if a player ends movment on terrain owned but not defended
    else if (defender && ![self thereAreDefendersOnTerrain:newTerrain]){ // defender without army
        
        [army setTerrain:newTerrain];
        [defender removeTerrainfromTerritories:newTerrain];
        //[player addNewTerrain:newTerrain];
        [board captureHex:player atTerrain:newTerrain];
        
    }*/

    
    else {
//        NSLog(@"user must have moved more than one hex, ignored");
        //        float xPos = [terrain getAbsoluteX];
        //        float yPos = [terrain getAbsoluteY];
        [army setPosition: oldTerrain.position];
    }
  
}



/*- (void) initiateCombat: (Player*) p{
    NSLog(@"Player Playing order: %d", p.playingOrder);
    if (p.isWaitingCombat) {
        Army *a = [p.combat objectForKey:@"withArmy"];
        Player *defender = [p.combat objectForKey:@"andPlayer"];
        Army *defArmy = [p.combat objectForKey:@"andDefenderArmy"];
        p.isWaitingCombat = NO;
        BOOL type = [[p.combat objectForKey:@"isDefending"] intValue];
        //[self combatPhase:p withArmy:a andPlayer:defender withArmy:defArmy isDefending:type];
    }
}*/
/*- (void) initiateCombat{
    Player* attacker,*defender;
    Army* attacking,*defending;
    Terrain* combatPlace;
    NSArray* players;
    for(CombatPhase* combat in battles){
        
        combatPlace = [self findTerrainAt:[combat battle].position];
        defender = [self findPlayerByTerrain:combatPlace];
        players = [self findPlayersByTerrain:combatPlace];
        
        for(Player* p in players){
            if(![p isEqual:defender]){
                attacker = p;
                break;
            }
        }
        attacking = [attacker findArmyOnTerrain:combatPlace];
        defending = [defender findArmyOnTerrain:combatPlace];
        if(!defender)
        
        //[self combatPhase:attacker withArmy:attacking andPlayer:defender withArmy:defending isDefending:YES];
        
    }
    
    
}
*/

-(void) combatPhase{
    NSLog(@"inside Combat phase");
    //CombatPhase* combat ;
    
    for (CombatPhase* combat in battles){
        
        if(combat.attacker == [self currentPlayer] || combat.defender == [self currentPlayer])
            [combat drawScene];
        
        if([combat.attacker hasWonCombat]){
            if(combat.type == exploration)
                [board captureHex:combat.attacker atTerrain:combat.defenderArmy.terrain];
            
        }
        else if ([combat.defender hasWonCombat]){
        
        }
        for(Creature* cre in [combat thingsToBeReturned]){
            [board returnThingToBowl:cre];
        }
        if([combat whoRetreated] == attackerRetreated){
            
        }
        else if ([combat whoRetreated] == defenderRetreated){
            
            [board captureHex:[combat attacker] atTerrain:[combat attackerArmy].terrain];
        }
        
    }
    /*if([attacker hasWonCombat]){
        
        
    }
    else if ([defender hasWonCombat]){
    }
     */
    
    
}
-(void) postCombat:(Player*)winner andLoser:(Player*)loser andTerrain:(Terrain*)terrain{
    oneDice = 0;
    secondDice = 0;
    int numOfRolles = 0;
    
    UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Post combat" message: @"Roll " delegate: self                                       cancelButtonTitle:@"GOT IT !" otherButtonTitles:nil];
    
    [error show];
    
    if(![winner isEqual:loser]){
        
        if([loser getSpecialIncomeOnTerrain:terrain])
            numOfRolles +=1;
        if ([loser getBuildingOnTerrain:terrain])
            numOfRolles +=1;
        
        
        NSString* message = [NSString stringWithFormat:@"%@ %d %@",@"Roll one dice for ",numOfRolles,@" time(s)."];
        
        UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Post combat" message:message delegate: self cancelButtonTitle:@"GOT IT !" otherButtonTitles:nil];
        
        [error show];
        NSRunLoop *loop = [NSRunLoop currentRunLoop];
        
        for(int i = 0 ; i < numOfRolles;i++ ){
        while ( (oneDice == 0) && (secondDice == 0) &&[loop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]])
        {}
        
        if (oneDice == 1 || oneDice == 6 || secondDice == 1 || secondDice == 6){
            if(i == 0 ){
                SpecialIncome* sp = [loser getSpecialIncomeOnTerrain:terrain];
                [sp setInBowl:YES];
                [board returnThingToBowl:sp];
            }
            if(i == 1){
                Building* b = [loser getBuildingOnTerrain:terrain];
                [b setStage:(b.stage-1)];
                [b removeFromParent];
                [[board getBoard] addChild:b];
            }
        }
        else {
            if(i == 0 ){
                SpecialIncome* sp = [loser getSpecialIncomeOnTerrain:terrain];
                [[loser specialIncome] removeObject:sp];
                [winner addSpecialIncome:sp];
            }
            if(i == 1){
                Building* b = [loser getBuildingOnTerrain:terrain];
                [loser removeBuilding:b];
                [winner setBuilding:b];
            }
        }
            
        }
        

        
    }
    
    
}


-(void) combatPhase:(Player *)attacker withArmy:(Army*)attackerArmy andPlayer:(Player*)defender withArmy:(Army*)defenderArmy{
    NSLog(@"inside Combat phase");
    //CombatPhase* combat ;
    
    for (CombatPhase* combat in battles){
        [combat drawScene];
    
    }
    if([attacker hasWonCombat]){
        
        
    }
    else if ([defender hasWonCombat]){
    }
}

-(void) pahses:(NSString*)pahse{
    NSRunLoop *loop = [NSRunLoop currentRunLoop];
    while ([loop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]])
    {
        
    }
}



- (void) checkBluffForPlayer:(Player *) player{
    //would check for each creatures to see if theyre bluff n add bluff to them
    NSMutableArray *terrainStrings;
    
    for(Terrain *t in [player getTerritories]){
        if (![terrainStrings containsObject:t.type]) {
            NSLog(@"adding terrain type %@",t.type);
            [terrainStrings addObject:t.type];
        }
    }
    for (Army * army in player.stacks) {
        for (Creature *c in army.creatures) {
            if ([c.name hasSuffix:@"Lord"] || [c.name hasSuffix:@"King"] || [c.name hasSuffix:@"Master"]){
                //dude gets to support other creatures in the territory who don't belong in there
                NSString *terrain = [c.name stringByReplacingOccurrencesOfString:@"Lord" withString:@""];
                terrain = [terrain stringByReplacingOccurrencesOfString:@"King" withString:@""];
                terrain = [terrain stringByReplacingOccurrencesOfString:@"Master" withString:@""];
                NSLog(@"Terrain lord was found for terrain: %@",terrain);
                [terrainStrings addObject:terrain];
            }
        }
    }
    
    NSLog(@"terrain strings :%@",terrainStrings);
    int affected = 0;
    for (Army * army in player.stacks) {
        for (Creature *c in army.creatures) {
            if (![terrainStrings containsObject:c.terrainType]) {
                c.isBluff = YES;
                c.color = [SKColor blackColor];
                c.colorBlendFactor = .60;
                affected++;
            }
        }
    }
    
    NSLog(@"%d discovered to bluff",affected);
}





- (void) useSpecialPowerFor:(Creature *) creature{
    
    if (phase != SpecialPower) {
        NSLog(@"Dont jump ahead, chill");
        return;
    }
    if (creature.isSpecial) {
        NSLog(@"this aint even special tho");
        return;
    }
    
    if ([creature.name isEqualToString: @"Assassin Primus"]) {
        //make an asssasination attempt on the enemy
        //
        

    }
    else if ([creature.name isEqualToString: @"Baron Munchausen"]){
        //inflicts 1 hit on all forts, villagse, cities in a hex before combat rounds are faought
    }
    else if ([creature.name isEqualToString: @"Deerhunter"]){
        //move through all terrain as 1 movement if its present in the stack
        //can also leave enemy occupied hex
    }
    else if ([creature.name isEqualToString: @"Dwarf King"]){
        //doubles the income from mines
    }
    else if ([creature.name isEqualToString: @"Grand Duke"]){
        //=Baron Munchausen
    }
    else if ([creature.name isEqualToString: @"Marksman"]){
        //you have to choose 2/5 combat value before the marksman shot
        //if you choose 2, if you choose 2 and hit, then you choose which enemy counter to eliminate
        //if you choose 5, battle is fought as usual
    }
    else if ([creature.name isEqualToString: @"Master Thief"]){
        //you steal things based by comparing the role and combat value :/
    }
    else if ([creature.name isEqualToString: @"Sword Master"]){
        //when this dude is hit, you roll a dice if its 1/6 he dies or else he comes back for next session
        //he can only take one hit and survive or else he is eliminated
    }
    else if ([creature.name isEqualToString: @"Elf Lord"]){
        //nothing, but hes powerful apparently
    }
    else if ([creature.name hasSuffix:@"Lord"] || [creature.name hasSuffix:@"King"] || [creature.name hasSuffix:@"Master"]){
        //dude gets to support other creatures in the territory who don't belong in there
        
        
        
    }
    else if ([creature.name isEqualToString: @"Warlord"]){
        //can get one enemy per battle to join forces with him
    }
    else{
        //you aint got no powers :(
    }
    
}


- (NSString *) advancePhase: (Phase) p{
    phase = p;
    return [self advancePhase];
    
    //if(one turn has finished){
      //[self checkForWinner];
    //}
    
}
-(NSString *)advancePhase{
    
//    SpecialPower,
//    RandomEvents
//    
    NSArray *phaseText = @[@"Initial Phase", @"Construction Phase", @"Movement Phase",@"Recruitment Phase",@"Recruit Special Character", @"Combat Phase", @"Gold Collection Phase", @"Special Power Phase", @"Random Events Phase"];
//    BOOL done = YES;
  
    
    
    //if its recruitment phase, 2 more recruits awarded
    if (phase == Recruitment) {
        
        for (Player *p in players) {
            int freeRecs = [p freeRecruitsCount];
            p.recruitsRemaining += freeRecs; //adds free recruits based on the rounded up # of terrains owned/2
            [self checkBluffForPlayer:p];
        }
        
        [board updateRecruitLabel:[self currentPlayer]];
        
    }
    else if (phase == SpecialRecruitment){
        for (Player *p in players) {
            p.recruitsRemaining = 1; //adds free recruits based on the rounded up # of terrains owned/2
            p.specialRecruitsRemaining = 1; //adds free recruits based on the rounded up # of terrains owned/2
        }
        [board updateRecruitLabel:[self currentPlayer]];
    }
    
    else if(phase == Combat){
            if (battles.count > 0)
                [self combatPhase];
    }
    board.textLabel.text = [phaseText objectAtIndex:phase];
    
    return [phaseText objectAtIndex:phase];
}


-(Player*) checkForWinner{
    Player* winner;
    int counter = 0;
    for(Player* p in players){
        if([p hasCitadel]){
            winner = p;
            counter +=1;
        }
    }
    if(counter==1)
        return winner;
    else
        return nil;
    
}

//========================================================
//helper functions for game center stuff.


#pragma get player info as dictionary for networking

- (NSDictionary *) getBoardAsADictionary{
    
    NSMutableDictionary *dicData = [[NSMutableDictionary alloc] init];
    
    NSNumber *phaseNS = [NSNumber numberWithInt:phase];
    [dicData setObject:phaseNS forKey:@"phase"];
    [dicData setObject:board.terrainsDictionary forKey:@"terrains"];
    [dicData setObject:board.markersArray forKey:@"markers"];
    [dicData setObject:[self getPlayerStacksAsDictionary] forKey:@"stacks"];
    [dicData setObject:[self getPlayerRackAsDictionary] forKey:@"racks"];
    [dicData setObject:[board.bowl dictionize] forKey:@"bowl"];
    [dicData setObject:[self getPlayerBuildingsAsDictionary] forKey:@"buildings"];
    [dicData setObject:[self getGoldsAsDictionary] forKey:@"balance"];
    [dicData setObject:[self getPlayerSettingsAsDictionary] forKey:@"user-settings"];
    [dicData setObject:[battles dictionize] forKey:@"battles"];
    [dicData setObject:[self getPlayerSICsAsDictionary] forKey:@"sic"];
    
    
    
    NSLog(@"battles: %@", [battles dictionize]);
    
    return dicData;
}



- (NSArray *) getPlayerSettingsAsDictionary{
    NSMutableArray *arrayStacks = [[NSMutableArray alloc] init];
    int i = 0;
    for (Player *p in players) {
        NSMutableDictionary *playerDict = [[NSMutableDictionary alloc] init];
        [playerDict setObject:[NSNumber numberWithInt:i] forKey:@"playerId"];
        [playerDict setObject:[NSNumber numberWithInt:p.recruitsRemaining] forKey:@"recruitsRemaining"];
        [playerDict setObject:[NSNumber numberWithInt:p.specialRecruitsRemaining] forKey:@"specialRecruitsRemaining"];
        [arrayStacks addObject:playerDict];
        i++;
    }
    //    NSLog(@"users settings array: %@",arrayStacks);
    return arrayStacks;
}

- (NSArray *) getPlayerStacksAsDictionary{
    NSMutableArray *arrayStacks = [[NSMutableArray alloc] init];
    int i = 0;
    for (Player *p in players) {
        NSMutableArray *playerArray = [p.stacks dictionize];
        NSMutableDictionary *playerDict = [[NSMutableDictionary alloc] init];
        [playerDict setObject:playerArray forKey:@"armies"];
        [playerDict setObject:[NSNumber numberWithInt:i] forKey:@"playerId"];
        [arrayStacks addObject:playerDict];
        
        i++;
    }
    NSLog(@"stacks array: %@",arrayStacks);
    return arrayStacks;
}


- (NSArray *) getPlayerRackAsDictionary{
    NSMutableArray *arrayStacks = [[NSMutableArray alloc] init];
    int i = 0;
    for (Player *p in players) {
        NSMutableArray *playerArray = [p.rack dictionize];
        NSMutableDictionary *playerDict = [[NSMutableDictionary alloc] init];
        [playerDict setObject:playerArray forKey:@"armies"];
        [playerDict setObject:[NSNumber numberWithInt:i] forKey:@"playerId"];
        [arrayStacks addObject:playerDict];
        
        i++;
    }
    //    NSLog(@"stacks array: %@",arrayStacks);
    return arrayStacks;
}


//SIC = special income counter ;)
- (NSArray *) getPlayerSICsAsDictionary{
    NSMutableArray *arrayStacks = [[NSMutableArray alloc] init];
    int i = 0;
    for (Player *p in players) {
        NSMutableArray *playerArray = [p.specialIncome dictionize];
        NSMutableDictionary *playerDict = [[NSMutableDictionary alloc] init];
        [playerDict setObject:playerArray forKey:@"counters"];
        [playerDict setObject:[NSNumber numberWithInt:i] forKey:@"playerId"];
        [arrayStacks addObject:playerDict];
        
        i++;
    }
    NSLog(@"SICs array: %@",arrayStacks);
    return arrayStacks;
}



- (NSArray *) getPlayerBuildingsAsDictionary{
    NSMutableArray *arrayStacks = [[NSMutableArray alloc] init];
    for (Player *p in players) {
//        NSLog(@"buildings array: %d",p.buildings.count);
        [arrayStacks addObject:[p.buildings dictionize]];
    }
    return arrayStacks;
}


- (NSArray *) getGoldsAsDictionary{
    NSMutableArray *arrayStacks = [[NSMutableArray alloc] init];
    int i = 0;
    for (Player *p in players) {
        NSMutableDictionary *playerDict = [[NSMutableDictionary alloc] init];
        
        NSMutableDictionary *gold = [[NSMutableDictionary alloc] init];
        
        [gold setValue:[NSNumber numberWithInt:p.bank.oneGold] forKey:@"1s"];
        [gold setValue:[NSNumber numberWithInt:p.bank.twoGold] forKey:@"2s"];
        [gold setValue:[NSNumber numberWithInt:p.bank.fiveGold] forKey:@"5s"];
        [gold setValue:[NSNumber numberWithInt:p.bank.tenGold] forKey:@"10s"];
        [gold setValue:[NSNumber numberWithInt:p.bank.fifteenGold] forKey:@"15s"];
        [gold setValue:[NSNumber numberWithInt:p.bank.twentyGold] forKey:@"20s"];
        
        
        [playerDict setObject:gold forKey:@"golds"];
        
        [playerDict setObject:[NSNumber numberWithInt:i] forKey:@"playerId"];
        [arrayStacks addObject:playerDict];
        i++;
    }
    
    
    NSMutableDictionary *playerDict = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *gold = [[NSMutableDictionary alloc] init];
    
    [gold setValue:[NSNumber numberWithInt:board.bank.oneGold] forKey:@"1s"];
    [gold setValue:[NSNumber numberWithInt:board.bank.twoGold] forKey:@"2s"];
    [gold setValue:[NSNumber numberWithInt:board.bank.fiveGold] forKey:@"5s"];
    [gold setValue:[NSNumber numberWithInt:board.bank.tenGold] forKey:@"10s"];
    [gold setValue:[NSNumber numberWithInt:board.bank.fifteenGold] forKey:@"15s"];
    [gold setValue:[NSNumber numberWithInt:board.bank.twentyGold] forKey:@"20s"];
    
    
    [playerDict setObject:gold forKey:@"golds"];
    
    [playerDict setObject:[NSNumber numberWithInt:-1] forKey:@"playerId"];
    [arrayStacks addObject:playerDict];
    
    
    return arrayStacks;
}


//========================================================
//functions for game center stuff.

#pragma GameCenter Functions


- (void) presentGCTurnViewController:(id)sender {
    [[GCTurnBasedMatchHelper sharedInstance] findMatchWithMinPlayers:2 maxPlayers:4 viewController:scene.controller];
}



- (void) endMatch:(id)sender {
    GKTurnBasedMatch *currentMatch = [[GCTurnBasedMatchHelper sharedInstance] currentMatch];
    NSString *text = @"Suppp!!";
    NSData *data = [text dataUsingEncoding:NSUTF8StringEncoding];
    
    [currentMatch endMatchInTurnWithMatchData:data completionHandler:^(NSError *error) {
        if (error) {
            NSLog(@"Error ending turn: %@", error);
        }
        else{
            NSLog(@"Send Turn, %@, participants: %@", data, currentMatch.participants);
        }
    }];
}

- (void)endTurn:(id)sender {
    GKTurnBasedMatch *currentMatch = [[GCTurnBasedMatchHelper sharedInstance] currentMatch];
    
    NSLog(@"current phase: %d",phase);
    
    
    if (currentMatch) {
        NSUInteger currentIndex = [currentMatch.participants indexOfObject:currentMatch.currentParticipant];
        GKTurnBasedParticipant *nextParticipant;
        
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:[self getBoardAsADictionary]];
        
        
        NSUInteger nextIndex = (currentIndex + 1) % [currentMatch.participants count];
        nextParticipant = [currentMatch.participants objectAtIndex:nextIndex];
        
        int index = nextIndex;
        
        while (nextParticipant.status != GKTurnBasedParticipantStatusActive && nextParticipant.status != GKTurnBasedParticipantStatusInvited) {
            if (order == ClockWise)
                index ++;
            else
                index --;
            
            NSUInteger nextIndex = index % [currentMatch.participants count];
            NSLog(@"current player id %d, status: %d",currentIndex, nextParticipant.status);
            nextParticipant = [currentMatch.participants objectAtIndex:nextIndex];
        }
        
        board.doneButton.hidden = YES;
        board.canTapDone = NO;
        NSArray *nextParticipants = [[NSArray alloc] initWithObjects:nextParticipant,nil];

        NSTimeInterval interval = 3600;
        
        [currentMatch endTurnWithNextParticipants:nextParticipants turnTimeout:interval matchData:data completionHandler:^(NSError *error) {
            if (error) {
                NSLog(@"%@", error);
                //                statusLabel.text = @"Oops, there was a problem.  Try that again.";
            } else {
                NSLog(@"done ending turn : %@",nextParticipant);
                //                statusLabel.text = @"Your turn is over.";
                //                textInputField.enabled = NO;
            }
        }];
    }
    else{
        NSLog(@"No matches present b.");
    }
    
    
}



-(BOOL) validateHex:(Terrain*)terrain forPlayer:(Player*)player{
    
    BOOL validMove = YES;
    NSMutableArray* temp = [self getOthersTerrains:player];
        //has to iterate through all terrains because they can be set in different orders for fuk sake lol
    for (NSMutableArray *arr in temp) {
        for(Terrain* t in arr){
            float dx = [t getAbsoluteX] - [terrain getAbsoluteX];
            float dy = [t getAbsoluteY] - [terrain getAbsoluteY];
        
            float distance = sqrt(dx*dx + dy*dy); //uses pythagorean theorem to caculate the distance
        
            if (distance < 75) {
                validMove = NO;
                break;
            }
        }
        
    }
    return validMove;
    
}

-(NSMutableArray*) getOthersTerrains:(Player*) player{
    
    NSMutableArray* tempArray = [[NSMutableArray alloc]init];
    
    for(Player* p in players){
        
        if(![p isEqual:player]){
            [tempArray addObject:[p getTerritories]];
        }
        
    }
    
    return tempArray;
}

-(BOOL) isHexAdjacent:(Terrain*)terrain forPlayer:(Player*)p{
    BOOL validMove = NO;
    NSMutableArray* temp = [p getTerritories];
    
    for(Terrain* t in temp){
        float dx = [t getAbsoluteX] - [terrain getAbsoluteX];
        float dy = [t getAbsoluteY] - [terrain getAbsoluteY];
        
        float distance = sqrt(dx*dx + dy*dy); //uses pythagorean theorem to caculate the distance
        
        if (distance < 75) {
            validMove = YES;
            
        }
    }
    if([temp count] == 0){
        validMove = YES;
    }
    
    return validMove;
    
   
}


// =============================================
// please use these helper functions.



//locates the terrain at a specific point
-(Terrain*) findTerrainAt:(CGPoint)thisPoint{
    for (Terrain *terrain in terrains) {
        if (terrain.position.x == thisPoint.x && terrain.position.y == thisPoint.y) {
            return terrain;
        }
    }
    return nil;
}

//locates terrain class object around the current point
- (Terrain *) locateTerrainAt:(CGPoint)thisPoint{
    NSArray * nodes = [[board getBoard] nodesAtPoint:thisPoint];
    
    for (id node in nodes) {
        if ([node isKindOfClass:[Terrain class]]) {
//            NSLog(@"terrain located");
            return node;
        }
    }
    return nil;
}


//returns the owner of the hex
- (Player *) findPlayerByTerrain:(Terrain *) terrain{
    for (Player *p in players) {
        if ([[p getTerritories] containsObject:terrain]) {
            return p;
        }
    }
    return nil;
}


//returns the total number of users in the terrain
//I think it should be used only when we need to find multiple users becoz a terrain will not alwys has army
- (NSArray *) findPlayersByArmyOnTerrain:(Terrain *) terrain{
    NSMutableArray *playersArray = [[NSMutableArray alloc] init];
    
    for (Player *p in players) {
        for (Army * a in p.stacks) {
            if ([a.terrain isEqual:terrain]) {
                [playersArray addObject:p];
            }
        }
    }
    return playersArray;
}

- (NSArray *) findPlayersByTerrain:(Terrain *) terrain{
    NSMutableArray *playersArray = [[NSMutableArray alloc] init];
    
    for (Player *p in players) {
        for (Army * a in p.stacks) {
            if ([a.terrain isEqual:terrain]) {
                [playersArray addObject:p];
                break;
            }
        }
    }
    return playersArray;
}

-(Player*) findPlayerArmy:(Army*) army{
    
    for(Player* p in players){
        if([p.stacks containsObject:army])
            return p;
    }
    return nil;
}

//returns current users on the terrain except the owner
- (NSArray *) findAttackersByTerrain:(Terrain *) terrain{
    NSMutableArray *playersArray = [self findPlayersByTerrain:terrain];
    Player *owner = [self findPlayerByTerrain:terrain];
    
    if ([playersArray containsObject:owner]) {
        [playersArray removeObject:owner];
    }
    return playersArray;
    
}


//tells you if theres an defending thing present on the provided terrain
- (BOOL) thereAreDefendersOnTerrain:(Terrain *) terrain{
   
        for(Player* p in players){
            for(Army* army in [p stacks]){
                if([army.terrain isEqual:terrain])
                    return YES;
            }
            if([p getSpecialIncomeOnTerrain:terrain].type == City ||
                [p getSpecialIncomeOnTerrain:terrain].type ==Village ||
                [p getBuildingOnTerrain:terrain]){
                return YES;
                
            }
        }
        
    
    return NO;
}

- (BOOL) thereIsArmyOnTerrain:(Terrain *) terrain{
    NSArray* playersOnTerrain = [self findPlayersByTerrain:terrain];
    if (playersOnTerrain.count > 0) {
        for(Player* p in playersOnTerrain){
            for(Army* army in [p stacks]){
                if([army.terrain isEqual:terrain])
                    return YES;
            }
        }
        
    }
    return NO;
}



-(NSArray *) stacksOnTerrain:(Terrain*)terrain{
    NSMutableArray* stacks = [[NSMutableArray alloc]init];
    NSArray* playersOnTerrain =[self findPlayersByTerrain:terrain];
    for(Player* p in playersOnTerrain){
        for(Army* aStack in [p stacks]){
            if([aStack.terrain isEqual:terrain])
                [stacks addObject:aStack];
        }
    }

    return stacks;
}

// to reset all values used in some phases like moving steps and battles array
-(void) resetValues{
    
    [battles removeAllObjects];
    
    for(Player* p in players){
        for(Army* army in p.stacks){
            [army resetMovingSteps];
        }
    }
}

@end
