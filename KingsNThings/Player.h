//
//  Player.h
//  KingsNThings
//
//  Created by Menan Vadivel on 1/28/2014.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Bank.h"

@interface Player : NSObject
    @property (nonatomic, strong) NSMutableArray* armies;
    @property (nonatomic, strong) NSMutableArray* territories;
    @property (nonatomic, strong) NSMutableArray* specialCharacters;
    @property (nonatomic, strong) NSMutableArray* treasures;

    @property int income;
    @property int orderOfPlay;
    @property int stageOfBuilding;

    @property (nonatomic, strong) Bank* bank;

@end
