//
//  ViewController.m
//  karttaIosClient
//
//  Created by Leif Roschier on 20.2.2015.
//  Copyright (c) 2015 Leif Roschier. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _socketID = @"00";
    // Do any additional setup after loading the view, typically from a nib.
    [SIOSocket socketWithHost: [NSString stringWithFormat:@"http://%@", _serverAddress.text] response: ^(SIOSocket *socket) {
        self.socket = socket;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendChatMessage:(id)sender {
    NSLog(_chatMessage.text);
    [self.socket emit: @"kMessage" args: @[@{@"text" : _chatMessage.text,
                                             @"type" : @"textMessage",
                                             @"name" : _userName.text,
                                             @"trackroom" : _trackRoom.text,
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
    [self.socket emit: @"kPosUpdate" args: @[@{@"text" : _chatMessage.text,
                                             @"type" : @"textMessage",
                                             @"name" : _userName.text,
                                             @"id" : _socketID,
                                             @"trackroom" : _trackRoom.text,
                                             @"latitude" : @(location.coordinate.latitude),
                                             @"longitude" : @(location.coordinate.longitude)
                                             }]];
}


@end
