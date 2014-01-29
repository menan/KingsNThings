//
//  Bank.h
//  KingsNThings
//
//  Created by Menan Vadivel on 1/28/2014.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import <Foundation/Foundation.h>

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
    
    UIButton* oneGoldB,*twoGoldB,*fiveGoldB,*tenGoldB,*fifteenGoldB,*twentyGoldB;
    
    
    
    
}

@property NSInteger oneGold;
@property NSInteger twoGold;
@property NSInteger fiveGold;
@property NSInteger tenGold;
@property NSInteger fifteenGold;
@property NSInteger twentyGold;

- (NSInteger) updateBalance;

@end
