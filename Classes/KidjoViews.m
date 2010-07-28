//
//  KidjoViews.m
//  Kidjo
//
//  Created by Manuel on 16.06.10.
//  Copyright 2010 apparatschik. All rights reserved.
//

#import "KidjoViews.h"


@implementation KidjoViews

-(id) init
{
	if (self = [super init]) {
		templateEngine = [KidjoTemplateEngine new];
	}
	
	return self;
}

-(void) dealloc
{
	[templateEngine release], templateEngine=nil;
	[super dealloc];
}

#pragma mark Templates

-(NSString *)halloWelt:(NSArray *)data
{
	NSMutableDictionary *dict = [NSMutableDictionary dictionary];
	for (NSString *s in data) {
		NSString *index = [NSString stringWithFormat:@"%d", [data indexOfObject:s]];
		[dict setObject:s forKey:index];
	}
	[dict setObject:[NSNumber numberWithInt:[data count]] forKey:@"count"];
	return [templateEngine templateForHalloWelt:dict];
}

-(NSString *)index:(NSArray *)data
{
	return [templateEngine templateForIndex];
}

-(NSString *)fallback:(NSArray *)data
{
	return [self index:data];
}

-(NSString *)allReports:(NSArray *)data
{
	NSMutableDictionary *dict = [NSMutableDictionary new];
	[dict setObject:[NSDate distantPast] forKey:@"startDate"];
	[dict setObject:[NSDate distantFuture] forKey:@"endDate"];
	[dict setObject:[NSArray arrayWithObjects:  @"report item 1", 
												@"report item 2",
												@"report item 3" , 
												@"report item 4", 
												@"report item 5",nil] 
			 forKey:@"report"];
	return [templateEngine templateForReports:(NSDictionary *)dict];
}

-(NSData *)files:(NSArray *)file
{
	TTDPRINT(@"%@", file);
	NSString *root = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0];
	root = [root stringByAppendingPathComponent:@"kidjo"];
	if ([file count]>1) {
		root = [root stringByAppendingPathComponent:[file objectAtIndex:1]];
	} else {
		root = [root stringByAppendingPathComponent:[file objectAtIndex:0]];
	}

	if ([[NSFileManager defaultManager] fileExistsAtPath:root]) {
		TTDPRINT(@"%@",root);
		return [NSData dataWithContentsOfFile:root];
	}
	NSString *f =[[root pathComponents] lastObject];
	NSString *inBundle = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:f];
	TTDPRINT(@"%@",inBundle);
	NSData *d =[NSData dataWithContentsOfFile:inBundle];
	return d;
}

-(NSData *)favicon:(NSArray *) data
{
	return [self files:data];
}
@end
