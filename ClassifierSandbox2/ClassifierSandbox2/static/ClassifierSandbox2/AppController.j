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
    @outlet     CPObject    testImageView;
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    // This is called when the application is done loading.
    
    //[collectionController loadGlyphs];
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
    
    var itemPrototype = [[CPCollectionViewItem alloc] init];
    var photoView = [[PhotoView alloc] initWithFrame:CGRectMakeZero()];
    
    [itemPrototype setView:photoView];
    
    [collectionController setItemPrototype:itemPrototype];
    
    
    
    for (i = 0; i < glyph64List.length; i++) {
        var glyphImageData = [CPData dataWithBase64:glyph64List[i]];
        var glyphImage = [[CPImage alloc] initWithData:glyphImageData];
        itemList[i] = glyphImage;
    }
    
    [collectionController setContent:[[[CPImage alloc] initWithData:glyphImageData]]];
    
    /*
    for (i = 0; i < glyph64List.length; i++) {
        var glyphImageData = [CPData dataWithBase64:glyph64List[i]];
        var glyphImage = [[CPImage alloc] initWithData:glyphImageData];
        
        //itemList[i] = {"id": i, "CPImage": glyphImage};
        
        var glyphImageView = [CPImageView initialize];
        [glyphImageView setImage:glyphImage];
        itemList[i] = [CPCollectionViewItem initialize];
        [itemList[i] setRepresentedObject:glyphImageView];
    }
    */
    var glyphImageData = [CPData dataWithBase64:glyph64List[0]];
    var glyphImage = [[CPImage alloc] initWithData:glyphImageData];
    [testImageView setImage:glyphImage];
    //[collectionController setContent:itemList];
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

/*
@implementation CollectionController : CPObject
{
    @outlet     CPObjectController      collectionObjectController;
    @outlet     CPCollectionView        cView;
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
    
    [cView addObjects:itemList];
}

@end*/