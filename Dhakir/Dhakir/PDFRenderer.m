//
//  PDFRenderer.m
//  iOSPDFRenderer
//
//  Created by Tope on 24/11/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PDFRenderer.h"
#import "CoreText/CoreText.h"

@implementation PDFRenderer


+(void)drawPDF:(NSString*)fileName content:(NSString*) content
{ 
    NSString* passStored = [JNKeychain loadValueForKey:@"m4u_dhakir_lp"];
  
    NSDictionary *dictionary = [[NSDictionary alloc] initWithObjectsAndKeys:passStored, kCGPDFContextOwnerPassword, passStored, kCGPDFContextUserPassword, kCFBooleanFalse, kCGPDFContextAllowsCopying, kCFBooleanFalse, kCGPDFContextAllowsPrinting,  nil];

    
    // Create the PDF context using the default page size of 612 x 792.
    UIGraphicsBeginPDFContextToFile(fileName, CGRectZero, dictionary);
    // Mark the beginning of a new page.
    UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, 612, 1500), nil);
    [self drawText:[NSString stringWithFormat:@"%@ %@\n\n%@",
                    [[m4u_CommonUtils getAppName] uppercaseString],
                    STR_PASSWORDS,
                    content]];
    // Close the PDF context and write the contents out.
    UIGraphicsEndPDFContext();
}

+(void)drawText : (NSString*) textToDraw
{
    CFStringRef stringRef = (__bridge CFStringRef)textToDraw;
    CFRetain(stringRef);
    
    //    create attributed string
    CFMutableAttributedStringRef attrStr = CFAttributedStringCreateMutable(kCFAllocatorDefault, 0);
    CFAttributedStringReplaceString (attrStr, CFRangeMake(0, 0), stringRef);
    
    //    create font
    CTFontRef font = CTFontCreateWithName(CFSTR("TimesNewRomanPSMT"), 5, NULL);
    
    //    create paragraph style and assign text alignment to it
    CTTextAlignment alignment = kCTJustifiedTextAlignment;
    CTParagraphStyleSetting _settings[] = {    {kCTParagraphStyleSpecifierAlignment, sizeof(alignment), &alignment} };
    CTParagraphStyleRef paragraphStyle = CTParagraphStyleCreate(_settings, sizeof(_settings) / sizeof(_settings[0]));
    
    //    set paragraph style attribute
    CFAttributedStringSetAttribute(attrStr, CFRangeMake(0, CFAttributedStringGetLength(attrStr)), kCTParagraphStyleAttributeName, paragraphStyle);
    
    //    set font attribute
    CFAttributedStringSetAttribute(attrStr, CFRangeMake(0, CFAttributedStringGetLength(attrStr)), kCTFontAttributeName, font);
    
    
    // Prepare the text using a Core Text Framesetter
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString(attrStr);

    
    CGRect frameRect = CGRectMake(10, 10, 600, 1200);
    CGMutablePathRef framePath = CGPathCreateMutable();
    CGPathAddRect(framePath, NULL, frameRect);
    
    // Get the frame that will do the rendering.
    CFRange currentRange = CFRangeMake(0, 0);
    CTFrameRef frameRef = CTFramesetterCreateFrame(framesetter, currentRange, framePath, NULL);
    CGPathRelease(framePath);

    
    // Get the graphics context.
    CGContextRef    currentContext = UIGraphicsGetCurrentContext();
    
    // Put the text matrix into a known state. This ensures
    // that no old scaling factors are left in place.
    CGContextSetTextMatrix(currentContext, CGAffineTransformIdentity);
    
    
    // Core Text draws from the bottom-left corner up, so flip
    // the current transform prior to drawing.
    CGContextTranslateCTM(currentContext, 10, 1220);
    CGContextScaleCTM(currentContext, 1.0, -1.0);

    // Draw the frame.
    CTFrameDraw(frameRef, currentContext);
    
    // release paragraph style and font
   
    CFRelease(font);
    CFRelease(_settings);
    CFRelease(paragraphStyle);
    CFRelease(&currentRange);
    CFRelease(attrStr);
    CFRelease(framesetter);
    CFRelease(frameRef);

    CFRelease(stringRef);
}

@end
