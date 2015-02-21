//
//  ngKarttaModel.h
//  karttaIosClient
//
//  Created by Leif Roschier on 21.2.2015.
//  Copyright (c) 2015 Leif Roschier. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SIOSocket/SIOSocket.h>
#import <CoreLocation/CoreLocation.h>
@import UIKit;


@class SIOSocket;
@class ngKarttaModel;

@protocol ngKarttaModelDelegate <NSObject>
@optional
- (void) ngKarttaModelConnectionUpdate: (ngKarttaModel *) sender;
@end

@interface ngKarttaModel : NSObject < CLLocationManagerDelegate>

@property (nonatomic, retain) NSString *webAddress;
@property (nonatomic, retain) NSString *userName;
@property (nonatomic, retain) NSString *trackRoom;

// socket
@property SIOSocket *socket;
@property BOOL socketIsConnected;
@property (nonatomic, strong) NSString *socketID;

// for location tracking
@property (nonatomic, strong) CLLocationManager *locationManager;
@property id <ngKarttaModelDelegate> delegate;

+ (id)sharedKarttaModel;

- (void) connect;
- (void) sendChatMessage: (NSString*) chatMessage;

@end
