//
//  ViewController.m
//  BKCircularLoadingButton
//
//  Created by Bhima on 14/03/19.
//  Copyright © 2019 Bhima Patange. All rights reserved.
//

#import "ViewController.h"
#import "BKCircularLoadingButton.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    BKCircularLoadingButton* button2 = [BKCircularLoadingButton buttonWithFrame:CGRectMake(20, 100, self.view.bounds.size.width - 2 * 20, 50)];
   
//    [button2 setTitle:@"OK" forState:UIControlStateNormal];
//    [button2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    [button2 setBackgroundColor:[UIColor whiteColor]];
//    [self.view addSubview:button2];
//
//       [button2 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view, typically from a nib.
}

-(IBAction)click:(BKCircularLoadingButton*)button{
    
    [button startAnimation];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
       [button stopAnimation];
    });
}
@end
