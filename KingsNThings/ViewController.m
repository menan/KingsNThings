//
//  ViewController.m
//  KingsNThings
//
// Created by Areej Ba Salamah and Menan Vadivel on 1/16/2014.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import "ViewController.h"

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
    if ([match.matchData bytes]) {
        NSString *storySoFar = [NSString stringWithUTF8String:[match.matchData bytes]];
        NSLog(@"Taking turn for existing game... %@",storySoFar);
//        mainTextController.text = storySoFar;
    }
}

@end
