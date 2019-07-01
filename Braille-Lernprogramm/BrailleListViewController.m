//
//  BrailleListViewController.m
//  Braille-Lernprogramm
//
//  Created by Alexander Eiselt on 09.05.13.
//  Copyright (c) 2013 Alexander Eiselt. All rights reserved.
//

#import "BrailleListViewController.h"
#import "VSListViewController.h"
#import "KSListMenuViewController.h"

@interface BrailleListViewController ()

@end

@implementation BrailleListViewController

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
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Zurück" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.title = @"Listen";
    ;
    VsButton = [coloredButton buttonWithType:UIButtonTypeRoundedRect];
    [VsButton setupWithColor:[UIColor whiteColor]];
    VsButton.frame = CGRectMake(110, 100, 100, 30);
    [VsButton setTitle:@"Vollschrift" forState:UIControlStateNormal];
    [VsButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    VsButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:14];
    [VsButton addTarget:self action:@selector(showVsListViewController) forControlEvents:UIControlEventTouchUpInside];

    KSButton = [coloredButton buttonWithType:UIButtonTypeRoundedRect];
    [KSButton setupWithColor:[UIColor whiteColor]];
    KSButton.frame = CGRectMake(110, 140, 100, 30);
    [KSButton setTitle:@"Kurzschrift" forState:UIControlStateNormal];
    [KSButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    KSButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:14];
    [KSButton addTarget:self action:@selector(showKSListViewController) forControlEvents:UIControlEventTouchUpInside];

    [self.view setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:VsButton];
    [self.view addSubview:KSButton];
    
}
-(void)showVsListViewController
{
    VSListViewController *VSLVC = [[VSListViewController alloc]initWithNibName:@"VSListViewController" bundle:nil];
    [self.navigationController pushViewController:VSLVC animated:YES];
}
-(void)showKSListViewController
{
    KSListMenuViewController *KSLMVC = [[KSListMenuViewController alloc]initWithNibName:@"KSListMenuViewController" bundle:nil];
    [self.navigationController pushViewController:KSLMVC animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
