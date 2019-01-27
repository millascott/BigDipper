//
//  NetworkConfig.h
//  luckysdk
//
//  Created by rico on 2017/12/9.
//  Copyright © 2017年 rico. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UniId.h"

@class Gap;

enum {
    MAX_GROUP_SUPPORT = 32,
    DEF_GROUP_SUPPORT = 10,
    DEV_DATA_LEN = 32,
};

@interface IdEntity : NSObject {
@public
    UniId       *Id;
    int         shortId;
    NSString    *name;
}

- (UniId *) Id;
- (int) shortId;
- (NSString *) name;

- (NSMutableDictionary *) toJson;

@end

@interface Device : IdEntity {
@package
    int         type;
    NSData      *dhmKey;
    bool        onOff;
    uint8_t     data[DEV_DATA_LEN];

    int         groupCount;
    int         groups[MAX_GROUP_SUPPORT];

    Gap         *onOffGap;
}

- (int) type;
- (NSData *) dhmKey;
- (NSMutableDictionary *) toJson;
+ (instancetype) fromJson: (NSMutableDictionary *) json;

+ (instancetype) from:(NSString *) name :(UniId *) uid :(int) shortId;
+ (instancetype) from:(int) shortId :(NSString *) name type:(int) type;

@end

@interface Group : IdEntity

- (NSMutableDictionary *) toJson;
+ (instancetype) fromJson: (NSMutableDictionary *) json;
+ (instancetype) from:(int) shortId :(NSString *) name;

@end


@interface NetworkInfo : NSObject {
@public
    NSString        *name;
    NSString        *account;
    NSString        *password;

    int64_t         createUtc;
    int64_t         lastUpdateUtc;
    int64_t         lastUploadUtc;
    int64_t         lastChangeUtc;
}

- (NSString *) getHashKey;

- (NSMutableDictionary *) toJson;
+ (instancetype) fromJson: (NSMutableDictionary *) json;

+ (instancetype) from: (NSString *) acc :(NSString *) psw :(NSString *) net : (int64_t) createUtc :(int64_t) uploadTime :(int64_t) changeTime;

@end

enum {
    GROUP_ALL = 0,
    GROUP_CLEAR = 0xFFFF,
};

@interface NetworkConfig : NSObject {
@public
    NSString        *name;
    NSString        *account;
    NSString        *password;
    NSString        *netKey;

@package
    int64_t         createUtc;
    int64_t         lastUpdateUtc;
    int64_t         lastUploadUtc;
    int64_t         lastChangeUtc;

    bool            firstInit;

    NSMutableDictionary    *deviceMap;
    NSMutableDictionary    *groupMap;

    // temp data.
    NSMutableDictionary    *sid2Uid;
    NSMutableDictionary    *uid2Sid;
}

+ (instancetype) from: (NSString *) acc :(NSString *) psw :(NSString *) net;

- (NSString *) getHashKey;
- (NetworkInfo *) toNetworkInfo;
- (NSString *) toStorage;
- (bool) fromRestore: (NSString *) data;

- (void) bindId: (UniId *) uid :(int) sid;
- (void) unbindId: (UniId *) uid :(int) sid;

+ (NSString *) getHashKey: (NSString *) acc : (NSString *) net;

@end
