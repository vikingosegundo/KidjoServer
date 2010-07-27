//
//  KidjoAppDelegate.h
//  Kidjo
//
//  Created by Manuel on 16.06.10.
//  Copyright apparatschik 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KidjoURLDispatcher.h"

@class KidjoViewController;
@class KidjoServer;

@interface KidjoAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    KidjoViewController *viewController;
	KidjoServer *server;
	
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet KidjoViewController *viewController;

@end

