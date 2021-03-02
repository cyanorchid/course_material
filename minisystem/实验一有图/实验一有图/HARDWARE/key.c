

#include 	"msp430f5529.h"
#include  	"key.h"

static	enum    key_type key_value = NOKEY;
static  int 	key_down_flag = 0;
enum key_type	KeyScan(void)
{
        
	if( KEY_L )	
            key_value = KEYLEFT;
        
	else if( KEY_R )		
            key_value = KEYRIGHT;
        
        else
            key_value = NOKEY;
        
        //防止一次按下多次响应，不等待按键抬起，不过多占用CPU
        if      (key_down_flag == 0 && key_value != NOKEY)
        {
            key_down_flag = 1;//第一次监测到按键，按下标志置位，返回此时键值

        }
        else if (key_down_flag == 1 && key_value != NOKEY)
        {
            key_value     = NOKEY;//第一次之后检测按键按下，返回空值
        }
        else
        {
            key_down_flag = 0;//检测按键抬起，按下标识复位，为下一次按下准备
        }
	                        
	return	key_value;
}
