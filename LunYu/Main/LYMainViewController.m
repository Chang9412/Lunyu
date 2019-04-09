//
//  LYMainViewController.m
//  LunYu
//
//  Created by zhengqiang zhang on 2019/3/29.
//  Copyright © 2019 chang. All rights reserved.
//

#import "LYMainViewController.h"

@interface LYMainViewController ()

@property(nonatomic, strong) UILabel *textlabel;

@end

@implementation LYMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
//    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(50, 50, 270, 200)];
//    [self.view addSubview:lab];
//    lab.text = @"1·2 有子(1)曰：“其为人也孝弟(2)，而好犯上者(3)，鲜(4)矣；不好犯上，而好作乱者，未之有也(5)。君子务本(6)，本立而道生(7)。孝弟也者，其为人之本与(8)？";
//    lab.textColor = [UIColor blackColor];
//    lab.font = [LYFontHelper defaultFontWithSize:30];
//    lab.numberOfLines = 0;
//    self.textlabel = lab;
//    
//    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 400, 50, 50)];
//    button.backgroundColor = [UIColor cyanColor];
//    [button addTarget:self action:@selector(event) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
}

- (void)event {
    NSLog(@"%@", self.textlabel.font);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"TEST" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    for (NSDictionary *dict in [LYFontHelper allFontNames]) {
        [alert addAction:[UIAlertAction actionWithTitle:dict[@"name"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [LYFontHelper changeFontName:dict[@"font"]];
            self.textlabel.font = [LYFontHelper defaultFontWithSize:30];
        }]];
    }
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}



@end
