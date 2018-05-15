//
//  UAnimation.h
//  UMTCEngine
//
//  Created by Tyler Martin on 2/5/13.
//  Copyright (c) 2013 Ultramegatronic. All rights reserved.
//

#import "RALEase.h"
#import <Foundation/Foundation.h>
@import UIKit;

typedef NS_ENUM(NSInteger, RALAnimationDirection) {
    RALAnimationDirectionForward,
    RALAnimationDirectionBackward
};

typedef void (^RALAnimationTickBlock)(float value);
typedef void (^RALAnimationCompleteBlock)(BOOL completed);

extern float const RALAnimationInfinite;

@interface RALAnimation : NSObject

// initialization
- (instancetype)initWithDuration:(float)t delay:(float)d ease:(RALEaseBlock)e tick:(RALAnimationTickBlock)b onComplete:(RALAnimationCompleteBlock)oc;
+ (instancetype)startWithDuration:(float)t delay:(float)d ease:(RALEaseBlock)e tick:(RALAnimationTickBlock)b onComplete:(RALAnimationCompleteBlock)oc;

// parameters
@property (nonatomic, readonly) BOOL registered;
@property (nonatomic) BOOL paused;
@property (nonatomic, readonly) RALEaseBlock ease;
@property (nonatomic, readonly) RALAnimationTickBlock block;
@property (nonatomic, readonly) RALAnimationCompleteBlock onComplete;
@property (nonatomic, readonly) BOOL infinite;
@property (nonatomic, readonly) BOOL isComplete;

// animation chain
@property (nonatomic, strong) RALAnimation *nextAnimation, *previousAnimation;

// control
- (void)tick:(float)dt;
- (void)start;
- (void)stop;
- (void)completeNow;

@end
