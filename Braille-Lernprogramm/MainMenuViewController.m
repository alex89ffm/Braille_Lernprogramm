//
//  MainMenuViewController.m
//  Braille-Lernprogramm
//
//  Created by Alexander Eiselt on 08.05.13.
//  Copyright (c) 2013 Alexander Eiselt. All rights reserved.
//

#import "MainMenuViewController.h"
#import "Connector.h"
#import "VSViewController.h"
#import "KSMenuViewController.h"
#import "BrailleListViewController.h"

@interface MainMenuViewController ()

@end

@implementation MainMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[Connector shared]copyDatabaseIfNeeded];
    self.title = @"Braille Übungen";
    
    VSButton = [coloredButton buttonWithType:UIButtonTypeCustom];
    [VSButton setupWithColor:[UIColor whiteColor]];
    VSButton.frame = CGRectMake(110, 100, 100, 30);
    [VSButton setTitle:@"Vollschrift" forState:UIControlStateNormal];
    [VSButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    VSButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:14];
    [VSButton addTarget:self action:@selector(showVSViewController) forControlEvents:UIControlEventTouchUpInside];
    VSButton.accessibilityLabel = @"Vollschrift";
    
    KSButton = [coloredButton buttonWithType:UIButtonTypeSystem];
    [KSButton setupWithColor:[UIColor whiteColor]];
    KSButton.frame = CGRectMake(110, 140, 100, 30);
    [KSButton setTitle:@"Kurzschrift" forState:UIControlStateNormal];
    [KSButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    KSButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:14];
    [KSButton addTarget:self action:@selector(showKSViewController) forControlEvents:UIControlEventTouchUpInside];
    
    ListButton = [coloredButton buttonWithType:UIButtonTypeSystem];
    [ListButton setupWithColor:[UIColor whiteColor]];
    ListButton.frame = CGRectMake(110, 180, 100, 30);
    [ListButton setTitle:@"Listen" forState:UIControlStateNormal];
    [ListButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    ListButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:14];
    [ListButton addTarget:self action:@selector(showListViewController) forControlEvents:UIControlEventTouchUpInside];

    [self.view setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:VSButton];
    [self.view addSubview:KSButton];
    [self.view addSubview:ListButton];
}
-(void)showVSViewController
{
    VSViewController *VSVC = [[VSViewController alloc]initWithNibName:@"VSViewController" bundle:nil];
    [self.navigationController pushViewController:VSVC animated:YES];
}
-(void)showKSViewController
{
    KSMenuViewController *KSMVC = [[KSMenuViewController alloc]initWithNibName:@"KSMenuViewController" bundle:nil];
    [self.navigationController pushViewController:KSMVC animated:YES];
}
-(void)showListViewController
{
    BrailleListViewController *BLVC = [[BrailleListViewController alloc]initWithNibName:@"BrailleListViewController" bundle:nil];
    [self.navigationController pushViewController:BLVC animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
