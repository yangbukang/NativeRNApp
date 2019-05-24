//
//  ViewController.m
//  NativeRNApp
//
//  Created by mxy on 16/8/13.
//

#import "ViewController.h"
#import "RNMethodTool.h"
#import "ReactViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 180, 30)];
    label.text = @"这是一个原生页面";
    [self.view addSubview:label];
    UIButton *but = [UIButton buttonWithType:UIButtonTypeSystem];
    [but setTitle:@"原生页面调用RN" forState:UIControlStateNormal];
    [but setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
    but.frame = CGRectMake(100, 200, 180, 30);
    [self.view addSubview:but];
    
    UIButton *nextBut = [UIButton buttonWithType:UIButtonTypeSystem];
    [nextBut setTitle:@"打开RN页面" forState:UIControlStateNormal];
    [nextBut setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [nextBut addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
    nextBut.frame = CGRectMake(100, 300, 180, 30);
    [self.view addSubview:nextBut];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)next:(id)sender{
    ReactViewController *viewController = [[ReactViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}
-(IBAction)clicked:(id)sender{
    [RNMethodTool emitMethod];
}

@end
