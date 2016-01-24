//
//  CommonUtils.h
//  Grabfree
//
//  Created by Pravin on 12/20/15.
//  Copyright (c) 2015 Grabfree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonUtils : NSObject




//*****************  Device Token *****************************
- (void)saveDeviceToken:(NSData *)object;
- (NSString *)loadDeviceToken;



//*****************  Navigation Bar *****************************
-(void)SetUpNavControllerWithid:(UIViewController *)delegate andTitle:(NSString*)title;

//*****************  Activity Indicator *****************************
-(void)showActivityIndicatorWithString:(NSString*)string;
-(void)hideActivityIndicator;

//***************** Miscellaneous *****************************
+ (CommonUtils *)sharedInstance;


- (NSMutableArray *)loadArrayUserDefault:(NSString*) key;
- (void)SaveArraytoUserDefault:(NSMutableArray *)object andKey:(NSString*)key;
@end
