//
//  Terrain.m
//  KingsNThings
//
// Created by Areej Ba Salamah and Menan Vadivel on 1/28/2014.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import "Terrain.h"

@implementation Terrain{
    CGPoint point;
    SKSpriteNode *board;
   
    
}
@synthesize type,imageName,flipped,position,node,hasOwner,hasArmyOnIt,location,hasBuilding,hasSpecialIncome;


- (id)initWithBoard: (SKSpriteNode *) aBoard atPoint: (CGPoint) aPoint imageNamed: (NSString *) image andTerrainName: (NSString *) name
{
    self = [super init];
    if (self) {
        point = aPoint;
        board = aBoard;
        imageName = image;
        type = name;
        flipped = YES;
        hasArmyOnIt = NO;
        hasSpecialIncome = NO;
    }
    return self;
}





- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        point = CGPointMake([[decoder decodeObjectForKey:@"pointX"] floatValue], [[decoder decodeObjectForKey:@"pointY"] floatValue]);
        board = [decoder decodeObjectForKey:@"board"];
        imageName = [decoder decodeObjectForKey:@"imageName"];
        type = [decoder decodeObjectForKey:@"type"];
        flipped = [[decoder decodeObjectForKey:@"flipped"] boolValue];
        hasArmyOnIt = [[decoder decodeObjectForKey:@"hasArmyOnIt"]boolValue];
        hasSpecialIncome = [[decoder decodeObjectForKey:@"hasSpecialIncome"]boolValue];
        location += [[decoder decodeObjectForKey:@"location"] integerValue];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:[NSNumber numberWithFloat:point.x] forKey:@"pointX"];
    [encoder encodeObject:[NSNumber numberWithFloat:point.y] forKey:@"pointY"];
    [encoder encodeObject:board forKey:@"board"];
    [encoder encodeObject:imageName forKey:@"imageName"];
    [encoder encodeObject:type forKey:@"type"];
    [encoder encodeObject:[NSNumber numberWithBool:flipped] forKey:@"flipped"];
    [encoder encodeObject:[NSNumber numberWithBool:hasArmyOnIt] forKey:@"hasArmyOnIt"];
    [encoder encodeObject:[NSNumber numberWithInteger:location] forKey:@"location"];
    [encoder encodeObject:[NSNumber numberWithBool:hasSpecialIncome] forKey:@"hasSpecialIncome"];
    
}



- (void) draw{
    node = [SKSpriteNode spriteNodeWithImageNamed:imageName];
    [node setName:type];
    [node setAccessibilityLabel:@"terrain"];
    node.size = CGSizeMake(88,88);
    [node setPosition:point];
    [board addChild:node];
}


- (float) getAbsoluteX{
    return node.position.x;
}

- (float) getAbsoluteY{
    return node.position.y;
}

@end
