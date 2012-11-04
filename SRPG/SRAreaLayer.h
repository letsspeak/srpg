//
//  SRAreaLayer.h
//  SRPG
//
//  Created by masa on 12/04/22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CCLayer.h"
#import "SRPG.h"
#import "SRArea.h"

@interface SRAreaLayer : CCLayer

- (void)removeAllAreaSprite;
- (void)drawArea:(SRArea*)area;

@end
