#ifndef __UTIL_H__SMTSVR
#define __UTIL_H__SMTSVR

// #include <boost/crc.hpp>
#include <string.h>

#ifdef __cplusplus
#endif  // __cplusplus
// #include "ExcptProj.h"

#import <Foundation/Foundation.h>

@interface SDKUtil : NSObject

/*
 * "ip/maskLength"
 * format: "10.0.0.1/8" / "fe80::1444:a0f1:32ed:3899/64"
 */
+ (NSString *) getHostMainIp: (BOOL)preferIPv4;

/*
 *  return bytes len: 4 / 16 => v4 / v6. -1 for error...
 */
+ (int) getIpBytesFromString: (void *) bytes :(NSString *) str;

/* @{ "interface/ipVersion": "ip/maskLength" }
 * format: @{ "en0/ipv4" : "192.168.1.104/24", "en0/ipv6" = "fe80::1444:a0f1:32ed:3899/96", }
 */
+ (NSDictionary *) getHostIpAddresses;

+ (NSString*) ip2mac: (in_addr_t)addr;
+ (NSString*) ipStr2mac: (NSString*)addr;

@end

@interface GcdPool : NSObject

+ (bool) push: (void (^)(void)) task;
+ (bool) push: (void (^)(void)) task : (double) delayMS;
+ (bool) push: (void (^)(void)) task : (double) delayMS : (double) loopGapMS;

+ (bool) pushMain: (void (^)(void)) task;
+ (bool) pushMain: (void (^)(void)) task : (double) delayMS;
+ (bool) pushMain: (void (^)(void)) task : (double) delayMS : (double) loopGapMS;

@end

#define printNSExcepST(TAG, e) do { LogE(TAG, "%@: \n %@", e, [e callStackSymbols]); } while(false)

#ifdef __cplusplus
extern "C" {
#endif

    inline long long MsUtc() {
        return [[NSDate date] timeIntervalSince1970] * 1000LL;
    }
    
    inline double Utc() {
        return [[NSDate date] timeIntervalSince1970];
    }
    
    inline NSData * cstr2Data(const void *str, size_t len) {
        return [NSData dataWithBytes:str length:len];
    }
    
    inline long randomLong() { return random(); }
    
    inline int randomInt() { return arc4random(); }
    
#ifdef __cplusplus
}
#endif


/*
 * Crypto
 */
#ifdef __cplusplus
extern "C" {
#endif
    
    extern bool aesCbcNoPaddingEnc(unsigned char * result, const unsigned char * src, size_t len, const char * key, const char * iv);
    extern bool aesCbcNoPaddingDec(unsigned char * result, const unsigned char * src, size_t len, const char * key, const char * iv);

    extern NSString * MSDateString(void);

#ifdef __cplusplus
}
#endif


#endif  // __UTIL_H__SMTSVR
