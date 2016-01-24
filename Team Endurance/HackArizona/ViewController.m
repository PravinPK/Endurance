//
//  ViewController.m
//  HackArizona
//
//  Created by Pravin on 1/23/16.
//  Copyright © 2016 MC. All rights reserved.
//


#import "ViewController.h"
#import "HealthSection.h"
@interface ViewController ()
{
    GCDAsyncUdpSocket *udpSocket;
    UILabel *lblCount;
    NSMutableArray *tbl_Data;
    IBOutlet UITableView *table;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor clearColor]];
    table.backgroundColor=[UIColor clearColor];
    


    [self setUpNavigationController];

    [self.view layoutIfNeeded];
    
    UIImageView *imageView=[[UIImageView alloc] initWithFrame:self.view.frame];
    [imageView setImage:[UIImage imageNamed:@"QP7WI19WFG.jpg"]];
    [imageView setContentMode:UIViewContentModeScaleAspectFill];
    [self.view addSubview:imageView];
    
    
    
    int mainHeight=self.view.frame.size.height;
    int mainWidth=self.view.frame.size.width;
    tbl_Data=[[NSMutableArray alloc]initWithObjects:@"Fitness", nil];
    table.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view bringSubviewToFront:table];



}

-(void)setUpNavigationController{
    [[CommonUtils sharedInstance] SetUpNavControllerWithid:self andTitle:@"Endurance"];
    CGRect frameimg1 = CGRectMake(0, 0,30, 30);
    UIButton *settings=[[UIButton alloc]initWithFrame:frameimg1];
    [settings.titleLabel setFont:[UIFont fontWithName:@"FontAwesome" size:26]];
    [settings setTitle:[NSString fontAwesomeIconStringForEnum:FACog] forState:UIControlStateNormal];
    [settings addTarget:self action:@selector(didTapSettings:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButton2=[[UIBarButtonItem alloc]initWithCustomView:settings];
    self.navigationItem.leftBarButtonItem=barButton2;

}

- (IBAction)didTapSettings:(id)sender {
    // Note that when the settings view controller is presented to the user, it must be in a UINavigationController.
    UINavigationController *controller = [TLMSettingsViewController settingsInNavigationController];
    // Present the settings view controller modally.
    [self presentViewController:controller animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==0){
        UIStoryboard *story =[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        HealthSection *health=[story instantiateViewControllerWithIdentifier:@"HealthSectionID"];
        [self.navigationController pushViewController:health animated:YES];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"CellID"];
    if(cell==nil){
        cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellID"];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    [cell setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.3]];
    cell.textLabel.textColor=[UIColor textColor];
    cell.textLabel.text=[tbl_Data objectAtIndex:indexPath.row];
    cell.textLabel.textAlignment=NSTextAlignmentCenter;
    cell.textLabel.font=[UIFont systemFontOfSize:38.0f weight:UIFontWeightThin];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return tbl_Data.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}
@end

