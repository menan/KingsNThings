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

@synthesize scene;


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
    NSLog(@"Entering new game...");
//    mainTextController.text = @"Once upon a time";
}

-(void)takeTurn:(GKTurnBasedMatch *)match {
    NSLog(@"Taking turn for existing game...");
    
    Board *b = [scene getBoard];
    b.doneButton.hidden = NO;
    b.canTapDone = YES;
    
    if ([match.matchData bytes]) {
        NSDictionary *myDictionary = (NSDictionary*) [NSKeyedUnarchiver unarchiveObjectWithData:match.matchData];

        
        
        NSLog(@"Taking turn for existing game... %@",myDictionary);
//        mainTextController.text = storySoFar;
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
//    statusLabel.text = statusString;
//    textInputField.enabled = NO;
    NSString *storySoFar = [NSString stringWithUTF8String:[match.matchData bytes]];
//    mainTextController.text = storySoFar;
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
