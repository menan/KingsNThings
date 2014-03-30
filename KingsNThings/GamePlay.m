
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
#import "MyScene.h"
#import "CombatPhase.h"
#import "Board.h"
#import "GCTurnBasedMatchHelper.h"

@implementation GamePlay{
    MyScene *scene;
    NSMutableArray *servers;
    Board *board;
    
}

@synthesize me,oneDice,secondDice,players;

@synthesize p1Stack1,p1Stack2,p2Stack1,p3Stack1,p3Stack2,p3Stack3,p4Stack1,p4Stack2,p4Stack3,terrains,scene,phase;


-(id) initWithBoard:(id) b{
    
    self = [super init];
    if(self){
        board = (Board *) b;
        
        players = [[NSMutableArray alloc] initWithObjects:[[Player alloc] init],[[Player alloc] init],[[Player alloc] init],[[Player alloc] init], nil];
        
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
    
      
        oneDice = 0;
        secondDice = 0;
        phase = Initial;
        
        [self advancePhase:Initial];
        
        
        p1Stack1 = @[@"-n Old Dragon -s Fly -s Magic -a 4",@"-n Elephant -t Jungle -s Charge -a 4",@"-n Giant Spider -t Desert -a 1",@"-n Brown Knight -t Mountain -s Charge -a 4",@"-n Giant -t Mountain -s Range -a 4",@"-n Dwarves -t Mountain -s Range -a 2"];
        
        
        
       
        p1Stack2 = @[@"-n Skletons -c 2 -t Desert -a 1",@"-n Watusi -t Jungle -s 2",@"-n Goblins -c 4 -t Mountain -a 1",@"-n Orge Mountain -t Mountain -a 2"];
        p2Stack1 = @[@"-n Pterodactyl Warriors -c 2 -t Jungle -s Fly -s Range -a 2",@"-n Sandworm -t Desert -a 3",@"-n Green Knight -t Forest -s Charge -a 4",@"-n Dervish -c 2 -t Desert -s Magic -a 2",@"-n Crocodiles -t Jungle -a 2",@"-n Nomads -c 2 -t Desert -a 1",@"-n Druid -t Forest -s Magic -a 3",@"-n Walking Tree -t Forest -a 5",@"-n Crawling Vines -t Jungle -a 6",@"-n Bandits -t Forest -a 2"];
        
        p3Stack1 = @[@"-n Centaur -t Plains -a 2",@"-n Camel Corps -t Desert -a 3",@"-n Farmers -c 4 -t Plains -a 1",@"-n Farmers -c 4 -t Plains -a 1"];
        p3Stack2 = @[@"-n Genie -t Desert -s Magic -a 4",@"-n Skletons -c 2 -t Desert -a 1",@"-n Pygmies -t Jungle -a 2"];
        p3Stack3 = @[@"-n Great Hunter -t Plains -s Range -a 4",@"-n Nomads -c 2 -t Desert -a 1",@"-n Witch Doctor -t Jungle -s Magic -a 2"];
        p4Stack1 = @[@"-n Tribesmen -c 2 -t Plains -a 2",@"-n Giant Lizard -c 2 -t Swamp -a 2",@"-n Villains -t Plains -a 2",@"-n Tigers -c 2 -t Jungle -a 3"];
        p4Stack2 = @[@"-n Vampire Bat -t Swamp -s Fly -a 4",@"-n Tribesmen -c 2 -t Plains -a 2",@"-n Dark Wizard -t Swamp -s Fly -s Magic -a 1",@"-n Black Knight -t Swamp -s Charge -a 3"];
        p4Stack3 = @[@"-n Giant Ape -c 2 -t Jungle -a 5",@"-n Buffalo Herd -t Plains -a 3"];
        
        
    }
    
    return self;
    
}


- (Player *) currentPlayer{
    GKTurnBasedMatch *currentMatch = [[GCTurnBasedMatchHelper sharedInstance] currentMatch];
    return [players objectAtIndex:[currentMatch.participants indexOfObject:currentMatch.currentParticipant]];
}




-(NSInteger)buildingCost{
    if([players count] == 4)
        return 20;
    else
        return 15;
    
    
}
-(void) assignScene:(MyScene*)sce{
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



-(void) movementPhase:(Player *)player withArmy:(Army*)army onTerrian:(Terrain *)newTerrain{
    
    NSLog(@"inside movementPhase");
    NSLog(@" player is %d",[player playingOrder]);
    Terrain* oldTerrain = army.terrain;
    Player *defender = [self findPlayerByTerrain:newTerrain];
    NSLog(@"tempPlayer is %d , player is %d",[defender playingOrder],[player playingOrder]);
    
    //to check to see if palyer only moved one hex
    BOOL validMove = NO;
    
        //Calculate if movement is valid
        
        float dx = [newTerrain getAbsoluteX] - [oldTerrain getAbsoluteX];
        float dy = [newTerrain getAbsoluteY] - [oldTerrain getAbsoluteY];
        
        float distance = sqrt(dx*dx + dy*dy); //uses pythagorean theorem to caculate the distance
        
        if (distance < 75) {
            validMove = YES;
        }
        
    
    
    
    if (validMove) {
        //must be one hex
        [army setTerrain:newTerrain];
        
        if([player isEqual:defender]){
            
            NSLog(@"tinside if players are equal");
            if([newTerrain hasArmyOnIt]){
                Army *a = [player findArmyOnTerrain:newTerrain];
                
                if(([a creaturesInArmy] + [army creaturesInArmy]) > 10)
                    NSLog(@"Invalid move cannot have more than 10 creatures on one terrain");
            }
        }
        else{
            //dude has army to deal with before he acquires this terrain
            if([newTerrain hasArmyOnIt]){
                
                Army *defArmy = [defender findArmyOnTerrain:newTerrain];
                if([newTerrain hasBuilding]){
                    
                    [defArmy setBuilding:[defender getBuildingOnTerrain:newTerrain]];
               }
                
                NSLog(@"tinside if players are NOT equal");
                player.isWaitingCombat = YES;
                [player.combat setObject:army forKey:@"withArmy"];
                [player.combat setObject:defender forKey:@"andPlayer"];
                [player.combat setObject:defArmy forKey:@"andDefenderArmy"];
                //[player.combat setObject:YES forKey:@"isDefinding"];
                
                NSLog(@"combat dictionary: %@",player.combat);
            }
            
            else {
                //dude is gonna fight with random creatures on the terrain since theres no one there.
                
                NSLog(@"Inside explor");
                
                NSRunLoop *loop = [NSRunLoop currentRunLoop];
                
                while ( ((oneDice == 0 ) && (secondDice == 0)) && [loop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]])
                {}
                
                if (oneDice == 1 || oneDice == 6 || secondDice == 1 || secondDice == 6){
                    
                    [newTerrain setHasArmyOnIt:NO];
                    
                    [board captureHex:player atTerrain:newTerrain];
                }
                
                else{ // random army should appear
                    Army* defender;
                    if(oneDice >0){
                        defender = [board createRandomArmy:oneDice atPoint:army.position andTerrain:newTerrain];
                    }
                    else{
                        defender = [board createRandomArmy:secondDice atPoint:army.position andTerrain:newTerrain];
                    }
                    
                    Player* tempDefender = [[Player alloc] init ];
                    [tempDefender setArmy:defender];
                    player.isWaitingCombat = YES;
                    [player.combat setObject:army forKey:@"withArmy"];
                    [player.combat setObject:tempDefender forKey:@"andPlayer"];
                    [player.combat setObject:defender forKey:@"andDefenderArmy"];
                    [player.combat setObject:NO forKey:@"isDefinding"];
                    
                }
            }
        }
    }
    else{
        NSLog(@"user must have moved more than one hex, ignored");
//        float xPos = [terrain getAbsoluteX];
//        float yPos = [terrain getAbsoluteY];
       [army setPosition: army.position];
    }
    
    NSLog(@"combat over");
}



- (void) initiateCombat: (Player*) p{
    NSLog(@"Player Playing order: %d", p.playingOrder);
    if (p.isWaitingCombat) {
        Army *a = [p.combat objectForKey:@"withArmy"];
        Player *defender = [p.combat objectForKey:@"andPlayer"];
        Army *defArmy = [p.combat objectForKey:@"andDefenderArmy"];
        p.isWaitingCombat = NO;
        BOOL type = [[p.combat objectForKey:@"isDefending"] intValue];
        [self combatPhase:p withArmy:a andPlayer:defender withArmy:defArmy isDefending:type];
    }
}



-(void) combatPhase:(Player *)attacker withArmy:(Army*)attackerArmy andPlayer:(Player*)defender withArmy:(Army*)defenderArmy isDefending:(BOOL)t{
    NSLog(@"inside Combat phase");
    CombatPhase* combat ;
    if(t){
        combat = [[CombatPhase alloc] initWithAttacker:attacker andDefender:defender andAttackerArmy:attackerArmy andDefenderArmy:defenderArmy andMainScene:scene ofType:defendingHex];
    }
    else{
        combat = [[CombatPhase alloc] initWithAttacker:attacker andDefender:defender andAttackerArmy:attackerArmy andDefenderArmy:defenderArmy andMainScene:scene ofType:exploration];
        
    }
    
    [combat drawScene];
    
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
    for (Army * army in player.armies) {
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
    for (Army * army in player.armies) {
        for (Creature *c in army.creatures) {
            if (![terrainStrings containsObject:c.terrainType]) {
                c.isBluff = YES;
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
        //you steal shit based by comparing the role and combat value
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


- (void) advancePhase: (Phase) p{
    NSLog(@"advancing phase to :%d",p);
    phase = p;
    NSArray *phaseText = @[@"Initial Phase", @"Construction Phase", @"Movement Phase",@"Recruitment Phase",@"Special Character Recruitment Phase", @"Combat Phase", @"Gold Collection Phase"];
    board.textLabel.text = [phaseText objectAtIndex:p];
    
    if(p == SpecialPower){
        int i = 0;
        for( Player* p in players){
            if([p hasBuiltCitadel])
                i+=1;
        }
        if(i == 1){
            //there is a winner
        }
    }
    
}


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
    
    
       
    NSUInteger currentIndex = [currentMatch.participants indexOfObject:currentMatch.currentParticipant];
    GKTurnBasedParticipant *nextParticipant;
    
    NSMutableDictionary *dicData = [[NSMutableDictionary alloc] init];
    
    NSNumber *phaseNS = [NSNumber numberWithInt:phase];
    [dicData setObject:phaseNS forKey:@"phase"];
    if (phase == Initial) {
        [dicData setObject:board.terrainsDictionary forKey:@"terrains"];
        [dicData setObject:board.markersArray forKey:@"markers"];
        [self currentPlayer].doneInitial = YES;
    }
    else if(phase == GoldCollection){
        
    }
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dicData];

    
    NSUInteger nextIndex = (currentIndex + 1) % [currentMatch.participants count];
    nextParticipant = [currentMatch.participants objectAtIndex:nextIndex];
    
    int index = nextIndex;
    
    while (nextParticipant.status != GKTurnBasedParticipantStatusActive && nextParticipant.status != GKTurnBasedParticipantStatusInvited) {
        index ++;
        NSUInteger nextIndex = index % [currentMatch.participants count];
        NSLog(@"current player id %d, status: %d",currentIndex, nextParticipant.status);
        nextParticipant = [currentMatch.participants objectAtIndex:nextIndex];
    }
    
    board.doneButton.hidden = YES;
    board.canTapDone = NO;
    [currentMatch endTurnWithNextParticipant:nextParticipant matchData:data completionHandler:^(NSError *error) {
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
- (NSArray *) findPlayersByTerrain:(Terrain *) terrain{
    NSMutableArray *playersArray = [[NSMutableArray alloc] init];
    
    for (Player *p in players) {
        for (Army * a in p.armies) {
            if ([a.terrain isEqual:terrain]) {
                [playersArray addObject:p];
            }
        }
    }
    return playersArray;
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


//tells you if theres an army present on the provided terrain
- (BOOL) hasArmyOnTerrain:(Terrain *) terrain{
    if ([self findPlayersByTerrain:terrain].count > 0) {
        return YES;
    }
    else{
        return NO;
    }
}


@end
