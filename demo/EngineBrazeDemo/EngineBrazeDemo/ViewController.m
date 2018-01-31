//
//  ViewController.m
//  EngineBrazeDemo
//
//  Created by Sevada Abraamyan on 1/25/18.
//  Copyright © 2018 Factual Inc. All rights reserved.
//

#import "ViewController.h"
#import "BButton.h"
#import "FactualEngine.h"
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addDetectButton];    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addDetectButton {
    [[BButton appearance] setButtonCornerRadius:@40.0f];
    
    CGRect frame = CGRectMake(0.0f, 0.0f, 250.0f, 75.0f);
    BButton *btn = [[BButton alloc] initWithFrame:frame
                                             type:BButtonTypePurple
                                            style:BButtonStyleBootstrapV3];
    [btn setTitle:@"Impatient? Detect location now!" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(detectAnyCircumstancesAndTrack:) forControlEvents:UIControlEventTouchUpInside];
    btn.enabled = YES;
    btn.center = self.view.center;
    [self.view addSubview:btn];
}

- (void)detectAnyCircumstancesAndTrack:(UIButton *)sender {
    NSLog(@"Triggered!");
    [[AppDelegate engine] runCircumstances];
}

@end
