//
//  Prot.h
//  luckysdk
//
//  Created by rico on 2017/12/9.
//  Copyright © 2017年 rico. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <math.h>

enum {
    VALID_MESH_TOKEN = 0x7880,
};

typedef enum CmdId {
    CMD_GPIO = 0,
    CMD_ONOFF = 1,
    CMD_TRIG_GPIO = 2,
    CMD_GPIO_BREATH = 3,
    CMD_ENABLE_LOW_ENERGY = 4,
    CMD_RESTART = 5,
    CMD_QUIT_NET = 6,
    CMD_TX_POWER = 7,
    CMD_ENABLE_SERIAL = 8,

    GET_MAC = 0,
    GET_TTL = 1,
    GET_NET_ID = 2,
    GET_CHIP_TEMP = 3,
    GET_HW_VOLTAGE = 4,
    GET_TX_POWER = 5,

    CMD_MX = -1
} CmdId;

enum {
    ON = 1,
    OFF = 0,
    ENABLE = 1,
    DISABLE = 0
};

typedef enum TxPowerLevel {
    POWER_N_18 = 0,
    POWER_N_14 = 1,
    POWER_N_10 = 2,
    POWER_N_6 = 3,
    POWER_N_2 = 4,
    POWER_P_2 = 5,
    POWER_P_6 = 6,
    POWER_P_8 = 7

} TxPowerLevel;

@class UIColor, CoolWarm;

#define byte uint8_t
#define null nil
#define boolean bool

@interface CmdRsp : NSObject {
@public
    byte cmd;
    byte args[6];
}

+ (instancetype) from: (byte) cmdId :(byte *) args;

- (NSData *) getMac;

- (int) getShortValue;
- (int) getByteValue;

- (int) getTTL;
- (int) getNetId;
- (int) getChipTemp;    // centigrade.
- (double) getPowerVoltage;
- (int) getTxPower;

@end

#ifdef __cplusplus

class Prot {
private:
    static const double power;
    static const double point, pointTan, drPoint;
    static const double offs, drOffs, drDelta;
    static double adjBrt(double brt) {
        return brt;
        // if (brt <= point) return brt * 1 * pointTan;
        // else return offs + (Math.pow(brt - point + drPoint, pow) - drOffs) / drDelta * (1.0 - offs);

        //if (brt <= 0.15) return Math.pow(brt/0.15, 0.85)*0.15;
        //else return 0.15 + Math.pow((brt - 0.15)/0.85, 2)*0.85;
    }

    static constexpr int MAX_TRANS = 16, MIN_TRANS = 4;
    static constexpr double MAX_CALC_DELTA_BRT = 0.6;

public:
    static NSData * getRGBCWProt(UIColor *c, CoolWarm *cw, double lastBrt);

    static NSData * bytes2NSData(byte data[], NSUInteger len) {
        return [NSData dataWithBytes: data length: len];
    }

    static NSData * getGIOProt(int r, int g, int b, int c, int w) {
        byte data[10] = {0x55, (byte) 0xAA, 0x0, CMD_TRIG_GPIO,
                (byte) r, (byte) g, (byte) b, (byte) c, (byte) w, 0, };
        return [NSData dataWithBytes: data length:sizeof(data)];
    }

    static NSData * getGIOTrigProt(int gpioIdx, boolean enable, int onTime, int offTime) {
        byte data[10] = {0x55, (byte) 0xAA, 0x0, CMD_TRIG_GPIO, 0,0,0,0,0,0, };
        int i = 4;

        data[i++] = (byte) gpioIdx;
        data[i++] = (byte) (enable ? 1 : 0);
        data[i++] = (byte) onTime;
        data[i++] = (byte) offTime;

        return [NSData dataWithBytes: data length:sizeof(data)];
    }

    static NSData * getGIOBreathProt(boolean isDoubleColor, int changeTime, int holdTime, int c1, int c2) {
        byte data[10] = {0x55, (byte) 0xAA, 0x0, CMD_TRIG_GPIO, 0,0,0,0,0,0, };
        int i = 4;

        data[i++] = (byte) (isDoubleColor ? 1 : 2);
        data[i++] = (byte) changeTime;
        data[i++] = (byte) holdTime;
        data[i++] = (byte) c1;
        data[i++] = (byte) c2;

        return [NSData dataWithBytes: data length:sizeof(data)];
    }

    static NSData * getOnOffProt(boolean onOff, int trans, boolean usingAck) {
        byte data[10] = {0x55, (byte) 0xAA, 0x0, CMD_ONOFF, 0,0,0,0,0,0, };
        int i = 4;
        data[i++] = (byte) (onOff ? 1 : 0);
        data[i++] = (byte) trans;

        return [NSData dataWithBytes: data length:sizeof(data)];
    }

    static NSData * getEnableLeProt(boolean enable) {
        byte data[10] = {0x55, (byte) 0xAA, 0x0, CMD_ENABLE_LOW_ENERGY, (byte) (enable ? 1 : 0),0,0,0,0,0, };
        return [NSData dataWithBytes: data length:sizeof(data)];
    }

    static NSData * getRestartProt() {
        byte data[10] = {0x55, (byte) 0xAA, 0x0, CMD_RESTART, 0x55, (byte) 0xAA, 0,0,0,0, };
        return [NSData dataWithBytes: data length:sizeof(data)];
    }

    static NSData * getQuitProt() {
        byte data[10] = {0x55, (byte) 0xAA, 0x0, CMD_QUIT_NET, 0x55, (byte) 0xAA, 0,0,0,0, };
        return [NSData dataWithBytes: data length:sizeof(data)];
    }

    static NSData * getAdjTxPowerProt(int powerLevel) {
        byte data[10] = {0x55, (byte) 0xAA, 0x0, CMD_TX_POWER, (byte) powerLevel,0,0,0,0,0, };
        return [NSData dataWithBytes: data length:sizeof(data)];
    }

    static NSData * getEnableSerialProt(boolean enable) {
        byte data[10] = {0x55, (byte) 0xAA, 0x0, CMD_ENABLE_SERIAL, (byte) (enable ? 1 : 0),0,0,0,0,0, };
        return [NSData dataWithBytes: data length:sizeof(data)];
    }

    static NSData * getReadCmdStatProt(int cmd, boolean usingAck) {
        byte data[10] = {(byte) 0xAA, 0x55, 0x0, (byte) cmd, 0,0,0,0,0,0, };
        return [NSData dataWithBytes: data length:sizeof(data)];
    }
};

#endif

#undef byte
#undef null
#undef boolean
