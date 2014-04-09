//
//  AdvancePhaseScene.h
//  kingsnthings
//
//  Created by Menan Vadivel on 2014-04-06.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "GameScene.h"

@interface AdvancePhaseScene : SKScene
    -(id)initWithSize:(CGSize)size andPhaseString:(NSString*)phase andTitle:(NSString *) title andSender:(GameScene *) s;
@end
