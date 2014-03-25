//
//  GCTurnBasedMatchHelper.m
//  KingsNThings
//
//  Created by Menan Vadivel on 2014-03-13.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import "GCTurnBasedMatchHelper.h"

@implementation GCTurnBasedMatchHelper{
    UIViewController *presentingViewController;
}
@synthesize gameCenterAvailable,currentMatch,delegate;


#pragma mark Initialization

static GCTurnBasedMatchHelper *sharedHelper = nil;
+ (GCTurnBasedMatchHelper *) sharedInstance {
    if (!sharedHelper) {
        sharedHelper = [[GCTurnBasedMatchHelper alloc] init];
    }
    return sharedHelper;
}
//- (void)handleInviteFromGameCenter:(NSArray *)playersToInvite {
//    [presentingViewController dismissViewControllerAnimated:YES completion:nil];
//    
//    GKMatchRequest *request = [[GKMatchRequest alloc] init];
//    request.playersToInvite = playersToInvite;
//    request.maxPlayers = 12;
//    request.minPlayers = 2;
//    GKTurnBasedMatchmakerViewController *viewController =   [[GKTurnBasedMatchmakerViewController alloc] initWithMatchRequest:request];
//    viewController.showExistingMatches = NO;
//    viewController.turnBasedMatchmakerDelegate = self;
//    [presentingViewController presentModalViewController:viewController animated:YES];
//}
//
//-(void)handleInviteFromGameCenter:(NSArray *)playersToInvite {
//    NSLog(@"new invite");
//}
//
//-(void)handleTurnEventForMatch:(GKTurnBasedMatch *)match {
//    NSLog(@"Turn has happened");
//}
//
//-(void)handleMatchEnded:(GKTurnBasedMatch *)match {
//    NSLog(@"Game has ended");
//}
//
//

#pragma mark GKLocalPlayerDelegate

- (void)player: (GKPlayer *)player
        receivedTurnEventForMatch: (GKTurnBasedMatch *)match
        didBecomeActive: (BOOL)didBecomeActive
{
    
    NSLog(@"Turn has happened");
    
    
}

- (void)player: (GKPlayer *)player
        didRequestMatchWithPlayers: (NSArray *)playerIDsToInvite
{
    NSLog(@"new invite");
    
    
    [presentingViewController dismissViewControllerAnimated:YES completion:nil];
    
    GKMatchRequest *request = [[GKMatchRequest alloc] init];
    request.playersToInvite = playerIDsToInvite;
    request.maxPlayers = 12;
    request.minPlayers = 2;
    GKTurnBasedMatchmakerViewController *viewController =   [[GKTurnBasedMatchmakerViewController alloc] initWithMatchRequest:request];
    viewController.showExistingMatches = NO;
    viewController.turnBasedMatchmakerDelegate = self;
    [presentingViewController presentViewController:viewController animated:YES completion:nil];
    
}
- (void)player: (GKPlayer *)player
        matchEnded: (GKTurnBasedMatch *)match
{
    
    NSLog(@"Game has ended");
}






- (BOOL)isGameCenterAvailable {
    // check for presence of GKLocalPlayer API
    Class gcClass = (NSClassFromString(@"GKLocalPlayer"));
    
    // check if the device is running iOS 4.1 or later
    NSString *reqSysVer = @"4.1";
    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
    BOOL osVersionSupported = ([currSysVer compare:reqSysVer
                                           options:NSNumericSearch] != NSOrderedAscending);
    
    return (gcClass && osVersionSupported);
}

- (id)init {
    if ((self = [super init])) {
        gameCenterAvailable = [self isGameCenterAvailable];
        if (gameCenterAvailable) {
            NSNotificationCenter *nc =
            [NSNotificationCenter defaultCenter];
            [nc addObserver:self
                   selector:@selector(authenticationChanged)
                       name:GKPlayerAuthenticationDidChangeNotificationName
                     object:nil];
        }
    }
    return self;
}

- (void)authenticationChanged {
    
    if ([GKLocalPlayer localPlayer].isAuthenticated &&
        !userAuthenticated) {
        NSLog(@"Authentication changed: player authenticated.");
        userAuthenticated = TRUE;
    } else if (![GKLocalPlayer localPlayer].isAuthenticated &&
               userAuthenticated) {
        NSLog(@"Authentication changed: player not authenticated");
        userAuthenticated = FALSE;
    }
    
}

#pragma mark User functions


-(void)authenticateLocalUser {
    NSLog(@"Authenticating local user ...");
    if(!gameCenterAvailable) {
        return;
    }
    
    
    
    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    __weak GKLocalPlayer *blockLocalPlayer = localPlayer;
    
    localPlayer.authenticateHandler = ^(UIViewController *viewController, NSError *error){
        NSLog(@"authenticateHandler");
        userAuthenticated = blockLocalPlayer.isAuthenticated;
        
        if (userAuthenticated) {
            [[GKLocalPlayer localPlayer] registerListener: self];
        }
        
    };
}


#pragma GKMatchmaker functions


- (void)turnBasedMatchmakerViewControllerWasCancelled:(GKTurnBasedMatchmakerViewController *)viewController
{
    [viewController dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"has cancelled");
}
- (void)turnBasedMatchmakerViewController:(GKTurnBasedMatchmakerViewController *)viewController didFailWithError:(NSError *)error
{
    [viewController dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"Error finding match: %@", error.localizedDescription);
}


- (void)turnBasedMatchmakerViewController:(GKTurnBasedMatchmakerViewController *)viewController didFindMatch:(GKTurnBasedMatch *)match
{
    [viewController dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"matched users were %@", match.participants);
    self.currentMatch = match;
    
    
    GKTurnBasedParticipant *firstParticipant =
    [match.participants objectAtIndex:0];
    if (firstParticipant.lastTurnDate) {
        [delegate takeTurn:match];
    } else {
        [delegate enterNewGame:match];
    }
    
}

- (void)turnBasedMatchmakerViewController:(GKTurnBasedMatchmakerViewController *)viewController playerQuitForMatch:(GKTurnBasedMatch *)match{
    NSLog(@"playerquitforMatch, %@, %@", match, match.currentParticipant);
}

- (void)findMatchWithMinPlayers:(int)minPlayers maxPlayers:(int)maxPlayers viewController:(UIViewController *)viewController {
    if (!gameCenterAvailable) return;
    
    presentingViewController = viewController;
    
    GKMatchRequest *request = [[GKMatchRequest alloc] init];
    request.minPlayers = minPlayers;
    request.maxPlayers = maxPlayers;
    
    GKTurnBasedMatchmakerViewController *mmvc = [[GKTurnBasedMatchmakerViewController alloc] initWithMatchRequest:request];
    mmvc.turnBasedMatchmakerDelegate = self;
    
    
    [presentingViewController presentViewController:mmvc animated:YES completion:nil];
    
    
}



@end
