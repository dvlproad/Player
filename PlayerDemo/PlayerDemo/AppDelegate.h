//
//  AppDelegate.h
//  PlayerDemo
//
//  Created by lichq on 8/7/15.
//  Copyright (c) 2015 ciyouzen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HTTPServer;
@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    HTTPServer *httpServer;
}

@property (strong, nonatomic) UIWindow *window;


@end

