//
//  SRArea.h
//  SRPG
//
//  Created by masa on 12/04/22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SRPG.h"

@interface SRArea : NSObject

@property (nonatomic, readwrite)    SRFieldPoint    fieldPoint;
@property (nonatomic, retain)       CCSprite        *sprite;

@property (nonatomic, readwrite)    NSUInteger      movingCount;
@property (nonatomic, retain)       SRArea          *parentArea;

@end
