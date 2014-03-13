//
//  GCTurnBasedMatchHelper.h
//  KingsNThings
//
//  Created by Menan Vadivel on 2014-03-13.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>

@interface GCTurnBasedMatchHelper : NSObject<GKTurnBasedMatchmakerViewControllerDelegate>{
    BOOL gameCenterAvailable;
    BOOL userAuthenticated;
}

@property (assign, readonly) BOOL gameCenterAvailable;
@property (retain) GKTurnBasedMatch * currentMatch;

+ (GCTurnBasedMatchHelper *)sharedInstance;
- (void)authenticateLocalUser;

- (void)findMatchWithMinPlayers:(int)minPlayers
                     maxPlayers:(int)maxPlayers
                 viewController:(UIViewController *)viewController;

@end
