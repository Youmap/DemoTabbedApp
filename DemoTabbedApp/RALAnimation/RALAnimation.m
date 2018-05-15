//
//  UAnimation.m
//  UMTCEngine
//
//  Created by Tyler Martin on 2/5/13.
//  Copyright (c) 2013 Ultramegatronic. All rights reserved.
//

#import "RALAnimation.h"
#import <QuartzCore/QuartzCore.h>


#define RALAnimationAnimationMax 60
float const RALAnimationInfinite = -1;



//
// First we have the RALAnimationManager.
//

@class RALAnimation;
@interface RALAnimationManager : NSObject
{
//    NSMutableArray *animations;
    CADisplayLink *displayLink;
    __strong RALAnimation **anims;
    int animationCount;
    
}
- (void)addAnimation:(RALAnimation *)a;
- (void)removeAnimation:(RALAnimation *)a;
+ (RALAnimationManager *)sharedInstance;

@end

@implementation RALAnimationManager

+ (RALAnimationManager *)sharedInstance
{
    static RALAnimationManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[RALAnimationManager alloc] init];
    });
    return sharedInstance;
}

- (id)init
{
    if (!(self = [super init])) return nil;
    
//    animations = [NSMutableArray new];
    anims = (__strong RALAnimation **)calloc(sizeof(RALAnimation *), RALAnimationAnimationMax);
    animationCount = 0;
    
    return self;
}

- (void)addAnimation:(RALAnimation *)a
{
//    [animations addObject:a];
//    if (animations.count == 1 && !displayLink)
//    {
//        displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(tick:)];
//        [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
//    }
    
    if (animationCount == RALAnimationAnimationMax)
    {
        [anims[0] stop];
        NSLog(@"ANIMATION MAX REACHED!!!!");
//        return;
    }
    anims[animationCount] = a;
    animationCount++;
    if (animationCount == 1 && !displayLink)
    {
        displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(tick:)];
        [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }
}
- (void)removeAnimation:(RALAnimation *)a
{
//    [animations removeObject:a];
//    if (animations.count == 0 && displayLink)
//    {
//        [displayLink invalidate];
//        displayLink = nil;
//    }

    if (animationCount == 0)
    {
        return;
    }

    BOOL found = NO;
    for (int i = 0; i < animationCount; i++)
    {
        if (a == anims[i])
        {
            anims[i] = nil;
            found = YES;
        }
        if (found && i < animationCount-1)
        {
            anims[i] = anims[i+1];
            anims[i+1] = nil;
        }
    }
    if (found)
        animationCount--;
    
    if (animationCount == 0 && displayLink)
    {
        [displayLink invalidate];
        displayLink = nil;
    }
}
- (void)tick:(CADisplayLink *)dl
{
//    NSLog(@"animations: %@", animations);
//    
//    for (RALAnimation *a in animations)
//    {
//        [a tick:dl.duration*dl.frameInterval];
//    }
    
    for (int i = 0; i < animationCount; i++)
    {
        [anims[i] tick:dl.duration];
    }
}

@end




//
// Then we have the actual RALAnimation class.
//

@interface RALAnimation ()
{
    float elapsedTime;
    float duration, delay;
    BOOL naturalCompletion;
}
@end

@implementation RALAnimation

@synthesize registered, paused;
@synthesize block;
@synthesize onComplete;
@synthesize infinite;
@synthesize ease;
@synthesize isComplete;

+ (instancetype)startWithDuration:(float)t delay:(float)d ease:(RALEaseBlock)e tick:(RALAnimationTickBlock)b onComplete:(RALAnimationCompleteBlock)oc
{
//    if (t < (1.0/60.0)) t = (1.0/60.0);
    RALAnimation *a = [[RALAnimation alloc] initWithDuration:t delay:d ease:e tick:b onComplete:oc];
    [a start];
    return a;
}

- (instancetype)initWithDuration:(float)t delay:(float)d ease:(RALEaseBlock)e tick:(RALAnimationTickBlock)b onComplete:(RALAnimationCompleteBlock)oc
{
    if (!(self = [super init])) return nil;
    
    if (b == nil)
        return nil;
    
    paused = NO;
    registered = NO;
    naturalCompletion = NO;
    block = b;
    onComplete = oc;
    duration = t;
    delay = d;
    ease = (e) ? e : EaseLinear;
    infinite = (t == RALAnimationInfinite);

    return self;
}

- (void)start
{
    isComplete = NO;
    naturalCompletion = NO;
    elapsedTime = -delay;
    [[RALAnimationManager sharedInstance] addAnimation:self];
    registered = YES;
    
    if (block) {
        block(0);
    }
}

- (void)tick:(float)dt
{
    if (paused)
        return;
    
    elapsedTime += dt;
    
    if (elapsedTime < 0)
        return;

    if (infinite)
    {
        if (block)
            block(dt);
        return;
    }

    static float p;
    p = elapsedTime / duration;
    if (p > 1)
        p = 1;
    
    if (block && ease)
        block(ease(p));
    
    if (p == 1)
    {
        naturalCompletion = YES;
        [self stop];
    }
}

- (void)stop
{
    isComplete = YES;
    if (onComplete)
        onComplete(naturalCompletion);
    block = nil;
    onComplete = nil;
    registered = NO;
    [[RALAnimationManager sharedInstance] removeAnimation:self];
}

- (void)completeNow
{
    if (isComplete)
        return;
    if (block)
        block(1);
    naturalCompletion = NO;
    [self stop];
}

- (void)setPaused:(BOOL)p
{
    paused = p;
    // do stuff?
}

@end
