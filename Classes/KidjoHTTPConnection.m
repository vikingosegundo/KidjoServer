//
//  This class was created by Nonnus,
//  who graciously decided to share it with the CocoaHTTPServer community.
//

#import "KidjoHTTPConnection.h"
#import "HTTPServer.h"
#import "HTTPResponse.h"
#import "AsyncSocket.h"
#import "DDRange.h"



@implementation KidjoHTTPConnection


-(id) initWithAsyncSocket:(AsyncSocket *)newSocket forServer:(HTTPServer *)myServer
{
	[super initWithAsyncSocket:newSocket forServer:myServer];
	return self;
}
/**
 * Returns whether or not the requested resource is browseable.
 **/
- (BOOL)isBrowseable:(NSString *)path
{
	// Override me to provide custom configuration...
	// You can configure it for the entire server, or based on the current request
	
	return YES;
}

- (BOOL)isPasswordProtected:(NSString *)path
{
	if ([[asyncSocket localHost] isEqualToString:[asyncSocket connectedHost]]) {
		return NO;
	}
	return [path hasPrefix:@"/"];
}

- (NSString *)passwordForUser:(NSString *)username
{
	// You can do all kinds of cool stuff here.
	// For simplicity, we're not going to check the username, only the password.
	
	return @"secret";
}

- (BOOL)useDigestAccessAuthentication
{
	// Digest access authentication is the default setting.
	// Notice in Safari that when you're prompted for your password,
	// Safari tells you "Your login information will be sent securely."
	// 
	// If you return NO in this method, the HTTP server will use
	// basic authentication. Try it and you'll see that Safari
	// will tell you "Your password will be sent unencrypted",
	// which is strongly discouraged.
	
	return YES;
}





- (BOOL)supportsMethod:(NSString *)method atPath:(NSString *)relativePath
{
//	if ([@"POST" isEqualToString:method])
//	{
//		return YES;
//	}
	
	return [super supportsMethod:method atPath:relativePath];
}





- (NSObject<HTTPResponse> *)httpResponseForMethod:(NSString *)method URI:(NSString *)path
{
	TTDPRINT(@"httpResponseForURI: method:%@ path:%@", method, path);
	
	//NSData *requestData = [(NSData *)CFHTTPMessageCopySerializedMessage(request) autorelease];
	
	//NSString *requestStr = [[[NSString alloc] initWithData:requestData encoding:NSASCIIStringEncoding] autorelease];
	//TTDPRINT(@"\n=== Request ====================\n%@\n================================", requestStr);
	

	id object= [[(KidjoServer *)server dispatcher] dispatch:path];
	if ([object isKindOfClass:[NSString class]]) {
		NSData *browseData = [object dataUsingEncoding:NSUTF8StringEncoding];
		return [[[HTTPDataResponse alloc] initWithData:browseData] autorelease];
	} else if ([object isKindOfClass:[NSData class]]) {
		return [[[HTTPDataResponse alloc] initWithData:object] autorelease];
	}
	
	return nil;
	
}



/**
 * Returns whether or not the server will accept POSTs.
 * That is, whether the server will accept uploaded data for the given URI.
 **/
- (BOOL)supportsPOST:(NSString *)path withSize:(UInt64)contentLength
{
	//	TTDPRINT(@"POST:%@", path);
	
	dataStartIndex = 0;
	multipartData = [[NSMutableArray alloc] init];
	postHeaderOK = FALSE;
	
	return YES;
}



@end