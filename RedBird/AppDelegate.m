//
//  AppDelegate.m
//  RedBird
//
//  Created by kennshi@qq.com on 2016/10/15.
//  Copyright © 2016年 Hope. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize _window;
@synthesize _webView;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    NSLog(@" NSScreen.Count=%lu\r\n", [[NSScreen screens] count]);
    NSRect theRect = [[[NSScreen screens] objectAtIndex:0] frame];
    if([[NSScreen screens] count] > 1)
    {
        theRect =[[[NSScreen screens] objectAtIndex:1] frame];
    }
    NSLog(@"theRect(%f,%f,%f,%f)",theRect.origin.x,theRect.origin.y,theRect.size.width,theRect.size.height);
    [_window setFrame:theRect display:YES];


    [_window setCollectionBehavior:NSWindowCollectionBehaviorFullScreenPrimary];
    //if(window.styleMask & NSWindowStyleMaskFullScreen){
        [_window toggleFullScreen:_window];
    //}
    //how to make sure FullScreen?
  

    //elem.onwebkitfullscreenchange
    NSString *jsscript =
    @"function showAlert(){"
    "   alert('helllo,worllldd!');"
    "   var scheme = 'videohandler://';"

    "   var videos = document.getElementsByTagName('video');"
    "   for (var i = 0; i < videos.length; i++) {"
    "       videos[i].addEventListener('onwebkitfullscreenchange', onBeginFullScreen, false);"
    "   }"
    "   var videoE=videos[0];"
    "   if(videoE){"
    "       window.webkit.messageHandlers.jsCallOC.postMessage('hava a videoEEE!');"
    "   }"
    "}"
    
    "function onBeginFullScreen() {"
    "    window.location = scheme + 'video-beginfullscreen';"
    "    window.webkit.messageHandlers.jsCallOC.postMessage('video-beginfullscreen');"
    "}"

    "function onEndFullScreen() {"
    "    window.location = scheme + 'video-endfullscreen';"
    "    window.webkit.messageHandlers.jsCallOC.postMessage('video-endfullscreen');"
    "}"
    
    "function CheckVideoFullScreen(){"
    "   var modplayer=document.getElementById('mod_player');"
    "   if(modplayer) {"
    "       modplayer.style.bottom='0px';"
    "   }"
    "   var modaction=document.getElementsByClassName('mod_action cf')[0];"
    "   if(modaction){"
    "       modaction.hidden=true;"
    "   }"
    "   window.webkit.messageHandlers.jsCallOC.postMessage('CheckVideoFullScreen');"
    "}"
    ;
    
    
    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
    [userContentController addScriptMessageHandler:self name:@"jsCallOC"];
    WKUserScript *userScript = [[WKUserScript alloc] initWithSource:jsscript injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:false];
    [userContentController addUserScript:userScript];
    
    
    
    WKPreferences *preferences=[[WKPreferences alloc] init];
    preferences.javaEnabled=true;
    preferences.javaScriptEnabled = true;
    preferences.javaScriptCanOpenWindowsAutomatically = true;
    preferences.plugInsEnabled=true;
    
    // WKWebView的配置
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.userContentController = userContentController;
    configuration.preferences =preferences;
    configuration.allowsAirPlayForMediaPlayback = NO;
    configuration.mediaTypesRequiringUserActionForPlayback = WKAudiovisualMediaTypeAll;
    configuration.applicationNameForUserAgent = @"RedBird";
    //configuration.allowsPictureInPictureMediaPlayback = YES;
    //configuration.allowsInlineMediaPlayback = YES;


    
    _webView = [[WKWebView alloc] initWithFrame: _window.contentView.bounds configuration:configuration];
    _window.contentView = _webView;
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    _webView.customUserAgent = @"RedBird";
    //[_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
    //[_webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
    //[_webView addObserver:self forKeyPath:@"*" options:NSKeyValueObservingOptionNew context:NULL];
    
    
    NSNotificationCenter *notifyCenter = [NSNotificationCenter defaultCenter];
    [notifyCenter addObserverForName:nil
                              object:nil
                               queue:nil
                          usingBlock:^(NSNotification *notification){
                              if([[notification name] rangeOfString:@"DidUpdateNotification"].location == NSNotFound
                                 && [[notification name] rangeOfString:@"WillUpdateNotification"].location == NSNotFound
                                 && [[notification name] rangeOfString:@"LUNotificationPopoverWillClose"].location == NSNotFound
                                 && [[notification name] rangeOfString:@"Keyboard"].location == NSNotFound)
                                 //&& [notification object] == _webView)
                              {
                              // Explore notification
                              /*NSLog(@"Notification found with:"
                                    "\r\n     name:     %@"
                                    "\r\n     object:   %@"
                                    "\r\n     userInfo: %@",
                                    [notification name],
                                    [notification object],
                                    [notification userInfo]);*/
                              }
                          }];
    
    
    
    
    
    
    
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://v.qq.com"]];
    [_webView loadRequest:request];
    //NSDictionary *fullScreenOptions = [NSDictionary dictionaryWithObject: [NSNumber         numberWithBool: YES] forKey: NSFullScreenModeSetting];
    //[_webView enterFullScreenMode:[[NSScreen screens] objectAtIndex:screenIdx]  withOptions:fullScreenOptions];
    //[window toggleFullScreen:1];
    
    //(nullable id)
    //[webView setAutoresizesSubviews:YES];
    //[window.contentView addSubview:webView];
    //[window.contentView setAutoresizesSubviews:YES];
    //NSScreen *screen = [[NSScreen screens] objectAtIndex:0];
    //window.screen = screen;
    //window.screen = screen;
    //NSDictionary *fullScreenOption = [
    //                                  [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:NSFullScreenModeSetting]
    //                                2];
    
    //NSDictionary *fullScreenOption = [[NSDictionary alloc] init];
    //[fullScreenOption insertValue:[NSNumber numberWithBool:YES] inPropertyWithKey:NSFullScreenModeSetting];
    //NSDictionary *fullScreenOptions0 = [NSDictionary dictionaryWithObject: [NSNumber         numberWithBool: YES] forKey: NSFullScreenModeSetting];
    //NSDictionary *fullScreenOptions = [NSDictionary dictionaryWithObjectsAndKeys:
    //                                   [NSNumber numberWithBool: NO], NSFullScreenModeAllScreens, nil];
    
    //NSDictionary *fullscreenOption = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:1],@"NSFullScreenModeWindowLevel", nil];
    //[webView enterFullScreenMode:screen withOptions:fullScreenOptions];
  }

-(void)awakeFromNib{
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

//WKScriptMessageHandler


//WKUIDelegate
//-(WKWebView*)webView{
//    NSLog(@"%s",__FUNCTION__);
    //return webView;
//}

#pragma mark - WKUIDelegate
#pragma mark 新建webView
-(WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    NSLog(@"%s",__FUNCTION__);
    //NSLog(@"%@,%@,%@,%@",windowFeatures.x,windowFeatures.y,windowFeatures.width,windowFeatures.height);
    NSLog(@"%@",navigationAction.targetFrame);
    
    //WKFrameInfo *frameInfo = navigationAction.targetFrame;
    //if(![frameInfo isMainFrame])
    //{
        NSURLRequest *request= navigationAction.request;
        NSLog(@"%@",request);
        if(request.URL.absoluteString != nil)
        {
            [_webView loadRequest:request];
        }
    //}
    //_webView.UIDelegate=self;
    //window.contentView = _webView;
    /*
    _webView = [[WKWebView alloc] initWithFrame:window.contentView.bounds configuration:configuration];
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    [_webView loadRequest: navigationAction.request];
    window.contentView = _webView;
    return _webView;*/
    return nil;
}

#pragma mark 关闭webView
- (void)webViewDidClose:(WKWebView *)webView {
    NSLog(@"%s",__FUNCTION__);
}

#pragma mark alert弹出框
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    NSLog(@"%s",__FUNCTION__);
    NSLog(@"%@",message);
    // 确定按钮
    //UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    //    completionHandler();
    //}];
    // alert弹出框
    //UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message message:nil preferredStyle:UIAlertControllerStyleAlert];
    //[alertController addAction:alertAction];
    //[self presentViewController:alertController animated:YES completion:nil];
    completionHandler();
}

#pragma mark Confirm选择框
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(nonnull NSString *)message initiatedByFrame:(nonnull WKFrameInfo *)frame completionHandler:(nonnull void (^)(BOOL))completionHandler {
    NSLog(@"%s",__FUNCTION__);
    // 按钮
    //UIAlertAction *alertActionCancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        // 返回用户选择的信息
    //    completionHandler(NO);
    //}];
    //UIAlertAction *alertActionOK = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    //    completionHandler(YES);
    //}];
    // alert弹出框
    //UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message message:nil preferredStyle:UIAlertControllerStyleAlert];
    //[alertController addAction:alertActionCancel];
    //[alertController addAction:alertActionOK];
    //[self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark TextInput输入框
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(nonnull NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(nonnull WKFrameInfo *)frame completionHandler:(nonnull void (^)(NSString * _Nullable))completionHandler {
    NSLog(@"%s",__FUNCTION__);
    // alert弹出框
    //UIAlertController *alertController = [UIAlertController alertControllerWithTitle:prompt message:nil preferredStyle:UIAlertControllerStyleAlert];
    // 输入框
    //[alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
    //    textField.placeholder = defaultText;
    //}];
    // 确定按钮
    //[alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 返回用户输入的信息
    //    UITextField *textField = alertController.textFields.firstObject;
    //    completionHandler(textField.text);
    //}]];
    // 显示
    //[self presentViewController:alertController animated:YES completion:nil];
}


#pragma mark WKNavigationDelegate

//请求之前，决定是否要跳转:用户点击网页上的链接，需要打开新页面时，将先调用这个方法。
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    NSLog(@"%s %ld",__FUNCTION__,(long)navigationAction.navigationType);
    NSLog(@"%@",navigationAction.request);

    
    //if (navigationAction.navigationType == WKNavigationTypeLinkActivated){
    //    decisionHandler(WKNavigationActionPolicyCancel);
    //}else{
    //    decisionHandler(WKNavigationActionPolicyAllow);
    //}
    NSString *js = @"CheckVideoFullScreen();";
    [webView evaluateJavaScript:js completionHandler:^(id _Nullable response, NSError * _Nullable error) {
        NSLog(@"response: %@ error: %@", response, error);
        NSLog(@"call jsCheckVideoFullScreen by native");
    }];
    decisionHandler(WKNavigationActionPolicyAllow);
}
//接收到相应数据后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
    NSLog(@"%s",__FUNCTION__);
    NSLog(@"%@",navigationResponse);
    //if (!navigationResponse.isForMainFrame){
    //    decisionHandler(WKNavigationResponsePolicyCancel);
    //}else{
    
    decisionHandler(WKNavigationResponsePolicyAllow);
    //}
}
//页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation
{
    NSLog(@"%s",__FUNCTION__);
    
}
// 主机地址被重定向时调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation
{
    NSLog(@"%s",__FUNCTION__);
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
    NSLog(@"%s",__FUNCTION__);
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation
{
    NSLog(@"%s",__FUNCTION__);
    NSString *js = @"showAlert();";
    [webView evaluateJavaScript:js completionHandler:^(id _Nullable response, NSError * _Nullable error) {
        NSLog(@"response: %@ error: %@", response, error);
        NSLog(@"call jsAlert by native");
    }];
}
// 页面加载完毕时调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation
{
    NSLog(@"%s",__FUNCTION__);
}
//跳转失败时调用
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
    NSLog(@"%s",__FUNCTION__);
}
// 如果需要证书验证，与使用AFN进行HTTPS证书验证是一样的
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *__nullable credential))completionHandler
{
    NSLog(@"%s",__FUNCTION__);
    completionHandler(NSURLSessionAuthChallengePerformDefaultHandling,nil);
    //completionHandler(
}
//9.0才能使用，web内容处理中断时会触发
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView NS_AVAILABLE(10_11, 9_0)
{
    NSLog(@"%s",__FUNCTION__);
}



#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSLog(@"name:%@ body:%@", message.name,message.body);
    //NSString *methods = [NSString stringWithFormat:@"%@:", message.name];
    //SEL selector = NSSelectorFromString(methods);
    // 调用方法
    //if ([self respondsToSelector:selector]) {
    //    [_webView evaluateJavaScript:message.body completionHandler:nil];

        //[self performSelector:selector withObject:message.body];
    //} else {
    //    NSLog(@"未实行方法：%@", methods);
    //}
}
- (IBAction)VideoListClick:(id)sender {
    NSMenuItem *item = (NSMenuItem*)sender;
    if([item.title  isEqual: @"Tencent"])
    {
        NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://v.qq.com"]];
        [_webView loadRequest:request];
    }
    else if([item.title isEqual:@"LeTV"])
    {
        NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.le.com"]];
        [_webView loadRequest:request];

    }
    else if([item.title isEqual:@"Youtube"])
    {
        NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.youtube.com"]];
        [_webView loadRequest:request];
        
    }
    
    
    
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    //NSLog(@"keyPath=%@ %s",keyPath,__FUNCTION__);

    
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        
        if (object == _webView) {
            //[self.progressView setAlpha:1.0f];
            //[self.progressView setProgress:self.currentSubView.webView.estimatedProgress animated:YES];
            
            //if(self.currentSubView.webView.estimatedProgress >= 1.0f) {
                
                //[UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
                //    [self.progressView setAlpha:0.0f];
                //} completion:^(BOOL finished) {
                //    [self.progressView setProgress:0.0f animated:NO];
                //}];
                
            //}
        }
        else
        {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
        
    }
    else if ([keyPath isEqualToString:@"title"])
    {
        if (object == self._webView) {
            //self.title = self.webView.title;
            
        }
        else
        {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
            
        }
    }
    else {
        
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


// -------------------------------------------------------------------------------
//  window:willUseFullScreenPresentationOptions:proposedOptions
//
//  Delegate method to determine the presentation options the window will use when
//  transitioning to full-screen mode.
// -------------------------------------------------------------------------------
- (NSApplicationPresentationOptions)window:(NSWindow *)window willUseFullScreenPresentationOptions:(NSApplicationPresentationOptions)proposedOptions
{
    // customize our appearance when entering full screen:
    // we don't want the dock to appear but we want the menubar to hide/show automatically
    //
    NSLog(@"%s",__FUNCTION__);
    return (NSApplicationPresentationFullScreen |       // support full screen for this window (required)
            NSApplicationPresentationHideDock |         // completely hide the dock
            NSApplicationPresentationAutoHideMenuBar);  // yes we want the menu bar to show/hide
}

- (NSArray*) customWindowsToEnterFullScreenForWindow:(NSWindow*)window {
    NSLog(@"%s",__FUNCTION__);
    if ([window isEqualTo:self._window]) {
        //return [NSArray arrayWithObjects:window, otherwindow, nil];
    }
    
    return nil;
}

- (NSArray*) customWindowsToExitFullScreenForWindow:(NSWindow*)window {
    NSLog(@"%s",__FUNCTION__);
    if ([window isEqualTo:self._window]) {
        //return [NSArray arrayWithObjects:window, otherwindow, nil];
    }
    
    return nil;
}


@end
