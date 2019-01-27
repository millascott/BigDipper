//
//  Manager.h
//  luckysdk
//
//  Created by rico on 2017/12/9.
//  Copyright © 2017年 rico. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Prot.h"
#import "UniId.h"
#import "CBS.h"


enum {
    MAX_RECENT_SIZE = 15,
};

extern bool createSampleGroup, createSampleDevice, autoCreateNetwork;


@class Device, Group, NetworkInfo, CmdRsp;
@class NetworkConfig;
@class MeshManager;
@class IdEntity;
@class UniId;
@class CoolWarm;
@class UIColor;
@class Pair<FIRST, SECOND>;

typedef Pair<Device *, Group *> * DeviceGroupItem;

@protocol ManagerLsnr <NSObject>
@optional

- (void) onDevFound: (Device *) dev :(double) rssi;
- (void) onDevAddFailed:(Device *)dev;
- (void) onDevDelFailed:(Device *)dev;

- (void) onDevAdd:(Device *) n;
- (void) onDevDel:(Device *) old;
- (void) onDevChanged:(Device *) changed;

- (void) onGroupAdd:(Group *) n;
- (void) onGroupDel:(Group *) old;
- (void) onGroupChanged:(Group *) changed;

- (void) onGroupItemChanged: (Device *) dev :(Group *) group :(bool) isAdd :(bool) succ;
- (void) onConnect:(bool) isBleConn :(bool) isWiFiConn;

- (void) onNetworkCreate:(NetworkInfo *) info;
- (void) onNetworkDel:(NetworkInfo *) info;
- (void) onNetworkListChanged;

- (void) onAutoSyncFailed:(NetworkInfo *) info;
- (void) onTokenInvalid;

- (void) onRecentChanged;

@end

@interface Manager : NSObject {
@public
    Device      * opDev;
    Group       * opGroup;
    bool        isOpGroup;
}

/*
 * lsnrs
 */
- (void) addLsnr: (id<ManagerLsnr>) lsnr;
- (void) remLsnr: (id<ManagerLsnr>) lsnr;
- (void) clearLsnr;

/* save / restore
 */
- (void) save;
- (void) restore;
- (void) setAutoUploadAndSync: (bool) autoSync;

/*
 * Account
 */
- (NSString *) getAccount;
- (NSString *) getPassword __attribute__((deprecated));
- (NSString *) getPasswordSig;

- (bool) isOwner;
- (bool) isAccountReady;

- (void) setAccount: (NSString *) account :(NSString *)psw :(__nonnull ProcessCB) cb __attribute__((deprecated));

- (void) login: (NSString *) account :(NSString *)psw :(__nonnull ProcessCB) cb;
- (void) updatePsw: (NSString *) account :(NSString *)psw :(__nonnull ProcessCB) cb;

- (void) register: (NSString *) account :(NSString *)psw :(__nonnull ProcessCB) cb;
- (void) validRegister: (NSString *) account :(NSString *) checkCode :(__nonnull ProcessCB) cb;

- (void) forgetAccount: (NSString *) acc :(__nonnull ProcessCB) cb;
- (void) updatePsw: (NSString *) account :(NSString *)psw :(NSString *) checkCode :(__nonnull ProcessCB) cb;

- (void)logout;

/*
 * Connection / scan
 */
- (void) checkConnect;
- (void) scanBridges: (uint64_t) msTo;
- (void) stopScanBridges;
- (void) scanNewDevice: (uint64_t) msTo;
- (void) stopScanNewDevice;

- (bool) isConnected;

/*
 * Devices & Groups
 */
- (NSArray<Group *> *) getGroups;
- (Group *) getGroupBySId:(int) sid;
- (Group *) getGroup:(UniId *) uid;

- (Group *) addGroup: (NSString *) name;
- (Group *) addGroupByConf: (Group *) group;

- (Group *) delGroup: (UniId *) uid;

- (NSArray<Device *> *) getDevices;
- (Device *) getDeviceBySId:(int) sid;
- (Device *) getDevice:(UniId *) uid;

- (bool) associateDevice: (Device *) dev;
- (Device *) associatingDevice;
- (bool) resetAndDelDevice: (Device *) dev :(bool) force;

/*
- (void) getRecent;
- (void) addRecent;
- (void) clearRecent;
- (void) pinRecent;
*/
- (IdEntity *) getTarget: (UniId *) uid;

/*
 * Group items.
 */
- (bool) addDeviceToGroup: (Device *) dev :(Group *) group;
- (bool) delDeviceFromGroup: (Device *) dev :(Group *) group;
- (NSArray<Device *> *) getDevicesInGroup: (int) groupId;
- (NSArray<Group *> *) getGroupsInDevice: (UniId *) devId;
- (bool) isDeviceInGroup: (Device *) dev :(Group *) grp;

- (bool) isDeletingGroupItem: (Device *) dev :(Group *) grp;
- (bool) isAddingGroupItem: (Device *) dev :(Group *) grp;

/*
 * Control & Status
 */

- (void) sendTransData:(IdEntity *)dest first:(BOOL)isfirst data:(NSData *)data;

/*
 * Network list
 */
- (bool) createNetwork: (NSString *) networkName;

- (NSArray<NetworkInfo *> *) getLocalNetworkList;
- (void) updateNetworkList;
- (NetworkInfo *) getNetworkInfo: (NSString *) hashKey;
- (NSString *) getNetworkConfig: (NSString *) acc :(NSString *) psw :(NSString *) networkName;
- (void) uploadNetwork: (NSString *) acc :(NSString *) psw :(NSString *) networkName :(ProcessCB1(NSString *)) cb;
- (void) downloadNetwork: (NSString *) acc :(NSString *) psw :(NSString *) networkName :(ProcessCB) cb;
- (void) delRemoteNetwork: (NSString *) acc :(NSString *) psw :(NSString *) networkName :(ProcessCB) cb;

- (bool) switchToLocalNetwork: (NSString *) acc :(NSString *) networkName;
- (void) delLocalNetwork: (NSString *) acc :(NSString *) psw :(NSString *) network;

- (void) saveNetworkConfig: (NetworkConfig *) conf;

- (bool) restoreNetworkConfig: (NSString *) config :(bool) autoSwitchTo;

- (bool) ownsNetwork: (NSString *) network;
- (bool) existLocal: (NSString *) acc :(NSString *) networkName;

- (bool) setCurrNetName: (NSString *) newName;
- (bool) setNetworkName: (NSString *) acc :(NSString *) oldNetName :(NSString *)newName;

- (NetworkInfo *) getCurrNetInfo;
- (NSString *) getNetworkKey;


+ (instancetype) inst;
+ (void) setSdkKey: (NSString *) sdkKey;

+ (int) protId: (int) fastId :(bool) reqAck :(bool) reqOp;

@end
