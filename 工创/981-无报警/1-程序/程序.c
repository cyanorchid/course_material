#include <reg52.h>
#include <intrins.h>	 //			 包含头文件

#define uint            unsigned int
#define uchar           unsigned char
#define ulong           unsigned long	 //宏定义
#define LCD_DATA        P0				 //定义P0口为LCD_DATA

sbit LCD_RS =P2^5;
sbit LCD_RW =P2^6;
sbit LCD_E  =P2^7;						 //定义LCD控制引脚

sbit Xintiao =P1^0 ;					 //脉搏检测输入端定义

void delay5ms(void);   //误差 0us
void LCD_WriteData(uchar LCD_1602_DATA);	 /********LCD1602数据写入***********/
void LCD_WriteCom(uchar LCD_1602_COM);		 /********LCD1602命令写入***********/
void lcd_1602_word(uchar Adress_Com,uchar Num_Adat,uchar *Adress_Data); /*1602字符显示函数，变量依次为字符显示首地址，显示字符长度，所显示的字符*/
void InitLcd();//液晶初始化函数

void Tim_Init();

uchar Xintiao_Change=0;	   //
uint  Xintiao_Jishu;
uchar stop;
uchar View_Data[3];

uchar View_Change;

void main()	  //主函数
{
 InitLcd();
 Tim_Init();
 lcd_1602_word(0x80,16,"Heart Rate:     ");	  //初始化显示
 TR0=1;
 TR1=1;				  //打开定时器
 while(1)			  //进入循环
  {
   if(View_Change)//开始显示变量
    {
	 View_Change=0;//变量清零
	 if(stop==0)			  //心率正常时
	  {
	   if(View_Data[0]==0x30) //最高位为0时不显示
	    View_Data[0]=' ';
	  }
	 else					  //心率不正常（计数超过5000，也就是两次信号时间超过5s）不显示数据
	  {
	   View_Data[0]=' ';
	   View_Data[1]=' ';
	   View_Data[2]=' ';
	  }
	lcd_1602_word(0xcd,3,View_Data);			 //第二行显示心率
	}
  }
}

void Time1() interrupt 3		//定时器1服务函数
{
 static uchar Xintiao_Con;
 TH1=0xd8;		   //10ms
 TL1=0xf0;		   //重新赋初值

 switch (Xintiao_Con)
  {
   case 0:			 //默认Xintiao_Con是为0的
          {
		   if(!Xintiao)//每10ms（上面的定时器）检测一次脉搏是否有信号
		    {
			 Xintiao_Con++;//如果有信号，变量加一，程序就会往下走了
			}
		   break;
		  }
   case 1:
          {
		   if(!Xintiao)	   //每过10ms检测一下信号是否还存在
		    {
			 Xintiao_Con++;//存在就加一
			}
		   else
		    {
			 Xintiao_Con=0;//如果不存在了，检测时间很短，说明检测到的不是脉搏信号，可能是其他干扰，将变量清零，跳出此次检测
			} 
		   break;
		  }
  case 2:
          {
		   if(!Xintiao)
		    {
			 Xintiao_Con++;//存在就加一
			}
		   else
		    {
			 Xintiao_Con=0;//如果不存在了，检测时间很短，说明检测到的不是脉搏信号，可能是其他干扰，将变量清零，跳出此次检测
			} 
		   break;
		  }
  case 3:
          {
		   if(!Xintiao)
		    {
			 Xintiao_Con++;//存在就加一
			}
		   else
		    {
			 Xintiao_Con=0;//如果不存在了，检测时间很短，说明检测到的不是脉搏信号，可能是其他干扰，将变量清零，跳出此次检测
			} 
		   break;
		  }
  case 4:
          {
		   if(Xintiao)//超过30ms一直有信号，判定此次是脉搏信号，执行以下程序
		    {
			 if(Xintiao_Change==1)//心率计原理为检测两次脉冲间隔时间计算心率，变量Xintiao_Change第一次脉冲时为0的，所有走下面的else，第二次走这里
			  {
			   View_Data[0]=(60000/Xintiao_Jishu)/100+0x30;
	           View_Data[1]=(60000/Xintiao_Jishu)%100/10+0x30;
	           View_Data[2]=(60000/Xintiao_Jishu)%10+0x30;


			   View_Change=1;	   //计算出心率后启动显示
			   Xintiao_Jishu=0;	   //心跳计数清零
			   Xintiao_Change=0;   //计算出心率后该变量清零，准备下次检测心率
			   stop=0;			   //计算出心率后stop清零
			  }
			 else//第一次脉冲时Xintiao_Change为0
			  {
			   Xintiao_Jishu=0;	//脉冲计时变量清零，开始计时
			   Xintiao_Change=1;//Xintiao_Change置1，准备第二次检测到脉冲时计算心率
			  }
			 Xintiao_Con=0;	//清零，准备检测下一次脉冲
			 break;
			}
		  }
  }
}
/**定时器T0工作函数**/
void Time0() interrupt 1
{
 TH0=0xfc;		   //1ms
 TL0=0x18;		   //重新赋初值
 Xintiao_Jishu++;  //心跳计数加
 if(Xintiao_Jishu==5000)//心跳计数大于5000
  {
   Xintiao_Jishu=0;		//数据清零
   View_Change=1;		//显示位置1
   Xintiao_Change=0;	//置零，准备再次检测
   stop=1;	   //心跳计数超过5000后说明心率不正常或者没有测出，stop置1
  }
}
/**定时器初始化函数**/
void Tim_Init()
{
 EA=1;			  //打开中断总开关
 ET0=1;			  //打开T0中断允许开关
 ET1=1;			  //打开T1中断允许开关
 TMOD=0x11;		  //设定定时器状态
 TH0=0xfc;		   //1ms
 TL0=0x18;		   //赋初值
 
 TH1=0xd8;		   //10ms
 TL1=0xf0;		   //赋初值
}
/**在指定地址显示指定数量的指定字符**/
/**Adress_Com显示地址，Num_Adat显示字符数量，Adress_Data显示字符串内容**/ 
void lcd_1602_word(uchar Adress_Com,uchar Num_Adat,uchar *Adress_Data)
{
 uchar a=0;
 uchar Data_Word;
 LCD_WriteCom(Adress_Com); //选中地址
 for(a=0;a<Num_Adat;a++)   //for循环决定显示字符个数
  {
   Data_Word=*Adress_Data;	  //读取字符串数据
   LCD_WriteData(Data_Word);  //显示字符串
   Adress_Data++;			  //显示地址加一
  }
}

/***************1602函数*******************/
void LCD_WriteData(uchar LCD_1602_DATA)	 /********LCD1602数据写入***********/
{
 delay5ms();  //操作前短暂延时，保证信号稳定
 LCD_E=0;
 LCD_RS=1;
 LCD_RW=0;
 _nop_();
 LCD_E=1;
 LCD_DATA=LCD_1602_DATA;
 LCD_E=0;
 LCD_RS=0;
}

/********LCD1602命令写入***********/
void LCD_WriteCom(uchar LCD_1602_COM)
{
 delay5ms();//操作前短暂延时，保证信号稳定
 LCD_E=0;
 LCD_RS=0;
 LCD_RW=0;
 _nop_();
 LCD_E=1;
 LCD_DATA=LCD_1602_COM;
 LCD_E=0;
 LCD_RS=0;
}


void InitLcd()		   //初始化液晶函数
{
 delay5ms();
 delay5ms();
 LCD_WriteCom(0x38); //display mode
 LCD_WriteCom(0x38); //display mode
 LCD_WriteCom(0x38); //display mode
 LCD_WriteCom(0x06); //显示光标移动位置
 LCD_WriteCom(0x0c); //显示开及光标设置
 LCD_WriteCom(0x01); //显示清屏
 delay5ms();
 delay5ms();
}

void delay5ms(void)   //5ms延时函数
{
    unsigned char a,b;
    for(b=185;b>0;b--)
        for(a=12;a>0;a--);
}
