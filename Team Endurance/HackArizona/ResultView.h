//
//  ResultView.h
//  HackArizona
//
//  Created by Pravin on 1/23/16.
//  Copyright © 2016 MC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultView : UIView

@property(nonatomic,retain) IBOutlet UILabel *currentValue;
@property(nonatomic,retain) IBOutlet UILabel *HighestValue;
@property(nonatomic,retain) IBOutlet UILabel *TotalValue;

@end
