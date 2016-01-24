//
//  NSString+baseEncoding.h
//  Grabfree
//
//  Created by Pravin on 12/28/15.
//  Copyright © 2015 Grabfree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (baseEncoding)
+ (NSString *) base64StringFromData:(NSData *)data length:(int)length;
@end
