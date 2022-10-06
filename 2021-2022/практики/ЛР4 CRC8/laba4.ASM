format PE CONSOLE
include 'C:\FASM\INCLUDE\win32ax.inc'

entry start

section '.data?' data readable writeable

   x1 db 256 dup(?)
   x2 rb 256
   x3 rd 256
   len_x dd ?

section '.CRC8' data readable writeable

        msg_hex db 'hex = %Xh ', 0Dh, 0Ah,0

        crc8_t  db 0x00, 0x31, 0x62, 0x53, 0xC4, 0xF5, 0xA6, 0x97
                db 0xB9, 0x88, 0xDB, 0xEA, 0x7D, 0x4C, 0x1F, 0x2E
                db 0x43, 0x72, 0x21, 0x10, 0x87, 0xB6, 0xE5, 0xD4
                db 0xFA, 0xCB, 0x98, 0xA9, 0x3E, 0x0F, 0x5C, 0x6D
                db 0x86, 0xB7, 0xE4, 0xD5, 0x42, 0x73, 0x20, 0x11
                db 0x3F, 0x0E, 0x5D, 0x6C, 0xFB, 0xCA, 0x99, 0xA8
                db 0xC5, 0xF4, 0xA7, 0x96, 0x01, 0x30, 0x63, 0x52
                db 0x7C, 0x4D, 0x1E, 0x2F, 0xB8, 0x89, 0xDA, 0xEB
                db 0x3D, 0x0C, 0x5F, 0x6E, 0xF9, 0xC8, 0x9B, 0xAA
                db 0x84, 0xB5, 0xE6, 0xD7, 0x40, 0x71, 0x22, 0x13
                db 0x7E, 0x4F, 0x1C, 0x2D, 0xBA, 0x8B, 0xD8, 0xE9
                db 0xC7, 0xF6, 0xA5, 0x94, 0x03, 0x32, 0x61, 0x50
                db 0xBB, 0x8A, 0xD9, 0xE8, 0x7F, 0x4E, 0x1D, 0x2C
                db 0x02, 0x33, 0x60, 0x51, 0xC6, 0xF7, 0xA4, 0x95
                db 0xF8, 0xC9, 0x9A, 0xAB, 0x3C, 0x0D, 0x5E, 0x6F
                db 0x41, 0x70, 0x23, 0x12, 0x85, 0xB4, 0xE7, 0xD6
                db 0x7A, 0x4B, 0x18, 0x29, 0xBE, 0x8F, 0xDC, 0xED
                db 0xC3, 0xF2, 0xA1, 0x90, 0x07, 0x36, 0x65, 0x54
                db 0x39, 0x08, 0x5B, 0x6A, 0xFD, 0xCC, 0x9F, 0xAE
                db 0x80, 0xB1, 0xE2, 0xD3, 0x44, 0x75, 0x26, 0x17
                db 0xFC, 0xCD, 0x9E, 0xAF, 0x38, 0x09, 0x5A, 0x6B
                db 0x45, 0x74, 0x27, 0x16, 0x81, 0xB0, 0xE3, 0xD2
                db 0xBF, 0x8E, 0xDD, 0xEC, 0x7B, 0x4A, 0x19, 0x28
                db 0x06, 0x37, 0x64, 0x55, 0xC2, 0xF3, 0xA0, 0x91
                db 0x47, 0x76, 0x25, 0x14, 0x83, 0xB2, 0xE1, 0xD0
                db 0xFE, 0xCF, 0x9C, 0xAD, 0x3A, 0x0B, 0x58, 0x69
                db 0x04, 0x35, 0x66, 0x57, 0xC0, 0xF1, 0xA2, 0x93
                db 0xBD, 0x8C, 0xDF, 0xEE, 0x79, 0x48, 0x1B, 0x2A
                db 0xC1, 0xF0, 0xA3, 0x92, 0x05, 0x34, 0x67, 0x56
                db 0x78, 0x49, 0x1A, 0x2B, 0xBC, 0x8D, 0xDE, 0xEF
                db 0x82, 0xB3, 0xE0, 0xD1, 0x46, 0x77, 0x24, 0x15
                db 0x3B, 0x0A, 0x59, 0x68, 0xFF, 0xCE, 0x9D, 0xAC


section '.msg' data readable

   msg_d db ' %d ', 0Dh, 0Ah,0
   msg_s db 0Dh, 0Ah,' %s ',  0Dh, 0Ah,0

section '.code' code readable executable

start:
     cinvoke printf,msg_s, 'Enter string of char',0
     cinvoke scanf,   ' %s', x1
     cinvoke strlen,x1
     mov [len_x], eax
     cinvoke printf,msg_d, [len_x],0

     xor ecx, ecx
     @@:
        mov bl, [x1+ecx]
        mov [x2+ecx], bl
        inc ecx
        cmp ecx,[len_x]
        jne @b
     cinvoke printf,msg_s, x2,0

     xor ecx, ecx
     @@:
        mov bl, [x2+ecx]
        inc ecx
        cmp bl, 0
        jne @b
     sub ecx,1
     cinvoke printf,msg_d, ecx,0

     xor ecx, ecx
     @@:
        xor ebx,ebx
        mov bl, [x1+ecx]
        mov [x3+ecx], ebx
        inc ecx
        cmp ecx,[len_x]
        jne @b
     cinvoke printf,msg_s, x3,0

     xor ecx, ecx
     @@:
        mov ebx, [x3+ecx]
        inc ecx
        cmp ebx, 0
        jne @b
     sub ecx,1
     cinvoke printf,msg_d, ecx,0


     cinvoke printf,msg_s, '',0
     mov al,[crc8_t+0]
     cinvoke printf,msg_hex, eax,0

     mov al,[crc8_t+1]
     cinvoke printf,msg_hex, eax,0

     mov al,[crc8_t+255]
     cinvoke printf,msg_hex, eax,0

     cinvoke printf,msg_s, 'CRC8',0
     stdcall CRC8Calc, x1,len_x
     cinvoke printf,msg_hex, eax,0

     cinvoke printf,msg_s, '',0
     stdcall CRC8Poly, 0
     cinvoke printf,msg_hex, eax,0

     stdcall CRC8Poly, 1
     cinvoke printf,msg_hex, eax,0

     stdcall CRC8Poly,255
     cinvoke printf,msg_hex, eax,0


     invoke  sleep, 5000     ; 5 sec. delay

     invoke  exit, 0
     ret

;-----------------------------------------------------------------------
; Функция вычисления хеша CRC8
; с использованием таблицы by ManHunter http://www.manhunter.ru
;-----------------------------------------------------------------------
; Параметры:
;       lpData - указатель на строку
;       dSize  - длина строки
; На выходе:
;       AL = полученный хеш
;-----------------------------------------------------------------------
proc    CRC8Calc lpData:BYTE, dSize:DWORD
    push    ebx ecx

    ; Длина строки
    cmp     [dSize],0
    je      .loc_ret

    ; Инициализация
    xor     ecx,ecx
    mov al, 0FFh

    @@:
         mov bl,[lpData+ecx]
         xor al,bl
         mov al,[crc8_t+eax]
         inc ecx
         cmp ecx,[len_x]
         jne @b

    .loc_ret:
         and     eax,0FFh
         pop     ecx ebx
         ret
endp

;-----------------------------------------------------------------------
; Функция вычисления значения CRC8 полинома
;-----------------------------------------------------------------------
; Параметры: 
;       data - элемент массива
; На выходе:
;       AL = полученный хеш 
;----------------------------------------------------------------------- 
proc    CRC8Poly data:BYTE
        push  esi
  
    CRC8_POLYNOM = 31h ; bin 0011 0001
    mov al,[data]
    xor  esi,esi

    .loc_cycle:
        test  al,80h; dec 128, bin 1 0000 0000
        jz    .loc_1
            shl   al,1
            xor   al,CRC8_POLYNOM
            jmp   .loc_next

        .loc_1:
            shl   al,1

        .loc_next:
            inc   esi
            cmp   esi,8
            jne   .loc_cycle

    .loc_ret:
       pop  esi
       ret
endp


section '.idata' import data readable
 
 library msvcrt,'MSVCRT.DLL',\
    kernel32,'KERNEL32.DLL'
 
 import kernel32,\
    sleep,'Sleep'
 
 import msvcrt,\
    puts,'puts',\
    scanf,'scanf',\
    printf,'printf',\
    strlen,'strlen',\
    exit,'exit'
