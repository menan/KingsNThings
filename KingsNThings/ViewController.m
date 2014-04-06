//
//  ViewController.m
//  KingsNThings
//
// Created by Areej Ba Salamah and Menan Vadivel on 1/16/2014.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import "ViewController.h"
#import "Board.h"

@implementation ViewController

@synthesize scene,longPressRecognizer;


- (void)viewDidLoad
{
    
    [GCTurnBasedMatchHelper sharedInstance].delegate = self;
    [self openScene];
    [super viewDidLoad];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void) openScene{
    [[GCTurnBasedMatchHelper sharedInstance] authenticateLocalUser];
    
    

    SKView * skView = (SKView *)self.view;
    skView.showsFPS = NO;
    skView.showsNodeCount = NO;
    
    
    // Create and configure the scene.
    scene = [MyScene sceneWithSize:skView.bounds.size];
    scene.controller = self;
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    [skView presentScene:scene];
}


-(void)enterNewGame:(GKTurnBasedMatch *)match {
    NSLog(@"Entering new game, place your markers first...");
    
    [self processData:match.matchData];
    
}

-(void)takeTurn:(GKTurnBasedMatch *)match {
    NSLog(@"Taking turn for existing game...");
    
    [self processData:match.matchData];
    
    GamePlay *g = [scene getGame];
    
    
    
    if (match.currentParticipant == [match.participants objectAtIndex:0]) {
        NSLog(@"came to first player turn again. should advance phase right?");
        if (g.phase == Initial && [[g currentPlayer] canAdvanceToGold]) {
            NSLog(@"advancing phase now");
            [scene transitToPhaseChange:[g advancePhase:GoldCollection]];
        }
        else if(g.phase == GoldCollection){
            [scene transitToPhaseChange:[g advancePhase:Recruitment]];
        }
        else if(g.phase == Recruitment){
            [scene transitToPhaseChange:[g advancePhase:SpecialRecruitment]];
        }
        else if(g.phase == SpecialRecruitment){
            [scene transitToPhaseChange:[g advancePhase:RandomEvents]];
        }
        else if(g.phase == RandomEvents){
            [scene transitToPhaseChange:[g advancePhase:Movement]];
        }
        else if(g.phase == Movement){
            [scene transitToPhaseChange:[g advancePhase:Combat]];
        }
        else if(g.phase == Combat){
            [scene transitToPhaseChange:[g advancePhase:Construction]];
        }
        else if(g.phase == Construction){
            NSLog(@"Checking for winner since the construction phase is over...");
            Player *winner = [g checkForWinner];
            if (winner) {
                NSLog(@"Yayyyy, the winner is %@", winner);
                [scene transitWinnerScene:[NSString stringWithFormat:@"Player %d", [winner playingOrder] + 1]];
            }
            else{
                NSLog(@"winner was not determined so continuing on with the game.");
                [scene transitToPhaseChange:[g advancePhase:SpecialPower]];
            }
        }
        else if(g.phase == SpecialPower){
            //change players order.
            NSLog(@"game first turn completed, gotta change the orders now");
        }
    }
    
}


- (void) processData:(NSData *) data{
    
    Board *b = [scene getBoard];
    GamePlay *g = [scene getGame];
//    [b checkForTotalPlayers];
    if ([data bytes]) {
        b.avoidChecks = YES;
        
        
        
        [b hideMarkersExceptCurrentPlayer];
        
        NSDictionary *myDictionary = (NSDictionary*) [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        Phase p = [[myDictionary objectForKey:@"phase"] integerValue];
        
        
        [b constructPlacemarkerFromDictionary:[myDictionary objectForKey:@"markers"]];
        [b constructBuildingsFromDictionary:[myDictionary objectForKey:@"buildings"]];
        [b setGoldsFromDictionary:[myDictionary objectForKey:@"balance"]];
        
        
        if (p != Initial){
            [g advancePhase:p];
        }
        
        [b constructStackFromDictionary:[myDictionary objectForKey:@"stacks"]];
        [b constructRackFromDictionary:[myDictionary objectForKey:@"racks"]];
        
        
        [b constructBowlFromDictionary:[myDictionary objectForKey:@"bowl"]];
        [b setUserSettingsFromDictionary:[myDictionary objectForKey:@"user-settings"]];
        
        b.avoidChecks = NO;
        NSLog(@"Taking turn for existing game with the received data...");
    }
}

-(void)checkForEnding:(NSData *)matchData {
    if ([matchData length] > 3000) {
//        statusLabel.text = [NSString stringWithFormat:@"%@, only about %d letter left", statusLabel.text, 4000 - [matchData length]];
    }
}

-(void)layoutMatch:(GKTurnBasedMatch *)match {
    NSLog(@"Viewing match where it's not our turn...");
    NSString *statusString;
    
    if (match.status == GKTurnBasedMatchStatusEnded) {
        statusString = @"Match Ended";
    } else {
        int playerNum = [match.participants indexOfObject:match.currentParticipant] + 1;
        statusString = [NSString stringWithFormat:@"Player %d's Turn", playerNum];
    }
    
    [self checkForEnding:match.matchData];
}

-(void)sendNotice:(NSString *)notice forMatch:(GKTurnBasedMatch *)match {
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Greetings" message:notice delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
    [av show];
}

-(void)recieveEndGame:(GKTurnBasedMatch *)match {
    [self layoutMatch:match];
}




@end
