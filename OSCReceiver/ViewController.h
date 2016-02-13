//
//  ViewController.h
//  OSCReceiver
//
//  Created by Benjamin Reynolds on 2/13/16.
//  Copyright © 2016 2makE. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "F53OSCMessage.h"
#import "F53OSCProtocols.h"

@interface ViewController : NSViewController<F53OSCPacketDestination>

-(void)takeMessage:(F53OSCMessage *)message;

@end

