/*
 * AppController.j
 * ClassifierSandbox2
 *
 * Created by You on February 5, 2013.
 * Copyright 2013, Your Company All rights reserved.
 */

@import <Foundation/CPObject.j>
@import <Ratatosk/Ratatosk.j>
@import "GlyphView.j"


@implementation AppController : CPObject
{
    CPWindow    theWindow; //this "outlet" is connected automatically by the Cib
    @outlet     CPCollectionView    collectionController;
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    // This is called when the application is done loading.
}

- (void)awakeFromCib
{
    // This is called when the cib is done loading.
    // You can implement this method on any object instantiated from a Cib.
    // It's a useful hook for setting up current UI values, and other things.

    [[GlyphViewController alloc] initWithCollectionView:collectionController];

    // In this case, we want the window from Cib to become our full browser window
    [WLRemoteLink setDefaultBaseURL:@""];
    [theWindow setFullPlatformWindow:YES];
}

@end