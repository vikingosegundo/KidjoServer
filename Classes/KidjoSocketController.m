//
//  KidjoSocketController.m
//  Kidjo
//
//  Created by Manuel on 16.06.10.
//  Copyright 2010 apparatschik. All rights reserved.
//

#import "KidjoSocketController.h"
#define WELCOME_MSG  0
#define ECHO_MSG     1

static KidjoSocketController *sharedInstance = nil;

@implementation KidjoSocketController
- (id) init 
{
    if (!(self = [super init]))
        return nil;
	
    socket = [[AsyncSocket alloc] initWithDelegate:self];
	[socket setDelegate:self];
    notificationCenter = [NSNotificationCenter defaultCenter];
	sharedInstance = self;
	connectedSockets = [[NSMutableArray alloc] init];
	TTDPRINT(@"%@", sharedInstance);
    return sharedInstance;
}

-(void)dealloc
{
	[socket release], socket = nil;
	[connectedSockets release], connectedSockets=nil;
	[notificationCenter release];
	[super dealloc];

}

+ (KidjoSocketController*)sharedSocketController
{
    @synchronized(self)
    {
        if (sharedInstance == nil)
			sharedInstance = [[KidjoSocketController alloc] init];
    }
    return sharedInstance;
}

+ (id)allocWithZone:(NSZone *)zone {
    @synchronized(self) {
        if (sharedInstance == nil) {
            sharedInstance = [super allocWithZone:zone];
            return sharedInstance;  // assignment and return on first allocation
        }
    }
    return nil; // on subsequent allocation attempts return nil
}

-(void)start
{	
	NSError *error = nil;
	if(![socket acceptOnPort:9876 error:&error])
	{
		TTDERROR(@"Error starting server: %@", error);
	} else {
		TTDPRINT(@"started: %@ ", socket);
	}

}

-(void)stop
{	
	TTDPRINT(@"stop: %@ ", socket);
	[socket disconnect];
}


#pragma mark delegate methods

- (void)onSocket:(AsyncSocket *)sock didAcceptNewSocket:(AsyncSocket *)newSocket
{
	[connectedSockets addObject:newSocket];
}

- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
	TTDPRINT(@"Accepted client %@:%hu", host, port);
	
	NSString *welcomeMsg = @"Welcome to the AsyncSocket Echo Server\r\n";
	NSData *welcomeData = [welcomeMsg dataUsingEncoding:NSUTF8StringEncoding];
	
	[sock writeData:welcomeData withTimeout:-1 tag:WELCOME_MSG];
	
	// We could call readDataToData:withTimeout:tag: here - that would be perfectly fine.
	// If we did this, we'd want to add a check in onSocket:didWriteDataWithTag: and only
	// queue another read if tag != WELCOME_MSG.
}

- (void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag
{
	[sock readDataToData:[AsyncSocket CRLFData] withTimeout:-1 tag:0];
}

- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
	NSData *strData = [data subdataWithRange:NSMakeRange(0, [data length] - 2)];
	NSString *msg = [[[NSString alloc] initWithData:strData encoding:NSUTF8StringEncoding] autorelease];
	if(msg)
	{
		TTDPRINT(@"%@", msg);
	}
	else
	{
	}
	NSString *string = [NSString stringWithFormat:@"<http><head><title>test</title></head><body><p>%@</p></body></http>", msg];
	
	strData =[string dataUsingEncoding:NSUTF8StringEncoding];
	// Even if we were unable to write the incoming data to the log,
	// we're still going to echo it back to the client.
	[sock writeData:strData  withTimeout:-1 tag:ECHO_MSG];
}

- (void)onSocket:(AsyncSocket *)sock willDisconnectWithError:(NSError *)err
{

}

- (void)onSocketDidDisconnect:(AsyncSocket *)sock
{
	[connectedSockets removeObject:sock];
}
#pragma mark singelton

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (id)retain {
    return self;
}

- (unsigned)retainCount {
    return UINT_MAX;  // denotes an object that cannot be released
}

- (void)release {
    //do nothing
}

- (id)autorelease {
    return self;
}

@end
