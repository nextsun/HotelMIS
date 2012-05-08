//
//  HotelAppDelegate.h
//  Hotel
//
//  Created by danal on 5/10/11.
//  Copyright danal 2011. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotelAppDelegate : NSObject <UIApplicationDelegate> {//UITabBarControllerDelegate
    UIWindow *window;
    UITabBarController *tabBarController;

	NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;	    
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
	
}

@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

- (NSString *)applicationDocumentsDirectory;
@end
