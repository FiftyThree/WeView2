//
//  WeView2ViewInfo.m
//  Unknown Project
//
//  Copyright (c) 2013 Charles Matthew Chen. All rights reserved.
//

#import <assert.h>
#import <objc/runtime.h>

#import "WeView2ViewInfo.h"
#import "WeView2Macros.h"

@implementation WeView2ViewInfo

- (void)dealloc {
}

- (id)init {
    if (self = [super init]) {
        self.hAlign = H_ALIGN_CENTER;
        self.vAlign = V_ALIGN_CENTER;

        self.maxWidth = CGFLOAT_MAX;
        self.maxHeight = CGFLOAT_MAX;
    }

    return self;
}

// TODO: Add asserts in the setters.
// TODO: hAlign and vAlign control how subviews of the view are aligned within the view, not the
// alignment of the view itself.

/* CODEGEN MARKER: View Info Start */

- (CGSize)minSize
{
    return CGSizeMake(self.minWidth, self.minHeight);
}

- (void)setMinSize:(CGSize)value
{
    [self setMinWidth:value.width];
    [self setMinHeight:value.height];
}

- (CGSize)maxSize
{
    return CGSizeMake(self.maxWidth, self.maxHeight);
}

- (void)setMaxSize:(CGSize)value
{
    [self setMaxWidth:value.width];
    [self setMaxHeight:value.height];
}

- (void)setFixedWidth:(CGFloat)value
{
    [self setMinWidth:value];
    [self setMaxWidth:value];
}

- (void)setFixedHeight:(CGFloat)value
{
    [self setMinHeight:value];
    [self setMaxHeight:value];
}

- (void)setFixedSize:(CGSize)value
{
    [self setMinWidth:value.width];
    [self setMinHeight:value.height];
    [self setMaxWidth:value.width];
    [self setMaxHeight:value.height];
}

- (void)setStretchWeight:(CGFloat)value
{
    [self setVStretchWeight:value];
    [self setHStretchWeight:value];
}

- (void)setHMargin:(CGFloat)value
{
    [self setLeftMargin:value];
    [self setRightMargin:value];
}

- (void)setVMargin:(CGFloat)value
{
    [self setTopMargin:value];
    [self setBottomMargin:value];
}

- (void)setMargin:(CGFloat)value
{
    [self setLeftMargin:value];
    [self setRightMargin:value];
    [self setTopMargin:value];
    [self setBottomMargin:value];
}

- (void)setSpacing:(CGFloat)value
{
    [self setHSpacing:value];
    [self setVSpacing:value];
}

/* CODEGEN MARKER: View Info End */

- (NSString *)formatLayoutDescriptionItem:(NSString *)key
                                    value:(id)value
{
    return [NSString stringWithFormat:@"%@: %@, ", key, value];
}

- (NSString *)layoutDescription
{
    NSMutableString *result = [@"" mutableCopy];

    /* CODEGEN MARKER: Debug Start */

    [result appendString:[self formatLayoutDescriptionItem:@"minWidth" value:@(self.minWidth)]];
    [result appendString:[self formatLayoutDescriptionItem:@"maxWidth" value:@(self.maxWidth)]];
    [result appendString:[self formatLayoutDescriptionItem:@"minHeight" value:@(self.minHeight)]];
    [result appendString:[self formatLayoutDescriptionItem:@"maxHeight" value:@(self.maxHeight)]];
    [result appendString:[self formatLayoutDescriptionItem:@"hStretchWeight" value:@(self.hStretchWeight)]];
    [result appendString:[self formatLayoutDescriptionItem:@"vStretchWeight" value:@(self.vStretchWeight)]];
    [result appendString:[self formatLayoutDescriptionItem:@"ignoreNaturalSize" value:@(self.ignoreNaturalSize)]];
    [result appendString:[self formatLayoutDescriptionItem:@"leftMargin" value:@(self.leftMargin)]];
    [result appendString:[self formatLayoutDescriptionItem:@"rightMargin" value:@(self.rightMargin)]];
    [result appendString:[self formatLayoutDescriptionItem:@"topMargin" value:@(self.topMargin)]];
    [result appendString:[self formatLayoutDescriptionItem:@"bottomMargin" value:@(self.bottomMargin)]];
    [result appendString:[self formatLayoutDescriptionItem:@"vSpacing" value:@(self.vSpacing)]];
    [result appendString:[self formatLayoutDescriptionItem:@"hSpacing" value:@(self.hSpacing)]];
    [result appendString:[self formatLayoutDescriptionItem:@"debugName" value:self.debugName]];
    [result appendString:[self formatLayoutDescriptionItem:@"debugLayout" value:@(self.debugLayout)]];

/* CODEGEN MARKER: Debug End */

    [result appendString:[self formatLayoutDescriptionItem:@"hAlign" value:FormatHAlign(self.hAlign)]];
    [result appendString:[self formatLayoutDescriptionItem:@"vAlign" value:FormatVAlign(self.vAlign)]];

    return result;
}

@end