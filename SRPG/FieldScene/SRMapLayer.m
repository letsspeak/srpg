//
//  SRMapLayer.m
//  SRPG
//
//  Created by masa on 12/03/24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "SRMapLayer.h"

@implementation SRMapLayer

- (id)init
{
    self = [super init];
    
    if(self){
        
//        self.isTouchEnabled = YES;
//        // create and initialize a Label
//        CCLabelTTF *label = [CCLabelTTF labelWithString:@"Hello? World" fontName:@"Marker Felt" fontSize:64];
//    
//        // ask director the the window size
//        CGSize size = [[CCDirector sharedDirector] winSize];
//    
//        // position the label on the center of the screen
//        label.position =  ccp( size.width /2 , size.height/2 );
//    
//        // add the label as a child to this Layer
//        [self addChild: label];
    }
    
    return self;
}

- (void)visit
{
    // draw horizonal lines
    for(int i = 0; i <= (320/40); i++){
        glColor4f(0.0f, 0.0f, 1.0f, 1.0f);
        CGPoint lpt1 = CGPointMake(i*40, 0);
        CGPoint lpt2 = CGPointMake(i*40, 480);
        ccDrawLine(lpt1, lpt2);
    }
    
    // draw vertical lines
    for(int i = 0; i <= (480/40); i++){
        glColor4f(1.0f, 0.0f, 0.0f, 1.0f);
        CGPoint lpt1 = CGPointMake(0, i*40);
        CGPoint lpt2 = CGPointMake(320, i*40);
        ccDrawLine(lpt1, lpt2);
    }
    
    /*
    glColor4f(1.0f, 0.0f, 0.0f, 1.0f);
    CGPoint center = CGPointMake(160, 60);
    float radius = 40;
    float angle = CC_DEGREES_TO_RADIANS(45);
    int segments = 12;
    ccDrawCircle(center, radius, angle, segments, YES);
     */
}
//
//- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    NSLog(@"SRMapLayer::ccTouchesBegan called.");
//}
//
//- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    NSLog(@"SRMapLayer::ccTouchesMoved called.");    
//}
//
//- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    NSLog(@"SRMapLayer::ccTouchesEnded called.");
//}
//
//- (void)ccTouchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    NSLog(@"SRMapLayer::ccTouchesCancelled called.");
//}

@end
