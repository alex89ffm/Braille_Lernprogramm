//
//  KSMenuViewController.m
//  Braille-Lernprogramm
//
//  Created by Alexander Eiselt on 09.05.13.
//  Copyright (c) 2013 Alexander Eiselt. All rights reserved.
//

#import "KSMenuViewController.h"
#import "KSViewController.h"

@interface KSMenuViewController ()

@end

@implementation KSMenuViewController

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
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"Kurzschrift Übungen";
    
    lautgruppeButton = [coloredButton buttonWithType:UIButtonTypeRoundedRect];
    [lautgruppeButton setupWithColor:[UIColor whiteColor]];
    lautgruppeButton.frame = CGRectMake(10, 30, 250, 30);
    [lautgruppeButton setTitle:@"Lautgruppenkürzungen" forState:UIControlStateNormal];
    [lautgruppeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    lautgruppeButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:14];
    [lautgruppeButton addTarget:self action:@selector(showKsViewController:) forControlEvents:UIControlEventTouchUpInside];
    [lautgruppeButton setTag:1];
    
    einformigeButton = [coloredButton buttonWithType:UIButtonTypeRoundedRect];
    [einformigeButton setupWithColor:[UIColor whiteColor]];
    einformigeButton.frame = CGRectMake(10, 70, 250, 30);
    [einformigeButton setTitle:@"einformige Kürzungen" forState:UIControlStateNormal];
    [einformigeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    einformigeButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:14];
    [einformigeButton addTarget:self action:@selector(showKsViewController:) forControlEvents:UIControlEventTouchUpInside];
    [einformigeButton setTag:2];
    
    zweiformigeButton = [coloredButton buttonWithType:UIButtonTypeRoundedRect];
    [zweiformigeButton setupWithColor:[UIColor whiteColor]];
    zweiformigeButton.frame = CGRectMake(10, 110, 250, 30);
    [zweiformigeButton setTitle:@"zweiformige Kürzungen" forState:UIControlStateNormal];
    [zweiformigeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    zweiformigeButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:14];
    [zweiformigeButton addTarget:self action:@selector(showKsViewController:) forControlEvents:UIControlEventTouchUpInside];
    [zweiformigeButton setTag:3];
    
    vorsilbeButton = [coloredButton buttonWithType:UIButtonTypeRoundedRect];
    [vorsilbeButton setupWithColor:[UIColor whiteColor]];
    vorsilbeButton.frame = CGRectMake(10, 190, 250, 30);
    [vorsilbeButton setTitle:@"Vorsilben" forState:UIControlStateNormal];
    [vorsilbeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    vorsilbeButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:14];
    [vorsilbeButton addTarget:self action:@selector(showKsViewController:) forControlEvents:UIControlEventTouchUpInside];
    [vorsilbeButton setTag:4];
    
    nachsilbeButton = [coloredButton buttonWithType:UIButtonTypeRoundedRect];
    [nachsilbeButton setupWithColor:[UIColor whiteColor]];
    nachsilbeButton.frame = CGRectMake(10, 230, 250, 30);
    [nachsilbeButton setTitle:@"Nachsilben" forState:UIControlStateNormal];
    [nachsilbeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    nachsilbeButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:14];
    [nachsilbeButton addTarget:self action:@selector(showKsViewController:) forControlEvents:UIControlEventTouchUpInside];
    [nachsilbeButton setTag:5];
    
    KommaBUtton = [coloredButton buttonWithType:UIButtonTypeRoundedRect];
    [KommaBUtton setupWithColor:[UIColor whiteColor]];
    KommaBUtton.frame = CGRectMake(10, 150, 250, 30);
    [KommaBUtton setTitle:@"Kommakürzungen" forState:UIControlStateNormal];
    [KommaBUtton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    KommaBUtton.titleLabel.font = [UIFont fontWithName:@"Arial" size:14];
    [KommaBUtton addTarget:self action:@selector(showKsViewController:) forControlEvents:UIControlEventTouchUpInside];
    [KommaBUtton setTag:6];

    [self.view setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:lautgruppeButton];
    [self.view addSubview:einformigeButton];
    [self.view addSubview:zweiformigeButton];
    [self.view addSubview:KommaBUtton];
    [self.view addSubview:vorsilbeButton];
    [self.view addSubview:nachsilbeButton];

}

-(void)showKsViewController:(UIButton *)theButton
{
    KSViewController *KSVC = [[KSViewController alloc]initWithType:theButton.tag];
    [self.navigationController pushViewController:KSVC animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
