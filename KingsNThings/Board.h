//
//  Board.h
//  KingsNThings
//
//  Created by Menan Vadivel on 1/28/2014.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@interface Board : NSObject
@property SKLabelNode* textLabel;

- (id)initWithScene: (SKScene *) aScene atPoint: (CGPoint) aPoint withSize: (CGSize) aSize;
- (void)draw;
- (SKSpriteNode *) getBoard;
- (void) resetText;
-(void) updateBankBalance:(NSInteger)goldNum;
-(void)drawPlayerGold:(NSString*)goldType andPoint:(CGPoint)location;
@end
