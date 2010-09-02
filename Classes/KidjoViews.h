//
//  KidjoViews.h
//  Kidjo
//
//  Created by Manuel on 16.06.10.
//  Copyright 2010 apparatschik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KidjoTemplateEngine.h"

@interface KidjoViews : NSObject {
	KidjoTemplateEngine *templateEngine;
}

-(NSString *)halloWelt:(NSArray *)data;
-(NSString *)index:(NSArray *)data;
-(NSString *)fallback:(NSArray *)data;
-(NSString *)allReports:(NSArray *)data;
-(NSData *)files:(NSArray *)files;
-(NSData *)favicon:(NSArray *) data;
@end
