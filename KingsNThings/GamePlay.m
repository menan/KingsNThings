
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

@implementation GamePlay{
    MyScene *scene;
    NSMutableArray *services;
    id board;
    
}

@synthesize me,oneDice,secondDice,goldCollectionCompleted, players;

@synthesize p1Stack1,p1Stack2,p2Stack1,p3Stack1,p3Stack2,p3Stack3,p4Stack1,p4Stack2,p4Stack3,goldPhase,terrains, isMovementPhase , isThingRecrPahse, isComabtPahse,scene;


-(id) initWithBoard:(id) b{
    
    self = [super init];
    if(self){
        board = b;
        goldCollectionCompleted = NO;
        
        
        NSString *type = @"KingsNThings22";
        
        _server = [[Server alloc] initWithProtocol:type];
        _server.delegate = self;
        NSError *error = nil;
        if(![_server start:&error]) {
            NSLog(@"error = %@", error);
        }
        
        me = [[Player alloc] initWithServer:_server];
        
        players = [[NSMutableArray alloc] initWithObjects:me, nil];
        terrains = [[NSMutableArray alloc]init];
        services = [[NSMutableArray alloc]init];
       
        
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
        p2Stack1 = @[@"-n Pterodactyl Warriors -c 2 -t Jungle -s Fly -s Range -a 2",@"-n Sandworm -t Desert -a 3.jpg",@"-n Green Knight -t Forest -s Charge -a 4",@"-n Dervish -c 2 -t Desert -s Magic -a 2",@"-n Crocodiles -t Jungle -a 2",@"-n Nomads -c 2 -t Desert -a 1",@"-n Druid -t Forest -s Magic -a 3",@"-n Walking Tree -t Forest -a 5",@"-n Crawling Vines -t Jungle -a 6",@"-n Bandits -t Forest -a 2"];
        
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
    
    Player *defender = [self findPlayerByTerrain:terrain];
    
    
    
    NSLog(@"tempPlayer is %d , player is %d",[defender playingOrder],[player playingOrder]);
    
    if([player isEqual:defender]){
        
        NSLog(@"tinside if players are equal");
        if([terrain hasArmyOnIt]){
            Army *a = [player findArmyOnTerrain:terrain];
            
            if(([a creaturesInArmy] + [army creaturesInArmy]) > 10)
                NSLog(@"Invalid move cannot have more than 10 creatures on one terrain");
            
        }
    }
    
    else{
        if([terrain hasArmyOnIt]){
            
            Army *defArmy = [defender findArmyOnTerrain:terrain];
            if([terrain hasBuilding]){
                [defArmy setBuilding:[defender getBuildingOnTerrain:terrain]];
            }
             NSLog(@"tinside if players are NOT equal");
            player.isWaitingCombat = YES;
            [player.combat setObject:army forKey:@"withArmy"];
            [player.combat setObject:defender forKey:@"andPlayer"];
            [player.combat setObject:defArmy forKey:@"andDefenderArmy"];
            
            NSLog(@"combat dictionary: %@",player.combat);
        }
    
    
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
        [self combatPhase:p withArmy:a andPlayer:defender withArmy:defArmy ];
    }
}



-(void) combatPhase:(Player *)attacker withArmy:(Army*)attackerArmy andPlayer:(Player*)defender withArmy:(Army*)defenderArmy{
    
     NSLog(@"inside Combat phase");
    
    
    CombatPhase* combat = [[CombatPhase alloc]initWithAttacker:attacker andDefender:defender andAttackerArmy:attackerArmy andDefenderArmy:defenderArmy andMainScene:scene];
    
    [combat drawScene];
    
    if([attacker hasWonCombat]){
        
        
        
    }
    else if ([defender hasWonCombat]){
        
        
    }
    
    
   }

-(void) pahses:(NSString*)pahse{
    
    NSRunLoop *loop = [NSRunLoop currentRunLoop];
    while ([loop runMode:NSDefaultRunLoopMode beforeDate:[NSDate
                                                           distantFuture]])
    {
    
    
    
    
    
    }
    
    
    
}

- (BOOL) removePlayerByServer: (Server *) thisServer{
    for (Player *p in players) {
        if ([p.server isEqual:thisServer]) {
            [p hasLeft:YES];
            return YES;
        }
    }
    return NO;
}

- (void) closeConnections{
    [_server stop];
    [_server stopBrowser];
}

- (void) broadCastMessage: (NSString *) message{
    int i = 0;
    for (Player *p in players) {
        i++;
        NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error = nil;
        
        [p.server sendData:data error:&error];
    }
}

#pragma mark Server Delegate Methods

- (void)serverRemoteConnectionComplete:(Server *)thisServer {
    NSLog(@"Server Started");
    // this is called when the remote side finishes joining with the socket as
    // notification that the other side has made its connection with this side
//    self.server = thisServer;
//    if (!players) {
//        players = [[NSMutableArray alloc] init];
//    }
    Player *p = [[Player alloc] initWithServer:thisServer];
    [players addObject:p];
    [board drawMarkersForPlayer:players.count -1];
    [board updateBank];
    
}

- (void)serverStopped:(Server *)server {
    NSLog(@"Server stopped");
}

- (void)server:(Server *)server didNotStart:(NSDictionary *)errorDict {
    NSLog(@"Server did not start %@", errorDict);
}

- (void)server:(Server *)server didAcceptData:(NSData *)data {
    NSLog(@"Server did accept data %@", data);
    NSString *message = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if(nil != message || [message length] > 0) {
        NSLog(@"messaged received: %@",message);
    } else {
        NSLog(@"no data received");
    }
}

- (void)server:(Server *)server lostConnection:(NSDictionary *)errorDict {
    NSLog(@"Server lost connection %@", errorDict);
    [self removePlayerByServer:server];
    [self closeConnections];
}

- (void)serviceAdded:(NSNetService *)service moreComing:(BOOL)more {
    NSLog(@"found a player tho: %@", [service name]);
    if (players.count == 4) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Limit Reached"
                                                        message:@"Sorry, but this game already has 4 players in it."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    else{
        [self.server connectToRemoteService:service];
    }
}

- (void)serviceRemoved:(NSNetService *)service moreComing:(BOOL)more {
    NSLog(@"wtf player left: %@", [service name]);
}



@end
