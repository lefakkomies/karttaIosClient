//
//  InConnectionViewController.h
//  karttaIosClient
//
//  Created by Leif Roschier on 21.2.2015.
//  Copyright (c) 2015 Leif Roschier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ngKarttaModel.h"

@class ngKarttaModel;

@interface InConnectionViewController : UIViewController <ngKarttaModelDelegate>

@property (weak, nonatomic) IBOutlet UITextField *chatMessage;

@end
