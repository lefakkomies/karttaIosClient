//
//  ViewController.h
//  karttaIosClient
//
//  Created by Leif Roschier on 20.2.2015.
//  Copyright (c) 2015 Leif Roschier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SIOSocket/SIOSocket.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController < CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *chatMessage;

@property (weak, nonatomic) IBOutlet UITextField *serverAddress;
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *trackRoom;

// socket
@property SIOSocket *socket;
@property (nonatomic, strong) NSString *socketID;

// for location tracking
@property (nonatomic, strong) CLLocationManager *locationManager;


@end

