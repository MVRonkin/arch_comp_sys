format PE CONSOLE
include 'C:\FASM\INCLUDE\win32ax.inc'


entry start

section '.data?' data readable writeable

   A    dd ?
   B    dd ?
   C    dd ?
   D    dd ?

section '.data' data readable
   answ    db  'A+B+1 = %d',0

section '.code' code readable executable

macro mov_zero op1 {
    mov op1,0
}

proc add2val, val1, val2
    mov eax,[val1]
    add eax,[val2]
    ret
endp

start:

     cinvoke puts,    'Enter A ', 0
     cinvoke scanf,   '%d', A    ;  A
     cinvoke printf,  'Enter B ', 0
     cinvoke scanf,   '%d', B    ;  A

     mov eax,[A]
     add eax,[B]
     lea ebx,[eax]
     xchg ecx,ebx
     inc  ecx

     mov [C],ecx
     cinvoke printf, answ , [C],0



     mov eax,[A]
     mov ebx,[B]
     imul ebx, eax
     cinvoke printf, '  mull = %d   ' , ebx,0

     mov edx, [C]
     mov_zero ecx

     .repeat
        add edx,10
        inc ecx
     .until edx>130

     mov [D],ecx

     cinvoke printf, ' D  %d  ' , [D],0

     mov_zero ebx
     cinvoke printf, 'mov_zero   %d  ' , ebx,0

     stdcall add2val, 10, 2
     cinvoke printf, ' add2reg  %d  ' , eax,0



     invoke  sleep, 5000     ; 5 sec. delay

     invoke  exit, 0
     ret







section '.idata' import data readable
 
 library msvcrt,'MSVCRT.DLL',\
    kernel32,'KERNEL32.DLL'
 
 import kernel32,\
    sleep,'Sleep'
 
 import msvcrt,\
    puts,'puts',\
    scanf,'scanf',\
    printf,'printf',\
    exit,'exit'
