//
//  EstateConsultantAppDelegate.m
//  EstateConsultant
//
//  Created by farthinker on 3/29/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import "EstateConsultantAppDelegate.h"
#import "LoginViewController.h"
#import "DataProvider.h"
#import "ZipArchive.h"
#import "EstateConsultantUtils.h"

@implementation EstateConsultantAppDelegate


@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self initApplicationDirectories];
    [[DataProvider sharedProvider] loadDemoData];
    
    LoginViewController *rootViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    [rootViewController.view setFrame:[UIScreen mainScreen].applicationFrame];
    [self.window setRootViewController:rootViewController];
    [rootViewController release];
    
    [self.window makeKeyAndVisible];
    
    NSLog(@"initialized");
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
    [[DataProvider sharedProvider] saveContext];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [[DataProvider sharedProvider] saveContext];
}

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (void)awakeFromNib
{
    /*
     Typically you should set up the Core Data stack here, usually by passing the managed object context to the first view controller.
     self.<#View controller#>.managedObjectContext = self.managedObjectContext;
    */
}

- (void)initApplicationDirectories
{
    NSString *documentsPath = [[[EstateConsultantUtils sharedUtils] documentsURL] path];
    NSString *demoPath = [documentsPath stringByAppendingPathComponent:@"demo"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:demoPath]) {
        ZipArchive *zipper = [[ZipArchive alloc] init];
        [zipper UnzipOpenFile:[[NSBundle mainBundle] pathForResource:@"defaults" ofType:@"zip"]];
        [zipper UnzipFileTo:documentsPath overWrite:YES];
        [zipper UnzipCloseFile];
        [zipper release];
        
        NSLog(@"application directories created");
    }
}


@end
