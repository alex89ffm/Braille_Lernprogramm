//
//  KSListViewController.m
//  Braille-Lernprogramm
//
//  Created by Alexander Eiselt on 09.05.13.
//  Copyright (c) 2013 Alexander Eiselt. All rights reserved.
//

#import "KSListViewController.h"
#import "Connector.h"

@interface KSListViewController ()

@end

@implementation KSListViewController

-(id)initWithType:(int)type
{
    if(self = [super init])
    {
        theType = type;
    }
    return self;
}
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
    if(theType != 4 && theType != 5)
    {
        self.title = [NSString stringWithFormat:@"Liste %@en", [[Connector shared]getTypeWithID:theType]];
    }
    else
    {
        self.title = [NSString stringWithFormat:@"Liste %@e", [[Connector shared]getTypeWithID:theType]];
    }
    max = [[Connector shared]getCountFortype:theType];
    actualrow = -1;
    
    [self getNext];
    
    SSLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, character1.frame.origin.y + character1.frame.size.height, 320, 100)];
    SSLabel.text = ksCharacter.Name;
    SSLabel.backgroundColor = [UIColor clearColor];
    SSLabel.textColor = [UIColor blackColor];
    SSLabel.font = [UIFont fontWithName:@"Arial" size:50];
    
    prevButton = [coloredButton buttonWithType:UIButtonTypeRoundedRect];
    [prevButton setupWithColor:[UIColor whiteColor]];
    [prevButton setFrame:CGRectMake(10, SSLabel.frame.origin.y+SSLabel.frame.size.height, 150, 30)];
    [prevButton setTitle:@"vorige Kürzung" forState:UIControlStateNormal];
    [prevButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    prevButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:14];
    [prevButton addTarget:self action:@selector(getPrev) forControlEvents:UIControlEventTouchUpInside];
    
    nextButton = [coloredButton buttonWithType:UIButtonTypeRoundedRect];
    [nextButton setupWithColor:[UIColor whiteColor]];
    [nextButton setFrame:CGRectMake(160, SSLabel.frame.origin.y+SSLabel.frame.size.height, 150, 30)];
    [nextButton setTitle:@"Nächste Kürzung" forState:UIControlStateNormal];
    [nextButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    nextButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:14];
    [nextButton addTarget:self action:@selector(getNext) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:SSLabel];
    [self.view addSubview:prevButton];
    [self.view addSubview:nextButton];
}
-(void)getNext
{
    if(actualrow+1 > max || actualrow < 0)
    {
        actualrow = 0;
    }
    else
    {
        actualrow++;
    }
    ksCharacter = [[Connector shared]GetKuerzungAtRow:actualrow WithType:theType];
    [character1 removeFromSuperview];
    [character2 removeFromSuperview];
    character1 = [[Connector shared]getCharacterwithID:ksCharacter.firstID andFrame:CGRectMake(0, 10, 128, 192) reading:YES];
    character2 = [[Connector shared]getCharacterwithID:ksCharacter.secondID andFrame:CGRectMake(128, 10, 128, 192) reading:YES];
    if(theType == 3 || theType == 6)
    {
        character1.isPartOfZweiformig = YES;
        character2.isPartOfZweiformig = YES;
        [character1 updateCharacter];
        [character2 updateCharacter];

    }
    else
    {
        [character1 updateCharacter];
        character2.hidden = YES;
    }
    SSLabel.text = ksCharacter.Name;
    if(theType == 1)
    {
        SSLabel.text = [[Connector shared] SpacedStringWithString:SSLabel.text];
    }
    [self.view addSubview:character1];
    [self.view addSubview:character2];
}
-(void)getPrev
{
    if(actualrow-1 < 0 || actualrow > max)
    {
        actualrow = max;
    }
    else
    {
        actualrow--;
    }
    ksCharacter = [[Connector shared]GetKuerzungAtRow:actualrow WithType:theType];
    [character1 removeFromSuperview];
    [character2 removeFromSuperview];
    character1 = [[Connector shared]getCharacterwithID:ksCharacter.firstID andFrame:CGRectMake(0, 10, 128, 192) reading:YES];
    character2 = [[Connector shared]getCharacterwithID:ksCharacter.secondID andFrame:CGRectMake(128, 10, 128, 192) reading:YES];
    if(theType == 3 || theType == 6)
    {
        character1.isPartOfZweiformig = YES;
        character2.isPartOfZweiformig = YES;
        [character1 updateCharacter];
        [character2 updateCharacter];

    }
    else
    {
        [character1 updateCharacter];
        character2.hidden = YES;
    }
    SSLabel.text = ksCharacter.Name;
    if(theType == 1)
    {
        SSLabel.text = [[Connector shared] SpacedStringWithString:SSLabel.text];
    }
    [self.view addSubview:character1];
    [self.view addSubview:character2];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
