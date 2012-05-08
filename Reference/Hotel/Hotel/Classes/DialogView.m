//
//  tangleView.m
//  QuartzFun
//
//  Created by danal on 5/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DialogView.h"

#define kRadius 5
#define kAngle 10
#define kLeftDiv 6
#define kLeftHeight 25
#define kSpace kAngle*2

@implementation DialogView

//void MyDrawWithShadows (CGContextRef myContext, 
//						float wd, float ht)
//{ 
//	// 2 
//    CGSize          myShadowOffset = CGSizeMake (-15,  20); 
//	// 3 
//    float           myColorValues[] = {1, 0, 0, .6}; 
//	// 4 
//    CGColorRef      myColor; 
//	// 5 
//    CGColorSpaceRef myColorSpace; 
//	// 6 
//    CGContextSaveGState(myContext); 
//	// 7 
//    CGContextSetShadow (myContext, myShadowOffset, 5); 
//	// 8 
//    // Your drawing code here 
//    CGContextSetRGBFillColor (myContext, 0, 1, 0, 1); 
//    CGContextFillRect (myContext, CGRectMake (wd/3 + 75, ht/2 , wd/4, ht/4)); 
//	// 9 
//    myColorSpace = CGColorSpaceCreateDeviceRGB (); 
//	// 10 
//    myColor = CGColorCreate (myColorSpace, myColorValues); 
//	// 11 
//    CGContextSetShadowWithColor (myContext, myShadowOffset, 5, myColor); 
//	// 12 
//
//    CGContextSetRGBFillColor (myContext, 0, 0, 1, 1); 
//    CGContextFillRect (myContext, CGRectMake (wd/3-75,ht/2-100,wd/4,ht/4)); 
//	//13 
//    CGColorRelease (myColor); 
//	//14 
//    CGColorSpaceRelease (myColorSpace); 
//	//15 
//    CGContextRestoreGState(myContext); 
//} 

@synthesize direction,labelText;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
	self.backgroundColor = [UIColor clearColor];
			
    }
	return self;
}

-(void)addLabelView:(CGRect)frame {
//	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.direction*kSpace+5, 0, frame.size.width -10.0, frame.size.height)];
	UITextView *label = [[UITextView alloc] initWithFrame:CGRectMake(self.direction*kSpace+5, 5, frame.size.width -10.0, frame.size.height)];
	label.backgroundColor = [UIColor clearColor];
	label.font = [UIFont systemFontOfSize:12];
	label.editable = NO;
	
	label.text = [labelText length] == 0 ? @"EMPTY" : labelText;
	
	if(self.direction == 1) {
//		label.textAlignment = UITextAlignmentRight;
	}	
	[self addSubview:label];
	[label	 release];
}

-(void)drawAsHeaderLeft:(CGContextRef)c rect:(CGRect)rect {
	CGFloat minx = CGRectGetMinX(rect)+kSpace,maxx = CGRectGetMaxX(rect);
	CGFloat miny = CGRectGetMinY(rect),midy = CGRectGetMidY(rect), maxy = CGRectGetMaxY(rect);

	CGContextMoveToPoint(c, minx, maxy);
	CGContextAddArcToPoint(c, maxx, maxy, maxx, miny, kRadius);
	CGContextAddArcToPoint(c, maxx, miny, minx, miny, kRadius);
	CGContextAddArcToPoint(c, minx, miny, minx, midy, kRadius);
	CGContextAddLineToPoint(c, minx, midy-kAngle/2);
	CGContextAddLineToPoint(c, minx - kAngle,midy);
	CGContextAddLineToPoint(c, minx,midy+kAngle/2);
	CGContextAddArcToPoint(c, minx, maxy, maxx, maxy, kRadius);
}

-(void)drawASHeaderRight:(CGContextRef)c rect:(CGRect)rect {
	CGFloat minx = CGRectGetMinX(rect),maxx = CGRectGetMaxX(rect)-kSpace;
	CGFloat miny = CGRectGetMinY(rect),midy = CGRectGetMidY(rect), maxy = CGRectGetMaxY(rect);

	CGContextMoveToPoint(c, minx, miny);
	CGContextAddArcToPoint(c, maxx, miny, maxx, midy, kRadius);
	CGContextAddLineToPoint(c, maxx, midy-kAngle/2);
	CGContextAddLineToPoint(c, maxx+kAngle,midy);
	CGContextAddLineToPoint(c, maxx,midy+kAngle/2);
	CGContextAddArcToPoint(c, maxx, maxy, minx, maxy, kRadius);
	CGContextAddArcToPoint(c, minx, maxy, minx, miny, kRadius);
	CGContextAddArcToPoint(c, minx, miny, maxx, miny, kRadius);
}
- (void)drawRect:(CGRect)rect {
    // Drawing code
//	CGRect rect = [[UIScreen mainScreen] applicationFrame];
//	CGRect rectLeft = rect;
//	rectLeft.size.width = rect.size.width/kLeftDiv;
//	rectLeft.size.height = kLeftHeight;	
	CGFloat minx = CGRectGetMinX(rect),maxx = CGRectGetMaxX(rect)-kAngle;
	CGFloat miny = CGRectGetMinY(rect),midy = CGRectGetMidY(rect), maxy = CGRectGetMaxY(rect);

	CGContextRef c = UIGraphicsGetCurrentContext();
	//	CGContextBeginPath(c);
	CGContextSetFillColorWithColor(c,[UIColor orangeColor].CGColor);
	
	CGContextMoveToPoint(c, minx, miny);
	
	if(self.direction == 1){
		//left rect
		[self drawAsHeaderLeft:c rect:rect];
	}else {
		//right rect
		[self drawASHeaderRight:c rect:rect];
	}
//	CGContextSaveGState(c);
	CGSize size = CGSizeMake (1,  1);
	if(self.direction == 1){
		size = CGSizeMake(-2,-1);
	}
	CGContextSetShadowWithColor(c, size, 1.0, [UIColor grayColor].CGColor);
//	CGContextRestoreGState(c);
	
	CGContextFillPath(c);
	
	[self addLabelView:rect];
	
	
}

- (void)dealloc {
	[labelText release];
    [super dealloc];
}


@end
