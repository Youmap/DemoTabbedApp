//
//  Created by Wes Pearce
//  Copyright (c) 2015 Rally Interactive. All rights reserved.
//

#import "RALEase.h"
#import <math.h>
@import Darwin;

RALEaseBlock const EaseLinear = ^(float p) {
    return p;
};


RALEaseBlock const EaseSineIn = ^(float p){
    return (float)(1 - cos(p * (M_PI / 2.0)));
};


RALEaseBlock const EaseSineOut = ^(float p){
    return (float)(sin(p * (M_PI / 2.0)));
};


RALEaseBlock const EaseSineInOut = ^(float p){
    return (float)(-.5 * (cos(M_PI * p) - 1) + 0);
};


RALEaseBlock const EaseCircIn = ^(float p){
    return (float)(1 - sqrt(1 - (p * p)));
};


RALEaseBlock const EaseCircOut = ^(float p){
    return (float)(sqrt((2 - p) * p));
};


RALEaseBlock const EaseCircInOut = ^(float p){
    if(p < 0.5) return (float)(0.5 * (1 - sqrt(1 - 4 * (p * p))));
    else        return (float)(0.5 * (sqrt(-((2 * p) - 3) * ((2 * p) - 1)) + 1));
};


RALEaseBlock const EaseExpoIn = ^(float p){
    return (float)((p==0) ? 0 : pow(2, 10 * (p - 1)));
};


RALEaseBlock const EaseExpoOut = ^(float p){
    return (float)((p == 1) ? 1 : 1 - pow(2, -10 * p));
};


RALEaseBlock const EaseExpoInOut = ^(float p){
    if (p==0) return (float)0.0;
    if (p==1) return (float)1.0;
    if (p < .5) return (float)(.5 * pow(2, 10 * (p * 2 - 1)) + 0);
    return (float)(.5 * (-pow(2, -10 * (p/.5 - 1)) + 2) + 0);
};


RALEaseBlock const EaseQuadIn = ^(float p){
    return p*p;
    
};


RALEaseBlock const EaseQuadOut = ^(float p){
    return -p*(p-2);
};


RALEaseBlock const EaseQuadInOut = ^(float p){
    if (p < .5) return p*p*2;
    return 4*p - 2*p*p - 1;
};


RALEaseBlock const EaseQuartIn = ^(float p){
    return p*p*p*p;
};


RALEaseBlock const EaseQuartOut = ^(float p){
    p -= 1;
    return 1-p*p*p*p;
};


RALEaseBlock const EaseQuartInOut = ^(float p){
    p *= 2;
    if (p < 1) return (float)(.5*p*p*p*p);
    p -= 2;
    return (float)(1 - .5*p*p*p*p);
};


RALEaseBlock const EaseQuintIn = ^(float p){
    return p*p*p*p*p;
};


RALEaseBlock const EaseQuintOut = ^(float p){
    p -= 1;
    return p*p*p*p*p + 1;
};


RALEaseBlock const EaseQuintInOut = ^(float p){
    p *= 2;
    if (p < 1) return (float)(.5*p*p*p*p*p);
    p -= 2;
    return (float)(.5*p*p*p*p*p + 1);
};


RALEaseBlock const EaseBackIn = ^(float p){
    const float s = 1.70158;
    return p*p*((s+1)*p - s);
};


RALEaseBlock const EaseBackOut = ^(float p){
    const float s = 1.70158;
    p -= 1;
    return p*p*((s+1)*p + s) + 1;
};


RALEaseBlock const EaseBackInOut = ^(float p){
    const float s = 1.70158*1.525;
    p *= 2;
    if (p < 1) return (float)(.5*(p*p*((s+1)*p - s)));
    p -= 2;
    return (float)(.5*(p*p*((s+1)*p + s) + 2));
};


RALEaseBlock const EaseSineInReturnOut = ^(float p){
    return (p < .5) ? EaseSineIn(p*2) : EaseSineOut(1-((p-.5)*2));
};


RALEaseBlock const EaseElasticIn = ^(float p){
    return (float)(sin(13 * M_PI_2 * p) * pow(2, 10 * (p - 1)));
};


RALEaseBlock const EaseElasticOut = ^(float p){
    return (float)(sin(-13 * M_PI_2 * (p + 1)) * pow(2, -10 * p) + 1);
};


RALEaseBlock const EaseElasticInOut = ^(float p){
    if(p < 0.5){
        return (float)(0.5 * sin(13 * M_PI_2 * (2 * p)) * pow(2, 10 * ((2 * p) - 1)));
    }else{
        return (float)(0.5 * (sin(-13 * M_PI_2 * ((2 * p - 1) + 1)) * pow(2, -10 * (2 * p - 1)) + 2));
    }
};


RALEaseBlock const EaseBounceIn = ^(float p){
    return 1 - EaseBounceOut(1-p);
};


RALEaseBlock const EaseBounceOut = ^(float p){
    if(p < 4/11.0){
        return (float)((121 * p * p)/16.0);
    }else if(p < 8/11.0){
        return (float)((363/40.0 * p * p) - (99/10.0 * p) + 17/5.0);
    }else if(p < 9/10.0){
        return (float)((4356/361.0 * p * p) - (35442/1805.0 * p) + 16061/1805.0);
    }else{
        return (float)((54/5.0 * p * p) - (513/25.0 * p) + 268/25.0);
    }
};


RALEaseBlock const EaseBounceInOut = ^(float p){
    if(p < 0.5){
        return (float)(0.5 * EaseBounceIn(p*2));
    }else{
        return (float)(0.5 * EaseBounceOut(p * 2 - 1) + 0.5);
    }
};


RALEaseBlock const EaseFlickerOut = ^(float p){
    if (p == 1.f)
        return 1.f;
    return (float)(arc4random_uniform(1000) < EaseQuadOut(p)*900+50);
};


RALEaseBlock const EaseFlickerIn = ^(float p){
    if (p == 1.f)
        return 1.f;
    return (float)(arc4random_uniform(1000) < EaseQuadIn(p)*900+50);
};

