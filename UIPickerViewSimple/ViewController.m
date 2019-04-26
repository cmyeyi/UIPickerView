
#import "ViewController.h"

@interface ViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>

@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;
@property (strong, nonatomic) IBOutlet UILabel *labelView;
@property (strong, nonatomic) IBOutlet UIButton *button;

@property (strong, nonatomic) NSDictionary *allData;
@property (strong, nonatomic) NSArray *level1;//一级目录数据
@property (strong, nonatomic) NSArray *level2;//二级目录数据
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //将委托协议和数据源协议分配给pickerView
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
    
    [self initData];
    [self.button addTarget:self action:@selector(onCLickButton:) forControlEvents:UIControlEventTouchDown];
}

- (IBAction)onCLickButton:(id)sender {
    NSInteger row1 = [self.pickerView selectedRowInComponent:0];
    NSInteger row2 = [self.pickerView selectedRowInComponent:1];
    NSString *seleted1 = [self.level1 objectAtIndex:row1];
    NSString *seleted2 = [self.level2 objectAtIndex:row2];
    NSString *title = [[NSString alloc]initWithFormat:@"%@ | %@", seleted1, seleted2];
    self.labelView.text = title;
}

- (void)initData {
    //获取资源文件路径
    NSString *plistPath =  [[NSBundle mainBundle]pathForResource:@"provinces" ofType:@"plist"];
    //获取资源文件中的全部数据
    NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    self.allData = dictionary;
    //获取一级数据
    self.level1 = [self.allData allKeys];
    
    //获取第一个一级单位下的数据
    NSString *seletedLevel1 = [self.level1 objectAtIndex:0];
    self.level2 = [self.allData objectForKey:seletedLevel1];
    
}

#pragma mark 实现UIPickerViewDataSource协议
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}


- (NSInteger) pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if(component == 0) {
        return [self.level1 count];
    } else {
        return [self.level2 count];
    }
    
}


#pragma mark 实现UIPickerViewDelegate协议
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if(component == 0) {
        return [self.level1 objectAtIndex:row];
    } else {
        return [self.level2 objectAtIndex:row];
    }
    
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if(component == 0) {
        NSString *seletedP1 = [self.level1 objectAtIndex:row];
        NSArray *array = [self.allData objectForKey:seletedP1];
        self.level2 = array;
        [self.pickerView reloadComponent:1];
        
    }
}


@end
