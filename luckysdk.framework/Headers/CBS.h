//
// Created by rico on 2017/12/11.
// Copyright (c) 2017 rico. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum CBS {
    PROC_SUCC = 0,
    PROC_TIMEOUT = 1,
    PROC_PARAM_ERR = 2,
    PROC_INTERNAL_ERR = 3,
    PROC_UNEXCEPTED_ERR = 4,
    PROC_NOT_SUPPORTED = 5,
    PROC_NOT_EXIST = 5,
    PROC_TOO_BUSY = 7,
    // Group
    PROC_PART_SUCC = 8,
    PROC_PART_TIMEOUT = 9,

    PROC_FAILED = 10,
    PROC_REJECTED = 11,
    MAX_PROC_CODE = 12
} CBS;

typedef enum RspCode {
    SUCC = 0,
    OK = 0,

    TIMEOUT = 50,
    FAILED = 50,

    NOT_EXIST = 100,
    ALREADY_EXIST = 101,
    PARAM_ERR = 200,
    PSW_ERR = 210,

    VERIFY_CODE_ERROR = 220,
    CAPTCHA_CODE_ERROR = 221,

    ACCESS_TOKEN_REQUIRED = 420,
    ACCESS_TOKEN_INVALID = 421,

    INTERNAL_ERR = 500,
    SERVER_BUSY = 501
} RspCode;
typedef void (^ ProcessCB) (RspCode code, NSString * reason);
#define ProcessCB1(TYPE) void (^) (RspCode code, NSString * reason, TYPE args)
#define ProcessCB2(T1, T2) void (^) (RspCode code, NSString * reason, T1 arg1, T2 arg2)
