//
//  Excercise.h
//  HackArizona
//
//  Created by Pravin on 1/23/16.
//  Copyright © 2016 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BEMSimpleLineGraphView.h"
typedef NS_ENUM(NSInteger, Extype) {
    EXtypePushUp,
    ExTypeSkipping,
    EXTypeDumbell,
    EXTypeSquats,
    EXTypePullUps
};

@interface Excercise : UIViewController<BEMSimpleLineGraphDataSource,BEMSimpleLineGraphDelegate>
@property(nonatomic) Extype excerciseName;
@property(nonatomic) IBOutlet UILabel *btnLock;
@property(nonatomic) NSString* previouslock;
 @end
