//
//  BrailleCharacter.h
//  Braille-Lernprogramm
//
//  Created by Alexander Eiselt on 08.05.13.
//  Copyright (c) 2013 Alexander Eiselt. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BrailleDot;
@interface BrailleCharacter : UIView
{
    NSMutableArray *_AccessibilityElements;
}
@property int theID;
@property(nonatomic)NSString *character;
@property(nonatomic)NSString *VOString;
@property(nonatomic)BrailleDot *dot1;
@property(nonatomic)BrailleDot *dot2;
@property(nonatomic)BrailleDot *dot3;
@property(nonatomic)BrailleDot *dot4;
@property(nonatomic)BrailleDot *dot5;
@property(nonatomic)BrailleDot *dot6;
@property(nonatomic) CGRect AccessibiltyRect;
@property bool isSecondCharacter;
@property bool isReading;
@property bool isPartOfZweiformig;

-(void)createAccessibilityElements;
-(void)updateCharacter;
-(id)initWithFrame:(CGRect)frame isreading:(BOOL)reading;
@end
