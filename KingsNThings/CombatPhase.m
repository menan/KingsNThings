//
//  CombatPhase.m
//  KingsNThings
//
//  Created by aob on 2/8/2014.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import "CombatPhase.h"
#import "Creature.h"
#import "MyScene.h"
#import "CombatScene.h"

@implementation CombatPhase{
    
    SKScene* comabtScen;
    MyScene* mainScene;
}

@synthesize attackerMagicCreature,attackerRangedCreature,attackerMeleeCreature;
@synthesize defenderMagicCreature,defenderRangedCreature,defenderMeleeCreature;
@synthesize attackerArmy,defenderArmy;
@synthesize attacker,defender;
@synthesize isMagicRound,isRangedRound,isMeleeRound,isAttacker,isDefender;;
@synthesize diceOne,diceTwo;
@synthesize attackerRolledDice, defenderRolledDice,attackerNumberOfHits,defenderNumberOfHits;





-(id) initWithAttacker:(Player*)att andDefender:(Player*)def andAttackerArmy:(id)attArmy andDefenderArmy:(id)defArmy andMainScene:(id)sce{
    
    self = [super init];
    if(self)
    {
        mainScene = sce;
        
        attacker = att;
        defender = def;
        
        attackerArmy =  attArmy;
        defenderArmy = defArmy;
        
        attackerMagicCreature   = [[NSMutableArray alloc]init];
        attackerMeleeCreature   = [[NSMutableArray alloc]init];;
        attackerRangedCreature  = [[NSMutableArray alloc]init];
        
        defenderMagicCreature   = [[NSMutableArray alloc]init];
        defenderRangedCreature  = [[NSMutableArray alloc]init];
        defenderMeleeCreature   = [[NSMutableArray alloc]init];
        
        attackerRolledDice = [[NSMutableArray alloc]init];
        defenderRolledDice = [[NSMutableArray alloc]init];

        
        
    }
    
    return self;
    
}

-(void)drawScene{
    
    
    [mainScene transitToCombat:attackerArmy andDefender:defenderArmy andCombatFunction:self];
    
    
}

/*-(void) meleeRound:(CombatScene*) combatScene{
   NSInteger attackerNumberOfHits = 0 , defenderNumberOfHits = 0;
    
    
    isMagicRound = NO;
    isMeleeRound = YES;
    isRangedRound = NO;
   
    //[defenderRolledDice removeAllObjects];
    
    
    
        //[combatScene setInstructionText:@"Inside Attaker melee if statment"];
    //NSString* str = @"Attacker: roll one dice for ";
    // str = [str stringByAppendingString:[NSString stringWithFormat:@"%i",[attackerMagicCreature count]]];
    //str = [str stringByAppendingString:@" times."];
    
    ////[combatScene setInstructionText:[NSString stringWithString:str]];
    //[combatScene setInstructionText:str];
            
    [combatScene collectDiceResult];

    for(int i = 0 ; i < [attackerMeleeCreature count] ; i++){
        
        if([[attackerMeleeCreature objectAtIndex: i] combatValue] >= [[attackerRolledDice objectAtIndex:i] integerValue] ){
            
            attackerNumberOfHits += 1;
        }
    }
       */ /*NSString* str2 = @"Attacker can apply hits";
        NSString* result = [NSString stringWithFormat:@"%@ %i hits",str2,attackerNumberOfHits];
        
        [combatScene setInstructionText:result];
        
        */
   
    
    
//}

-(void)updateArmy:(NSString*)creatureName andPlayerType:(NSString *)player{
    
    if([player isEqualToString:@"attacker"]){
        
        
            for(Creature* cre in [attackerArmy creatures]){
                if([[cre name] isEqualToString:creatureName]){
                    if([cre isMagic]){
                        [attackerMagicCreature removeObject:cre];
                        break;
                    }
                    else if ([cre isRanged]){
                        [attackerRangedCreature removeObject:cre];
                        break;
                        
                    }
                    else{
                        
                        [attackerMeleeCreature removeObject:cre];
                        break;
                    }
                }
            }
    }
    else {
        for(Creature* cre in [defenderArmy creatures]){
            if([[cre name] isEqualToString:creatureName]){
                if([cre isMagic]){
                    [defenderMagicCreature removeObject:cre];
                    break;
                }
                else if ([cre isRanged]){
                    [defenderRangedCreature removeObject:cre];
                    break;
                    
                }
                else{
                    
                    [defenderMeleeCreature removeObject:cre];
                    break;
                }
            }
        }
    }
}

-(void) startCombat:(CombatScene*) combatScene{
    
    NSInteger attakerNumOfMagicCreatures,defenderNumOfMagicCreatures;
    NSInteger attackerNumOfRangedCreatures,defenderNumOfRangedCreatures;
    NSInteger attackerNumOfMeleeCreatures,defenderNumOfMeleeCreatures;
    
    NSRunLoop *loop = [NSRunLoop currentRunLoop];
    
    
    NSLog(@" at start num of Creatures in Attacker army %d", [attackerArmy creaturesInArmy]);
     NSLog(@" at start num of Creatures in defender army %d", [defenderArmy creaturesInArmy]);
    
    
    for(Creature *creature in [attackerArmy creatures])
    {
        //NSLog(@"creature name is %@ " ,[creature name]);
        if([creature isMagic] )
            [attackerMagicCreature addObject:creature];
        else if ([creature isRanged] )
            [attackerRangedCreature addObject:creature];
        else if ([creature isMelee] || [creature isCharge] ){
            [attackerMeleeCreature addObject:creature];
            //NSLog(@"creature is melee");
        }
        
    }
    
    
    
    //NSLog(@"number of creature in MElee %d",[attackerMeleeCreature count] );
    for(Creature *creature in [defenderArmy creatures])
    {
        if([creature isMagic] )
            [defenderMagicCreature addObject:creature];
        else if ([creature isRanged] )
            [defenderRangedCreature addObject:creature];
        
        else if ([creature isMelee] || [creature isCharge] )
            [defenderMeleeCreature addObject:creature];
        
    }
    
    attakerNumOfMagicCreatures      = [attackerMagicCreature count];
    defenderNumOfMagicCreatures     = [defenderMagicCreature count];
    attackerNumOfRangedCreatures    = [attackerRangedCreature count];
    defenderNumOfRangedCreatures    = [defenderRangedCreature count];
    attackerNumOfMeleeCreatures     = [attackerMeleeCreature count];
    defenderNumOfMeleeCreatures     = [defenderMeleeCreature count];
    
    
    // now keep fighting until one loses
    
    while(([[attackerArmy creatures] count] > 0) && ([[defenderArmy creatures ]count]) && ([loop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]])){
        
      
        
        /*------------Magic round---------------*/
        attackerNumberOfHits = 0;
        defenderNumberOfHits = 0;
        
        
        isMagicRound = YES;
        isMeleeRound = NO;
        isRangedRound = NO;
        
        [attackerRolledDice removeAllObjects];
        [defenderRolledDice removeAllObjects];
        [combatScene setRoundLable:@"Magic Round"];
        
        if(attakerNumOfMagicCreatures > 0){
            //while([attackerRolledDice count] < [attackerMagicCreature count]){
            
            isAttacker = YES;
            isDefender = NO;
            NSString* str = @"Attacker: roll one dice for \n ";
            str = [str stringByAppendingString:[NSString stringWithFormat:@"%i",attakerNumOfMagicCreatures]];
            str = [str stringByAppendingString:@" times."];
            
            [combatScene setInstructionText:str];
            
            [combatScene collectDiceResult];
            
            //[combatSctttene setInstructionText:[NSString stringWithString:str]];
            
            
        }
        
        
        if(defenderNumOfMagicCreatures> 0){
            
            
            isAttacker = NO;
            isDefender = YES;
            NSString* str = @"Defender: roll one dice for \n ";
            str = [str stringByAppendingString:[NSString stringWithFormat:@"%i",defenderNumOfMagicCreatures]];
            str = [str stringByAppendingString:@" times."];
            
            [combatScene setInstructionText:str];
            
            [combatScene collectDiceResult];
            
            
        }
        
        for(int i = 0 ; i < attakerNumOfMagicCreatures ; i++){
            
            if([[attackerMagicCreature objectAtIndex: i] combatValue] >= [[attackerRolledDice objectAtIndex:i] integerValue] ){
                
                attackerNumberOfHits += 1;
            }
            
        }
        
        
        //NSLog(@"Attacker can apply %d hits, in Magic round",attackerNumberOfHits);
        
        
        for(int i = 0 ; i < defenderNumOfMagicCreatures ; i++){
            
            if([[defenderMagicCreature objectAtIndex: i] combatValue] >= [[defenderRolledDice objectAtIndex:i] integerValue] )
                
                defenderNumberOfHits += 1;
        }
        
        if(attackerNumberOfHits > 0){
            
            defenderNumOfMagicCreatures     = [defenderMagicCreature count];
            defenderNumOfRangedCreatures    = [defenderRangedCreature count];
            defenderNumOfMeleeCreatures     = [defenderMeleeCreature count];
        }
        if(defenderNumberOfHits > 0){
            attakerNumOfMagicCreatures      = [attackerMagicCreature count];
            attackerNumOfRangedCreatures    = [attackerRangedCreature count];
            attackerNumOfMeleeCreatures     = [attackerMeleeCreature count];

            
        }
        
        //Inform player how many hits are applied
        NSString* str = @"Attacker: can apply \n ";
        str = [str stringByAppendingString:[NSString stringWithFormat:@"%i",attackerNumberOfHits]];
        str = [str stringByAppendingString:@" hits."];
        
        
        str = [str stringByAppendingString:@" \n Defender: can apply \n "];
        str = [str stringByAppendingString:[NSString stringWithFormat:@"%i",defenderNumberOfHits]];
        str = [str stringByAppendingString:@" hits. \n Choose creature(s) to take the hits"];
        
        [combatScene setInstructionText:str];
        [combatScene applyHits];
        
        NSLog(@"Done Magic");
        
        /*----------Ranged Round -------------*/
        
        attackerNumberOfHits = 0;
        defenderNumberOfHits = 0;
        
        
        isMagicRound = NO;
        isMeleeRound = NO;
        isRangedRound = YES;
        
        
        [attackerRolledDice removeAllObjects];
        [defenderRolledDice removeAllObjects];
        
        [combatScene setRoundLable:@"Ranged Round"];
        
        if(attackerNumOfRangedCreatures > 0){
            //while([attackerRolledDice count] < [attackerMagicCreature count]){
            
            isAttacker = YES;
            isDefender = NO;
            NSString* str = @"Attacker: roll one dice for \n ";
            str = [str stringByAppendingString:[NSString stringWithFormat:@"%i",attackerNumOfRangedCreatures]];
            str = [str stringByAppendingString:@" times."];
            
            [combatScene setInstructionText:str];
            
            [combatScene collectDiceResult];
            
            //[combatSctttene setInstructionText:[NSString stringWithString:str]];
            
            
        }
        
        
        if(defenderNumOfRangedCreatures > 0){
            
            
            isAttacker = NO;
            isDefender = YES;
            NSString* str = @"Defender: roll one dice \n for  ";
            str = [str stringByAppendingString:[NSString stringWithFormat:@"%i",defenderNumOfRangedCreatures]];
            str = [str stringByAppendingString:@" times."];
            
            [combatScene setInstructionText:str];
            
            [combatScene collectDiceResult];
            
            
        }
        
        for(int i = 0 ; i < attackerNumOfRangedCreatures ; i++){
            
            if([[attackerRangedCreature objectAtIndex: i] combatValue] >= [[attackerRolledDice objectAtIndex:i] integerValue] ){
                
                attackerNumberOfHits += 1;
            }
            
        }
        
        
        
        
        
        
        //NSLog(@"Attacker can apply %d hits, in Magic round",attackerNumberOfHits);
        
        
        for(int i = 0 ; i < defenderNumOfRangedCreatures; i++){
            
            if([[defenderRangedCreature objectAtIndex: i] combatValue] >= [[defenderRolledDice objectAtIndex:i] integerValue] )
                
                defenderNumberOfHits += 1;
        }
        if(attackerNumberOfHits > 0){
            
            defenderNumOfMagicCreatures     = [defenderMagicCreature count];
            defenderNumOfRangedCreatures    = [defenderRangedCreature count];
            defenderNumOfMeleeCreatures     = [defenderMeleeCreature count];
        }
        if(defenderNumberOfHits > 0){
            attakerNumOfMagicCreatures      = [attackerMagicCreature count];
            attackerNumOfRangedCreatures    = [attackerRangedCreature count];
            attackerNumOfMeleeCreatures     = [attackerMeleeCreature count];
            
            
        }
        
        str = @"Attacker: can apply \n ";
        str = [str stringByAppendingString:[NSString stringWithFormat:@"%i",attackerNumberOfHits]];
        str = [str stringByAppendingString:@" hits."];
        
        
        str = [str stringByAppendingString:@" \n Defender: can apply \n "];
        str = [str stringByAppendingString:[NSString stringWithFormat:@"%i",defenderNumberOfHits]];
        str = [str stringByAppendingString:@" hits. \n Choose creature(s) to take the hits"];
        
        [combatScene setInstructionText:str];
        [combatScene applyHits];
        
        NSLog(@"Done Ranged");
        /*----------Melee Round -------------*/
        
        attackerNumberOfHits = 0;
        defenderNumberOfHits = 0;
        
        
        isMagicRound = NO;
        isMeleeRound = YES;
        isRangedRound = NO;
        
        
        [attackerRolledDice removeAllObjects];
        [defenderRolledDice removeAllObjects];
        
        [combatScene setRoundLable:@"Melee Round"];
        
        if(attackerNumOfMeleeCreatures > 0){
            //while([attackerRolledDice count] < [attackerMagicCreature count]){
            
            isAttacker = YES;
            isDefender = NO;
            NSString* str = @"Attacker: roll one dice for \n ";
            str = [str stringByAppendingString:[NSString stringWithFormat:@"%i",attackerNumOfMeleeCreatures]];
            str = [str stringByAppendingString:@" times."];
            
            [combatScene setInstructionText:str];
            
            [combatScene collectDiceResult];
            
            //[combatSctttene setInstructionText:[NSString stringWithString:str]];
            
            
        }
        
        
        if(defenderNumOfMeleeCreatures > 0){
            
            
            isAttacker = NO;
            isDefender = YES;
            NSString* str = @"Defender: roll one dice \n for  ";
            str = [str stringByAppendingString:[NSString stringWithFormat:@"%i",defenderNumOfMeleeCreatures]];
            str = [str stringByAppendingString:@" times."];
            
            [combatScene setInstructionText:str];
            
            [combatScene collectDiceResult];
            
            
        }
        
        for(int i = 0 ; i < attackerNumOfMeleeCreatures ; i++){
            
            if([[attackerMeleeCreature objectAtIndex: i] combatValue] >= [[attackerRolledDice objectAtIndex:i] integerValue] ){
                
                attackerNumberOfHits += 1;
            }
            
        }
        
        
        
        
        
        
        //NSLog(@"Attacker can apply %d hits, in Magic round",attackerNumberOfHits);
        
        
        for(int i = 0 ; i < defenderNumOfMeleeCreatures; i++){
            
            if([[defenderMeleeCreature objectAtIndex: i] combatValue] >= [[defenderRolledDice objectAtIndex:i] integerValue] )
                
                defenderNumberOfHits += 1;
        }
        
        
        if(attackerNumberOfHits > 0){
            
            defenderNumOfMagicCreatures     = [defenderMagicCreature count];
            defenderNumOfRangedCreatures    = [defenderRangedCreature count];
            defenderNumOfMeleeCreatures     = [defenderMeleeCreature count];
        }
        if(defenderNumberOfHits > 0){
            attakerNumOfMagicCreatures      = [attackerMagicCreature count];
            attackerNumOfRangedCreatures    = [attackerRangedCreature count];
            attackerNumOfMeleeCreatures     = [attackerMeleeCreature count];
            
            
        }
        
        //Inform player how many hits are applied
        NSString* str2 = @"Attacker: can apply \n ";
        str2 = [str2 stringByAppendingString:[NSString stringWithFormat:@"%i",attackerNumberOfHits]];
        str2 = [str2 stringByAppendingString:@" hits."];
        
        
        str2 = [str2 stringByAppendingString:@" \n Defender: can apply  "];
        str2 = [str2 stringByAppendingString:[NSString stringWithFormat:@"%i",defenderNumberOfHits]];
        str2 = [str2 stringByAppendingString:@" hits. \n Choose creature(s) to take the hits"];
        
        [combatScene setInstructionText:str];
        [combatScene applyHits];
        
        
        
    }
    
    
    NSLog(@" at end num of Creatures in Attacker army %d", [attackerArmy creaturesInArmy]);
    NSLog(@" at end num of Creatures in Defender army %d", [defenderArmy creaturesInArmy]);
    
}




@end
