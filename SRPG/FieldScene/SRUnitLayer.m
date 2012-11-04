//
//  SRUnitLayer.m
//  SRPG
//
//  Created by masa on 12/04/22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SRUnitLayer.h"
#import "SRFieldScene.h"
#import "SRUnit.h"
#import "SRRoute.h"

@implementation SRUnitLayer

@synthesize movingUnit = _movingUnit;
@synthesize movingRouteArray = _movingRouteArray;

- (id)init
{
    self = [super init];
    
    if(self){
                
        self.isTouchEnabled = YES;
        
    }
    
    return self;
}

- (void)setUnits:(CCArray*)unitArray
{
    for (NSUInteger i = 0; i < [unitArray count]; i++) {

        // create unitSprite
        SRUnit *unit = [unitArray objectAtIndex:i];
        unit.sprite = [CCSprite spriteWithFile:unit.spriteFilename]; 
        unit.sprite.tag = i;
        
        // draw unit
        [self drawUnit:unit];        
    }
}

- (void)drawUnit:(SRUnit*)unit
{    
    CGFloat chipSize = 40.0f;
    
    CGFloat drawPointX = chipSize * unit.fieldPoint.x + (chipSize / 2.0f);
    CGFloat drawPointY = 480.0f - (chipSize * unit.fieldPoint.y) - (chipSize / 2.0f);
    
    unit.sprite.position = CGPointMake(drawPointX, drawPointY);
    [self addChild:unit.sprite];
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"SRUnitLayer::ccTouchesBegan called.");

    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:[touch view]];
    
    location = [[CCDirector sharedDirector] convertToGL:location];
    
    SRFieldScene *fieldScene = (SRFieldScene*)self.parent;
    if(!fieldScene.unitArray) return;
    
    for (SRUnit *unit in fieldScene.unitArray){
        
        CGRect spriteRect = [self rectForSprite:unit.sprite];
        if(CGRectContainsPoint(spriteRect, location)){
            
            [fieldScene unitDidTouch:unit];
            return;
        }
    }
    
}

- (CGRect)rectForSprite:(CCSprite*)sprite
{
    float w = [sprite contentSize].width;
    float h = [sprite contentSize].height;
    float x = sprite.position.x - w/2.0f;
    float y = sprite.position.y - h/2.0f;
        
    CGRect rect = CGRectMake(x, y, w, h);
    return rect;
}

- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"SRUnitLayer::ccTouchesMoved called.");    
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"SRUnitLayer::ccTouchesEnded called.");
}

- (void)ccTouchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"SRUnitLayer::ccTouchesCancelled called.");
}

- (void)moveUnit:(SRUnit*)unit withMovingRouteArray:(CCArray*)movingRouteArray
{
    NSMutableArray *actionsArray = [NSMutableArray array];
    
    for(int i = 0; i < [movingRouteArray count]; i++){
        
        SRRoute *route = [movingRouteArray objectAtIndex:i];
        
        CGFloat chipSize = 40.0f;
        CGFloat movePointX = chipSize * route.fieldPoint.x + (chipSize / 2.0f);
        CGFloat movePointY = 480.0f - (chipSize * route.fieldPoint.y) - (chipSize / 2.0f);
        
        id actionMove = [CCMoveTo actionWithDuration:0.2f position:CGPointMake(movePointX, movePointY)];
        [actionsArray addObject:actionMove];
    }
    
    id actionMoveDone = [CCCallFuncN actionWithTarget:self selector:@selector(moveUnitFinished)];
    [actionsArray addObject:actionMoveDone];
    
    [unit.sprite runAction:[CCSequence actionsWithArray:actionsArray]];
}

- (void)moveUnitFinished
{
    SRFieldScene *fieldScene = (SRFieldScene*)self.parent;
    [fieldScene setPhase:SRFieldPointPhaseUnitMovingFinished];
}




@end
