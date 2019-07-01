//
//  KSViewController.h
//  Braille-Lernprogramm
//
//  Created by Alexander Eiselt on 09.05.13.
//  Copyright (c) 2013 Alexander Eiselt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BrailleCharacter.h"
#import "KurzschriftCharacter.h"
#import "coloredButton.h"

@interface KSViewController : UIViewController <UITextFieldDelegate>
{
    BrailleCharacter *character1;
    BrailleCharacter *character2;
    KurzschriftCharacter *searchedCharacter;
    UILabel *ssLabel;
    UITextField *SSTextField;
    UISegmentedControl *segControl;
    coloredButton *checkButton;
    coloredButton *NextCharacterButton;
    coloredButton *loesungButton;
    int editingMode;
    int theType;
}
-(id)initWithType:(int)type;
-(void)check;
-(void)getNewCharacter;
-(void)getLoesung;
-(void)changeEditingMode;
@end
