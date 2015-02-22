//
//  InConnectionViewController.m
//  karttaIosClient
//
//  Created by Leif Roschier on 21.2.2015.
//  Copyright (c) 2015 Leif Roschier. All rights reserved.
//

#import "InConnectionViewController.h"

@interface InConnectionViewController ()
{
    ngKarttaModel *sharedKarttaModel;
}
@end

@implementation InConnectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // reference to model
    sharedKarttaModel = [ngKarttaModel sharedKarttaModel];
    sharedKarttaModel.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void) dealloc {
    if (sharedKarttaModel.delegate == self) {
        sharedKarttaModel.delegate = nil; // remove delegate
    }
}

- (IBAction)sendChatMessage:(id)sender {
    [sharedKarttaModel sendChatMessage:_chatMessage.text];
    
}

#pragma mark ngKarttaModel delegates
- (void) ngKarttaModelConnectionUpdate: (ngKarttaModel *) sender {
    NSLog(@"Connection Update!");
}


@end
