//
//  SRUnit.h
//  SRPG
//
//  Created by masa on 12/04/22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SRPG.h"

@interface SRUnit : NSObject

@property (nonatomic, readwrite)    SRFieldPoint    fieldPoint;
@property (nonatomic, retain)       NSString        *spriteFilename;
@property (nonatomic, retain)       CCSprite        *sprite;

// statuses

@property (nonatomic, readwrite)    NSUInteger      moving;

@end
