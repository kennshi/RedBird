//
//  AppDelegate.h
//  RedBird
//
//  Created by kennshi on 2016/10/15.
//  Copyright © 2016年 Hope. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

@interface AppDelegate : NSObject <NSApplicationDelegate,WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>{
    //NSWindow * window;
    //IBOutlet WKWebView *webView;
}

@property (assign) IBOutlet NSWindow *_window;
@property (nonatomic, strong) IBOutlet WKWebView *_webView;


@end

