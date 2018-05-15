/*
 * Copyright (C) 2008 Apple Inc. All Rights Reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY APPLE INC. ``AS IS'' AND ANY
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 * PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL APPLE INC. OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
 * OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

//
// Obj-C port of Webkit implementation of CSS cubic-bezier(p1x.p1y,p2x,p2y)
// By Wes Pearce; works with RALAnimation.
//

#import "RALEase.h"
#import "RALUnitBezier.h"

@implementation RALUnitBezier

+ (RALEaseBlock)bezierWithControlPoints:(double)p1x :(double)p1y :(double)p2x :(double)p2y
{
    // Calculate the polynomial coefficients, implicit first and last control points are (0,0) and (1,1).
    double cx = 3.0 * p1x;
    double bx = 3.0 * (p2x - p1x) - cx;
    double ax = 1.0 - cx -bx;
    
    double cy = 3.0 * p1y;
    double by = 3.0 * (p2y - p1y) - cy;
    double ay = 1.0 - cy - by;
    
    double (^sampleCurveX)(double) = ^(double t){
        return ((ax * t + bx) * t + cx) * t;
    };
    
    double (^sampleCurveY)(double) = ^(double t){
        return ((ay * t + by) * t + cy) * t;
    };
    
    double (^sampleCurveDerivativeX)(double) = ^(double t){
        return (3.0 * ax * t + 2.0 * bx) * t + cx;
    };
    
    double (^solveCurveX)(double,double) = ^(double x, double epsilon){
        double t0;
        double t1;
        double t2;
        double x2;
        double d2;
        int i;
        
        // First try a few iterations of Newton's method -- normally very fast.
        for (t2 = x, i = 0; i < 8; i++) {
            x2 = sampleCurveX(t2) - x;
            if (fabs (x2) < epsilon)
                return t2;
            d2 = sampleCurveDerivativeX(t2);
            if (fabs(d2) < 1e-6)
                break;
            t2 = t2 - x2 / d2;
        }
        
        // Fall back to the bisection method for reliability.
        t0 = 0.0;
        t1 = 1.0;
        t2 = x;
        
        if (t2 < t0)
            return t0;
        if (t2 > t1)
            return t1;
        
        while (t0 < t1) {
            x2 = sampleCurveX(t2);
            if (fabs(x2 - x) < epsilon)
                return t2;
            if (x > x2)
                t0 = t2;
            else
                t1 = t2;
            t2 = (t1 - t0) * .5 + t0;
        }
        
        // Failure.
        return t2;
    };
    
//    double (^solveX)(double) = ^(double x){
//        return sampleCurveY(solveCurveX(x,10));
//    };
    
    float (^ralEase)(float) = ^(float x){
        return (float)sampleCurveY(solveCurveX(x,2));
    };
    
    return ralEase;
}

+ (RALEaseBlock)offsetBezierWithControlPoints:(double)p1x :(double)p1y :(double)p2x :(double)p2y
{
    RALEaseBlock bezier = [RALUnitBezier bezierWithControlPoints:p1x :p1y :p2x :p2y];
    float (^ralEase)(float) = ^(float x){
        return bezier(x) - x;
    };
    return ralEase;
}

@end