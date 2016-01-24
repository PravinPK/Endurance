//
//  Excercise.m
//  HackArizona
//
//  Created by Pravin on 1/23/16.
//  Copyright © 2016 MC. All rights reserved.
//

#import "Excercise.h"
#import "ResultView.h"



static int pushUpThreshold=0;
static int skippingThreshold=0;




#define resultBarHeight 150
#define GraphBarHeight 150
#define lbl1Frame CGRectMake(0, 0, viewWidth/3, resultBarHeight/2)
#define lbl2Frame CGRectMake(0, resultBarHeight/2, viewWidth/3, resultBarHeight/2)

#define UDpush @"UDpush"
#define UDSkip @"UDSkip"
#define UDDumb @"UDDumb"
#define UDSquat @"UDSquat"
#define UDPull @"UDPull"

@interface Excercise ()
{
    int viewWidth;
    int viewHeight;
    int skipCount;
    int goingUP;
    int maxValue;
    int minValue;
    ResultView *result;
    BEMSimpleLineGraphView *myGraph;
    BEMSimpleLineGraphView *myGraph2;
    
    UILabel *bigLabel;
    NSMutableArray *data;
    NSMutableArray *data2;
}

@end

@implementation Excercise

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view layoutIfNeeded];
    
     skipCount=0;
     goingUP=0;
     maxValue=-100000;
     minValue=+100000;
    viewHeight=self.view.frame.size.height;
    viewWidth=self.view.frame.size.width;
    [self setResultView];
    data=[[NSMutableArray alloc]init];
    if(_excerciseName==EXtypePushUp)
    {
        [[CommonUtils sharedInstance] SetUpNavControllerWithid:self andTitle:@"Push Up"];
        data=[[CommonUtils sharedInstance] loadArrayUserDefault:UDpush];
    }
    else if(_excerciseName==ExTypeSkipping)
    {
        [[CommonUtils sharedInstance] SetUpNavControllerWithid:self andTitle:@"Skipping"];
        data=[[CommonUtils sharedInstance] loadArrayUserDefault:UDSkip];
    }
    else if(_excerciseName==EXTypeDumbell)
    {
        [[CommonUtils sharedInstance] SetUpNavControllerWithid:self andTitle:@"Dumbbell"];
        data=[[CommonUtils sharedInstance] loadArrayUserDefault:UDDumb];
    }
    else if(_excerciseName==EXTypeSquats)
    {
        [[CommonUtils sharedInstance] SetUpNavControllerWithid:self andTitle:@"Squats"];
        data=[[CommonUtils sharedInstance] loadArrayUserDefault:UDSquat];
    }
    else if(_excerciseName==EXTypePullUps)
    {
        [[CommonUtils sharedInstance] SetUpNavControllerWithid:self andTitle:@"Pull Ups"];
        data=[[CommonUtils sharedInstance] loadArrayUserDefault:UDPull];
    }
    result.currentValue.text=[NSString stringWithFormat:@"%ld",[[data lastObject] integerValue]];
    
    int total=0;
    int highest=0;
    for (NSNumber *num in data){
        total=total+(int)[num integerValue];
        if(highest<(int)[num integerValue]){
            highest=(int)[num integerValue];
        }
        
    }
    result.TotalValue.text=[NSString stringWithFormat:@"%d",total];
    result.HighestValue.text=[NSString stringWithFormat:@"%d",highest];

    
    
    // Do any additional setup after loading the view.

    [self setUpNavigationController];
    [self.view setBackgroundColor:[UIColor FlatLight]];
    
    
    


    myGraph = [[BEMSimpleLineGraphView alloc] initWithFrame:CGRectMake(0, viewHeight-300, viewWidth,250)];
    myGraph.dataSource = self;
    myGraph.delegate = self;
    myGraph.animationGraphStyle= BEMLineAnimationFade;
    myGraph.colorTop=[UIColor FlatDark];
    myGraph.colorBottom=[UIColor FlatDark];
    [myGraph setBackgroundColor:[UIColor clearColor]];
    myGraph.enableBezierCurve = YES;
    myGraph.colorXaxisLabel=[UIColor whiteColor];
    myGraph.colorYaxisLabel=[UIColor whiteColor];
    myGraph.enableXAxisLabel=true;
    myGraph.enableYAxisLabel=true;
    myGraph.autoScaleYAxis=YES;
//    myGraph.enableReferenceXAxisLines=true;
//    myGraph.enableReferenceYAxisLines=true;
    myGraph.enableReferenceAxisFrame=true;
    myGraph.alwaysDisplayDots=true;
    myGraph.colorBottom=[UIColor clearColor];
    myGraph.colorTop=[UIColor clearColor];
    myGraph.alphaBottom=0.4;
    myGraph.displayDotsWhileAnimating=TRUE;
    
    

    [self.view addSubview:myGraph];
    
    
    
    
    
    
    myGraph2 = [[BEMSimpleLineGraphView alloc] initWithFrame:CGRectMake(0, 0, viewWidth,200)];
    myGraph2.dataSource = self;
    myGraph2.delegate = self;
    myGraph2.animationGraphStyle= BEMLineAnimationNone;
    myGraph2.colorTop=[UIColor FlatDark];
    myGraph2.colorBottom=[UIColor FlatDark];
    [myGraph2 setBackgroundColor:[UIColor clearColor]];
    myGraph2.enableBezierCurve = YES;
    myGraph2.colorXaxisLabel=[UIColor whiteColor];
    myGraph2.colorYaxisLabel=[UIColor whiteColor];
    myGraph2.enableXAxisLabel=true;
    myGraph2.enableYAxisLabel=true;
    myGraph2.enableReferenceAxisFrame=true;
    myGraph2.colorBottom=[UIColor clearColor];
    myGraph2.colorTop=[UIColor clearColor];
    myGraph2.alphaBottom=0.4;
    myGraph2.alwaysDisplayDots=false;
    myGraph2.colorLine=[UIColor colorWithWhite:1.0 alpha:0.5];

    
    
    [self.view addSubview:myGraph2];
    
    
    
    
    
    [self.view bringSubviewToFront:_btnLock];
    [_btnLock setFont:[UIFont fontWithName:@"FontAwesome" size:30]];
    [_btnLock setText:_previouslock];
    

}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    int times=(int)[bigLabel.text integerValue];
    if([bigLabel.text integerValue]>=3){
        if(_excerciseName==EXtypePushUp)
        {
            data=[[CommonUtils sharedInstance] loadArrayUserDefault:UDpush];
            if(data==nil){
                data=[[NSMutableArray alloc]init];
            }
            [data addObject:[NSNumber numberWithInt:times]];
            [[CommonUtils sharedInstance] SaveArraytoUserDefault:data andKey:UDpush];
            
        }
        else if(_excerciseName==ExTypeSkipping)
        {
            data=[[CommonUtils sharedInstance] loadArrayUserDefault:UDSkip];
            if(data==nil){
                data=[[NSMutableArray alloc]init];
            }
            [data addObject:[NSNumber numberWithInt:times]];
            [[CommonUtils sharedInstance] SaveArraytoUserDefault:data andKey:UDSkip];
        }
        else if(_excerciseName==EXTypeDumbell)
        {
            data=[[CommonUtils sharedInstance] loadArrayUserDefault:UDDumb];
            if(data==nil){
                data=[[NSMutableArray alloc]init];
            }
            [data addObject:[NSNumber numberWithInt:times]];
            [[CommonUtils sharedInstance] SaveArraytoUserDefault:data andKey:UDDumb];
        }
        else if(_excerciseName==EXTypeSquats)
        {
            data=[[CommonUtils sharedInstance] loadArrayUserDefault:UDSquat];
            if(data==nil){
                data=[[NSMutableArray alloc]init];
            }
            [data addObject:[NSNumber numberWithInt:times]];
            [[CommonUtils sharedInstance] SaveArraytoUserDefault:data andKey:UDSquat];
        }
        else if(_excerciseName==EXTypePullUps)
        {
            data=[[CommonUtils sharedInstance] loadArrayUserDefault:UDPull];
            if(data==nil){
                data=[[NSMutableArray alloc]init];
            }
            [data addObject:[NSNumber numberWithInt:times]];
            [[CommonUtils sharedInstance] SaveArraytoUserDefault:data andKey:UDPull];
        }
    }
    
}

-(void)viewWillAppear:(BOOL)animated{
    [self hearNorification];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUpNavigationController{
      CGRect frameimg1 = CGRectMake(0, 0,30, 30);
    UIButton *settings=[[UIButton alloc]initWithFrame:frameimg1];
    [settings.titleLabel setFont:[UIFont fontWithName:@"FontAwesome" size:26]];
    [settings setTitle:[NSString fontAwesomeIconStringForEnum:FACog] forState:UIControlStateNormal];
    [settings addTarget:self action:@selector(didTapSettings:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButton2=[[UIBarButtonItem alloc]initWithCustomView:settings];
    self.navigationItem.rightBarButtonItem=barButton2;

}

-(void)setResultView{
    
    bigLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, viewWidth, 200)];
    [bigLabel setText:@"Start"];
    [bigLabel setFont:[UIFont systemFontOfSize:80.0f weight:UIFontWeightSemibold]];
    [bigLabel setTextColor:[UIColor textColor]];
    [bigLabel setTextAlignment:NSTextAlignmentCenter];
    [bigLabel setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:bigLabel];
    
    
    result =[[[NSBundle mainBundle] loadNibNamed:@"ResultView" owner:self options:nil]
     objectAtIndex:0];
    [result setFrame:CGRectMake(0,200,viewWidth, 200)];
    [result setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.13]];
    result.currentValue.text=@"0";
    result.HighestValue.text=@"0";
    result.TotalValue.text=@"0";
    [self.view addSubview:result];

}










#pragma mark - Myo Notifications

-(void)hearNorification{
    // Data notifications are received through NSNotificationCenter.
    // Posted whenever a TLMMyo connects
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didConnectDevice:)
                                                 name:TLMHubDidConnectDeviceNotification
                                               object:nil];
    // Posted whenever a TLMMyo disconnects.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didDisconnectDevice:)
                                                 name:TLMHubDidDisconnectDeviceNotification
                                               object:nil];
    // Posted whenever the user does a successful Sync Gesture.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didSyncArm:)
                                                 name:TLMMyoDidReceiveArmSyncEventNotification
                                               object:nil];
    // Posted whenever Myo loses sync with an arm (when Myo is taken off, or moved enough on the user's arm).
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didUnsyncArm:)
                                                 name:TLMMyoDidReceiveArmUnsyncEventNotification
                                               object:nil];
    // Posted whenever Myo is unlocked and the application uses TLMLockingPolicyStandard.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didUnlockDevice:)
                                                 name:TLMMyoDidReceiveUnlockEventNotification
                                               object:nil];
    // Posted whenever Myo is locked and the application uses TLMLockingPolicyStandard.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didLockDevice:)
                                                 name:TLMMyoDidReceiveLockEventNotification
                                               object:nil];
    // Posted when a new orientation event is available from a TLMMyo. Notifications are posted at a rate of 50 Hz.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveOrientationEvent:)
                                                 name:TLMMyoDidReceiveOrientationEventNotification
                                               object:nil];
    // Posted when a new accelerometer event is available from a TLMMyo. Notifications are posted at a rate of 50 Hz.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveAccelerometerEvent:)
                                                 name:TLMMyoDidReceiveAccelerometerEventNotification
                                               object:nil];
    // Posted when a new pose is available from a TLMMyo.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceivePoseChange:)
                                                 name:TLMMyoDidReceivePoseChangedNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveEMG:)
                                                 name:TLMMyoDidReceiveEmgEventNotification
                                               object:nil];
    
    
}

- (void)didConnectDevice:(NSNotification *)notification {
    // Access the connected device.
    TLMMyo *myo = notification.userInfo[kTLMKeyMyo];
    NSLog(@"Connected to %@.", myo.name);
    
}

- (void)didDisconnectDevice:(NSNotification *)notification {
    // Access the disconnected device.
    TLMMyo *myo = notification.userInfo[kTLMKeyMyo];
    NSLog(@"Disconnected from %@.", myo.name);
    
}

- (void)didUnlockDevice:(NSNotification *)notification {
    // Update the label to reflect Myo's lock state.
    NSLog(@"Myo Unlocked");
    [_btnLock setText:[NSString fontAwesomeIconStringForEnum:FAUnlock]];

}

- (void)didLockDevice:(NSNotification *)notification {
    // Update the label to reflect Myo's lock state.
    NSLog(@"Myo Locked");
    [_btnLock setText:[NSString fontAwesomeIconStringForEnum:FALock]];
}

- (void)didSyncArm:(NSNotification *)notification {
    // Retrieve the arm event from the notification's userInfo with the kTLMKeyArmSyncEvent key.
    NSLog(@"Arm Synched");
    TLMArmSyncEvent *armEvent = notification.userInfo[kTLMKeyArmSyncEvent];
    
    // Update the armLabel with arm information.
    NSString *armString = armEvent.arm == TLMArmRight ? @"Right" : @"Left";
    NSString *directionString = armEvent.xDirection == TLMArmXDirectionTowardWrist ? @"Toward Wrist" : @"Toward Elbow";
    
}

- (void)didUnsyncArm:(NSNotification *)notification {
    // Reset the labels.
    NSLog(@"Arm UnSynched");
    
}

- (void)didReceiveOrientationEvent:(NSNotification *)notification {
    // Retrieve the orientation from the NSNotification's userInfo with the kTLMKeyOrientationEvent key.
    TLMOrientationEvent *orientationEvent = notification.userInfo[kTLMKeyOrientationEvent];
    
    // Create Euler angles from the quaternion of the orientation.
    TLMEulerAngles *angles = [TLMEulerAngles anglesWithQuaternion:orientationEvent.quaternion];
    
    // Next, we want to apply a rotation and perspective transformation based on the pitch, yaw, and roll.
    CATransform3D rotationAndPerspectiveTransform = CATransform3DConcat(CATransform3DConcat(CATransform3DRotate (CATransform3DIdentity, angles.pitch.radians, -1.0, 0.0, 0.0), CATransform3DRotate(CATransform3DIdentity, angles.yaw.radians, 0.0, 1.0, 0.0)), CATransform3DRotate(CATransform3DIdentity, angles.roll.radians, 0.0, 0.0, -1.0));
    
    // Apply the rotation and perspective transform to helloLabel.
    
//    
//    if(_excerciseName==EXtypePushUp){
//        if(maxPitch<angles.yaw.degrees && goingUP==1){
//            maxPitch=angles.yaw.degrees;
//            goingUP=0;
//            NSLog(@"Push Up");
//            minPitch=maxPitch-pushUpThreshold;
//            [self bounceAnimation:bigLabel andText:++skipCount];
//            [result.TotalValue setText:[NSString stringWithFormat:@"%d",skipCount]];
//            NSLog(@"minPitch %d  maxPitch %d",minPitch,maxPitch);
//            
//            
//            
//        }
//        else if(minPitch>angles.yaw.degrees && goingUP==0){
//            NSLog(@"Push Up");
//            minPitch=angles.yaw.degrees;
//            maxPitch=minPitch+pushUpThreshold;
//            NSLog(@"minPitch %d  maxPitch %d",minPitch,maxPitch);
//            goingUP=1;
//        }
//    }
//    
//    
//    else if(_excerciseName==ExTypeSkipping){
//            if(maxPitch<angles.pitch.degrees && goingUP==1){
//                maxPitch=angles.pitch.degrees;
//                goingUP=0;
//                NSLog(@"Skipping");
//                minPitch=maxPitch-skippingThreshold;
//                NSLog(@"minPitch %d  maxPitch %d",minPitch,maxPitch);
//                [result.TotalValue setText:[NSString stringWithFormat:@"%d",skipCount]];
//                [self bounceAnimation:bigLabel andText:++skipCount];
//            }
//            else if(minPitch>angles.pitch.degrees && goingUP==0){
//                NSLog(@"Skipping");
//                minPitch=angles.pitch.degrees;
//                maxPitch=minPitch+skippingThreshold;
//                NSLog(@"minPitch %d  maxPitch %d",minPitch,maxPitch);
//                goingUP=1;
//            }
//        
//    }
//
    
    
    int currentValue=0;
    if(_excerciseName==EXtypePushUp){
        currentValue=angles.roll.degrees;
        
        if(maxValue<currentValue && goingUP==1){
            maxValue=currentValue;}
        else if(maxValue>currentValue && goingUP==1){
            minValue=maxValue;goingUP=0;}
        else if (minValue>currentValue && goingUP==0){
            minValue=currentValue;}
        else if (minValue<currentValue && goingUP==0){
            if(maxValue-minValue>=40){
                NSLog(@"Threshold= %d",maxValue-minValue);
                [self bounceAnimation:bigLabel andText:++skipCount];
                [result.TotalValue setText:[NSString stringWithFormat:@"%d",skipCount]];
            }
            goingUP=1;
            maxValue=minValue;
            }

    }
    else if (_excerciseName==ExTypeSkipping){
        currentValue=angles.pitch.degrees;
        if(maxValue<currentValue && goingUP==1){
            maxValue=currentValue;}
        else if(maxValue>currentValue && goingUP==1){
            minValue=maxValue;goingUP=0;}
        else if (minValue>currentValue && goingUP==0){
            minValue=currentValue;}
        else if (minValue<currentValue && goingUP==0){
            if(maxValue-minValue>=skippingThreshold){
                NSLog(@"Threshold= %d",maxValue-minValue);
                [self bounceAnimation:bigLabel andText:++skipCount];
                [result.TotalValue setText:[NSString stringWithFormat:@"%d",skipCount]];
            }
            goingUP=1;
            maxValue=minValue;
        }
    }
    

    else if (_excerciseName==EXTypeDumbell){
        currentValue=angles.pitch.degrees;
        if(maxValue<currentValue && goingUP==1){
            maxValue=currentValue;}
        else if(maxValue>currentValue && goingUP==1){
            minValue=maxValue;goingUP=0;}
        else if (minValue>currentValue && goingUP==0){
            minValue=currentValue;}
        else if (minValue<currentValue && goingUP==0){
            if(maxValue-minValue>=skippingThreshold){
                NSLog(@"Threshold= %d",maxValue-minValue);
                [self bounceAnimation:bigLabel andText:++skipCount];
                [result.TotalValue setText:[NSString stringWithFormat:@"%d",skipCount]];
            }
            goingUP=1;
            maxValue=minValue;
        }
    }
    

    
    
    // NSLog(@"Pitch %f",angles.pitch.degrees);
    //NSLog(@"Yaw %f",angles.yaw.degrees);
    //    NSLog(@"Roll %f",angles.roll.degrees);
}
- (void)didReceiveEMG:(NSNotification *)notification {
    TLMEmgEvent *emg =notification.userInfo[kTLMKeyEMGEvent];
    NSLog(@"Count=%lu",(unsigned long)emg.rawData.count);
    if(!data2){
        data2=[[NSMutableArray alloc]init];
    }
    else if(data2.count>=500){
        [myGraph2 reloadGraph];
        data2=nil;
    }
    else{
        data2=(NSMutableArray *)[data2 arrayByAddingObjectsFromArray:emg.rawData];
    }
}

- (void)didReceiveAccelerometerEvent:(NSNotification *)notification {
    // Retrieve the accelerometer event from the NSNotification's userInfo with the kTLMKeyAccelerometerEvent.
    TLMAccelerometerEvent *accelerometerEvent = notification.userInfo[kTLMKeyAccelerometerEvent];
    
    // Get the acceleration vector from the accelerometer event.
    TLMVector3 accelerationVector = accelerometerEvent.vector;
    
    // Calculate the magnitude of the acceleration vector.
    float magnitude = TLMVector3Length(accelerationVector);
    
    // Update the progress bar based on the magnitude of the acceleration vector.
    
    
    /* Note you can also access the x, y, z values of the acceleration (in G's) like below
     float x = accelerationVector.x;
     float y = accelerationVector.y;
     float z = accelerationVector.z;
     */
}

- (void)didReceivePoseChange:(NSNotification *)notification {
    // Retrieve the pose from the NSNotification's userInfo with the kTLMKeyPose key.
    TLMPose *pose = notification.userInfo[kTLMKeyPose];
    
    // Handle the cases of the TLMPoseType enumeration, and change the color of helloLabel based on the pose we receive.
    switch (pose.type) {
        case TLMPoseTypeUnknown:
        case TLMPoseTypeRest:
        case TLMPoseTypeDoubleTap:
            NSLog(@"Hello Myo");
            break;
        case TLMPoseTypeFist:
            [self.navigationController popViewControllerAnimated:YES];
            NSLog(@"Fist");
            break;
        case TLMPoseTypeWaveIn:
            
            NSLog(@"Wave In");
            break;
        case TLMPoseTypeWaveOut:
            NSLog(@"Wave Out");
            break;
        case TLMPoseTypeFingersSpread:
            NSLog(@"Fingers Spread");
            break;
    }
    
    // Unlock the Myo whenever we receive a pose
    if (pose.type == TLMPoseTypeUnknown || pose.type == TLMPoseTypeRest) {
        // Causes the Myo to lock after a short period.
        [pose.myo unlockWithType:TLMUnlockTypeTimed];
    } else {
        // Keeps the Myo unlocked until specified.
        // This is required to keep Myo unlocked while holding a pose, but if a pose is not being held, use
        // TLMUnlockTypeTimed to restart the timer.
        [pose.myo unlockWithType:TLMUnlockTypeHold];
        // Indicates that a user action has been performed.
        [pose.myo indicateUserAction];
    }
}






-(void)bounceAnimation:(UILabel*) view andText:(int) count{
    [UIView animateWithDuration:0.3/1.5 animations:^{
        view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3/2 animations:^{
            view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
            [view setText:[NSString stringWithFormat:@"%d",count]];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3/2 animations:^{
                view.transform = CGAffineTransformIdentity;
            }];
        }];
    }];
}

#pragma mark Delegate Methods
- (NSInteger)numberOfPointsInLineGraph:(BEMSimpleLineGraphView *)graph {
    if(graph==myGraph)
        return data.count;
    return data2.count;
}

- (CGFloat)lineGraph:(BEMSimpleLineGraphView *)graph valueForPointAtIndex:(NSInteger)index {
    if(graph==myGraph){
        NSNumber *num=[data objectAtIndex:index];
        return [num floatValue];
    }
    
    return [[data2 objectAtIndex:index] floatValue];
    
}


- (NSString *)lineGraph:(nonnull BEMSimpleLineGraphView *)graph labelOnXAxisForIndex:(NSInteger)index{
    if(graph==myGraph)
        return [NSString stringWithFormat:@"%ld",index];
    return @"";
}


- (IBAction)didTapSettings:(id)sender {
    // Note that when the settings view controller is presented to the user, it must be in a UINavigationController.
    UINavigationController *controller = [TLMSettingsViewController settingsInNavigationController];
    [self presentViewController:controller animated:YES completion:nil];
}

- (CGFloat)baseValueForYAxisOnLineGraph:(BEMSimpleLineGraphView *)graph{
    if(graph==myGraph2)
        return -200;
    return 0.0;
}



@end
