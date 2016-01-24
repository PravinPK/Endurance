
#import "UIColor+ThemeColors.h"

@implementation UIColor (ThemeColors)
+ (UIColor*)themeGreen {
    return [UIColor colorWithRed:73.0/255.0 green:138.0/255.0 blue:69.0/255.0 alpha:1];
    //return [UIColor colorWithRed:62.0/255.0 green:124.0/255.0 blue:214.0/255.0 alpha:1.0];
}
+ (UIColor*)HeaderColor{
    return [UIColor colorWithRed:73.0/255.0 green:138.0/255.0 blue:69.0/255.0 alpha:1];
    //return [UIColor colorWithRed:214.0/255.0 green:69.0/255.0 blue:73.0/255.0 alpha:1.0];
    //return [UIColor colorWithRed:62.0/255.0 green:124.0/255.0 blue:214.0/255.0 alpha:1.0];
}

+(UIColor*)TableHeader{
    return [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1];
}



//Dashboard

+ (UIColor*)KarmaPointsRed{
    return [UIColor colorWithRed:214.0/255.0 green:69.0/255.0 blue:73.0/255.0 alpha:0.0];
}
+ (UIColor*)KarmaPointsBlue{
    return [UIColor colorWithRed:62.0/255.0 green:124.0/255.0 blue:214.0/255.0 alpha:0.0];
}
+ (UIColor*)LightText{
    return [UIColor colorWithRed:190.0/255.0 green:190.0/255.0 blue:190.0/255.0 alpha:0.5];
}

+ (UIColor*)LightBorderGreen{
    return [UIColor colorWithRed:73.0/255.0 green:138.0/255.0 blue:69.0/255.0 alpha:0.65];
}

+ (UIColor*)whiteFaded{
    return [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.65];
}
+ (UIColor*)themeGrey{
    return [UIColor colorWithRed:50.0/255.0 green:50.0/255.0 blue:50.0/255.0 alpha:1];
}

+(UIColor*)themeBlue{
    return [UIColor colorWithRed:62.0/255.0 green:124.0/255.0 blue:214.0/255.0 alpha:1];
}

+(UIColor*)themeColor{
    //brown
    //return [UIColor colorWithRed:78.0/255.0 green:52.0/255.0 blue:46.0/255.0 alpha:1];
    //orange
    //return [UIColor colorWithRed:240.0/255.0 green:138.0/255.0 blue:93.0/255.0 alpha:1];
    //YIK YAK blue
    
    //original green
    // return [UIColor colorWithRed:131.0/255.0 green:204.0/255.0 blue:97.0/255.0 alpha:1];
    
    return [UIColor colorWithRed:102.0/255.0 green:189.0/255.0 blue:61.0/255.0 alpha:1];
}


+(UIColor*)FAbtnColors{
    return [UIColor colorWithRed:190.0/255.0 green:190.0/255.0 blue:190.0/255.0 alpha:1];
}

+(UIColor*)FlatLight{
    return [UIColor flatTealColor];
}
+(UIColor*)FlatDark{
    return [UIColor flatTealColorDark];
}
+(UIColor *)textColor{
    return [UIColor whiteColor];
}

+(UIColor*)ApproveColor{
    return [UIColor flatMintColor];
}

+(UIColor *)RejectColor{
    return [UIColor flatRedColor];
}

@end
