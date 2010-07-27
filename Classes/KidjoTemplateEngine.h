//
//  KidjoTemplateEngine.h
//  Kidjo
//
//  Created by Manuel on 18.06.10.
//  Copyright 2010 apparatschik. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface KidjoTemplateEngine : NSObject {

}
-(NSString *)templateForIndex;
-(NSString *)templateForHalloWelt:(NSDictionary *)dict;
-(NSString *)templateForReports:(NSDictionary *)dict;
@end
