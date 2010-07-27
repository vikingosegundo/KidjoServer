//
//  KidjoURLDispatcher.h
//  Kidjo
//
//  Created by Manuel on 16.06.10.
//  Copyright 2010 apparatschik. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface KidjoURLDispatcher : NSObject {
	NSMutableArray *map;
}

-(void)registerScheme:(NSString *)regex 
		 toController:(id)controller 
		  andSelector:(NSString *)selector;

-(id)dispatch:(NSString *)relativeURL;
@end
