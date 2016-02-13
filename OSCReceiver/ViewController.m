//
//  ViewController.m
//  ExampleOSC
//
//  Created by Charles Martin on 21/05/2014.
//  Copyright (c) 2014 Charles Martin. All rights reserved.
//

#import "ViewController.h"
#import "F53OSCServer.h"

//#define SENDHOST @"18.189.11.222" //"127.0.0.1" //@"7ec81eac.ngrok.io" //
//#define SENDPORT 3001 //8080 //
#define RECEIVEPORT 3001


@interface ViewController ()
//@property (strong, nonatomic) F53OSCClient* oscClient;
@property (strong, nonatomic) F53OSCServer* oscServer;
//@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
//@property (weak, nonatomic) IBOutlet UILabel *argumentsLabel;
@property (strong, nonatomic) NSString* dataWritePath;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.oscClient = [[F53OSCClient alloc] init];
    self.oscServer = [[F53OSCServer alloc] init];
    [self.oscServer setPort:RECEIVEPORT];
    [self.oscServer setDelegate:self];
    [self.oscServer startListening];
    
    // create file for
    self.dataWritePath = @"/Users/benreynolds/Documents/MakeMIT/HeartRateData/data.txt";
    [[NSFileManager defaultManager] createFileAtPath:self.dataWritePath contents:nil attributes:nil];
    
}

//- (IBAction)sendMessage:(UIButton *)sender {
//    F53OSCMessage *message = [F53OSCMessage messageWithAddressPattern:@"/derp" arguments:@[@"A derpy message.",@1,@5.82]];
//    [self.oscClient sendPacket:message toHost:SENDHOST onPort:SENDPORT];
//    NSLog(@"Send Message: %@", message);
//}
//
//- (IBAction)sendSliderMessage:(UISlider *)sender {
//    F53OSCMessage *message = [F53OSCMessage messageWithAddressPattern:@"/slider" arguments:@[[NSNumber numberWithFloat:sender.value]]];
//    [self.oscClient sendPacket:message toHost:SENDHOST onPort:SENDPORT];
//    NSLog(@"Send Slider Message: %@", message);
//}

-(void)takeMessage:(F53OSCMessage *)message {
    NSLog(@"Message Received");
//    NSLog(@"%@", message.addressPattern);
//    NSLog(@"%@", message.arguments.description);
    if ([message.addressPattern isEqualToString:@"/heartrate"]) {
        if (message.arguments.count > 0) {
            int heartRate = [[message.arguments objectAtIndex:0] intValue];
            NSLog(@"heartRate = %i", heartRate);
            
            NSString *writeString = [NSString stringWithFormat:@"%i,", heartRate];
//            [writeString writeToFile:self.dataWritePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
            
            NSFileHandle *myHandle = [NSFileHandle fileHandleForWritingAtPath:self.dataWritePath];
            [myHandle seekToEndOfFile];
            [myHandle writeData:[writeString dataUsingEncoding:NSUTF8StringEncoding]];
        }
    }
}

@end
