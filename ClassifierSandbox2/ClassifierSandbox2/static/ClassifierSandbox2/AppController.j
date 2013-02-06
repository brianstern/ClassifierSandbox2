/*
 * AppController.j
 * ClassifierSandbox2
 *
 * Created by You on February 5, 2013.
 * Copyright 2013, Your Company All rights reserved.
 */

@import <Foundation/CPObject.j>
@import <Ratatosk/Ratatosk.j>


@implementation AppController : CPObject
{
    CPWindow    theWindow; //this "outlet" is connected automatically by the Cib
    @outlet     CPObject    collectionController;
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    // This is called when the application is done loading.
    
    [collectionController loadGlyphs];
}

- (void)awakeFromCib
{
    // This is called when the cib is done loading.
    // You can implement this method on any object instantiated from a Cib.
    // It's a useful hook for setting up current UI values, and other things.

    // In this case, we want the window from Cib to become our full browser window
    [WLRemoteLink setDefaultBaseURL:@""];
    [theWindow setFullPlatformWindow:YES];
}

@end

@implementation CollectionController : CPObject
{
    @outlet     CPObjectController      collectionObjectController;
}

- (void)loadGlyphs
{
    var glyphTokens = encodedGlyphs.split(",");
    
    var glyph64List = [];
    var i;
    var glyphLimit = 10;
    if (glyphTokens.length < 10) {
        glyphLimit = glyphTokens.length;
    }
    for (i = 0; i < glyphLimit; i++) {
        var partGlyphs = glyphTokens[i].split("&#39;");
        glyph64List[i] = partGlyphs[1];
    }
    
    var itemList = [];
    for (i = 0; i < glyph64List.length; i++) {
        var glyphImageData = [CPData dataWithBase64:glyph64List[i]];
        var glyphImage = [[CPImage alloc] initWithData:glyphImageData];
        itemList[i] = [CPCollectionViewItem initialize];
        [itemList[i] setRepresentedObject:glyphImage];
    }
    
    [collectionObjectController addObjects:itemList];
}

@end