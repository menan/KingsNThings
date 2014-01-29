//
//  Bank.h
//  KingsNThings
//
//  Created by Menan Vadivel on 1/28/2014.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@interface Bank : NSObject
{
    /*20 of 1golds, 2golds,5golds,10golds
     10 of fifteengold and twentyGold
     */
    
    NSInteger oneGold;
    NSInteger twoGold;
    NSInteger fiveGold;
    NSInteger tenGold;
    NSInteger fifteenGold;
    NSInteger twentyGold;
    NSInteger balance;
    
    //UIButton* oneGoldB,*twoGoldB,*fiveGoldB,*tenGoldB,*fifteenGoldB,*twentyGoldB;
    
}

@property NSInteger oneGold;
@property NSInteger twoGold;
@property NSInteger fiveGold;
@property NSInteger tenGold;
@property NSInteger fifteenGold;
@property NSInteger twentyGold;


/*@property (nonatomic, strong) UIButton *oneGoldB;
@property (nonatomic, strong) UIButton *twoGoldB;
@property (nonatomic, strong) UIButton *fiveGoldB;
@property (nonatomic, strong) UIButton *tenGoldB;
@property (nonatomic, strong) UIButton *fifteenGoldB;
@property (nonatomic, strong) UIButton *twentyGoldB;*/

- (void) updateBalance;
- (NSInteger)getBalance;

- (id)initWithBoard: (SKSpriteNode *) aBoard atPoint: (CGPoint) aPoint imageNamed: (NSString *) image;

//- (id)initWithPlayer: (SKSpriteNode *) aBoard atPoint: (CGPoint) aPoint imageNamed: (NSString *) image;

-(SKSpriteNode *) goldsWithImage:(NSString*) imageName;

@end
