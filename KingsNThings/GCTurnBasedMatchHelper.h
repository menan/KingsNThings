//
//  GCTurnBasedMatchHelper.h
//  KingsNThings
//
//  Created by Menan Vadivel on 2014-03-13.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>



@protocol GCTurnBasedMatchHelperDelegate
- (void)enterNewGame:(GKTurnBasedMatch *)match;
- (void)layoutMatch:(GKTurnBasedMatch *)match;
- (void)takeTurn:(GKTurnBasedMatch *)match;
- (void)recieveEndGame:(GKTurnBasedMatch *)match;
- (void)sendNotice:(NSString *)notice
          forMatch:(GKTurnBasedMatch *)match;
@end


@interface GCTurnBasedMatchHelper : NSObject<GKTurnBasedMatchmakerViewControllerDelegate,GKLocalPlayerListener>{
    BOOL gameCenterAvailable;
    BOOL userAuthenticated;
}

@property (assign, readonly) BOOL gameCenterAvailable;
@property (assign, readonly) BOOL userAuthenticated;
@property (retain) GKTurnBasedMatch * currentMatch;
@property (nonatomic, retain)
id <GCTurnBasedMatchHelperDelegate> delegate;

+ (GCTurnBasedMatchHelper *)sharedInstance;
- (void)authenticateLocalUser;

- (void)findMatchWithMinPlayers:(int)minPlayers
                     maxPlayers:(int)maxPlayers
                 viewController:(UIViewController *)viewController;

@end
