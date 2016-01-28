//
//  MyCustomModule.m
//  AwesomeProject
//
//  Created by zyma on 1/22/16.
//  Copyright © 2016 Facebook. All rights reserved.
//

#import "MyCustomModule.h"

@implementation MyCustomModule

RCT_EXPORT_MODULE();

// Available as NativeModules.MyCustomModule.processString
RCT_EXPORT_METHOD(processString:(NSString *)input callback:(RCTResponseSenderBlock)callback)
{
  callback(@[[input stringByReplacingOccurrencesOfString:@"Goodbye" withString:@"Hello"]]);
}

@end