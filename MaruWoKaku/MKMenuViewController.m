//
//  MKMenuViewController.m
//  MaruWoKaku
//
//  Created by Takuya Suenaga on 2014/07/23.
//  Copyright (c) 2014年 Takuya Suenaga. All rights reserved.
//

#import "MKMenuViewController.h"
#import "InfoView.h"

@interface MKMenuViewController ()

@end

@implementation MKMenuViewController

@synthesize scrollView, page;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSInteger pageSize = 2; // ページ数
    CGFloat width = scrollView.bounds.size.width;
    CGFloat height = scrollView.bounds.size.height;
    
    // UIScrollViewのインスタンス化
//    scrollView = [[UIScrollView alloc]init];
//    scrollView.frame = self.view.bounds;
    
    // 横スクロールのインジケータを非表示にする
    scrollView.showsHorizontalScrollIndicator = NO;
    
    // ページングを有効にする
    scrollView.pagingEnabled = YES;
    
    scrollView.userInteractionEnabled = YES;
    scrollView.delegate = self;
    
    // スクロールの範囲を設定
    [scrollView setContentSize:CGSizeMake((pageSize * width), height)];
    
    // スクロールビューを貼付ける
    [self.view addSubview:scrollView];

    // スクロールビューにラベルを貼付ける
//    for (int i = 0; i < pageSize; i++) {
//        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(i * width, 0, width, height)];
//        label.text = [NSString stringWithFormat:@"%d", i + 1];
//        label.font = [UIFont fontWithName:@"Arial" size:92];
//        label.backgroundColor = [UIColor yellowColor];
//        label.textAlignment = NSTextAlignmentCenter;
//        [scrollView addSubview:label];
//    }
    [scrollView addSubview:[[InfoView alloc] initWithFrame:scrollView.frame]];
    [scrollView addSubview:[[InfoView alloc] initWithFrame:scrollView.frame]];

    // ページコントロールのインスタンス化
//    CGFloat x = (width - 300) / 2;
//    pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(x, 350, 300, 50)];
    
    // 背景色を設定
    page.backgroundColor = [UIColor clearColor];
    
    // ページ数を設定
    page.numberOfPages = pageSize;
    
    // 現在のページを設定
    page.currentPage = 0;
    
//    // ページコントロールをタップされたときに呼ばれるメソッドを設定
//    page.userInteractionEnabled = YES;
//    [page addTarget:self
//             action:@selector(pageControl_Tapped:)
//   forControlEvents:UIControlEventValueChanged];
//    
//    // ページコントロールを貼付ける
//    [self.view addSubview:pageControl];
}

/**
 * スクロールビューがスワイプされたとき
 * @attention UIScrollViewのデリゲートメソッド
 */
- (void)scrollViewDidScroll:(UIScrollView *)_scrollView
{
    CGFloat pageWidth = scrollView.frame.size.width;
    if ((NSInteger)fmod(scrollView.contentOffset.x , pageWidth) == 0) {
        // ページコントロールに現在のページを設定
        page.currentPage = scrollView.contentOffset.x / pageWidth;
    }
}

/**
 * ページコントロールがタップされたとき
 */
- (void)pageControl_Tapped:(id)sender
{
    CGRect frame = scrollView.frame;
    frame.origin.x = frame.size.width * page.currentPage;
    [scrollView scrollRectToVisible:frame animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
