//
//  KidjoServer.h
//  Kidjo
//
//  Created by Manuel on 16.06.10.
//  Copyright 2010 apparatschik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTTPServer.h"
#import "KidjoURLDispatcher.h"

@interface KidjoServer : HTTPServer {
	KidjoURLDispatcher *dispatcher;
}
@property(readonly, assign)KidjoURLDispatcher *dispatcher;

@end
