//
//  KidjoURLDispatcher.m
//  Kidjo
//
//  Created by Manuel on 16.06.10.
//  Copyright 2010 apparatschik. All rights reserved.
//

#import "KidjoURLDispatcher.h"


@implementation KidjoURLDispatcher

-(id)init
{
	if ([super init]!=nil) {
		
		
	}
	map = [[NSMutableArray alloc] init];
	return self;
}

-(void)registerScheme:(NSString *)regex 
		 toController:(id)controller 
		  andSelector:(NSString *)selector
{

	[map addObject:[NSArray arrayWithObjects:regex,controller,selector,nil] ];
}

-(id)dispatch:(NSString *)relativeURL
{
	
	id controller;
	SEL selector;
	NSArray *array = nil;
	
	for (NSArray *a in map) {
		NSString *re = [a objectAtIndex:0];
		if ([relativeURL isMatchedByRegex:re]) {
			TTDPRINT(@"%@", re);
			controller = [a objectAtIndex:1];
			selector =	 NSSelectorFromString([a objectAtIndex:2]);
			array = [relativeURL captureComponentsMatchedByRegex:re];
			if ([re captureCount]>1) {
				array = [array subarrayWithRange: NSMakeRange(1, [array count]-1)];
			}
			break;
		}
		
	}

	
	if([controller respondsToSelector:selector])
	{
		return [controller performSelector:selector withObject:array];
	}
	return nil;
}

@end
