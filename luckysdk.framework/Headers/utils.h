//
// Created by rico on 2017/12/9.
// Copyright (c) 2017 rico. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface utils : NSObject
@end

@interface Gap: NSObject

@property int64_t miniGap;

- (instancetype) init: (long) msMiniGap;

- (bool) peekNext;
- (bool) passedNext;
- (void) reset;
- (void) updateToNow;

@end

@interface CoolWarm: NSObject {
@public
    uint8_t         c, w;
    double          warmRatio, brt;
}

+ (instancetype) from: (double) warmRation :(double) brt;
+ (instancetype) fromInt: (int) c :(int) w;

@end


@interface Pair<FIRST, SECOND>:NSObject
@property (strong) FIRST f;
@property (strong) SECOND  s;

+ (instancetype) from: (FIRST) f :(SECOND) s;

@end

#ifdef __cplusplus
extern "C" {
#endif
    NSString *json2String(NSDictionary *json);
    NSMutableDictionary *string2Json(NSString *str);
    NSMutableArray *string2JsonArr(NSString *str);
    NSMutableData *decodeHex(NSString *data);
#ifdef __cplusplus
};
#endif