//
//  SRFieldScene.h
//  SRPG
//
//  Created by masa on 12/03/24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CCScene.h"
#import "SRPG.h"

typedef enum{
    SRFieldScenePhaseNoAction,
    SRFieldScenePhaseUnitTouching,
    SRFieldScenePhaseUnitSelected,
    SRFieldPointPhaseUnitMoving,
    SRFieldPointPhaseUnitMovingFinished,
}SRFieldScenePhase;


@class SRUnit;
@class SRArea;

@class SRMapLayer;
@class SRUnitLayer;
@class SRAreaLayer;

@interface SRFieldScene : CCScene{
    SRMapLayer          *_mapLayer;
    SRAreaLayer         *_areaLayer;
    SRUnitLayer         *_unitLayer;
}

@property (nonatomic, retain) CCArray     *unitArray;     // for SRUnit
@property (nonatomic, retain) CCArray     *areaArray;     // for SRArea

@property (nonatomic, retain) SRUnit      *selectedUnit;
@property (nonatomic, retain) CCArray     *movingRouteArray;

@property (nonatomic, readwrite) SRFieldScenePhase phase;

- (void)unitDidTouch:(SRUnit*)unit;
- (void)areaDidTouch:(SRArea*)area;

- (void)setPhase:(SRFieldScenePhase)phase;

@end
