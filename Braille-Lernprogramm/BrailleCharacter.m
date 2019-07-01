//
//  BrailleCharacter.m
//  Braille-Lernprogramm
//
//  Created by Alexander Eiselt on 08.05.13.
//  Copyright (c) 2013 Alexander Eiselt. All rights reserved.
//

#import "BrailleCharacter.h"
#import "BrailleDot.h"

@implementation BrailleCharacter
@synthesize dot1, dot2, dot3, dot4, dot5, dot6, AccessibiltyRect, isReading, isSecondCharacter, isPartOfZweiformig, character, theID, VOString;
-(id)initWithFrame:(CGRect)frame isreading:(BOOL)reading
{
    self = [super initWithFrame:frame];
    if(self) {
        theID = 0;
        _AccessibilityElements = [[NSMutableArray alloc] init];
        isReading = reading;
        if(frame.origin.x >=128)
        {
            isSecondCharacter = YES;
        }
        if(isReading)
        {
            [self setUserInteractionEnabled:NO];
        }
        dot1 = [[BrailleDot alloc]initWithFrame:CGRectMake(0, 0, 64, 64)];
        dot2 = [[BrailleDot alloc]initWithFrame:CGRectMake(0, 64, 64, 64)];
        dot3 = [[BrailleDot alloc]initWithFrame:CGRectMake(0, 128, 64, 64)];
        dot4 = [[BrailleDot alloc]initWithFrame:CGRectMake(64, 0, 64, 64)];
        dot5 = [[BrailleDot alloc]initWithFrame:CGRectMake(64, 64, 64, 64)];
        dot6 = [[BrailleDot alloc]initWithFrame:CGRectMake(64, 128, 64, 64)];
        dot1.dotButton.isAccessibilityElement = NO;
        dot2.dotButton.isAccessibilityElement = NO;
        dot3.dotButton.isAccessibilityElement = NO;
        dot4.dotButton.isAccessibilityElement = NO;
        dot5.dotButton.isAccessibilityElement = NO;
        dot6.dotButton.isAccessibilityElement = NO;
        
        dot1.tag = 1;
        dot2.tag = 2;
        dot3.tag = 3;
        dot4.tag = 4;
        dot5.tag = 5;
        dot6.tag = 6;
        
        [dot1.dotButton addTarget:self action:@selector(touchdot:) forControlEvents:UIControlEventTouchUpInside];
        [dot2.dotButton addTarget:self action:@selector(touchdot:) forControlEvents:UIControlEventTouchUpInside];
        [dot3.dotButton addTarget:self action:@selector(touchdot:) forControlEvents:UIControlEventTouchUpInside];
        [dot4.dotButton addTarget:self action:@selector(touchdot:) forControlEvents:UIControlEventTouchUpInside];
        [dot5.dotButton addTarget:self action:@selector(touchdot:) forControlEvents:UIControlEventTouchUpInside];
        [dot6.dotButton addTarget:self action:@selector(touchdot:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:dot1];
        [self addSubview:dot2];
        [self addSubview:dot3];
        [self addSubview:dot4];
        [self addSubview:dot5];
        [self addSubview:dot6];
        [self createAccessibilityElements];
        character = @"";
        VOString = @"";
        dot1.isselected = false;
        dot2.isselected = false;
        dot3.isselected = false;
        dot4.isselected = false;
        dot5.isselected = false;
        dot6.isselected = false;
    }
    return self;
}
-(void)updateCharacter
{
    if(dot1.isselected)
    {
        [dot1.dotButton setImage:[UIImage imageNamed:@"filled.png"] forState:UIControlStateNormal];
    }
    else
    {
        [dot1.dotButton setImage:[UIImage imageNamed:@"unfilled.png"] forState:UIControlStateNormal];
    }
    if(dot2.isselected)
    {
        [dot2.dotButton setImage:[UIImage imageNamed:@"filled.png"] forState:UIControlStateNormal];
    }
    else
    {
        [dot2.dotButton setImage:[UIImage imageNamed:@"unfilled.png"] forState:UIControlStateNormal];
    }
    if(dot3.isselected)
    {
        [dot3.dotButton setImage:[UIImage imageNamed:@"filled.png"] forState:UIControlStateNormal];
    }
    else
    {
        [dot3.dotButton setImage:[UIImage imageNamed:@"unfilled.png"] forState:UIControlStateNormal];
    }
    if(dot4.isselected)
    {
        [dot4.dotButton setImage:[UIImage imageNamed:@"filled.png"] forState:UIControlStateNormal];
    }
    else
    {
        [dot4.dotButton setImage:[UIImage imageNamed:@"unfilled.png"] forState:UIControlStateNormal];
    }
    if(dot5.isselected)
    {
        [dot5.dotButton setImage:[UIImage imageNamed:@"filled.png"] forState:UIControlStateNormal];
    }
    else
    {
        [dot5.dotButton setImage:[UIImage imageNamed:@"unfilled.png"] forState:UIControlStateNormal];
    }
    if(dot6.isselected)
    {
        [dot6.dotButton setImage:[UIImage imageNamed:@"filled.png"] forState:UIControlStateNormal];
    }
    else
    {
        [dot6.dotButton setImage:[UIImage imageNamed:@"unfilled.png"] forState:UIControlStateNormal];
    }
    [self createAccessibilityElements];
}
-(void)touchdot:(id)sender
{
    BrailleDot *dot = (BrailleDot*)[sender superview];
    if(dot.isselected)
    {
        dot.isselected = NO;
        [sender setImage:[UIImage imageNamed:@"unfilled.png"] forState:UIControlStateNormal];
    }
    else
    {
        dot.isselected = YES;
        [sender setImage:[UIImage imageNamed:@"filled.png"] forState:UIControlStateNormal];
    }
    [self createAccessibilityElements];
}
-(void)createAccessibilityElements
{
    [_AccessibilityElements removeAllObjects];
    if(isReading)
    {
        UIAccessibilityElement *AE = [[UIAccessibilityElement alloc]initWithAccessibilityContainer:self];
        if(isSecondCharacter)
        {
            AE.accessibilityFrame = CGRectMake(128, self.frame.origin.y+64, 128, 192);
        }
        else
        {
            AE.accessibilityFrame = CGRectMake(0, self.frame.origin.y+64, 128, 192);
        }
        AE.isAccessibilityElement = YES;
        AE.accessibilityTraits = UIAccessibilityTraitButton;
        NSString *accesslabel = @"";
        for(int i = 1; i <= 6;i++)
        {
            BrailleDot *thedot = (BrailleDot*) [self getsubviewbytag:i];
            if(thedot.isselected)
            {
                if(![accesslabel hasPrefix:@"Punkt"])
                {
                    accesslabel = [accesslabel stringByAppendingFormat:@"Punkt %d", i];
                }
                else
                {
                    accesslabel = [accesslabel stringByAppendingFormat:@" %d", i];
                }
            }
        }
        if(isPartOfZweiformig)
        {
            NSMutableString *accesslabel2 = [NSMutableString stringWithString:accesslabel];
            if(isSecondCharacter)
            {
                [accesslabel2 insertString:@"Zweites Zeichen: " atIndex:0];
                accesslabel = accesslabel2;
            }
            else
            {
                [accesslabel2 insertString:@"Erstes Zeichen: " atIndex:0];
                accesslabel = accesslabel2;
            }
        }
        if([accesslabel isEqualToString:@""])
        {
            accesslabel = @"Leeres Zeichen";
        }
        AE.accessibilityLabel = accesslabel;
        [_AccessibilityElements addObject:AE];
    }
    else
    {
        for(int i = 1; i <= 6;i++)
        {
            BrailleDot *thedot = (BrailleDot*)[self getsubviewbytag:i];
            UIAccessibilityElement *AE = [[UIAccessibilityElement alloc]initWithAccessibilityContainer:self];
            if(isSecondCharacter)
            {
                AE.accessibilityFrame = CGRectMake(thedot.frame.origin.x+128, thedot.frame.origin.y+self.frame.origin.y+64, 64, 64);
            }
            else
            {
                AE.accessibilityFrame = CGRectMake(thedot.frame.origin.x, thedot.frame.origin.y+self.frame.origin.y+64, 64, 64);
            }
            AE.isAccessibilityElement = YES;
            //AE.accessibilityTraits = UIAccessibilityTraitButton;
            
            NSString *accessLabel;
            if(thedot.isselected)
            {
                accessLabel = [NSString stringWithFormat:@"Punkt %i Ein", i];
            }
            else
            {
                accessLabel = [NSString stringWithFormat:@"Punkt %i Aus", i];
            }
            if(isPartOfZweiformig)
            {
                NSMutableString *accesslabel2 = [NSMutableString stringWithString:accessLabel];
                if(isSecondCharacter)
                {
                    [accesslabel2 insertString:@"Zeichen 2 " atIndex:0];
                    accessLabel = accesslabel2;
                }
                else
                {
                    [accesslabel2 insertString:@"Zeichen 1 " atIndex:0];
                    accessLabel = accesslabel2;
                }
            }
            AE.accessibilityLabel = accessLabel;
            [_AccessibilityElements addObject:AE];
        }
    }
}
-(UIView*)getsubviewbytag:(int)mytag
{
    for(UIView *theview in self.subviews)
    {
        if(theview.tag == mytag)
        {
            return theview;
        }
    }
    return nil;
}
-(NSArray*)AccElements
{
    if(_AccessibilityElements.count > 0)
    {
        return _AccessibilityElements;
    }
    return nil;
}
-(BOOL)isAccessibilityElement
{
    return NO;
}
-(id)accessibilityElementAtIndex:(NSInteger)index
{
    return [[self AccElements] objectAtIndex:index];
}
-(int)indexOfAccessibilityElement:(id)element
{
    return [[self AccElements] indexOfObject:element];
}
-(int)accessibilityElementCount
{
    return [[self AccElements] count];
}
@end
