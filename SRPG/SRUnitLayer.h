//
//  SRCharacterLayer.h
//  SRPG
//
//  Created by masa on 12/04/22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CCLayer.h"
#import "SRPG.h"
#import "SRUnit.h"

@interface SRUnitLayer : CCLayer

@property (nonatomic, retain) SRUnit    *movingUnit;
@property (nonatomic, retain) CCArray   *movingRouteArray;

- (void)setUnits:(CCArray*)unitArray;
- (void)moveUnit:(SRUnit*)unit withMovingRouteArray:(CCArray*)movingRouteArray;

@end
