//
//  JSCallOCViewController.h
//  JavaScriptCore-Demo
//
//  Created by Jakey on 14/12/26.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol TestJSExport <JSExport>

JSExportAs
(calculateForJS  /** handleFactorialCalculateWithNumber 作为js方法的别名 */,
 - (void)handleFactorialCalculateWithNumber:(NSNumber *)number
 );

JSExportAs
(calculate_2,
 - (NSString *)calculate_2:(NSNumber *)number
 );

- (void)pushViewController:(NSString *)view title:(NSString *)title detail:(NSString *)detail;
@end



@interface JSCallOCViewController : UIViewController<UIWebViewDelegate,TestJSExport>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) JSContext *context;
@end
