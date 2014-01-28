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
    @property BOOL flipped;
    @property int position;

@end
