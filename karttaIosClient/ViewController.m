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
    // Do any additional setup after loading the view, typically from a nib.
    [SIOSocket socketWithHost: [NSString stringWithFormat:@"http://%@", _serverAddress.text] response: ^(SIOSocket *socket) {
        self.socket = socket;
    }];
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
                                             @"trackroom" : _trackRoom.text
                                             }]];

}


@end
