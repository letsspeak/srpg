//
//  SRTypes.h
//  SRPG
//
//  Created by masa on 12/04/22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#ifndef SRPG_SRTypes_h
#define SRPG_SRTypes_h

struct SRFieldPoint {
    NSUInteger x;
    NSUInteger y;
};
typedef struct SRFieldPoint SRFieldPoint;

static inline SRFieldPoint SRFieldPointMake(NSUInteger x, NSUInteger y)
{
    SRFieldPoint p; p.x = x; p.y = y; return p;
}

#define SR_FIELDPOINT_X_MAX     256
#define SR_FIELDPOINT_Y_MAX     256

#endif
