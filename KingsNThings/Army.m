//
//  Army.m
//  KingsNThings
//
//  Created by aob on 2/6/2014.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import "Army.h"

@implementation Army

@synthesize creatures,position,belongsToP1,belongsToP2,belongsToP3,belongsToP4,imageIsDrawn,terrain;



-(id) init{
    
    self = [super init];
    
    if(self){
        
        creatures = [[NSMutableArray alloc]init];
       
        
        
    }
    return self;
}
    
    

-(id) initWithPoint:(CGPoint) aPoint{
    
    self = [super init];
    
    if(self){
        
        creatures = [[NSMutableArray alloc]init];
        [self setPosition:aPoint];
        
        
    }
    return self;
}

-(void) addCreatures:(id)creature{
    
    [creatures addObject:creature];
    
    

}
-(NSInteger) getTerrainLocation{
    
    return [terrain location];
}

-(void) removeCreature:(id)creature{
    
    [creatures removeObject:creature];
    
    
}
-(BOOL)containCreature:(id)creature{
    
    if([creatures containsObject:creature])
        return YES;
    else
        return NO;
    
}
@end
