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
    
//    longPressRecognizer =
//    [[UILongPressGestureRecognizer alloc]
//     initWithTarget:scene
//     action:@selector(longPressDetected:)];
//    longPressRecognizer.minimumPressDuration = 2;
//    longPressRecognizer.numberOfTouchesRequired = 1;
//    [skView addGestureRecognizer:longPressRecognizer];

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
            [g advancePhase:GoldCollection];
        }
        else if(g.phase == GoldCollection){
            [g advancePhase:Recruitment];
        }
        else if(g.phase == Recruitment){
            [g advancePhase:SpecialRecruitment];
        }
        else if(g.phase == SpecialRecruitment){
            [g advancePhase:Movement];
        }
        else if(g.phase == Movement){
            [g advancePhase:Combat];
        }
        else if(g.phase == Movement){
            [g advancePhase:Combat];
        }
    }
    
}


- (void) processData:(NSData *) data{
    
    Board *b = [scene getBoard];
    GamePlay *g = [scene getGame];
    if ([data bytes]) {
        [b hideMarkersExceptCurrentPlayer];
        
        NSDictionary *myDictionary = (NSDictionary*) [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        Phase p = [[myDictionary objectForKey:@"phase"] integerValue];
        
        
        [b constructBowlFromDictionary:[myDictionary objectForKey:@"bowl"]];
        [b constructPlacemarkerFromDictionary:[myDictionary objectForKey:@"markers"]];
        [b constructBuildingsFromDictionary:[myDictionary objectForKey:@"buildings"]];
        [b constructStackFromDictionary:[myDictionary objectForKey:@"stacks"]];
        [b constructRackFromDictionary:[myDictionary objectForKey:@"racks"]];
        [b setGoldsFromDictionary:[myDictionary objectForKey:@"balance"]];
        
        
        if (p == Initial) {
            
        }
        else if(p == GoldCollection){
            [g advancePhase:p];
        }
        
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
/*-(void) longPressDetected:(UIGestureRecognizer *)gestureRecognizer{
    
    CGPoint location = [gestureRecognizer locationInView:[gestureRecognizer view]];
    
    [scene respondToGesture:location];
}
 */



@end
