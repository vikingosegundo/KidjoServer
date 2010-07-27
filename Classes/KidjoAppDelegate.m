//
//  KidjoAppDelegate.m
//  Kidjo
//
//  Created by Manuel on 16.06.10.
//  Copyright apparatschik 2010. All rights reserved.
//

#import "KidjoAppDelegate.h"
#import "KidjoViewController.h"
#import "KidjoServer.h"
#import "KidjoHTTPConnection.h"
#import "KidjoViews.h"

@implementation KidjoAppDelegate

@synthesize window;
@synthesize viewController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    	
	NSString *root = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0];
	root = [root stringByAppendingPathComponent:@"kidjo"];
	
	NSFileManager *fileManager = [NSFileManager defaultManager];
	
	if(![fileManager fileExistsAtPath:root]){
		[fileManager createDirectoryAtPath:root attributes:nil];
		
		
	}
//	NSString *path = [root stringByAppendingPathComponent:@"P1.png"];
//	if(![fileManager fileExistsAtPath:path])
//	{
//		NSData *data = [NSData dataWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"P1.png_p"]];
//		[data writeToFile:path atomically:YES];
//	}
//	
//	path = [root stringByAppendingPathComponent:@"favicon.ico"];
//	if(![fileManager fileExistsAtPath:path])
//	{
//		NSData *data = [NSData dataWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"favicon.ico"]];
//		[data writeToFile:path atomically:YES];
//	}
//	
	server = [KidjoServer new];
	[server setConnectionClass:[KidjoHTTPConnection class]];
	[server setDocumentRoot:[NSURL fileURLWithPath:root]];
	[server setPort:50001];
	[server setType:@"_http._tcp."];
	[server setName:@"Kidjo"];
	KidjoViews *kidjoView =[[KidjoViews alloc] init];
	
	KidjoURLDispatcher *dispatcher = server.dispatcher;
	[dispatcher registerScheme:@"^/favicon.ico" toController:kidjoView andSelector:@"favicon:"];
	[dispatcher registerScheme:@"^/reports/.*" toController:kidjoView andSelector:@"allReports:"];
	[dispatcher registerScheme:@"^/files/(.*)$" toController:kidjoView andSelector:@"files:"];
	[dispatcher registerScheme:@"^/([a-zA-Z]+)/([a-zA-Z]+)(.*)$" toController:kidjoView andSelector:@"halloWelt:"];
	
	[dispatcher registerScheme:@"^/$" toController:kidjoView andSelector:@"index:"];
	[dispatcher registerScheme:@"^/(.+)$" toController:kidjoView andSelector:@"fallback:"];
	
	
	
	NSError *error=nil;
	if (![server start:&error]) {
		TTDERROR(@"server not started: %@", error);
	}
	
	
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
	
	return YES;
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
