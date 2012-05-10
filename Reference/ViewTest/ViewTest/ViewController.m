//
//  ViewController.m
//  ViewTest
//
//  Created by Sun on 12-5-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"


@implementation ViewController






- (id)init
{
    self = [super init];
    if (self) {
           
    }
    return self;
}


-(void)loadView
{
    
    [super loadView];
      
    
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"mainbg.jpg"]];
    left=[[LeftViewController alloc] init];    
    [self.view addSubview:left.view];
    
    right=[[RightViewController alloc] init];
    [self.view addSubview:right.view];
    
     
}
-(void)viewWillAppear:(BOOL)animated
{
    

}



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    [left release];
    [right release];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
//    //NSLog(@"shouldAutorotateToInterfaceOrientation:%@",NSStringFromCGRect(self.view.frame)); 
//    //return interfaceOrientation==UIDeviceOrientationPortrait;
//    
//    //CGRectMake(1024-300-10, 10, 300, 768-20);
//    int padding=10;
//    int width=1024;
//    int height=768;
//    
////    float scale=768.f/1024;    
//    int contentWidth=300;
//    
////    if ((interfaceOrientation == UIInterfaceOrientationPortrait)||(interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)) {
////         width*=scale;
////         height/=scale;
////         contentWidth*=scale;
////    }
//    height-=20;
    
    
 
    int padding=10;
    int width=1024;
    int height=768;
    int leftcontentWidth=300;
    int rightcontentWidth=720;
    height-=20;
    
    left.view.frame=CGRectMake(padding, padding, leftcontentWidth-padding*2, height-padding*2); 
    
    right.view.frame=CGRectMake(width-rightcontentWidth+padding, padding, rightcontentWidth-padding*2, height-padding*2); 

    
    
    
    
    return (interfaceOrientation==UIInterfaceOrientationLandscapeLeft)||(interfaceOrientation==UIInterfaceOrientationLandscapeRight);
    
}

- (void)dealloc
{
    
    [super dealloc];
}
@end
