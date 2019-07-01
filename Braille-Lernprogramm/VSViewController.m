//
//  VSViewController.m
//  Braille-Lernprogramm
//
//  Created by Alexander Eiselt on 08.05.13.
//  Copyright (c) 2013 Alexander Eiselt. All rights reserved.
//

#import "VSViewController.h"
#import "Connector.h"
#import "BrailleDot.h"

@interface VSViewController ()

@end

@implementation VSViewController

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSInteger offset = 0;
    if([self isIOS7])
         offset = 150;
    else
    {
        offset = 170;
    }
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25];
    CGRect rect = self.view.frame;
    rect.origin.y = 0-offset;
    self.view.frame = rect;
    [UIView commitAnimations];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25];
    CGRect rect = self.view.frame;
    if([self isIOS7])
        rect.origin.y = self.navigationController.navigationBar.frame.size.height+20;
    else
        rect.origin.y = 0;
    self.view.frame = rect;
    [UIView commitAnimations];
    [textField resignFirstResponder];
    [self check];
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25];
    CGRect rect = self.view.frame;
    if([self isIOS7])
        rect.origin.y = self.navigationController.navigationBar.frame.size.height+20;
    else
        rect.origin.y = 0;    self.view.frame = rect;
    [UIView commitAnimations];
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
    self.title = @"Vollschrift Übungen";
    
    NSArray *segmentArray = [[NSArray alloc]initWithObjects:@"SS in PS", @"PS in SS", nil];
    segControl = [[UISegmentedControl alloc]initWithItems:segmentArray];
    segControl.selectedSegmentIndex = 0;
    [segControl addTarget:self action:@selector(changeEditingMode) forControlEvents:UIControlEventValueChanged];
    
    //set Color:
    segControl.tintColor = [UIColor darkGrayColor];
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                [UIFont boldSystemFontOfSize:17], NSFontAttributeName,
                                [UIColor blackColor], NSForegroundColorAttributeName,
                                nil];
    [segControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
    NSDictionary *highlightedAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    [segControl setTitleTextAttributes:highlightedAttributes forState:UIControlStateHighlighted];
    
    editingMode = 0;
    int buttoncount = 0;
    for(UIView *theview in [segControl subviews])
    {
        switch (buttoncount) {
            case 0:
                
                theview.accessibilityLabel=@"Schwarzschrift in Punktschrift";
                break;
            case 1:
                theview.accessibilityLabel=@"Punktschrift in Schwarzschrift";
                break;
            default:
                break;
        }
        buttoncount++;
    }
    
    ssLabel = [[UILabel alloc]init];
    ssLabel.backgroundColor = [UIColor clearColor];
    ssLabel.font = [UIFont fontWithName:@"Arial" size:50];
    
    SSTextField = [[UITextField alloc]init];
    SSTextField.borderStyle = UITextBorderStyleRoundedRect;
    SSTextField.font = [UIFont fontWithName:@"Arial" size:50];
    SSTextField.textColor = [UIColor blackColor];
    SSTextField.delegate = self;
    SSTextField.returnKeyType = UIReturnKeyDone;
    SSTextField.accessibilityLabel = @"Schwarzschrift";
    SSTextField.hidden = YES;
    
    checkBUtton = [coloredButton buttonWithType:UIButtonTypeRoundedRect];
    [checkBUtton setupWithColor:[UIColor whiteColor]];
    [checkBUtton setTitle:@"überprüfen" forState:UIControlStateNormal];
    [checkBUtton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    checkBUtton.titleLabel.font = [UIFont fontWithName:@"Arial" size:14];
    [checkBUtton addTarget:self action:@selector(check) forControlEvents:UIControlEventTouchUpInside];
    
    NextCharacterButton = [coloredButton buttonWithType:UIButtonTypeRoundedRect];
    [NextCharacterButton setupWithColor:[UIColor whiteColor]];
    [NextCharacterButton setTitle:@"nächstes" forState:UIControlStateNormal];
    [NextCharacterButton setAccessibilityLabel:@"nächstes Zeichen"];
    [NextCharacterButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    NextCharacterButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:14];
    [NextCharacterButton addTarget:self action:@selector(getNewCharacter) forControlEvents:UIControlEventTouchUpInside];
    
    loesungButton = [coloredButton buttonWithType:UIButtonTypeRoundedRect];
    [loesungButton setupWithColor:[UIColor whiteColor]];
    [loesungButton setTitle:@"Lösung" forState:UIControlStateNormal];
    [loesungButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    loesungButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:14];
    [loesungButton addTarget:self action:@selector(getLoesung) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:segControl];
    [self.view addSubview:ssLabel];
    [self.view addSubview:SSTextField];
    [self.view addSubview:checkBUtton];
    [self.view addSubview:loesungButton];
    [self.view addSubview:NextCharacterButton];
}
-(BOOL)isIOS7
{
    float osVersion = [[[UIDevice currentDevice]systemVersion]floatValue];
    
    if(osVersion >= 7.0)
        return YES;
    else
        return NO;
}
-(void)viewWillAppear:(BOOL)animated
{
    self.edgesForExtendedLayout = UIRectEdgeNone;
    NSLog(@"%f", self.view.frame.origin.y);
    segControl.frame = CGRectMake(0, 0, 320, 50);
    [self getNewCharacter];
    ssLabel.text = searchedCharacter.character;
    ssLabel.frame  = CGRectMake(10, myCharacter.frame.origin.y + myCharacter.frame.size.height, 320, 100);
    SSTextField.frame = CGRectMake(10, myCharacter.frame.origin.y + myCharacter.frame.size.height, 320, 100);
    checkBUtton.frame = CGRectMake(10, ssLabel.frame.origin.y + ssLabel.frame.size.height+10, 100, 30);
    NextCharacterButton.frame = CGRectMake(110, ssLabel.frame.origin.y + ssLabel.frame.size.height+10, 100, 30);
    loesungButton.frame = CGRectMake(210, ssLabel.frame.origin.y + ssLabel.frame.size.height+10, 100, 30);
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches]anyObject];
    CGPoint Location = [touch locationInView:self.view];
    if(CGRectContainsPoint(self.view.frame, Location))
    {
        [SSTextField resignFirstResponder];
    }
}
-(void)getNewCharacter
{
    [SSTextField resignFirstResponder];
    if(editingMode == 0)
    {
        [myCharacter removeFromSuperview];
        myCharacter = [[Connector shared]getCharacterwithID:0 andFrame:CGRectMake(0, segControl.frame.origin.y + segControl.frame.size.height, 128, 192) reading:NO];
        [myCharacter updateCharacter];
        searchedCharacter = [[Connector shared]getrandomcharacterwithframe:CGRectMake(0, 0, 0, 0) reading:NO];
        if(ssLabel)
        {
            ssLabel.text = searchedCharacter.character;
            ssLabel.accessibilityLabel = searchedCharacter.VOString;
        }
        [self.view addSubview:myCharacter];
    }
    else
    {
        searchedCharacter = [[Connector shared]getrandomcharacterwithframe:CGRectMake(0, 0,0,0) reading:YES];
        SSTextField.text = @"";
        [myCharacter removeFromSuperview];
        myCharacter = [[Connector shared]getCharacterwithID:searchedCharacter.theID andFrame:CGRectMake(0, segControl.frame.origin.y + segControl.frame.size.height, 128, 194) reading:YES];
        [myCharacter updateCharacter];
        [self.view addSubview:myCharacter];
    }
}
-(void)changeEditingMode
{
    SSTextField.text = @"";
    ssLabel.text = @"";
    if(segControl.selectedSegmentIndex == 0)
    {
        editingMode = 0;
        ssLabel.hidden = NO;
        SSTextField.hidden = YES;
        [myCharacter removeFromSuperview];
        myCharacter = [[Connector shared]getCharacterwithID:0 andFrame:CGRectMake(0, segControl.frame.size.height, 128, 192) reading:NO];
        [self.view addSubview:myCharacter];
    }
    else if(segControl.selectedSegmentIndex == 1)
    {
        editingMode = 1;
        ssLabel.hidden = YES;
        SSTextField.hidden = NO;
    }
    [self getNewCharacter];
}
-(void)check
{
    [SSTextField resignFirstResponder];
    if(editingMode == 0)
    {
        if([[Connector shared]getIDfromBrailleCHaracter:myCharacter] == searchedCharacter.theID)
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Glückwunsch" message:@"Das ist Richtig" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [self getNewCharacter];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Schade!" message:@"Das ist leider falsch" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    else
    {
        if([SSTextField.text caseInsensitiveCompare:searchedCharacter.character] == NSOrderedSame)
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Glückwunsch" message:@"Das ist Richtig" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [self getNewCharacter];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Schade!" message:@"Das ist leider falsch" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
}
-(void)getLoesung
{
    [SSTextField resignFirstResponder];
    if(editingMode == 0)
    {
        [myCharacter removeFromSuperview];
        myCharacter = [[Connector shared]getCharacterwithID:searchedCharacter.theID andFrame:CGRectMake(0, segControl.frame.origin.y + segControl.frame.size.height, 128, 192) reading:YES];
        [myCharacter updateCharacter];
        [self.view addSubview:myCharacter];
    }
    else
    {
        NSString *Loesung = [NSString stringWithFormat:@"Die Lösung ist: %@", searchedCharacter.VOString];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Schade!" message:Loesung delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
