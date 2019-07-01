//
//  VSListViewController.m
//  Braille-Lernprogramm
//
//  Created by Alexander Eiselt on 09.05.13.
//  Copyright (c) 2013 Alexander Eiselt. All rights reserved.
//

#import "VSListViewController.h"
#import "Connector.h"

@interface VSListViewController ()

@end

@implementation VSListViewController

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

}
-(void)viewWillAppear:(BOOL)animated
{
    self.edgesForExtendedLayout = UIRectEdgeNone;
    NSLog(@"%f", self.view.frame.size.height);
    self.title = @"Liste Vollschrift";
    actualrow = -1;
    
    [self getNextCharacter];
    
    SSLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, theCharacter.frame.origin.y +  theCharacter.frame.size.height, 320, 100)];
    SSLabel.text = theCharacter.character;
    SSLabel.backgroundColor = [UIColor clearColor];
    SSLabel.textColor = [UIColor blackColor];
    SSLabel.font = [UIFont fontWithName:@"Arial" size:50];
    
    prevButton = [coloredButton buttonWithType:UIButtonTypeRoundedRect];
    [prevButton setupWithColor:[UIColor whiteColor]];
    [prevButton setFrame:CGRectMake(10, SSLabel.frame.origin.y+SSLabel.frame.size.height, 150, 30)];
    [prevButton setTitle:@"voriges Zeichen" forState:UIControlStateNormal];
    [prevButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    prevButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:14];
    [prevButton addTarget:self action:@selector(getPreviousCharacter) forControlEvents:UIControlEventTouchUpInside];
    
    nextButton = [coloredButton buttonWithType:UIButtonTypeRoundedRect];
    [nextButton setupWithColor:[UIColor whiteColor]];
    [nextButton setFrame:CGRectMake(160, SSLabel.frame.origin.y+SSLabel.frame.size.height, 150, 30)];
    [nextButton setTitle:@"Nächstes Zeichen" forState:UIControlStateNormal];
    [nextButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    nextButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:14];
    [nextButton addTarget:self action:@selector(getNextCharacter) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:SSLabel];
    [self.view addSubview:prevButton];
    [self.view addSubview:nextButton];
}
-(void)getNextCharacter
{
    if(actualrow+1 > 64 || actualrow < 1)
    {
        actualrow = 1;
    }
    else
    {
        actualrow++;
    }
    [theCharacter removeFromSuperview];
    theCharacter = [[Connector shared]getCharacterwithID:actualrow andFrame:CGRectMake(0, 10, 128, 192) reading:YES];
    [theCharacter updateCharacter];
    SSLabel.text = theCharacter.character;
    SSLabel.accessibilityLabel = theCharacter.VOString;
    [self.view addSubview:theCharacter];
}
-(void)getPreviousCharacter
{
    if(actualrow-1 < 1 || actualrow > 64)
    {
        actualrow = 64;
    }
    else
    {
        actualrow--;
    }
    [theCharacter removeFromSuperview];
    theCharacter = [[Connector shared]getCharacterwithID:actualrow andFrame:CGRectMake(0, 10, 128, 192) reading:YES];
    [theCharacter updateCharacter];
    SSLabel.text = theCharacter.character;
    SSLabel.accessibilityLabel = theCharacter.VOString;
    [self.view addSubview:theCharacter];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
