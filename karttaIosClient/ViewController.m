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
    
    //  reference to model that has all logic related to location on socket
    sharedKarttaModel = [ngKarttaModel sharedKarttaModel];
    
    // Do any additional setup after loading the view, typically from a nib.

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark unwind in segue
- (IBAction)unwindToMainMenu:(UIStoryboardSegue*)sender
{
    UIViewController *sourceViewController = sender.sourceViewController;
    // Pull any data from the view controller which initiated the unwind segue.
}

/*
 * Enter trackroom
 * -> update params and connect socket.io
 */
- (IBAction)enterTrackRoomPressed:(id)sender {
    // update model parameters
    sharedKarttaModel.webAddress = _serverAddress.text;
    sharedKarttaModel.userName = _userName.text;
    sharedKarttaModel.trackRoom = _trackRoom.text;
    [sharedKarttaModel connect];
}

@end
