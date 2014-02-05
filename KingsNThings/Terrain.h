//
//  Terrain.h
//  KingsNThings
//
//  Created by Menan Vadivel on 1/28/2014.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@interface Terrain : NSObject
@property (nonatomic, strong) NSString* type;
@property (nonatomic, strong) NSString* imageName;
@property (nonatomic, strong) SKSpriteNode* node;
    @property BOOL flipped;
    @property int position;

- (id)initWithBoard: (SKSpriteNode *) aBoard atPoint: (CGPoint) aPoint imageNamed: (NSString *) image andTerrainName: (NSString *) name;
- (void) draw;
@end
