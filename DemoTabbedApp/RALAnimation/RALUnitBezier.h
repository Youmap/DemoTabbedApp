//
//  Created by Wes Pearce
//  Copyright (c) 2015 Rally Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RALEase.h"

@interface RALUnitBezier : NSObject

+ (RALEaseBlock)bezierWithControlPoints:(double)p1x :(double)p1y :(double)p2x :(double)p2y;
+ (RALEaseBlock)offsetBezierWithControlPoints:(double)p1x :(double)p1y :(double)p2x :(double)p2y;

@end
