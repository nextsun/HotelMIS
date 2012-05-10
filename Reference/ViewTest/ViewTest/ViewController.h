//
//  ViewController.h
//  ViewTest
//
//  Created by Sun on 12-5-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftViewController.h"
#import "RightViewController.h"

@interface ViewController : UIViewController{
    
    LeftViewController* left;   
    RightViewController* right; 
}
@end
