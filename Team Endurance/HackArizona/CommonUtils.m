//
//  CommonUtils.m
//  Grabfree
//
//  Created by Pravin on 12/20/15.
//  Copyright (c) 2015 Grabfree. All rights reserved.
//

#import "CommonUtils.h"
#import "MBProgressHUD.h"



@implementation CommonUtils
static CommonUtils *instance = nil;



+ (CommonUtils *)sharedInstance {
    if (nil != instance) {
        return instance;
    }
    static dispatch_once_t pred;        // Lock
    dispatch_once(&pred, ^{             // This code is called at most once per app
        instance = [[CommonUtils alloc]init];
    });
    return instance;
}

#pragma mark Device Token
- (void)saveDeviceToken:(NSData*)object{
    [[NSUserDefaults standardUserDefaults] setObject:object forKey:kDeviceTokenKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (NSString *)loadDeviceToken{
    NSMutableData *data =[[NSUserDefaults standardUserDefaults]objectForKey:kDeviceTokenKey];
    if(data!=nil){
    NSString *token=[[NSString alloc] initWithBytes:[data mutableBytes] length:[data length] encoding:NSUTF8StringEncoding];
    token= [NSString stringWithUTF8String:[data bytes]];
    const unsigned *tokenBytes = [data bytes];
    NSString *hexToken = [NSString stringWithFormat:@"%08x%08x%08x%08x%08x%08x%08x%08x",
                          ntohl(tokenBytes[0]), ntohl(tokenBytes[1]), ntohl(tokenBytes[2]),
                          ntohl(tokenBytes[3]), ntohl(tokenBytes[4]), ntohl(tokenBytes[5]),
                          ntohl(tokenBytes[6]), ntohl(tokenBytes[7])];
        return hexToken;
    }
        return  nil;
}



#pragma mark Navigation controller Setup
-(void)SetUpNavControllerWithid:(UIViewController *)delegate andTitle:(NSString*)title{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
//    label.font = [UIFont boldSystemFontOfSize:20.0];
    NSArray *ary=[UIFont familyNames];
    label.font=[UIFont fontWithName:@"Chalet-NewYorkNineteenSeventy" size:24.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    delegate.navigationItem.titleView = label;
    label.text = title;
    [label sizeToFit];
    delegate.navigationController.navigationBar.barTintColor=[UIColor FlatDark];
    delegate.navigationController.navigationBar.tintColor=[UIColor textColor];
    delegate.navigationController.navigationBar.translucent = NO;
}



#pragma Activity Indicator

/*******************************************************************************
 * @method visibleViewController : To dynamically get the current viewcontroller
 *******************************************************************************/
- (UIViewController *)visibleViewController:(UIViewController *)rootViewController{
    if (rootViewController.presentedViewController == nil)
    {
        return rootViewController;
    }
    if ([rootViewController.presentedViewController isKindOfClass:[UINavigationController class]])
    {
        UINavigationController *navigationController = (UINavigationController *)rootViewController.presentedViewController;
        UIViewController *lastViewController = [[navigationController viewControllers] lastObject];
        
        return [self visibleViewController:lastViewController];
    }
    if ([rootViewController.presentedViewController isKindOfClass:[UITabBarController class]])
    {
        UITabBarController *tabBarController = (UITabBarController *)rootViewController.presentedViewController;
        UIViewController *selectedViewController = tabBarController.selectedViewController;
        return [self visibleViewController:selectedViewController];
    }
    
    UIViewController *presentedViewController = (UIViewController *)rootViewController.presentedViewController;
    
    return [self visibleViewController:presentedViewController];
}




#pragma mark Load and Save Userdefaults

/*******************************************************************************
 * @method Load_Stringfrom_UserDefaultWithKey : As name says
 *******************************************************************************/
-(NSString *)Load_Stringfrom_UserDefaultWithKey:(NSString *)key{
    return [[NSUserDefaults standardUserDefaults]
                            stringForKey:key];

}

/*******************************************************************************
 * @method Save_StringTo_UserDefault : As name says
 *******************************************************************************/
-(void)Save_StringTo_UserDefault:(NSString*)object andKey:(NSString *)key{
    [[NSUserDefaults standardUserDefaults] setObject:object forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}



/*******************************************************************************
 * @method showActivityIndicatorWithString : To dynamically get the current viewcontroller
 *******************************************************************************/
-(void)showActivityIndicatorWithString:(NSString*)string{
    UIViewController *vc = [self visibleViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:vc.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Uploading";
    //UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, vc.view.frame.size.width, vc.view.frame.size.height)];
}

/*******************************************************************************
 * @method hideActivityIndicator :As name says
 *******************************************************************************/
-(void)hideActivityIndicator{

    UIViewController *vc = [self visibleViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
    [MBProgressHUD hideHUDForView:vc.view animated:YES];
}

/*******************************************************************************
 * @method loadDashBoard_AllFavors : As name says
 *******************************************************************************/
- (NSMutableArray *)loadArrayUserDefault:(NSString*) key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [defaults objectForKey:key];
    NSMutableArray *object = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    return object;
}

/*******************************************************************************
 * @method saveDashBoard_AllFavors : As name says
 *******************************************************************************/
- (void)SaveArraytoUserDefault:(NSMutableArray *)object andKey:(NSString*)key{
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:object];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:encodedObject forKey:key];
    [defaults synchronize];
}




@end
