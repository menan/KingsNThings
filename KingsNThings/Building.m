//
//  Building.m
//  KingsNThings
//
//  Created by Mac5 on 2/6/2014.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import "Building.h"

@implementation Building

@synthesize terrain, stage;

- (id)initWithStage:(Stage) s andTerrain: (Terrain *) t
{
    self = [super init];
    if (self) {
        terrain = t;
        stage = s;
    }
    return self;
}

@end
