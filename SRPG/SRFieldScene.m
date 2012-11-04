//
//  SRFieldScene.m
//  SRPG
//
//  Created by masa on 12/03/24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

#import "SRUnit.h"
#import "SRArea.h"
#import "SRRoute.h"

#import "SRFieldScene.h"
#import "SRMapLayer.h"
#import "SRAreaLayer.h"
#import "SRUnitLayer.h"

@implementation SRFieldScene

@synthesize unitArray = _unitArray;
@synthesize areaArray = _areaArray;


@synthesize selectedUnit = _selectedUnit;
@synthesize movingRouteArray = _movingRouteArray;
@synthesize phase = _phase;

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
        
        // create map layer
        _mapLayer = [SRMapLayer node];
        [self addChild:_mapLayer];
        
        // create area layer
        _areaLayer = [SRAreaLayer node];
        [self addChild:_areaLayer];
        
        // create units
        self.unitArray = [CCArray array];
        
        SRUnit *unit1 = [[SRUnit alloc] init];
        unit1.spriteFilename = @"pc01_00.png";
        unit1.fieldPoint = SRFieldPointMake(5, 5);
        unit1.moving = 3;
        [self.unitArray addObject:unit1];
        
        SRUnit *unit2 = [[SRUnit alloc] init];
        unit2.spriteFilename = @"pc01_00.png";
        unit2.fieldPoint = SRFieldPointMake(2, 10);
        unit2.moving = 5;
        [self.unitArray addObject:unit2];
        
        // create unit layer and set units
        _unitLayer = [SRUnitLayer node];
        [_unitLayer setUnits:_unitArray];
        [self addChild:_unitLayer];
        
        self.selectedUnit = nil;
        self.phase = SRFieldScenePhaseNoAction;

	}
	return self;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

- (void)unitDidTouch:(SRUnit*)unit
{
    switch (self.phase) {
        case SRFieldScenePhaseNoAction:
        {
            // create movingArea and show
            [self createMovingAreaWithUnit:unit];
            
        }
            break;
        case SRFieldScenePhaseUnitSelected:
        {
            // TODO : show unit infomation 
        }
        default:
            break;
    }
}

- (void)areaDidTouch:(SRArea*)area;
{
    switch (self.phase) {
        case SRFieldScenePhaseUnitSelected:
        {
            // move selected unit to selected area
            [self moveSelectedUnitToArea:area];
        }
            break;
            
        default:
            break;
    }
}

- (void)createMovingAreaWithUnit:(SRUnit*)unit
{
    // set phase to SRFieldScenePhaseUnitSelected
    [self setPhase:SRFieldScenePhaseUnitSelected];
    
    // create area
    self.areaArray = [CCArray array];
    [self checkMovingAreaWithFieldPoint:unit.fieldPoint moving:unit.moving parentArea:nil];
    
    // redraw areaLayer
    [_areaLayer removeAllAreaSprite];
    for(SRArea *area in self.areaArray){
        [_areaLayer drawArea:area];
    }
    
    // areaLayer touches enable
    _areaLayer.isTouchEnabled = YES;
    self.selectedUnit = unit;
}

- (void)moveSelectedUnitToArea:(SRArea*)area
{
    // set phase to SRFieldScenePhaseUnitMoving
    [self setPhase:SRFieldPointPhaseUnitMoving];
    
    // set unit fieldPoint to touched area
    self.selectedUnit.fieldPoint = SRFieldPointMake(area.fieldPoint.x, area.fieldPoint.y);
    
    // create move route for animation
    [self createMovingRouteWithTargetArea:area];
    
    // start animation on selected unit
    [_unitLayer moveUnit:self.selectedUnit withMovingRouteArray:self.movingRouteArray];
}

- (void)createMovingRouteWithTargetArea:(SRArea*)targetArea;
{
    CCArray *reverseRouteArray = [CCArray array];

    // add target area to route array
    SRRoute *goalRoute = [[SRRoute alloc] init];
    goalRoute.fieldPoint = SRFieldPointMake(targetArea.fieldPoint.x, targetArea.fieldPoint.y);
    [reverseRouteArray addObject:goalRoute];
    
    // search next area and add route array
    SRArea *nextArea = targetArea.parentArea;
    while(nextArea){
        
        SRRoute *nextRoute = [[SRRoute alloc] init];
        nextRoute.fieldPoint = SRFieldPointMake(nextArea.fieldPoint.x, nextArea.fieldPoint.y);
        [reverseRouteArray addObject:nextRoute];
        
        nextArea = nextArea.parentArea;
    }
    
    // turn the other way and set to movingRouteArray
    [reverseRouteArray reverseObjects];
    self.movingRouteArray = reverseRouteArray;
}

- (SRArea*)getAreaWithFieldPoint:(SRFieldPoint)targetFieldPoint
{
    for(SRArea *area in self.areaArray){
        if(area.fieldPoint.x == targetFieldPoint.x
           && area.fieldPoint.y == targetFieldPoint.y) return area;
    }
    
    return nil;
}


- (void)checkMovingAreaWithFieldPoint:(SRFieldPoint)fieldPoint moving:(NSUInteger)moving parentArea:(SRArea*)parentArea
{
    
    // check if fieldPoint had buried or not
    for(SRArea *area in self.areaArray){
        if(area.fieldPoint.x == fieldPoint.x
           && area.fieldPoint.y == fieldPoint.y){
            
            if(area.movingCount < moving){
                [self.areaArray removeObject:area];
                break;
            }else{
                return;
            }
            
        }
    }
    
    // add area to areaArray
    SRArea *area = [[SRArea alloc] init];
    area.fieldPoint = fieldPoint;
    area.movingCount = moving;
    area.parentArea = parentArea;
    [self.areaArray addObject:area];
    
    // next area check
    if(moving > 1){
        
        // chip on the current chip
        if(fieldPoint.y > 0){
            [self checkMovingAreaWithFieldPoint:SRFieldPointMake(fieldPoint.x, fieldPoint.y-1) moving:moving-1 parentArea:area];
        }
    
        // chip under the current chip
        if(fieldPoint.y < SR_FIELDPOINT_Y_MAX){
            [self checkMovingAreaWithFieldPoint:SRFieldPointMake(fieldPoint.x, fieldPoint.y+1) moving:moving-1 parentArea:area];
        }
        
        // chip left of the current chip
        if(fieldPoint.x > 0){
            [self checkMovingAreaWithFieldPoint:SRFieldPointMake(fieldPoint.x-1, fieldPoint.y) moving:moving-1 parentArea:area];
        }
        
        // chip right of the current chip
        if(fieldPoint.x < SR_FIELDPOINT_X_MAX){
            [self checkMovingAreaWithFieldPoint:SRFieldPointMake(fieldPoint.x+1, fieldPoint.y) moving:moving-1 parentArea:area];
        }
    }
}

- (BOOL)isBuriedAreaWithFieldPoint:(SRFieldPoint)fieldPoint
{
    for(SRArea *area in self.areaArray){
        if(area.fieldPoint.x == fieldPoint.x
           && area.fieldPoint.y == fieldPoint.y){
            return YES;
        }
    }
    
    return NO;
}

- (SRUnit*)getUnitWithFieldPoint:(SRFieldPoint)fieldPoint
{
    if(!self.unitArray) return nil;
    
    for (NSUInteger i = 0; i < [self.unitArray count]; i++) {
        SRUnit *unit = [self.unitArray objectAtIndex:i];
        if(unit.fieldPoint.x == fieldPoint.x
           && unit.fieldPoint.y == fieldPoint.y){
            return unit;
        }
    }
    return nil;
}

- (void)setPhase:(SRFieldScenePhase)phase
{
    _phase = phase;
    
    switch (self.phase) {
        case SRFieldScenePhaseNoAction:
            break;
        case SRFieldScenePhaseUnitTouching:
            break;
        case SRFieldScenePhaseUnitSelected:
            break;
        case SRFieldPointPhaseUnitMoving:
            break;
        case SRFieldPointPhaseUnitMovingFinished:
        {
            // reset areaLayer
            [_areaLayer removeAllAreaSprite];
            _areaLayer.isTouchEnabled = NO;
            
            // set phase to SRFieldScenePhaseNoAction
            _phase = SRFieldScenePhaseNoAction;
        }
            break;
        default:
            break;
    }
}


@end
