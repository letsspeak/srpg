//
//  SRAreaLayer.m
//  SRPG
//
//  Created by masa on 12/04/22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SRAreaLayer.h"
#import "SRFieldScene.h"

@implementation SRAreaLayer

- (id)init
{
    self = [super init];
    
    if(self){
        self.isTouchEnabled = NO;
    }
    
    return self;
}

- (void)removeAllAreaSprite
{
    SRFieldScene *fieldScene = (SRFieldScene*)self.parent;
    if(!fieldScene.areaArray) return;
    
    for(SRArea *area in fieldScene.areaArray){
        [area.sprite removeFromParentAndCleanup:YES];
        area.sprite = nil;
    }
}

- (void)drawArea:(SRArea *)area
{    
    CGFloat chipSize = 40.0f;
    
    CGFloat drawPointX = chipSize * area.fieldPoint.x + (chipSize / 2.0f);
    CGFloat drawPointY = 480.0f - (chipSize * area.fieldPoint.y) - (chipSize / 2.0f);
    
    // init sprite and draw
    area.sprite = [CCSprite spriteWithFile:@"areachip.png"];
    area.sprite.position = CGPointMake(drawPointX, drawPointY);
    area.sprite.opacity = 128;
    [self addChild:area.sprite];
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{    
    NSLog(@"SRAreaLayer::ccTouchesBegan called.");

    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:[touch view]];
    
    location = [[CCDirector sharedDirector] convertToGL:location];
    
    SRFieldScene *fieldScene = (SRFieldScene*)self.parent;
    if(!fieldScene.areaArray) return;
    
    for (SRArea *area in fieldScene.areaArray){
        
        CGRect spriteRect = [self rectForSprite:area.sprite];
        if(CGRectContainsPoint(spriteRect, location)){
            
            [fieldScene areaDidTouch:area];
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
    NSLog(@"SRAreaLayer::ccTouchesMoved called.");    
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"SRAreaLayer::ccTouchesEnded called.");
}

- (void)ccTouchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"SRAreaLayer::ccTouchesCancelled called.");
}

@end
