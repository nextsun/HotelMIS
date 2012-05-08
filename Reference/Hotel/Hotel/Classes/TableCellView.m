//
//  TableCellView.m
//  Hotel
//
//  Created by danal on 5/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TableCellView.h"

#define kRadius 10

@implementation TableCellView
@synthesize _count,_index;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
		self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
	CGContextRef c = UIGraphicsGetCurrentContext();	
	CGContextSetFillColorWithColor(c, [UIColor colorWithRed:255/255.0 green:205/255.0 blue:222/255.0 alpha:1.0].CGColor);
	
	CGFloat minx = CGRectGetMinX(rect) , maxx = CGRectGetMaxX(rect) ;
	CGFloat miny = CGRectGetMinY(rect) , maxy = CGRectGetMaxY(rect) ;		
	
	CGContextMoveToPoint(c, minx, miny);
	
	if(0 == _index){	// the first indexPath
		CGContextMoveToPoint(c, minx, maxy);
		CGContextAddArcToPoint(c, minx, miny, maxx, miny, 10);
		CGContextAddArcToPoint(c, maxx, miny, maxx, maxy, 10);
		CGContextAddLineToPoint(c, maxx, maxy);
	}else if(_index == _count -1){	//the last indexPath
		CGContextMoveToPoint(c, minx, miny);
		CGContextAddArcToPoint(c, minx, maxy, maxx, maxy, 10);
		CGContextAddArcToPoint(c, maxx, maxy, maxx, miny, 10);
		CGContextAddLineToPoint(c, maxx, miny);
	}else{	//middle
		CGContextAddRect(c,rect);
	}
	
	CGContextClosePath(c);
	
	CGContextSaveGState(c);			
	CGContextClip(c);
	
	CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
	CGFloat components[] =
	{	
	204.0 / 255.0, 224.0 / 255.0, 244.0 / 255.0, 1.00,
	29.0 / 255.0, 156.0 / 255.0, 215.0 / 255.0, 1.00,
	0.0 / 255.0,  50.0 / 255.0, 126.0 / 255.0, 1.00,

	};
//	204.0 / 255.0, 224.0 / 255.0, 244.0 / 255.0, 1.00,
//	29.0 / 255.0, 156.0 / 255.0, 215.0 / 255.0, 1.00,
//	0.0 / 255.0,  50.0 / 255.0, 126.0 / 255.0, 1.00,
	CGGradientRef gradient = CGGradientCreateWithColorComponents(rgb, components, NULL, sizeof(components)/(sizeof(components[0])*4));
	CGColorSpaceRelease(rgb);
	CGPoint start = {minx,miny};
	CGPoint end = {minx,maxy};
	CGContextDrawLinearGradient(c, gradient, start, end, 0);
	
	CGContextRestoreGState(c);
	
	
	CGContextFillPath(c);

}


- (void)dealloc {
    [super dealloc];
}


@end
