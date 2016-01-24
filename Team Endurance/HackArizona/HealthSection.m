//
//  HealthSection.m
//  HackArizona
//
//  Created by Pravin on 1/23/16.
//  Copyright © 2016 MC. All rights reserved.
//

#import "HealthSection.h"
#import "Excercise.h"
#define labelHeight 80.0
static int maxPitch=0;
static int minPitch=0;
static int goingUP=0;
static int skipCount=0;
static int threshold=30;


@interface HealthSection ()
{
    GCDAsyncUdpSocket *udpSocket;
    UILabel *lblCount;
    IBOutlet UITableView *table;
    NSMutableArray *tbl_Data;
    int selIndex;
    IBOutlet UILabel *lock;
}
@end

@implementation HealthSection


- (void)viewDidLoad {
    [super viewDidLoad];
    selIndex=0;
    [self.view setBackgroundColor:[UIColor FlatLight]];
    table.backgroundColor=[UIColor FlatLight];
    [self setUpNavigationController];
    [lock setFont:[UIFont fontWithName:@"FontAwesome" size:30]];
    [lock setText:[NSString fontAwesomeIconStringForEnum:FALock]];
    tbl_Data=[[NSMutableArray alloc] initWithObjects:@"Push Ups",@"Skipping",@"Dumbell",@"Squats",@"Pull ups", nil];
}
-(void)viewWillAppear:(BOOL)animated{
    [self hearNorification];
}

-(void)setUpNavigationController{
    [[CommonUtils sharedInstance] SetUpNavControllerWithid:self andTitle:@"Endurance"];
    CGRect frameimg1 = CGRectMake(0, 0,30, 30);
    UIButton *settings=[[UIButton alloc]initWithFrame:frameimg1];
    [settings.titleLabel setFont:[UIFont fontWithName:@"FontAwesome" size:26]];
    [settings setTitle:[NSString fontAwesomeIconStringForEnum:FACog] forState:UIControlStateNormal];
    [settings addTarget:self action:@selector(didTapSettings:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButton2=[[UIBarButtonItem alloc]initWithCustomView:settings];
    self.navigationItem.rightBarButtonItem=barButton2;
    
//    UIButton *signOut=[[UIButton alloc]initWithFrame:frameimg1];
//    [signOut.titleLabel setFont:[UIFont fontWithName:@"FontAwesome" size:26]];
//    [signOut setTitle:[NSString fontAwesomeIconStringForEnum:FAPencilSquareO] forState:UIControlStateNormal];
//    [signOut addTarget:self action:@selector(sendSocketInformation) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *barButton=[[UIBarButtonItem alloc]initWithCustomView:signOut];
//    self.navigationItem.rightBarButtonItem=barButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didTapSettings:(id)sender {
    // Note that when the settings view controller is presented to the user, it must be in a UINavigationController.
    UINavigationController *controller = [TLMSettingsViewController settingsInNavigationController];
    // Present the settings view controller modally.
    [self presentViewController:controller animated:YES completion:nil];
}







#pragma mark TableView Delegates

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        UIStoryboard *story =[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        Excercise *health=[story instantiateViewControllerWithIdentifier:@"ExcerciseID"];
        health.previouslock=lock.text;
    switch (indexPath.row) {
        case 0:
            health.excerciseName=EXtypePushUp;
            break;
        case 1:
            health.excerciseName=ExTypeSkipping;
            break;
        case 2:
            health.excerciseName=EXTypeDumbell;
            break;
        case 3:
            health.excerciseName=EXTypeSquats;
            break;
        case 4:
            health.excerciseName=EXTypePullUps;
            break;
        default:
            break;
    }
        [self.navigationController pushViewController:health animated:YES];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"CellID"];
    if(cell==nil){
        cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellID"];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    [cell setBackgroundColor:[UIColor FlatLight]];
    cell.textLabel.textColor=[UIColor textColor];
    cell.textLabel.text=[tbl_Data objectAtIndex:indexPath.row];
    cell.textLabel.textAlignment=NSTextAlignmentCenter;
    cell.textLabel.font=[UIFont systemFontOfSize:38.0f weight:UIFontWeightThin];
    
    [cell layoutIfNeeded];
    
    UIView *screenview=[cell viewWithTag:100];
    if(!screenview){
        screenview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 120)];
        screenview.tag=100;
        [screenview setBackgroundColor:[UIColor blackColor]];
        [screenview setAlpha:0.3];
        [cell addSubview:screenview];
    }
    
    
    UILabel *lbl=[[UILabel alloc] initWithFrame:CGRectMake(220, 80, self.view.frame.size.width-220, 40)];
    lbl.textAlignment=NSTextAlignmentRight;
    lbl.font=[UIFont italicSystemFontOfSize:15.0f];
    [lbl setTextColor:[UIColor whiteColor]];
    
    UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(8, 40, 60, 60)];
    [cell addSubview:imageView];

    if(indexPath.row==0){
        [lbl setText:@"Personal Best: 35"];
        [imageView setImage:[UIImage imageNamed:@"Pushups.png"]];
    }
    else if(indexPath.row==1){
        [lbl setText:@"Calories Burned:245"];
        [imageView setImage:[UIImage imageNamed:@"skip.png"]];
    }
    else if (indexPath.row==2){
        [lbl setText:@"35Lbs last Thursday"];
        [imageView setImage:[UIImage imageNamed:@"Dumbbells.png"]];
    }
    else if(indexPath.row==3){
        [lbl setText:@"2 Sets Remaining"];
        [imageView setImage:[UIImage imageNamed:@"Squats.png"]];
    }
    else if(indexPath.row==4){
        [lbl setText:@"Yet to start"];
        [lbl setTextColor:[UIColor FlatDark]];
        [imageView setImage:[UIImage imageNamed:@"Pullups.png"]];
    }
    
    [cell addSubview:lbl];

    
    
    if(indexPath.row!=selIndex){
        [screenview setHidden:false];
    }
    else{
        [screenview setHidden:true];
    }
    return cell;
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return tbl_Data.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}










#pragma mark - NSNotificationCenter Methods

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
    TLMUnlockEvent *myounlockEvent = notification.userInfo[kTLMKeyUnlockEvent];
    [myounlockEvent.myo setStreamEmg:TLMStreamEmgEnabled];
    [lock setText:[NSString fontAwesomeIconStringForEnum:FAUnlock]];
    NSLog(@"Myo Unlocked");
}

- (void)didLockDevice:(NSNotification *)notification {
    // Update the label to reflect Myo's lock state.
    [lock setText:[NSString fontAwesomeIconStringForEnum:FALock]];
    NSLog(@"Myo Locked");
}

- (void)didSyncArm:(NSNotification *)notification {
    // Retrieve the arm event from the notification's userInfo with the kTLMKeyArmSyncEvent key.
    NSLog(@"Arm Synched");
    TLMArmSyncEvent *armEvent = notification.userInfo[kTLMKeyArmSyncEvent];
    
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
    
    
    
    if(maxPitch<angles.pitch.degrees && goingUP==1){
        maxPitch=angles.pitch.degrees;
        goingUP=0;
        minPitch=maxPitch-threshold;
        NSLog(@"minPitch %d \n maxPitch %d",minPitch,maxPitch);
        [lblCount setText:[NSString stringWithFormat:@"%d",skipCount++]];
    }
    else if(minPitch>angles.pitch.degrees && goingUP==0){
        minPitch=angles.pitch.degrees;
        maxPitch=minPitch+threshold;
        NSLog(@"minPitch %d \n maxPitch %d",minPitch,maxPitch);
        goingUP=1;
    }
    
    //    if(maxPitch<angles.yaw.degrees && goingUP==1){
    //        maxPitch=angles.yaw.degrees;
    //        goingUP=0;
    //        minPitch=maxPitch-threshold;
    //        NSLog(@"minPitch %d \n maxPitch %d",minPitch,maxPitch);
    //        [lblCount setText:[NSString stringWithFormat:@"%d",skipCount++]];
    //    }
    //    else if(minPitch>angles.yaw.degrees && goingUP==0){
    //        minPitch=angles.yaw.degrees;
    //        maxPitch=minPitch-threshold;
    //        NSLog(@"minPitch %d \n maxPitch %d",minPitch,maxPitch);
    //        goingUP=1;
    //    }
    //
    
    
    // NSLog(@"Pitch %f",angles.pitch.degrees);
    //NSLog(@"Yaw %f",angles.yaw.degrees);
    //    NSLog(@"Roll %f",angles.roll.degrees);
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
            {
                NSLog(@"Fist");
                UIStoryboard *story =[UIStoryboard storyboardWithName:@"Main" bundle:nil];
                Excercise *health=[story instantiateViewControllerWithIdentifier:@"ExcerciseID"];
                health.previouslock=lock.text;
                switch (selIndex) {
                    case 0:
                        health.excerciseName=EXtypePushUp;
                        break;
                    case 1:
                        health.excerciseName=ExTypeSkipping;
                        break;
                    case 2:
                        health.excerciseName=EXTypeDumbell;
                        break;
                    case 3:
                        health.excerciseName=EXTypeSquats;
                        break;
                    case 4:
                        health.excerciseName=EXTypePullUps;
                        break;
                    default:
                        break;
                }
                [self.navigationController pushViewController:health animated:YES];
            }
            break;
        case TLMPoseTypeWaveIn:
            {
                if(selIndex==4)
                        selIndex=0;
                else{
                    selIndex=selIndex+1;
                }
                [table reloadData];
                NSLog(@"Wave In");
            }

            break;
        case TLMPoseTypeWaveOut:
        {
                if(selIndex==0)
                    selIndex=4;
                else{
                    selIndex=selIndex-1;
                }
                [table reloadData];
                NSLog(@"Wave Out");
        }
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

-(void)sendSocketInformation{
    udpSocket = [[GCDAsyncUdpSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    NSData *data = [[NSString stringWithFormat:@"Janakayanamaha!!"] dataUsingEncoding:NSUTF8StringEncoding];
    [udpSocket sendData:data toHost:@"10.135.242.137" port:666 withTimeout:-1 tag:1];

}



- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
