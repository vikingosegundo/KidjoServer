//
//  KidjoViewController.h
//  Kidjo
//
//  Created by Manuel on 16.06.10.
//  Copyright apparatschik 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KidjoViewController : UIViewController {
	UIWebView *webView;
}

@property(nonatomic,retain) IBOutlet UIWebView *webView;
@end

