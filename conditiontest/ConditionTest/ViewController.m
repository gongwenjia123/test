//
//  ViewController.m
//  ConditionTest
//
//  Created by Apple_Gong on 14-12-8.
//  Copyright (c) 2014年 Apple_Gong. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSCondition *conditon;
    NSMutableArray *productor;
    //NSMutableArray *consumer;
}

@end

@implementation ViewController

+ (void)initialize{
    NSLog(@"initlize");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    conditon = [[NSCondition alloc]init];
    productor = [[NSMutableArray alloc]init];
    
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button1 setTitle:@"consumer" forState:UIControlStateNormal];
    [button1 setBackgroundColor:[UIColor redColor]];
    button1.frame = CGRectMake(0, 100, 80, 50);
    button1.center = CGPointMake(self.view.frame.size.width/2, 100);
    [self.view addSubview:button1];
    [button1 addTarget:self action:@selector(createConsumerAction) forControlEvents:UIControlEventTouchUpInside];
    //[button1 addTarget:button1 action:@selector(createConsumerAction1) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button2 setTitle:@"productor" forState:UIControlStateNormal];
    button2.frame = CGRectMake(0, 100, 80, 50);
    [button2 setBackgroundColor:[UIColor redColor]];
    button2.center = CGPointMake(self.view.frame.size.width/2, 300);
    [self.view addSubview:button2];
    [button2 addTarget:self action:@selector(createProductorAction) forControlEvents:UIControlEventTouchUpInside];
    
    NSArray *array = [[NSArray alloc]initWithObjects:@"1",@"2",@"3",@"6",@"5",@"6",@"7",@"8", nil];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    for (int i = 0; i < 8; i++) {
        [dic setValue:[NSNumber numberWithInt:i] forKey:[NSString stringWithFormat:@"%d",i]];
    }
//  NSIndexSet * index = [array indexesOfObjectsPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
//       NSLog(@"%@%d%d",obj,idx,*stop);
//      *stop = [obj isEqualToString:@"3"];
//       return [obj isEqualToString: @"6"];
//   }];
//    array = [array objectsAtIndexes:index];
//    NSLog(@"@array = %@",array);
    
    //获取整个程序所在目录
    NSString *homePath=NSHomeDirectory();
    NSLog(@"%@",homePath);
    //获取.app文件目录
    NSString *appPath=[[NSBundle mainBundle]bundlePath];
    NSLog(@"%@",appPath);
    
    NSArray *pathArr = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *path = pathArr[0];
    NSString *path1 = [path stringByAppendingPathComponent:@"arrayDoc"];
    NSString *path2 = [path stringByAppendingPathComponent:@"dictionaryDoc"];
   // NSString *path3 = [path stringByAppendingString:@"arrayDocDoc"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path1] == YES) {
        //[[NSFileManager defaultManager] createDirectoryAtPath:path1 withIntermediateDirectories:YES attributes:nil error:nil];
        [fileManager removeItemAtPath:path1 error:nil];
    }
    if ([fileManager fileExistsAtPath:path2] == YES) {
       // [[NSFileManager defaultManager] createDirectoryAtPath:path2 withIntermediateDirectories:YES attributes:nil error:nil];
        [fileManager removeItemAtPath:path2 error:nil];
    }
    
    BOOL success = [array writeToFile:[path1 stringByAppendingPathComponent:@"1.plist"] atomically:YES];
    BOOL succ = [dic writeToFile:path2 atomically:YES];
    NSLog(@"path1 = %@",path1);
    NSLog(@"path2 = %@",path2);
    NSLog(@"path3 = %d",self.marginType);
}

- (void)createConsumerAction
{
    //[[NSThread alloc]initWithTarget:self selector:@selector(createConsumer) object:nil];
    [NSThread detachNewThreadSelector:@selector(createConsumer) toTarget:self withObject:nil];
}

//- (void)createConsumerAction1
//{
//    NSLog(@"action111");
//}

- (void)createProductorAction
{
    [NSThread detachNewThreadSelector:@selector(createProductor) toTarget:self withObject:nil];
}

- (void)createConsumer
{
    [conditon lock];
    while (productor.count == 0) {
        NSLog(@"wait for productor");
        [conditon wait];
    }
    [productor removeObjectAtIndex:0];
    NSLog(@"consumer a productor");
    [conditon unlock];
}

- (void)createProductor
{
    [conditon lock];
    [productor addObject:[[NSObject alloc]init]];
    NSLog(@"create a producer");
    [conditon broadcast];
    [conditon unlock];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
