//
//  Connector.m
//  Tabletten-App
//
//  Created by edv on 10.11.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import "Connector.h"
#import "BrailleCharacter.h"
#import "BrailleDot.h"
#import "KurzschriftCharacter.h"
static Connector *zeiger;

@implementation Connector

@synthesize database;

-(id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}
//gibt ein statisches Objekt vom Typ Connector wieder
+(Connector *)shared {
    if (zeiger == nil) {
        zeiger = [[Connector alloc] init];
    }
    return zeiger;
}
//gibt den Pfad der lokalen Datenbank database.sqlite im Projektverzeichnis wieder.
+(NSString *)filePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *Documentsdir = [paths objectAtIndex:0];
    Documentsdir = [Documentsdir stringByAppendingPathComponent:@"braille.sql"];
    return Documentsdir;
}
-(BrailleCharacter*)getCharacterwithName:(NSString*)name andFrame:(CGRect)Frame reading:(BOOL)reading
{
    BrailleCharacter *thecharacter = [[BrailleCharacter alloc]initWithFrame:Frame isreading:reading];
    
    if(sqlite3_open([[Connector filePath]UTF8String], &database) == SQLITE_OK)
    {
        NSString *statement = [NSString stringWithFormat:@"select * from 'vollschrift' where name = %@;", name];
        sqlite3_stmt *comstatement;
        if(sqlite3_prepare_v2(database, [statement UTF8String], -1, &comstatement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(comstatement) == SQLITE_ROW)
            {
                thecharacter.character = [NSString stringWithUTF8String:(char*)sqlite3_column_text(comstatement, 1)];
                NSNumber *dot1selected = [NSNumber numberWithInt:sqlite3_column_int(comstatement, 2)];
                thecharacter.dot1.isselected = dot1selected.boolValue;
                NSNumber *dot2selected = [NSNumber numberWithInt:sqlite3_column_int(comstatement, 3)];
                thecharacter.dot2.isselected = dot2selected.boolValue;
                NSNumber *dot3selected = [NSNumber numberWithInt:sqlite3_column_int(comstatement, 4)];
                thecharacter.dot3.isselected = dot3selected.boolValue;
                NSNumber *dot4selected = [NSNumber numberWithInt:sqlite3_column_int(comstatement, 5)];
                thecharacter.dot4.isselected = dot4selected.boolValue;
                NSNumber *dot5selected = [NSNumber numberWithInt:sqlite3_column_int(comstatement, 6)];
                thecharacter.dot5.isselected = dot5selected.boolValue;
                NSNumber *dot6selected = [NSNumber numberWithInt:sqlite3_column_int(comstatement, 7)];
                thecharacter.dot6.isselected = dot6selected.boolValue;
                thecharacter.VOString = [NSString stringWithUTF8String:(char*)sqlite3_column_text(comstatement, 8)];
            }
            sqlite3_finalize(comstatement);
        }
        else
        {
            NSLog(@"Error = %@", [NSString stringWithCString:sqlite3_errmsg(database) encoding:NSUTF8StringEncoding]);
        }
        sqlite3_close(database);
    }
    return thecharacter;
}
-(BrailleCharacter*)getCharacterwithID:(int)theID andFrame:(CGRect)Frame  reading:(BOOL)reading
{
    BrailleCharacter *thecharacter = [[BrailleCharacter alloc]initWithFrame:Frame isreading:reading];
    
    if(sqlite3_open([[Connector filePath]UTF8String], &database) == SQLITE_OK)
    {
        NSString *statement = [NSString stringWithFormat:@"select * from 'vollschrift' where id = %d;", theID];
        sqlite3_stmt *comstatement;
        if(sqlite3_prepare_v2(database, [statement UTF8String], -1, &comstatement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(comstatement) == SQLITE_ROW)
            {
                thecharacter.theID = theID;
                thecharacter.character = [NSString stringWithUTF8String:(char*)sqlite3_column_text(comstatement, 1)];
                NSNumber *dot1selected = [NSNumber numberWithInt:sqlite3_column_int(comstatement, 2)];
                thecharacter.dot1.isselected = dot1selected.boolValue;
                NSNumber *dot2selected = [NSNumber numberWithInt:sqlite3_column_int(comstatement, 3)];
                thecharacter.dot2.isselected = dot2selected.boolValue;
                NSNumber *dot3selected = [NSNumber numberWithInt:sqlite3_column_int(comstatement, 4)];
                thecharacter.dot3.isselected = dot3selected.boolValue;
                NSNumber *dot4selected = [NSNumber numberWithInt:sqlite3_column_int(comstatement, 5)];
                thecharacter.dot4.isselected = dot4selected.boolValue;
                NSNumber *dot5selected = [NSNumber numberWithInt:sqlite3_column_int(comstatement, 6)];
                thecharacter.dot5.isselected = dot5selected.boolValue;
                NSNumber *dot6selected = [NSNumber numberWithInt:sqlite3_column_int(comstatement, 7)];
                thecharacter.dot6.isselected = dot6selected.boolValue;
                thecharacter.VOString = [NSString stringWithUTF8String:(char*)sqlite3_column_text(comstatement, 8)];
            }
            sqlite3_finalize(comstatement);
        }
        else
        {
            NSLog(@"Error = %@", [NSString stringWithCString:sqlite3_errmsg(database) encoding:NSUTF8StringEncoding]);
        }
        sqlite3_close(database);
    }
    return thecharacter;
}
-(BrailleCharacter*)getrandomcharacterwithframe:(CGRect)Frame reading:(BOOL)reading
{
    BrailleCharacter *thecharacter = [[BrailleCharacter alloc]initWithFrame:Frame isreading:reading];
    
    int theid = (arc4random() % 65);
    if(sqlite3_open([[Connector filePath]UTF8String], &database) == SQLITE_OK)
    {
        NSString *statement = [NSString stringWithFormat:@"select * from 'vollschrift' where id = %d;", theid];
        sqlite3_stmt *comstatement;
        if(sqlite3_prepare_v2(database, [statement UTF8String], -1, &comstatement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(comstatement) == SQLITE_ROW)
            {
                thecharacter.theID = [[NSNumber numberWithInt:sqlite3_column_int(comstatement, 0)]intValue];
                thecharacter.character = [NSString stringWithUTF8String:(char*)sqlite3_column_text(comstatement, 1)];
                NSNumber *dot1selected = [NSNumber numberWithInt:sqlite3_column_int(comstatement, 2)];
                thecharacter.dot1.isselected = dot1selected.boolValue;
                NSNumber *dot2selected = [NSNumber numberWithInt:sqlite3_column_int(comstatement, 3)];
                thecharacter.dot2.isselected = dot2selected.boolValue;
                NSNumber *dot3selected = [NSNumber numberWithInt:sqlite3_column_int(comstatement, 4)];
                thecharacter.dot3.isselected = dot3selected.boolValue;
                NSNumber *dot4selected = [NSNumber numberWithInt:sqlite3_column_int(comstatement, 5)];
                thecharacter.dot4.isselected = dot4selected.boolValue;
                NSNumber *dot5selected = [NSNumber numberWithInt:sqlite3_column_int(comstatement, 6)];
                thecharacter.dot5.isselected = dot5selected.boolValue;
                NSNumber *dot6selected = [NSNumber numberWithInt:sqlite3_column_int(comstatement, 7)];
                thecharacter.dot6.isselected = dot6selected.boolValue;
                thecharacter.VOString = [NSString stringWithUTF8String:(char*)sqlite3_column_text(comstatement, 8)];
            }
            sqlite3_finalize(comstatement);
        }
        else
        {
            NSLog(@"Error = %@", [NSString stringWithCString:sqlite3_errmsg(database) encoding:NSUTF8StringEncoding]);
        }
        sqlite3_close(database);
    }
    return thecharacter;
}
-(NSString*)getCharacterwithBrailleCharacter:(BrailleCharacter*)theCharacter
{
    NSString *thecharacter = @"";
    if(sqlite3_open([[Connector filePath]UTF8String], &database) == SQLITE_OK)
    {
        int i1 = theCharacter.dot1.isselected;
        int i2 = theCharacter.dot2.isselected;
        int i3 = theCharacter.dot3.isselected;
        int i4 = theCharacter.dot4.isselected;
        int i5 = theCharacter.dot5.isselected;
        int i6 = theCharacter.dot6.isselected;
        NSString *statement = [NSString stringWithFormat:@"select * from vollschrift where pt1 = %d and pt2 = %d and pt3 = %d and pt4 = %d and pt5 = %d and pt6 = %d;", i1, i2, i3, i4, i5, i6];
        sqlite3_stmt *comstatement;
        if(sqlite3_prepare_v2(database, [statement UTF8String], -1, &comstatement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(comstatement) == SQLITE_ROW)
            {
                thecharacter = [NSString stringWithUTF8String:(char*)sqlite3_column_text(comstatement, 1)];
            }
            sqlite3_finalize(comstatement);
        }
        else
        {
            NSLog(@"Error = %@", [NSString stringWithCString:sqlite3_errmsg(database) encoding:NSUTF8StringEncoding]);
        }
        sqlite3_close(database);
    }
    return thecharacter;
}
-(int)getIDfromBrailleCHaracter:(BrailleCharacter*)theCharacter
{
    int theiD = 0;
    if(sqlite3_open([[Connector filePath]UTF8String], &database) == SQLITE_OK)
    {
        int i1 = theCharacter.dot1.isselected;
        int i2 = theCharacter.dot2.isselected;
        int i3 = theCharacter.dot3.isselected;
        int i4 = theCharacter.dot4.isselected;
        int i5 = theCharacter.dot5.isselected;
        int i6 = theCharacter.dot6.isselected;
        NSString *statement = [NSString stringWithFormat:@"select * from vollschrift where pt1 = %d and pt2 = %d and pt3 = %d and pt4 = %d and pt5 = %d and pt6 = %d;", i1, i2, i3, i4, i5, i6];
        sqlite3_stmt *comstatement;
        if(sqlite3_prepare_v2(database, [statement UTF8String], -1, &comstatement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(comstatement) == SQLITE_ROW)
            {
                theiD = [[NSNumber numberWithInt:sqlite3_column_int(comstatement, 0)]intValue];
            }
            sqlite3_finalize(comstatement);
        }
        else
        {
            NSLog(@"Error = %@", [NSString stringWithCString:sqlite3_errmsg(database) encoding:NSUTF8StringEncoding]);
        }
        sqlite3_close(database);
    }
    return theiD;
}
-(NSString*)getkuerzungwithID1:(int)id1 andID2:(int)id2 andType:(int)type
{
    NSString *kuerzung = @"";
    if(sqlite3_open([[Connector filePath]UTF8String], &database) == SQLITE_OK)
    {
        NSString *statement = [NSString stringWithFormat:@"select * from kurzschrift where first = %d and second = %d and type = %d", id1, id2, type];
        sqlite3_stmt *comstatement;
        if(sqlite3_prepare_v2(database, [statement UTF8String], -1, &comstatement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(comstatement) == SQLITE_ROW)
            {
                kuerzung = [NSString stringWithUTF8String:(char*)sqlite3_column_text(comstatement, 2)];
            }
            sqlite3_finalize(comstatement);
        }
        else
        {
            NSLog(@"Error = %@", [NSString stringWithCString:sqlite3_errmsg(database) encoding:NSUTF8StringEncoding]);
        }
        sqlite3_close(database);
    }
    return kuerzung;
}
-(int)getCountFortype:(int)type
{
    int count = 0;
    if(sqlite3_open([[Connector filePath]UTF8String], &database) == SQLITE_OK)
    {
        NSString *statement = [NSString stringWithFormat:@"select count(*) from kurzschrift where type = %d;", type];
        sqlite3_stmt *comstatement;
        if(sqlite3_prepare_v2(database, [statement UTF8String], -1, &comstatement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(comstatement) == SQLITE_ROW)
            {
                count = [[NSNumber numberWithInt:sqlite3_column_int(comstatement, 0)]intValue];
            }
            sqlite3_finalize(comstatement);
        }
        else
        {
            NSLog(@"Error = %@", [NSString stringWithCString:sqlite3_errmsg(database) encoding:NSUTF8StringEncoding]);
        }
        sqlite3_close(database);
    }
    count--;
    return count;
}
-(NSString*)getTypeWithID:(int)ID
{
    NSString *type = @"";
    if(sqlite3_open([[Connector filePath]UTF8String], &database) == SQLITE_OK)
    {
        NSString *statement = [NSString stringWithFormat:@"select * from types where type_id = %d", ID];
        sqlite3_stmt *comstatement;
        if(sqlite3_prepare_v2(database, [statement UTF8String], -1, &comstatement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(comstatement) == SQLITE_ROW)
            {
                type = [NSString stringWithUTF8String:(char*)sqlite3_column_text(comstatement, 1)];
            }
            sqlite3_finalize(comstatement);
        }
        else
        {
            NSLog(@"Error = %@", [NSString stringWithCString:sqlite3_errmsg(database) encoding:NSUTF8StringEncoding]);
        }
        sqlite3_close(database);
    }
    return type;
}
-(KurzschriftCharacter*)GetRandomKuerzungWithType:(int)thetype
{
    
    KurzschriftCharacter *chr = [[KurzschriftCharacter alloc]init];
    if(sqlite3_open([[Connector filePath]UTF8String], &database) == SQLITE_OK)
    {
        NSString *statement = [NSString stringWithFormat:@"select * from kurzschrift where type = %d order by RANDOM() Limit 1", thetype];
        sqlite3_stmt *comstatement;
        if(sqlite3_prepare_v2(database, [statement UTF8String], -1, &comstatement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(comstatement) == SQLITE_ROW)
            {
                chr.firstID = [[NSNumber numberWithInt:sqlite3_column_int(comstatement, 0)]intValue];
                chr.secondID = [[NSNumber numberWithInt:sqlite3_column_int(comstatement, 1)]intValue];
                chr.name = [NSString stringWithUTF8String:(char*)sqlite3_column_text(comstatement, 2)];
            }
            sqlite3_finalize(comstatement);
        }
        else
        {
            NSLog(@"Error = %@", [NSString stringWithCString:sqlite3_errmsg(database) encoding:NSUTF8StringEncoding]);
        }
        sqlite3_close(database);
    }
    return chr;
}
-(KurzschriftCharacter*)GetKuerzungAtRow:(int)row WithType:(int)thetype{
    
    KurzschriftCharacter *chr = [[KurzschriftCharacter alloc]init];
    if(sqlite3_open([[Connector filePath]UTF8String], &database) == SQLITE_OK)
    {
        NSString *statement = [NSString stringWithFormat:@"select * from kurzschrift where type = %d order by name Limit 1 offset %d", thetype, row];
        sqlite3_stmt *comstatement;
        if(sqlite3_prepare_v2(database, [statement UTF8String], -1, &comstatement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(comstatement) == SQLITE_ROW)
            {
                chr.firstID = [[NSNumber numberWithInt:sqlite3_column_int(comstatement, 0)]intValue];
                chr.secondID = [[NSNumber numberWithInt:sqlite3_column_int(comstatement, 1)]intValue];
                chr.name = [NSString stringWithUTF8String:(char*)sqlite3_column_text(comstatement, 2)];
            }
            sqlite3_finalize(comstatement);
        }
        else
        {
            NSLog(@"Error = %@", [NSString stringWithCString:sqlite3_errmsg(database) encoding:NSUTF8StringEncoding]);
        }
        sqlite3_close(database);
    }
    return chr;
}
-(void)copyDatabaseIfNeeded
{
    bool fileexists = [[NSFileManager defaultManager]fileExistsAtPath:[Connector filePath]];
    if(!fileexists)
    {
        NSString *path = [[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"braille.sql"];
        if([[NSFileManager defaultManager]fileExistsAtPath:path])
        {
            [[NSFileManager defaultManager]copyItemAtPath:path toPath:[Connector filePath] error:nil];
            fileexists = true;
            NSLog(@"Datei wurde kopiert");
        }
        else
        {
            fileexists = false;
            NSLog(@"Datei existiert nich");
        }
    }
}
-(void)execute:(NSString *)sql
{
    if(sqlite3_open([[Connector filePath]UTF8String], &database) == SQLITE_OK)
    {
        NSString *statement = sql;
        sqlite3_stmt *comstatement;
        if(sqlite3_prepare_v2(database, [statement UTF8String], -1, &comstatement, NULL) == SQLITE_OK)
        {
            sqlite3_exec(database, [sql UTF8String], 0, 0, 0);
            sqlite3_finalize(comstatement);
        }
        else
        {
            NSLog(@"Error = %@", [NSString stringWithCString:sqlite3_errmsg(database) encoding:NSUTF8StringEncoding]);
        }
        sqlite3_close(database);
    }
}

-(NSString*)SpacedStringWithString:(NSString*)string
{
    if(string.length <= 2)
    {
        NSMutableArray *buffer = [NSMutableArray arrayWithCapacity:[string length]];
        for (int i = 0; i < [string length]; i++) {
            [buffer addObject:[NSString stringWithFormat:@"%C", [string characterAtIndex:i]]];
        }
        return [buffer componentsJoinedByString:@" "];
    }
    else
    {
        return string;
    }
}
@end
