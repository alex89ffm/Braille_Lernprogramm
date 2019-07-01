//
//  VSViewController.h
//  Braille-Lernprogramm
//
//  Created by Alexander Eiselt on 08.05.13.
//  Copyright (c) 2013 Alexander Eiselt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BrailleCharacter.h"
#import "BrailleDot.h"
#import "coloredButton.h"

@interface VSViewController : UIViewController <UITextFieldDelegate>
{
    BrailleCharacter *myCharacter;
    BrailleCharacter *searchedCharacter;
    UILabel *ssLabel;
    UITextField *SSTextField;
    UISegmentedControl *segControl;
    coloredButton *checkBUtton;
    coloredButton *NextCharacterButton;
    coloredButton *loesungButton;
    int editingMode;
}
-(void)check;
-(void)changeEditingMode;
-(void)getNewCharacter;
-(void)getLoesung;
@end
