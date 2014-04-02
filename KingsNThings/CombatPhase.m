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
    SKSpriteNode* board;
    
}

@synthesize attackerMagicCreature,attackerRangedCreature,attackerMeleeCreature;
@synthesize defenderMagicCreature,defenderRangedCreature,defenderMeleeCreature;
@synthesize attackerArmy,defenderArmy;
@synthesize attacker,defender,building;
@synthesize round,isAttacker;
@synthesize diceOne,diceTwo,type;
@synthesize attackerRolledDice, defenderRolledDice,attackerNumberOfHits,defenderNumberOfHits,attakerChargeCreatures,defenderChargeCreatures,battle;




-(id) initWithMarkerAtPoint:(CGPoint)aPoint onBoard:(id)aBoard andMainScene:(id)sce{
    self = [super init];
    
    if(self) {
        
        board = (SKSpriteNode*) aBoard;
        battle = [[SKSpriteNode alloc]initWithImageNamed:@"battle.jpg"];
        battle.name= @"battle";
        battle.position = aPoint;
        battle.size = CGSizeMake(36.0f,36.0f);
        [board addChild:battle];
        
        mainScene = (MyScene*)sce;
    }
    
    
    return self;
    
}
-(id) initWithAttacker:(Player*)att andDefender:(Player*)def andAttackerArmy:(id)attArmy andDefenderArmy:(id)defArmy andMainScene:(id)sce ofType:(combatType)t{
    
    self = [super init];
    if(self)
    {
        mainScene = sce;
        type = t;
        
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
                    if(cre.combatType == isMagic){
                        [attackerMagicCreature removeObject:cre];
                        break;
                    }
                    else if (cre.combatType == isRanged){
                        [attackerRangedCreature removeObject:cre];
                        break;
                        
                    }
                    else{
                        if(cre.combatType == isCharge){
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
                if(cre.combatType == isMagic){
                    [defenderMagicCreature removeObject:cre];
                    break;
                }
                else if (cre.combatType == isRanged){
                    [defenderRangedCreature removeObject:cre];
                    break;
                    
                }
                else{
                    if(cre.combatType == isCharge){
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
  
    
    NSRunLoop *loop = [NSRunLoop currentRunLoop];

    
    
    
     NSLog(@" at start num of Creatures in Attacker army %d", [attackerArmy creaturesInArmy]);
     NSLog(@" at start num of Creatures in defender army %d", [defenderArmy creaturesInArmy]);
    
    
    for(Creature *creature in [attackerArmy creatures])
    {
        //NSLog(@"creature name is %@ " ,[creature name]);
        if(creature.combatType == isMagic)
            [attackerMagicCreature addObject:creature];
        else if (creature.combatType ==isRanged )
            [attackerRangedCreature addObject:creature];
        else if ((creature.combatType == isMelee) || (creature.combatType == isCharge)){
                [attackerMeleeCreature addObject:creature];
            
            if(creature.combatType == isCharge)
                    attakerChargeCreatures += 1;
      
        }
        
    }
    
    
    
    //NSLog(@"number of creature in MElee %d",[attackerMeleeCreature count] );
    for(Creature *creature in [defenderArmy creatures])
    {
           if(creature.combatType == isMagic)
            [defenderMagicCreature addObject:creature];
        else if (creature.combatType ==isRanged )
            [defenderRangedCreature addObject:creature];
        
        else if ((creature.combatType == isMelee) || (creature.combatType == isCharge)){
            [defenderMeleeCreature addObject:creature];
            
            if(creature.combatType == isCharge)
                defenderChargeCreatures += 1;
        }
        
    }
    
    
    // now keep fighting until one loses
    
    while(([attackerArmy creaturesInArmy] > 0) && ([defenderArmy creaturesInArmy] > 0) && ([loop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]])){
        
      
        
        /*------------Magic round---------------*/
        attackerNumberOfHits = 0;
        defenderNumberOfHits = 0;
        
        
        round = MagicRound;
        
        [attackerRolledDice removeAllObjects];
        [defenderRolledDice removeAllObjects];
        
        [combatScene setRoundLable:@"Magic Round"];
        
        if([attackerMagicCreature count] > 0){
           
            
            isAttacker = YES;
            
            NSString* str = @"Attacker: roll one dice for \n ";
            str = [str stringByAppendingString:[NSString stringWithFormat:@"%d",[attackerMagicCreature count]]];
            str = [str stringByAppendingString:@" times."];
            
            [combatScene setInstructionText:str];
            
            [combatScene collectDiceResult];
            
            //[combatSctttene setInstructionText:[NSString stringWithString:str]];
            
            
        }
        
    
        if([defenderMagicCreature count]> 0 || (building.combat == Magic)){
            
            
            isAttacker = NO;
         
            NSString* str = @"Defender: roll one dice for \n ";
            if((building.combat == Magic) && ([building combatValue] > 0)){
                str = [str stringByAppendingString:[NSString stringWithFormat:@"%d",[defenderMagicCreature count]+1]];
            }
            else{
                str = [str stringByAppendingString:[NSString stringWithFormat:@"%d",[defenderMagicCreature count]]];
            }


           
            str = [str stringByAppendingString:@" times."];
            
            [combatScene setInstructionText:str];
            
            [combatScene collectDiceResult];
            
            
        }
        
        for(int i = 0 ; i < [attackerMagicCreature count] ; i++){
            Creature *c = [attackerMagicCreature objectAtIndex: i];
            if(c.combatValue >= [[attackerRolledDice objectAtIndex:i] integerValue] ){
                
                attackerNumberOfHits += 1;
            }
            
        }
        
        
        //NSLog(@"Attacker can apply %d hits, in Magic round",attackerNumberOfHits);
        
        
        for(int i = 0 ; i < [defenderMagicCreature count] ; i++){
            Creature *c = [defenderMagicCreature objectAtIndex: i];
            if(c.combatValue >= [[defenderRolledDice objectAtIndex:i] integerValue] )
                defenderNumberOfHits += 1;
        }
        if((building.combat == Magic)&& ([building combatValue] > 0)){
            if([building combatValue] >= ([defenderRolledDice count] - 1))
                defenderNumberOfHits +=1;
            
        }
        
      
        
        //Inform player how many hits are applied
        NSString* str = @"Attacker: can apply \n ";
        str = [str stringByAppendingString:[NSString stringWithFormat:@"%d",attackerNumberOfHits]];
        str = [str stringByAppendingString:@" hits."];
        
        
        str = [str stringByAppendingString:@" \n Defender: can apply \n "];
        str = [str stringByAppendingString:[NSString stringWithFormat:@"%d",defenderNumberOfHits]];
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
        
        
        round = RangedRound;
        
        
        [attackerRolledDice removeAllObjects];
        [defenderRolledDice removeAllObjects];
        
        [combatScene setRoundLable:@"Ranged Round"];
        
        if([attackerRangedCreature count]> 0){
            
            isAttacker = YES;
          
            NSString* str = @"Attacker: roll one dice for \n ";
            str = [str stringByAppendingString:[NSString stringWithFormat:@"%i",[attackerRangedCreature count]]];
            str = [str stringByAppendingString:@" times."];
            
            [combatScene setInstructionText:str];
            
            [combatScene collectDiceResult];
            
        }
        
        
        if([defenderRangedCreature count] > 0 || (building.combat == Ranged)){
            NSString* str = @"Defender: roll one dice for \n  ";

            if((building.combat == Ranged) && ([building combatValue]>0)){
                str = [str stringByAppendingString:[NSString stringWithFormat:@"%i",[defenderRangedCreature count]+1]];
                
            }
            else{
               str = [str stringByAppendingString:[NSString stringWithFormat:@"%i",[defenderRangedCreature count]]];
            }
            isAttacker = NO;
            
            
            str = [str stringByAppendingString:@" times."];
            
            [combatScene setInstructionText:str];
            
            [combatScene collectDiceResult];
            
            
        }
        
        for(int i = 0 ; i < [attackerRangedCreature count] ; i++){
            Creature *c = [attackerRangedCreature objectAtIndex: i];
            if(c.combatValue >= [[attackerRolledDice objectAtIndex:i] integerValue] ){
                
                attackerNumberOfHits += 1;
            }
            
        }
        
        
        
        for(int i = 0 ; i < [defenderRangedCreature count]; i++){
            Creature *c = [defenderRangedCreature objectAtIndex: i];
            
            if(c.combatValue >= [[defenderRolledDice objectAtIndex:i] integerValue] )
                    defenderNumberOfHits += 1;
        }
        if((building.combat == Ranged) && ([building combatValue])){
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
        
        
        round = MeleeRound;
        
        
        [attackerRolledDice removeAllObjects];
        [defenderRolledDice removeAllObjects];
        
        [combatScene setRoundLable:@"Melee Round"];
        
        if([attackerMeleeCreature count]> 0){
           
            
            isAttacker = YES;
            
            
            
            NSString* str = @"Attacker: roll one dice  \n ";
            str = [str stringByAppendingString:[NSString stringWithFormat:@"%d",([attackerMeleeCreature count] - attakerChargeCreatures)]];
            str = [str stringByAppendingString:@" times. and two dices for each Charge(C) creatures for "];
            str = [str stringByAppendingString:[NSString stringWithFormat:@"%d %@",attakerChargeCreatures ,@"times."]];
            
            
            [combatScene setInstructionText:str];
            
            
            [combatScene collectDiceResult];
            
        }
        
        
        if([defenderMeleeCreature count] > 0 || (building.combat == Melee)){
            
            isAttacker = NO;
           
            NSString* str = @"Defender: roll one dice for \n  ";
            
            if((building.combat == Melee) && ([building combatValue]>0)){
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
        for(Creature *c in attackerMeleeCreature){
            
            if(c.combatType == isCharge){
                
                if(c.combatValue >= [[attackerRolledDice objectAtIndex:j] integerValue] ){
                   
                    attackerNumberOfHits += 1;
                    
                }
                if(c.combatValue >= [[attackerRolledDice objectAtIndex:j+1] integerValue] ){
                        attackerNumberOfHits += 1;
                }
                j+=1;
            }
            else{
                if(c.combatValue >= [[attackerRolledDice objectAtIndex:j] integerValue] ){
                
                    attackerNumberOfHits += 1;
                }
            }
              NSLog(@"in attacker j is %d",j);
            j++;
        }
        
        
        j = 0;
        for(Creature *c in defenderMeleeCreature){
            
            if(c.combatType == isCharge){
                if(c.combatValue >= [[defenderRolledDice objectAtIndex:j] integerValue] ){
                    
                    defenderNumberOfHits += 1;
                }
                if(c.combatValue >= [[defenderRolledDice objectAtIndex:j+1] integerValue] ){
                    defenderNumberOfHits += 1;
                }
                
                j+=1;
            }
            else{
                if([c combatValue] >= [[defenderRolledDice objectAtIndex:j] integerValue] ){
                    
                    defenderNumberOfHits += 1;
                }
            }
            NSLog(@"in defender j is %d",j);
            j++;
        }
        
        if((building.combat == Melee) && ([building combatValue]>0)){
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
        [combatScene postCombatScene];
        
        if((building.stage == Citadel) && [attacker hasCitadel]){
////////////////////////// game should end
        }
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
