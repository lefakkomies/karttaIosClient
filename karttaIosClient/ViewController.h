//
//  ViewController.h
//  karttaIosClient
//
//  Created by Leif Roschier on 20.2.2015.
//  Copyright (c) 2015 Leif Roschier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ngKarttaModel.h"

@class ngKarttaModel;

@interface ViewController : UIViewController 
{
ngKarttaModel *sharedKarttaModel;
}
//@property (weak, nonatomic) IBOutlet UITextField *chatMessage;

@property (weak, nonatomic) IBOutlet UITextField *serverAddress;
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *trackRoom;

// Reference to model
@property (strong, nonatomic) IBOutlet ngKarttaModel *karttaModel;






@end

