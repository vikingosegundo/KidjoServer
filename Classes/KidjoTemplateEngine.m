//
//  KidjoTemplateEngine.m
//  Kidjo
//
//  Created by Manuel on 18.06.10.
//  Copyright 2010 apparatschik. All rights reserved.
//

#import "KidjoTemplateEngine.h"


@implementation KidjoTemplateEngine

-(NSString *)templateForIndex
{
	NSString *string =@"<html>\n";
	string = [string stringByAppendingString:@"		<head>\n"];
	string = [string stringByAppendingString:@"			<title>Hallo</title>\n"];
	string = [string stringByAppendingString:@"			<script src=\"files/raphael.js\" type=\"text/javascript\"></script>\n"];
	NSString *inBundle = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"clock.text"];
	TTDPRINT(@"%@",inBundle);
	
	NSError *error = nil;
	NSString *s = [NSString stringWithContentsOfFile:inBundle encoding:NSUTF8StringEncoding error:&error];
	string = [string stringByAppendingString:s];
	string = [string stringByAppendingString:@"		</head>\n"];
	string = [string stringByAppendingString:@"		<body>\n"];
	string = [string stringByAppendingString:@"			<h1>Willkommen im P1"];

	string = [string stringByAppendingString:@"!</h1>\n"];
	string = [string stringByAppendingString:@"			<img src=\"files/P1.png\" /><a href=\"/reports/\">zum den reports</a>\n"];
	string = [string stringByAppendingString:@"			<form><div id=\"holder\"></div>"];
	
	/*
	 */
	string = [string stringByAppendingString:@"	 <div id=\"time\"><span id=\"h\"></span>:<span id=\"m\"></span>:<span id=\"s\"></span> <span id=\"ampm\"></span> · <span id=\"d\"></span>/<span id=\"mnth\"></span></div>"];
	string = [string stringByAppendingString:@"		</form></body>\n"];
	string = [string stringByAppendingString:@"</html>"];
	
	return string;
}


-(NSString *) templateForHalloWelt:(NSDictionary *)dict
{
	NSString *string =@"<html>\n";
	string = [string stringByAppendingString:@"		<head>\n"];
	string = [string stringByAppendingString:@"			<title>Hallo</title>\n"];
	string = [string stringByAppendingString:@"		</head>\n"];
	string = [string stringByAppendingString:@"		<body>\n"];
	string = [string stringByAppendingString:@"			<h1>Hallo "];
	for (int i =0 ; i< [[dict objectForKey:@"count"] intValue]; i++) {
		NSString *index = [NSString stringWithFormat:@"%d",i];
		string = [string stringByAppendingFormat:@"%@ ", [dict objectForKey:index]];
	}
	string = [string stringByAppendingString:@"!</h1>\n"];
	string = [string stringByAppendingString:@"		</body>\n"];
	string = [string stringByAppendingString:@"</html>"];
	
	return string;

}
-(NSString *) templateForReports:(NSDictionary *)dict
{
	NSDateFormatter *dateFormatter = [NSDateFormatter new];
	[dateFormatter setDateFormat:@"dd.MM.YYYY"];
	NSString *string = @"";
	string = [string stringByAppendingString:@"<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">"];
	string = [string stringByAppendingString:@"<html xmlns=\"http://www.w3.org/1999/xhtml\" dir=\"ltr\" xml:lang=\"de\" lang=\"de\">\n"];
	string = [string stringByAppendingString:@"		<head>\n"];
	string = [string stringByAppendingString:@"		<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\"/>"];
	string = [string stringByAppendingString:@"			<title>Reports</title>\n"];
	string = [string stringByAppendingString:@"		</head>\n"];
	string = [string stringByAppendingString:@"		<body>\n"];
	string = [string stringByAppendingFormat:@"			<h1>Reports für %@ - %@</h1>\n", [dateFormatter stringFromDate:[dict objectForKey:@"startDate"]],
																						 [dateFormatter stringFromDate:[dict objectForKey:@"endDate"]]];
	if ([[dict objectForKey:@"report"] count]>0) {
		string = [string stringByAppendingString:@"				<ul>\n"];
		for (NSString *s in [dict objectForKey:@"report"]) {
			string = [string stringByAppendingFormat:@"					<li><a href=\".\">%@</a></li>\n", s];
		}
		string = [string stringByAppendingString:@"				</ul>\n"];
	}
	
	string = [string stringByAppendingString:@"			<a href=\"/\">zum index</a>\n"];
	string = [string stringByAppendingString:@"		</body>\n"];
	string = [string stringByAppendingString:@"</html>"];
	
	return string;
}
@end
