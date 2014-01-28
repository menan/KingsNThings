//
//  Terrain.m
//  KingsNThings
//
//  Created by Menan Vadivel on 1/28/2014.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import "Terrain.h"

@implementation Terrain


- (void) draw: (SKSpriteNode *) board atPoint: (CGPoint) point{
    
    // 2) Loading the images
    NSArray *images = @[@"desert", @"forest", @"frozenWaste", @"jungle", @"mountains", @"plains", @"sea", @"swamp"];
    NSArray *imageNames = @[@"Desert", @"Forest", @"Frozen Waste", @"Jungle", @"Mountains", @"Plains", @"Sea", @"Swamp"];
    
    for(int i = 0; i < [imageNames count]; ++i) {
        NSString *image = [images objectAtIndex:i];
        NSString *imageName = [imageNames objectAtIndex:i];
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:image];
        [sprite setName:imageName];
        
        [sprite setPosition:point];
        [board addChild:sprite];
    }
}
@end
