//
//  KSViewController.m
//  Braille-Lernprogramm
//
//  Created by Alexander Eiselt on 09.05.13.
//  Copyright (c) 2013 Alexander Eiselt. All rights reserved.
//

#import "KSViewController.h"
#import "Connector.h"

@interface KSViewController ()

@end

@implementation KSViewController

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

-(id)initWithType:(int)type
{
    if(self == [super init])
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
    
    if(theType != 4 && theType != 5)
    {
        self.title = [NSString stringWithFormat:@"%@en", [[Connector shared]getTypeWithID:theType]];
    }
    else
    {
        self.title = [NSString stringWithFormat:@"%@e", [[Connector shared]getTypeWithID:theType]];
    }
    NSArray *segmentArray = [[NSArray alloc]initWithObjects:@"SS in PS", @"PS in SS", nil];
    segControl = [[UISegmentedControl alloc]initWithItems:segmentArray];
    segControl.selectedSegmentIndex = 0;
    [segControl addTarget:self action:@selector(changeEditingMode) forControlEvents:UIControlEventValueChanged];
    
    //set Color
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
    SSTextField = [[UITextField alloc]init];
    checkButton = [coloredButton buttonWithType:UIButtonTypeRoundedRect];
    [checkButton setupWithColor:[UIColor whiteColor]];
    NextCharacterButton = [coloredButton buttonWithType:UIButtonTypeRoundedRect];
    [NextCharacterButton setupWithColor:[UIColor whiteColor]];
    loesungButton = [coloredButton buttonWithType:UIButtonTypeRoundedRect];
    [loesungButton setupWithColor:[UIColor whiteColor]];
    
    [self getNewCharacter];
    
    ssLabel.backgroundColor = [UIColor clearColor];
    ssLabel.font = [UIFont fontWithName:@"Arial" size:50];
    
    SSTextField.borderStyle = UITextBorderStyleRoundedRect;
    SSTextField.font = [UIFont fontWithName:@"Arial" size:50];
    SSTextField.textColor = [UIColor blackColor];
    SSTextField.delegate = self;
    SSTextField.returnKeyType = UIReturnKeyDone;
    SSTextField.accessibilityLabel = @"Schwarzschrift";
    SSTextField.hidden = YES;
    
    [checkButton setTitle:@"überprüfen" forState:UIControlStateNormal];
    [checkButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    checkButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:14];
    [checkButton addTarget:self action:@selector(check) forControlEvents:UIControlEventTouchUpInside];
    
    [NextCharacterButton setTitle:@"nächste" forState:UIControlStateNormal];
    [NextCharacterButton setAccessibilityLabel:@"nächste Kürzung"];
        [NextCharacterButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    NextCharacterButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:14];
    [NextCharacterButton addTarget:self action:@selector(getNewCharacter) forControlEvents:UIControlEventTouchUpInside];
    
    [loesungButton setTitle:@"Lösung" forState:UIControlStateNormal];
    [loesungButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    loesungButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:14];
    [loesungButton addTarget:self action:@selector(getLoesung) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view setBackgroundColor:[UIColor grayColor]];
    [self.view setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:segControl];
    [self.view addSubview:ssLabel];
    [self.view addSubview:SSTextField];
    [self.view addSubview:checkButton];
    [self.view addSubview:NextCharacterButton];
    [self.view addSubview:loesungButton];
}
-(BOOL)isIOS7
{
    NSString *version = [[UIDevice currentDevice]systemVersion];
    
    if ([version floatValue] >= 7.0) {
        return YES;
    }
    else
    {
        return NO;
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    self.edgesForExtendedLayout = UIRectEdgeNone;
    segControl.frame = CGRectMake(0, 0, 320, 50);
    [self getNewCharacter];
    ssLabel.text = searchedCharacter.Name;
    ssLabel.frame  = CGRectMake(10, character1.frame.origin.y + character1.frame.size.height, 320, 100);
    SSTextField.frame = CGRectMake(10, character1.frame.origin.y + character1.frame.size.height, 320, 100);
    checkButton.frame = CGRectMake(10, ssLabel.frame.origin.y + ssLabel.frame.size.height, 100, 30);
    NextCharacterButton.frame = CGRectMake(110, ssLabel.frame.origin.y + ssLabel.frame.size.height, 100, 30);
    loesungButton.frame = CGRectMake(210, ssLabel.frame.origin.y + ssLabel.frame.size.height, 100, 30);
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
-(void)changeEditingMode
{
    SSTextField.text = @"";
    ssLabel.text = @"";
    if(segControl.selectedSegmentIndex == 0)
    {
        editingMode = 0;
        ssLabel.hidden = NO;
        SSTextField.hidden = YES;
        [character1 removeFromSuperview];
        [character2 removeFromSuperview];
        character1 = [[Connector shared]getCharacterwithID:0 andFrame:CGRectMake(0, 68, 128, 192) reading:NO];
        character2 = [[Connector shared]getCharacterwithID:0 andFrame:CGRectMake(128, 68, 128, 192) reading:NO];
        if(theType == 3 || theType == 4)
        {
            [character2 updateCharacter];
        }
        else
        {
            character2.hidden = YES;
        }
        [self.view addSubview:character1];
        [self.view addSubview:character2];
    }
    else if(segControl.selectedSegmentIndex == 1)
    {
        editingMode = 1;
        ssLabel.hidden = YES;
        SSTextField.hidden = NO;
    }
    [self getNewCharacter];
}
-(void)getNewCharacter
{
    if(editingMode == 0)
    {
        [character1 removeFromSuperview];
        [character2 removeFromSuperview];
        character1 = [[Connector shared]getCharacterwithID:0 andFrame:CGRectMake(0, segControl.frame.origin.y + segControl.frame.size.height, 128, 192) reading:NO];
        character2 = [[Connector shared]getCharacterwithID:0 andFrame:CGRectMake(128, segControl.frame.origin.y + segControl.frame.size.height, 128, 192) reading:NO];
        if(theType == 3 || theType == 6)
        {
            character1.isPartOfZweiformig = YES;
            character2.isPartOfZweiformig = YES;
        }
        else
        {
            character2.hidden = YES;
        }
        [character1 updateCharacter];
        [character2 updateCharacter];
        searchedCharacter = [[Connector shared]GetRandomKuerzungWithType:theType];
        ssLabel.text = searchedCharacter.Name;
        if(theType == 1)
        {
            ssLabel.text = [[Connector shared]SpacedStringWithString:ssLabel.text];
            NSLog(@"%@", ssLabel.text);
        }
        [self.view addSubview:character1];
        [self.view addSubview:character2];
    }
    else
    {
        [SSTextField resignFirstResponder];
        searchedCharacter = [[Connector shared]GetRandomKuerzungWithType:theType];
        SSTextField.text = @"";
        [character1 removeFromSuperview];
        [character2 removeFromSuperview];
        character1 = [[Connector shared]getCharacterwithID:searchedCharacter.firstID andFrame:CGRectMake(0, segControl.frame.origin.y + segControl.frame.size.height, 128, 192) reading:YES];
        character2 = [[Connector shared]getCharacterwithID:searchedCharacter.secondID andFrame:CGRectMake(128, segControl.frame.origin.y + segControl.frame.size.height, 128, 192) reading:YES];
        if(theType == 3 || theType == 6)
        {
            character1.isPartOfZweiformig = YES;
            character2.isPartOfZweiformig = YES;
            character2.hidden = NO;
        }
        else
        {
            character2.hidden = YES;
        }
        [character1 updateCharacter];
        [character2 updateCharacter];
        [self.view addSubview:character1];
        [self.view addSubview:character2];
    }
}
-(void)check
{
    if(editingMode == 0)
    {
        int ID_1 = 0;
        int ID_2 = 0;
        if(character2.hidden)
        {
            ID_1 = [[Connector shared]getIDfromBrailleCHaracter:character1];
            ID_2 = 0;
        }
        else
        {
            ID_1 = [[Connector shared]getIDfromBrailleCHaracter:character1];
            ID_2 = [[Connector shared]getIDfromBrailleCHaracter:character2];
        }
        if(ID_1 == searchedCharacter.firstID && ID_2 == searchedCharacter.secondID)
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Glückwunsch!" message:@"Das ist Richtig" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [self getNewCharacter];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Schade!!" message:@"Das ist leider falsch" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    else
    {
        [SSTextField resignFirstResponder];
        if([SSTextField.text caseInsensitiveCompare:searchedCharacter.Name] == NSOrderedSame)
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Glückwunsch!" message:@"Das ist Richtig" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [self getNewCharacter];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Schade!!" message:@"Das ist leider falsch" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
}
-(void)getLoesung
{
    if(editingMode == 0)
    {
        [character1 removeFromSuperview];
        [character2 removeFromSuperview];
        character1 = [[Connector shared]getCharacterwithID:searchedCharacter.firstID andFrame:CGRectMake(0, segControl.frame.origin.y + segControl.frame.size.height, 128, 192) reading:YES];
        character2 = [[Connector shared]getCharacterwithID:searchedCharacter.secondID andFrame:CGRectMake(128, segControl.frame.origin.y + segControl.frame.size.height, 128, 192) reading:YES];
        if(theType == 3 || theType == 6)
        {
            character1.isPartOfZweiformig = YES;
            character2.isPartOfZweiformig = YES;
        }
        else
        {
            character2.hidden = YES;
        }
        [character1 updateCharacter];
        [character2 updateCharacter];
        [self.view addSubview:character1];
        [self.view addSubview:character2];
    }
    else
    {
        [SSTextField resignFirstResponder];
        NSString *Loesung;
        if(theType == 1)
        {
            NSString *kuerzung = [NSString stringWithString:searchedCharacter.Name];
            NSMutableArray *buffer = [[NSMutableArray alloc]initWithCapacity:kuerzung.length];
            for(int i = 0; i < kuerzung.length;i++)
            {
                [buffer addObject:[NSString stringWithFormat:@"%C", [kuerzung characterAtIndex:i]]];
            }
            Loesung = [NSString stringWithFormat:@"Die Lösung ist: %@", [buffer componentsJoinedByString:@" "]];
        }
        else
        {
            Loesung = [NSString stringWithFormat:@"Die Lösung ist: %@", searchedCharacter.Name];
        }
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
