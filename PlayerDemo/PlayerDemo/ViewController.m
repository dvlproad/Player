//
//  ViewController.m
//  PlayerDemo
//
//  Created by lichq on 8/7/15.
//  Copyright (c) 2015 ciyouzen. All rights reserved.
//

#import "ViewController.h"
#import "MoviePlayViewController.h"
#import "ImagePickerViewController.h"
#import "VideoViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)mpmovieplayer:(id)sender{
    MoviePlayViewController *vc = [[MoviePlayViewController alloc]initWithNibName:@"MoviePlayViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)imagePicker:(id)sender{
    ImagePickerViewController *vc = [[ImagePickerViewController alloc]initWithNibName:@"ImagePickerViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)loadingAndLive:(id)sender{ //边下边播
    VideoViewController *vc = [[VideoViewController alloc]initWithNibName:@"VideoViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
