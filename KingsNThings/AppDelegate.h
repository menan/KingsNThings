//
//  AppDelegate.h
//  KingsNThings
//
// Created by Areej Ba Salamah and Menan Vadivel on 1/16/2014.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Server.h"
#import "GamePlay.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    Server *_server;
    GamePlay *game;
}

@property (strong, nonatomic) UIWindow *window;

@end
