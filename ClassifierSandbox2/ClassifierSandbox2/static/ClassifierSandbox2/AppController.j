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
    
    [self loadGlyphs];

    // In this case, we want the window from Cib to become our full browser window
    [WLRemoteLink setDefaultBaseURL:@""];
    [theWindow setFullPlatformWindow:YES];
}

- (void)loadGlyphs
{
    // Retrieve base64 glyph data
    var glyphTokens = encodedGlyphs.split(",");
    var glyph64List = [];
    var glyphLimit = glyphTokens.length;
    for (var i = 0; i < glyphLimit; i++) {
        var partGlyphs = glyphTokens[i].split("&#39;");
        glyph64List[i] = partGlyphs[1];
    }
    
    var itemList = [];
    
    //Prepare CPCollectionView
    [collectionController setAutoresizingMask:CPViewWidthSizable];
    [collectionController setMinItemSize:CGSizeMake(100, 100)];
    [collectionController setMaxItemSize:CGSizeMake(100, 100)];
    [collectionController setDelegate:self];
    
    //Set CPCollectionView to use PhotoViews
    var itemPrototype = [[CPCollectionViewItem alloc] init];
    [itemPrototype setView:[[PhotoView alloc] initWithFrame:CGRectMakeZero()]];
    [collectionController setItemPrototype:itemPrototype];
    
    //Create CPImages with the base64 data
    for (var i = 0; i < glyph64List.length; i++) {
        var glyphImageData = [CPData dataWithBase64:glyph64List[i]];
        var glyphImage = [[CPImage alloc] initWithData:glyphImageData];
        itemList[i] = glyphImage;
    }
    
    //Add images to CPCollectionView
    [collectionController setContent:itemList];
}

@end


@implementation PhotoView : CPView
{
    CPImageView _imageView;
}

- (void)setRepresentedObject:(id)anObject
{
    if (!_imageView)
    {
        var frame = CGRectInset([self bounds], 5.0, 5.0);

        _imageView = [[CPImageView alloc] initWithFrame:frame];

        [_imageView setImageScaling:CPScaleProportionally];
        [_imageView setAutoresizingMask:CPViewWidthSizable | CPViewHeightSizable];

        [self addSubview:_imageView];
    }

    [_imageView setImage:anObject];
}

- (void)setSelected:(BOOL)isSelected
{
    [self setBackgroundColor:isSelected ? [CPColor grayColor] : nil];
}

@end