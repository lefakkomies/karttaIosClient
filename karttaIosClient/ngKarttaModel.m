//
//  ngKarttaModel.m
//  karttaIosClient
//
//  Created by Leif Roschier on 21.2.2015.
//  Copyright (c) 2015 Leif Roschier. All rights reserved.
//

#import "ngKarttaModel.h"


@implementation ngKarttaModel

// singleton according to http://www.galloway.me.uk/tutorials/singleton-classes/
//
// Class method to create the model once. Access to signlen via:
//
// ngKarttaModel *sharedKarttaModel = [ngKarttaModel sharedKarttaModel];
//
+ (id)sharedKarttaModel {
    static ngKarttaModel *sharedKarttaModel = nil;
    @synchronized(self) {
        if (sharedKarttaModel == nil)
            sharedKarttaModel = [[self alloc] init];
    }
    return sharedKarttaModel;
}

/*
 * Initialization, start of location service
 */
- (id)init {
    if (self = [super init]) {
        // put some NSStrings instead of nils
        _socketID = @"00";
        _webAddress = @"192.168.0.10:3000";
        _userName = @"Init Name";
        _trackRoom = @"Init trackroom";
        _socket = nil; // unconnected
        
        // Create the location manager if this object does not
        // already have one.
        if (nil == _locationManager)
            _locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        // Set a movement threshold for new events.
        self.locationManager.distanceFilter = 5; // meters
        
        [_locationManager startUpdatingLocation];
        if ([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [_locationManager requestWhenInUseAuthorization];
        }

    }
    return self;
}
#pragma mark socket.io
/*
 * Connects to server
 */
- (void) connect {
    if (_socket == nil) { // not connected
        NSLog(@"Connecting...");
        [SIOSocket socketWithHost: [NSString stringWithFormat:@"http://%@", _webAddress] response: ^(SIOSocket *socket) {
            self.socket = socket;
            __weak typeof(self) weakSelf = self;
            // Connection callback
            self.socket.onConnect = ^()
            {
                weakSelf.socketIsConnected = YES;
                NSLog(@"Connected!");
            };
            // Disconnect callback
            self.socket.onDisconnect = ^()
            {
                weakSelf.socketIsConnected = NO;
                NSLog(@"Disonnected!");
            };
            
            NSLog(@"%@",socket);
            // send id request emit
            [self.socket emit: @"kID" args: @[@{@"id" : @"idRequest"}]];
            
            // receive ID
            [self.socket on: @"kID" callback: ^(SIOParameterArray *args)
             {
                 _socketID = [args firstObject];
                 NSLog(@"Receive ID: %@", _socketID);
             }];
        }];
    }
}

/*
 *  Send chat message
 */
- (void) sendChatMessage: (NSString*) chatMessage {
    [self.socket emit: @"kMessage" args: @[@{@"text" : chatMessage,
                                             @"type" : @"textMessage",
                                             @"name" : _userName,
                                             @"trackroom" : _trackRoom,
                                             @"id" : _socketID
                                             }]];
    
}


#pragma mark Location manager methods
// Delegate method from the CLLocationManagerDelegate protocol.
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    // If it's a relatively recent event, turn off updates to save power.
    CLLocation* location = [locations lastObject];
    NSDate* eventDate = location.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if (abs(howRecent) < 15.0) {
        // If the event is recent, do something with it.
        NSLog(@"latitude %+.6f, longitude %+.6f\n",
              location.coordinate.latitude,
              location.coordinate.longitude);
    }
    if (self.socket) {
    [self.socket emit: @"kPosUpdate" args: @[@{@"text" : @"This is message",
                                               @"type" : @"textMessage",
                                               @"name" : _userName,
                                               @"id" : _socketID,
                                               @"trackroom" : _trackRoom,
                                               @"latitude" : @(location.coordinate.latitude),
                                               @"longitude" : @(location.coordinate.longitude)
                                               }]];
        // test delegate
        [_delegate ngKarttaModelConnectionUpdate:self];
        
    }
}

@end
