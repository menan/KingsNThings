//
//  Building.h
//  KingsNThings
//
//  Created by Mac5 on 2/6/2014.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Terrain.h"

@interface Building : NSObject

typedef enum Stage : NSUInteger {
    Tower,
    Keep,
    Castle,
    Citadel
}Stage;

- (id)initWithStage:(Stage) s andTerrain: (Terrain *) t;

@property Stage stage;
@property Terrain *terrain;

@end
