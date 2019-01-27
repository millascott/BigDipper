//
// Created by rico on 2017/12/9.
// Copyright (c) 2017 rico. All rights reserved.
//

#import <Foundation/Foundation.h>


@class CBUUID;

@interface UniId : NSObject <NSCopying>

+ (instancetype) fromStr: (NSString *) str;
+ (instancetype) fromBytes: (void *) bytes;
+ (instancetype) fromCBUUID: (CBUUID *) id;

+ (instancetype) randomId;

- (NSString *)description;

@end

typedef enum ShortId {
    SHORT_ID_START = 0,
    SHORT_ID_GROUP_START = 0,   // 0x0FFF,
    SHORT_ID_GROUP_END = 0x7FFF,

    SHORT_ID_PHONE_START = 0x8000,
    SHORT_ID_PHONE_END = 0x87FF,

    SHORT_ID_ROUTER_START = 0x8800,
    SHORT_ID_ROUTER_END = 0x8DFF,

    SHORT_ID_SERVER_START = 0x8E00,
    SHORT_ID_SERVER_BAPI = 0x8E00,
    SHORT_ID_SERVER_END = 0x8EFF,

    SHORT_ID_RESERVED_START = 0x8F00,
    SHORT_ID_RESERVED_END = 0x8FFF,

    SHORT_ID_SLAVE_START = 0x9000,
    SHORT_ID_SLAVE_END = 0xFFFE,

    SHORT_ID_DEV_START = 0x8000,
    SHORT_ID_DEV_END = 0xFFFE,

    SHORT_ID_END = 0xFFFF,
    INVALID_SHORT_ID = -1,


    SHORT_ID_TYPE_GROUP = 0,
    SHORT_ID_TYPE_PHONE = 1,
    SHORT_ID_TYPE_SLAVE = 2,

    MAX_SHORT_ID_TYPE = 3,

} ShortId;

#ifdef __cplusplus
extern "C" {
#endif
    extern int ShortIdOffset(int shortId);
    extern int ShortIdOffsetForName(int shortId);
    extern NSString * md5(NSString * string);
#ifdef __cplusplus
}
#endif