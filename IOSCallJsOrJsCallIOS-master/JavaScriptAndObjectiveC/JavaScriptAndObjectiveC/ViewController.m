//
//  ViewController.m
//  JavaScriptAndObjectiveC
//
//  Created by huangyibiao on 15/10/13.
//  Copyright © 2015年 huangyibiao. All rights reserved.
//

#import "ViewController.h"

// 此模型用于注入JS的模型，这样就可以通过模型来调用方法。
@interface HYBJsObjCModel : NSObject <JavaScriptObjectiveCDelegate>

@property (nonatomic, weak) JSContext *jsContext;
@property (nonatomic, weak) UIWebView *webView;
@property (nonatomic, weak) ViewController *contoller;

@end

@implementation HYBJsObjCModel

- (void)callWithDict:(NSDictionary *)params {
    NSLog(@"Js调用了OC的方法，参数为：%@", params);
}

// Js调用了callSystemCamera
- (void)callSystemCamera {
    NSLog(@"JS调用了OC的方法，调起系统相册");
    
    // JS调用后OC后，又通过OC调用JS，但是这个是没有传参数的
    JSValue *jsFunc = self.jsContext[@"jsFunc"];
    [jsFunc callWithArguments:nil];
}

- (void)jsCallObjcAndObjcCallJsWithDict:(NSDictionary *)params {
    NSLog(@"jsCallObjcAndObjcCallJsWithDict was called, params is %@", params);
    
    // 调用JS的方法
    JSValue *jsParamFunc = self.jsContext[@"jsParamFunc"];
    [jsParamFunc callWithArguments:@[@{@"age": @10, @"name": @"lili", @"height": @158}]];
}

- (void)showAlert:(NSString *)title msg:(NSString *)msg {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"title" message:@"message" preferredStyle:UIAlertControllerStyleAlert];
        
        [ac addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = @"账户";
        }];
        
        [ac addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = @"密码";
            textField.secureTextEntry = YES;
        }];
        
        [self.contoller presentViewController:ac animated:YES completion:^{
            
        }];
        
//        UIAlertView *a = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//        [a show];
    });
}

@end

@interface ViewController () <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) JSContext *jsContext;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self.view addSubview:self.webView];
 
  // 一个JSContext对象，就类似于Js中的window，只需要创建一次即可。
  self.jsContext = [[JSContext alloc] init];

  // jscontext可以直接执行JS代码。
  [self.jsContext evaluateScript:@"var num = 10"];
  [self.jsContext evaluateScript:@"var squareFunc = function(value) { return value * 2 }"];
  // 计算正方形的面积
  JSValue *square = [self.jsContext evaluateScript:@"squareFunc(num)"];
  
  // 也可以通过下标的方式获取到方法
  JSValue *squareFunc = self.jsContext[@"squareFunc"];
  JSValue *value = [squareFunc callWithArguments:@[@"20"]];
  NSLog(@"%@", square.toNumber);
  NSLog(@"%@", value.toNumber);
}

- (UIWebView *)webView {
  if (_webView == nil) {
    _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    _webView.scalesPageToFit = YES;
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"test" withExtension:@"html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
    _webView.delegate = self;
  }
  
  return _webView;
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
  self.jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
  // 通过模型调用方法，这种方式更好些。
    HYBJsObjCModel *model  = [[HYBJsObjCModel alloc] init];
  self.jsContext[@"OCModel"] = model;
  model.jsContext = self.jsContext;
  model.webView = self.webView;
  model.contoller = self;
    
  self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
    context.exception = exceptionValue;
    NSLog(@"异常信息：%@", exceptionValue);
  };
}

@end
