/*
 * AppController.j
 * ClassifierSandbox2
 *
 * Created by You on February 5, 2013.
 * Copyright 2013, Your Company All rights reserved.
 */

@import <Foundation/CPObject.j>
@import <Ratatosk/Ratatosk.j>

PhotoDragType = "PhotoDragType";

@implementation GlyphViewController : CPObject
{
    CPArray     itemList;
    @outlet     CPCollectionView    glyphView;
    @outlet     CPImageView         testCell;
}

- (id)initWithCollectionView:(CPCollectionView)collectionView
{
    self = [super init];
    if (self)
    {
        glyphView = collectionView;
        // Retrieve base64 glyph data
        var glyphTokens = encodedGlyphs.split(",");
        var glyph64List = [];
        var glyphLimit = glyphTokens.length;
        for (var i = 0; i < glyphLimit; i++)
        {
            var partGlyphs = glyphTokens[i].split("&#39;");
            glyph64List[i] = partGlyphs[1];
        }

        itemList = [];

        //Prepare CPCollectionView
        [glyphView setAutoresizingMask:CPViewWidthSizable];
        [glyphView setMinItemSize:CGSizeMake(100, 100)];
        [glyphView setMaxItemSize:CGSizeMake(100, 100)];
        [glyphView setDelegate:self];
        [glyphView setSelectable:YES];

        //Set CPCollectionView to use PhotoViews
        var itemPrototype = [[CPCollectionViewItem alloc] init];
        [itemPrototype setView:[[PhotoView alloc] initWithFrame:CGRectMakeZero()]];
        [glyphView setItemPrototype:itemPrototype];

        //Create CPImages with the base64 data
        for (var i = 0; i < glyph64List.length; i++)
        {
            var glyphImageData = [CPData dataWithBase64:glyph64List[i]];
            var glyphImage = [[CPImage alloc] initWithData:glyphImageData];
            itemList[i] = glyphImage;
        }

        //Add images to CPCollectionView
        [glyphView setContent:itemList];

        console.log(glyphView);
    }
    return self;
}

- (CPData)collectionView:(CPCollectionView)aCollectionView dataForItemsAtIndexes:(CPIndexSet)indices forType:(CPString)aType
{
    return [CPKeyedArchiver archivedDataWithRootObject:[itemList objectAtIndex:[indices firstIndex]]];
}

- (CPArray)collectionView:(CPCollectionView)aCollectionView dragTypesForItemsAtIndexes:(CPIndexSet)indices
{
    return [PhotoDragType];
}



@end


@implementation PhotoView : CPImageView
{
    CPImageView _imageView;
}

- (void)setSelected:(BOOL)isSelected
{
    [self setBackgroundColor:isSelected ? [CPColor grayColor] : nil];
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

@end