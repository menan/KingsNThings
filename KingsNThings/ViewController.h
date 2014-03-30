//
//  ViewController.h
//  KingsNThings
//
//Created by Areej Ba Salamah and Menan Vadivel 
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import "MyScene.h"
#import "GCTurnBasedMatchHelper.h"

@interface ViewController : UIViewController<GCTurnBasedMatchHelperDelegate>

@property (nonatomic, strong) MyScene * scene;
@property UILongPressGestureRecognizer *longPressRecognizer;
@end
