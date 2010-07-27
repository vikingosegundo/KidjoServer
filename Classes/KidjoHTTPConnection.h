//
//  This class was created by Nonnus,
//  who graciously decided to share it with the CocoaHTTPServer community.
//

#import <Foundation/Foundation.h>
#import "HTTPConnection.h"
#import "KidjoServer.h"

@interface KidjoHTTPConnection : HTTPConnection
{
	int dataStartIndex;
	NSMutableArray* multipartData;
	
	BOOL postHeaderOK;
}
-(id) initWithAsyncSocket:(AsyncSocket *)newSocket forServer:(HTTPServer *)myServer;
- (BOOL)isBrowseable:(NSString *)path;

- (BOOL)supportsPOST:(NSString *)path withSize:(UInt64)contentLength;

@end