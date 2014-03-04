//
//  CombatPhase.m
//  KingsNThings
//
//  Created by Areej Ba Salamah and Menan Vadivel  on 2/8/2014.
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
@synthesize attacker,defender,building;
@synthesize isMagicRound,isRangedRound,isMeleeRound,isAttacker,isDefender;;
@synthesize diceOne,diceTwo;
@synthesize attackerRolledDice, defenderRolledDice,attackerNumberOfHits,defenderNumberOfHits,attakerChargeCreatures,defenderChargeCreatures;





-(id) initWithAttacker:(Player*)att andDefender:(Player*)def andAttackerArmy:(id)attArmy andDefenderArmy:(id)defArmy andMainScene:(id)sce{
    
    self = [super init];
    if(self)
    {
        mainScene = sce;
        
        attacker = att;
        defender = def;
        building = [defArmy building];
        
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
                        if([cre isCharge]){
                            attakerChargeCreatures -=1;
                        }
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
                    if([cre isCharge]){
                        defenderChargeCreatures -=1;
                    }
                    [defenderMeleeCreature removeObject:cre];
                    break;
                }
            }
        }
    }
}

-(void) startCombat:(CombatScene*) combatScene{
    /*
    NSInteger attakerNumOfMagicCreatures,defenderNumOfMagicCreatures;
    NSInteger attackerNumOfRangedCreatures,defenderNumOfRangedCreatures;
    NSInteger attackerNumOfMeleeCreatures,defenderNumOfMeleeCreatures;
    */
    
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
        else if ([creature isMelee] || [creature isCharge]){
                [attackerMeleeCreature addObject:creature];
            
            if([creature isCharge])
                    attakerChargeCreatures += 1;
      
        }
        
    }
    
    
    
    //NSLog(@"number of creature in MElee %d",[attackerMeleeCreature count] );
    for(Creature *creature in [defenderArmy creatures])
    {
        if([creature isMagic] )
            [defenderMagicCreature addObject:creature];
        else if ([creature isRanged] )
            [defenderRangedCreature addObject:creature];
        
        else if ([creature isMelee] || [creature isCharge]){
            [defenderMeleeCreature addObject:creature];
            if([creature isCharge])
                defenderChargeCreatures += 1;
        }
        
    }
    
    
    // now keep fighting until one loses
    
    while(([attackerArmy creaturesInArmy] > 0) && ([defenderArmy creaturesInArmy] > 0) && ([loop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]])){
        
      
        
        /*------------Magic round---------------*/
        attackerNumberOfHits = 0;
        defenderNumberOfHits = 0;
        
        
        isMagicRound = YES;
        isMeleeRound = NO;
        isRangedRound = NO;
        
        [attackerRolledDice removeAllObjects];
        [defenderRolledDice removeAllObjects];
        
        [combatScene setRoundLable:@"Magic Round"];
        
        if([attackerMagicCreature count] > 0){
            //while([attackerRolledDice count] < [attackerMagicCreature count]){
            
            isAttacker = YES;
            isDefender = NO;
            NSString* str = @"Attacker: roll one dice for \n ";
            str = [str stringByAppendingString:[NSString stringWithFormat:@"%i",[attackerMagicCreature count]]];
            str = [str stringByAppendingString:@" times."];
            
            [combatScene setInstructionText:str];
            
            [combatScene collectDiceResult];
            
            //[combatSctttene setInstructionText:[NSString stringWithString:str]];
            
            
        }
        
        
        if([defenderMagicCreature count]> 0 || [building isMagic]){
            
            
            isAttacker = NO;
            isDefender = YES;
            NSString* str = @"Defender: roll one dice for \n ";
            if([building isMagic] && ([building combatValue] > 0)){
                str = [str stringByAppendingString:[NSString stringWithFormat:@"%i",[defenderMagicCreature count]+1]];
            }
            else{
                str = [str stringByAppendingString:[NSString stringWithFormat:@"%i",[defenderMagicCreature count]]];
            }


           
            str = [str stringByAppendingString:@" times."];
            
            [combatScene setInstructionText:str];
            
            [combatScene collectDiceResult];
            
            
        }
        
        for(int i = 0 ; i < [attackerMagicCreature count] ; i++){
            
            if([[attackerMagicCreature objectAtIndex: i] combatValue] >= [[attackerRolledDice objectAtIndex:i] integerValue] ){
                
                attackerNumberOfHits += 1;
            }
            
        }
        
        
        //NSLog(@"Attacker can apply %d hits, in Magic round",attackerNumberOfHits);
        
        
        for(int i = 0 ; i < [defenderMagicCreature count] ; i++){
            
            if([[defenderMagicCreature objectAtIndex: i] combatValue] >= [[defenderRolledDice objectAtIndex:i] integerValue] )
                defenderNumberOfHits += 1;
        }
        if([building isMagic] && ([building combatValue] > 0)){
            if([building combatValue] >= ([defenderRolledDice count] - 1))
                defenderNumberOfHits +=1;
            
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
  
        //NSLog(@"Done Magic");
        
        if(([attackerArmy creaturesInArmy] == 0 )|| ([defenderArmy creaturesInArmy] == 0)){
            
            break;
        }
        
        /*----------Ranged Round -------------*/
        
        attackerNumberOfHits = 0;
        defenderNumberOfHits = 0;
        
        
        isMagicRound = NO;
        isMeleeRound = NO;
        isRangedRound = YES;
        
        
        [attackerRolledDice removeAllObjects];
        [defenderRolledDice removeAllObjects];
        
        [combatScene setRoundLable:@"Ranged Round"];
        
        if([attackerRangedCreature count]> 0){
            
            isAttacker = YES;
            isDefender = NO;
            NSString* str = @"Attacker: roll one dice for \n ";
            str = [str stringByAppendingString:[NSString stringWithFormat:@"%i",[attackerRangedCreature count]]];
            str = [str stringByAppendingString:@" times."];
            
            [combatScene setInstructionText:str];
            
            [combatScene collectDiceResult];
            
        }
        
        
        if([defenderRangedCreature count] > 0 || [building isRanged] ){
            NSString* str = @"Defender: roll one dice for \n  ";

            if([building isRanged]&& ([building combatValue]>0)){
                str = [str stringByAppendingString:[NSString stringWithFormat:@"%i",[defenderRangedCreature count]+1]];
                
            }
            else{
               str = [str stringByAppendingString:[NSString stringWithFormat:@"%i",[defenderRangedCreature count]]];
            }
            isAttacker = NO;
            isDefender = YES;
            
            str = [str stringByAppendingString:@" times."];
            
            [combatScene setInstructionText:str];
            
            [combatScene collectDiceResult];
            
            
        }
        
        for(int i = 0 ; i < [attackerRangedCreature count] ; i++){
            
            if([[attackerRangedCreature objectAtIndex: i] combatValue] >= [[attackerRolledDice objectAtIndex:i] integerValue] ){
                
                attackerNumberOfHits += 1;
            }
            
        }
        
        
        
        for(int i = 0 ; i < [defenderRangedCreature count]; i++){
            
            if([[defenderRangedCreature objectAtIndex: i] combatValue] >= [[defenderRolledDice objectAtIndex:i] integerValue] )
                    defenderNumberOfHits += 1;
        }
        if([building isRanged] && ([building combatValue])){
            if([building combatValue] >= ([defenderRolledDice count] - 1))
                defenderNumberOfHits +=1;
        }
        
        str = @"Attacker: can apply \n ";
        str = [str stringByAppendingString:[NSString stringWithFormat:@"%i",attackerNumberOfHits]];
        str = [str stringByAppendingString:@" hits."];
        
        
        str = [str stringByAppendingString:@" \n Defender: can apply \n "];
        str = [str stringByAppendingString:[NSString stringWithFormat:@"%i",defenderNumberOfHits]];
        str = [str stringByAppendingString:@" hits. \n Choose creature(s) to take the hits"];
        
        [combatScene setInstructionText:str];
        [combatScene applyHits];
  
     
        if(([attackerArmy creaturesInArmy] == 0 )|| ([defenderArmy creaturesInArmy] == 0)){
            
            break;
        }
        /*----------Melee Round -------------*/
        
        attackerNumberOfHits = 0;
        defenderNumberOfHits = 0;
        
        
        isMagicRound = NO;
        isMeleeRound = YES;
        isRangedRound = NO;
        
        
        [attackerRolledDice removeAllObjects];
        [defenderRolledDice removeAllObjects];
        
        [combatScene setRoundLable:@"Melee Round"];
        
        if([attackerMeleeCreature count]> 0){
           
            
            isAttacker = YES;
            isDefender = NO;
            
            
            NSString* str = @"Attacker: roll one dice  \n ";
            str = [str stringByAppendingString:[NSString stringWithFormat:@"%i",([attackerMeleeCreature count] - attakerChargeCreatures)]];
            str = [str stringByAppendingString:@" times. and two dices for each Charge(C) creatures for "];
            str = [str stringByAppendingString:[NSString stringWithFormat:@"%i %@",attakerChargeCreatures,@"times."]];
            
            
            [combatScene setInstructionText:str];
            
            
            [combatScene collectDiceResult];
            
        }
        
        
        if([defenderMeleeCreature count] > 0 || [building isMelee]){
            
            isAttacker = NO;
            isDefender = YES;
            NSString* str = @"Defender: roll one dice for \n  ";
            
            if([building isMelee] && ([building combatValue]>0)){
                str = [str stringByAppendingString:[NSString stringWithFormat:@"%i",([defenderMeleeCreature count] - defenderChargeCreatures)+1]];
                
            }
            else{
                str = [str stringByAppendingString:[NSString stringWithFormat:@"%i",[defenderMeleeCreature count] - defenderChargeCreatures]];
            }
            str = [str stringByAppendingString:@" times. two dices for each Charge(C) creatures"];
            str = [str stringByAppendingString:[NSString stringWithFormat:@"%i",defenderChargeCreatures]];
            
            [combatScene setInstructionText:str];
            
            [combatScene collectDiceResult];
            
            
        }
        int j = 0;
        for(int i = 0 ; i <  [attackerMeleeCreature count]; i++){
            
            if([[attackerMeleeCreature objectAtIndex: i] isCharge]){
                
                if([[attackerMeleeCreature objectAtIndex: i] combatValue] >= [[attackerRolledDice objectAtIndex:j] integerValue] ){
                   
                    attackerNumberOfHits += 1;
                    
                }
                if([[attackerMeleeCreature objectAtIndex: i] combatValue] >= [[attackerRolledDice objectAtIndex:j+1] integerValue] ){
                        attackerNumberOfHits += 1;
                }
                j+=1;
            }
            else{
                if([[attackerMeleeCreature objectAtIndex: i] combatValue] >= [[attackerRolledDice objectAtIndex:j] integerValue] ){
                
                    attackerNumberOfHits += 1;
                }
            }
              NSLog(@"in attacker j is %d",j);
            j++;
        }
        
        
        j = 0;
        for(int i = 0 ; i < [defenderMeleeCreature count]  ; i++){
            
            if([[defenderMeleeCreature objectAtIndex: i] isCharge]){
                if([[defenderMeleeCreature objectAtIndex: i] combatValue] >= [[defenderRolledDice objectAtIndex:j] integerValue] ){
                    
                    defenderNumberOfHits += 1;
                }
                if([[defenderMeleeCreature objectAtIndex: i] combatValue] >= [[defenderRolledDice objectAtIndex:j+1] integerValue] ){
                    defenderNumberOfHits += 1;
                }
                
                j+=1;
            }
            else{
                if([[defenderMeleeCreature objectAtIndex: i] combatValue] >= [[defenderRolledDice objectAtIndex:j] integerValue] ){
                    
                    defenderNumberOfHits += 1;
                }
            }
            NSLog(@"in defender j is %d",j);
            j++;
        }
        
        if([building isMelee] && ([building combatValue]>0)){
            if([building combatValue] >= ([defenderRolledDice count] - 1))
                defenderNumberOfHits +=1;
        }
        
        //Inform player how many hits are applied
        NSString* str2 = @"Attacker: can apply \n ";
        str2 = [str2 stringByAppendingString:[NSString stringWithFormat:@"%d",attackerNumberOfHits]];
        str2 = [str2 stringByAppendingString:@" hits. \n Defender: can apply "];
        
        
        
        str2 = [str2 stringByAppendingString:[NSString stringWithFormat:@"%d",defenderNumberOfHits]];
        str2 = [str2 stringByAppendingString:@" hits. \n Choose creature(s) to take the hits"];
        
        [combatScene setInstructionText:str2];
        [combatScene applyHits];
             
    }
    
    if([attackerArmy creaturesInArmy] > 0){
        
        [attacker setHasWonCombat:YES];
        
        [combatScene setInstructionText:@"We have a WINNER "];
    }
    else if ([defenderArmy creaturesInArmy] > 0){
        [defender setHasWonCombat:YES];
          [combatScene setInstructionText:@"Defender is the winner and may keep the territory "];
        
    }
    else {
        [combatScene setInstructionText:@"Its a tie , defender keeps terrain"];
    }
    
    
    
}




@end
