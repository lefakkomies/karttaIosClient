//
//  ViewController.h
//  karttaIosClient
//
//  Created by Leif Roschier on 20.2.2015.
//  Copyright (c) 2015 Leif Roschier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SIOSocket/SIOSocket.h>

@interface ViewController : UIViewController    

@property (weak, nonatomic) IBOutlet UITextField *chatMessage;

@property (weak, nonatomic) IBOutlet UITextField *serverAddress;
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *trackRoom;
@property SIOSocket *socket;


@end

