/*
 yololib
 Inject dylibs into existing Mach-O binaries
 
 
 DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
 Version 2, December 2004
 
 Copyright (C) 2004 Sam Hocevar <sam@hocevar.net>
 
 Everyone is permitted to copy and distribute verbatim or modified
 copies of this license document, and changing it is allowed as long
 as the name is changed.
 
 DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
 TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
 
 0. You just DO WHAT THE FUCK YOU WANT TO.
 
 */

#import <Foundation/Foundation.h>
#import "Yololib.h"


NSString* DYLIB_PATH;

int main(int argc, const char * argv[])
{
    if (argc != 3) {
        NSLog(@"usage:yololib binaryfile libfile");
        return 0;
    }
    NSString* binary = [NSString stringWithUTF8String:argv[1]];
    NSString* dylib = [NSString stringWithUTF8String:argv[2]];
    
    [Yololib injectFile:binary libPath:dylib];
    
    return 0;
}

