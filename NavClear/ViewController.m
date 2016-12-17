//
//  ViewController.m
//  NavClear
//
//  Created by 刘浩浩 on 16/6/7.
//  Copyright © 2016年 CodingFire. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UIImageView *barImageView;
    UITableView *myTableView;
    float _lastPosition;
    float currentPostion;
    float stopPosition;
    float lhAlpha;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor=[UIColor whiteColor];
    //    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
    //                                                  forBarMetrics:UIBarMetricsDefault];
    //    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
    _lastPosition = 0;
    stopPosition = 0;
    lhAlpha = 1;
    [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"first"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    self.navigationController.navigationBar.barTintColor=[UIColor orangeColor];
    
    self.title=@"This is my title!";
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    myTableView=[[UITableView alloc]initWithFrame:self.view.bounds];
    myTableView.delegate=self;
    myTableView.dataSource=self;
    [self.view addSubview:myTableView];
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 270)];
    imageView.image=[UIImage imageNamed:@"1.png"];
    myTableView.tableHeaderView=imageView;
    
    barImageView = self.navigationController.navigationBar.subviews.firstObject;
    NSString *str=@"122222";
}
#pragma mark - UITableViewDelaget
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 80;
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text=[NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}


- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    stopPosition = currentPostion + 64;
    NSLog(@"滑动停止:%f",stopPosition);

    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
   
    
    currentPostion = scrollView.contentOffset.y;
    
    if (currentPostion > 0) {
        if (currentPostion - _lastPosition >= 0) {
            if ([[NSUserDefaults standardUserDefaults]objectForKey:@"first"]!=nil) {
                [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"first"];
                [[NSUserDefaults standardUserDefaults]synchronize];
//                [NSObject cancelPreviousPerformRequestsWithTarget:self];
//                [self performSelector:@selector(scrollViewDidEndScrollingAnimation:) withObject:nil afterDelay:0.00001];
                [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"second"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                stopPosition = currentPostion + 64;

            }
           
            
            _lastPosition = currentPostion;
            NSLog(@"ScrollUp now    current:%f    last:%f    stop:%f",currentPostion,_lastPosition,stopPosition);
            if (lhAlpha >= 0) {
                lhAlpha = lhAlpha - 0.025f;
            }
            else
            {
                lhAlpha = 0;
            }
            self.navigationController.navigationBar.alpha = lhAlpha;

//            self.navigationController.navigationBar.alpha = 1 - currentPostion / 400;
            
            
        }
        else
        {
            if ([[NSUserDefaults standardUserDefaults]objectForKey:@"second"]!=nil) {
                [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"second"];
                [[NSUserDefaults standardUserDefaults]synchronize];
//                [NSObject cancelPreviousPerformRequestsWithTarget:self];
//                [self performSelector:@selector(scrollViewDidEndScrollingAnimation:) withObject:nil afterDelay:0.00001];
                [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"first"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                stopPosition = currentPostion + 64;

            }
            _lastPosition = currentPostion;
            NSLog(@"ScrollDown now    current:%f   last:%f    stop:%f",currentPostion,_lastPosition,stopPosition);
            if (lhAlpha <= 1) {
                lhAlpha = lhAlpha + 0.025f;
            }
            else
            {
                lhAlpha = 1;
            }
            self.navigationController.navigationBar.alpha = lhAlpha;
            //            self.navigationController.navigationBar.alpha = (stopPosition - currentPostion)/200;
        }
        
    }
    
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
