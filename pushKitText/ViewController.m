//
//  ViewController.m
//  voipTestAsif Seraje
//
//  Created by Asif Seraje on 9/20/16.
//  Copyright © 2016 Asif Seraje. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //http://stackoverflow.com/questions/27245808/implement-pushkit-and-test-in-development-behavior/28562124#28562124
    PKPushRegistry *pushRegistry = [[PKPushRegistry alloc] initWithQueue:dispatch_get_main_queue()];
    pushRegistry.delegate = self;
    pushRegistry.desiredPushTypes = [NSSet setWithObject:PKPushTypeVoIP];
}
NSString *token1, *token2;
- (void)pushRegistry:(PKPushRegistry *)registry didUpdatePushCredentials:(PKPushCredentials *)credentials forType:(NSString *)type{
    if([credentials.token length] == 0) {
        NSLog(@"voip token NULL");
        return;
    }
    
    NSLog(@"PushCredentials: DEVICE_TOKEN GENERATED! TOKEN: %@", credentials.token);
}

- (void)pushRegistry:(PKPushRegistry *)registry didReceiveIncomingPushWithPayload:(PKPushPayload *)payload forType:(NSString *)type
{
    NSDictionary *payloadDict = payload.dictionaryPayload[@"aps"];
    
    NSLog(@"didReceiveIncomingPushWithPayload: %@", payloadDict);
    NSString *message = payloadDict[@"alert"];
    
    NSLog(@"%@", message);
    
    //present a local notifcation to visually see when we are recieving a VoIP Notification
    if ([[UIApplication sharedApplication] applicationState] == UIApplicationStateBackground) {

        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert)
                              completionHandler:^(BOOL granted, NSError * _Nullable error) {
                                  if (!error) {
                                      NSLog(@"request authorization succeeded!");
                                      
                                  }
                              }];
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        content.title = [NSString localizedUserNotificationStringForKey:@"Voip PushKit"
                                                              arguments:nil];
        content.body = [NSString localizedUserNotificationStringForKey:message
                                                             arguments:nil];
        content.sound = [UNNotificationSound defaultSound];
        
        content.badge = [NSNumber numberWithInteger:([UIApplication sharedApplication].applicationIconBadgeNumber + 1)];
//        UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger
//                                                      triggerWithTimeInterval:0.1f
//                                                      repeats:NO];
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"ZeroSecond"
                                                                              content:content
                                                                              trigger:nil];
        [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
            if (!error) {
                NSLog(@"add NotificationRequest succeeded!");
            }
        }];
    }
    else {
        dispatch_async(dispatch_get_main_queue(), ^(void){

            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"VoIP Notification"
                                                                                     message:message
                                                                              preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"OK"
                                                               style:UIAlertActionStyleDefault
                                                             handler:nil];
            [alertController addAction:actionOk];
            [self presentViewController:alertController animated:YES completion:nil];

        });
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
