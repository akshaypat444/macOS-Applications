//
//  AppDelegate.m
//  Dice
//
//  Created by AKSHAY PATEL on 1/3/26.
//

#import "AppDelegate.h"
#import "MainWindowController.h"

@interface AppDelegate ()
@property (strong) NSWindowController *windowController;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    self.windowController = [[MainWindowController alloc] init];
    [self.windowController showWindow:self];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification
{
    // Insert code here to tear down your application
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender
{
    return YES;
}


- (BOOL)applicationSupportsSecureRestorableState:(NSApplication *)app
{
    return YES;
}


@end
