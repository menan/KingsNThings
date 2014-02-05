//
//  GamePlay.h
//  KingsNThings
//
//  Created by Menan Vadivel on 2/1/2014.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"

@interface GamePlay : NSObject

@property Player *player1;
@property Player *player2;
@property Player *player3;
@property Player *player4;

-(id) initWith4Players;


@end
