//
//  KidjoServer.m
//  Kidjo
//
//  Created by Manuel on 16.06.10.
//  Copyright 2010 apparatschik. All rights reserved.
//

#import "KidjoServer.h"
#import "KidjoHTTPConnection.h"

@implementation KidjoServer
@synthesize dispatcher;
-(id) init
{
	if(self = [super init])
	{
		dispatcher = [[KidjoURLDispatcher alloc] init];
		connectionClass = [KidjoHTTPConnection class];
		
	}
	return self;
}

-(void) dealloc
{
	[dispatcher release], dispatcher = nil;
	[super dealloc];
}

-(void)onSocket:(AsyncSocket *)sock didAcceptNewSocket:(AsyncSocket *)newSocket
{
	id newConnection = [[connectionClass alloc] initWithAsyncSocket:newSocket forServer:self];
	
	@synchronized(connections)
	{
		[connections addObject:newConnection];
	}
	[newConnection release];
}


@end
