//
//  KidjoSocketController.h
//  Kidjo
//
//  Created by Manuel on 16.06.10.
//  Copyright 2010 apparatschik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AsyncSocket.h"

@interface KidjoSocketController : NSObject {
	AsyncSocket *socket;
	NSNotificationCenter *notificationCenter;
	NSMutableArray *connectedSockets;
}
+ (KidjoSocketController*)sharedSocketController;
-(void)start;
-(void)stop;
@end
