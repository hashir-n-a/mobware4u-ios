//
//  PDFRenderer.h
//  iOSPDFRenderer
//
//  Created by Tope on 24/11/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PDFRenderer : NSObject

+(void)drawPDF:(NSString*)fileName content:(NSString*) content;

@end
