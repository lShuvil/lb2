.686
.model flat,stdcall
.stack 100h

.data
arr1 dd 0b8f7h, 3da6h, 911ch, 6633h
len equ ($-arr1)/4
arr2 dd 3 dup (?)

.code
ExitProcess PROTO STDCALL :DWORD
Start:
xor eax,eax
xor ebx,ebx
xor ecx,ecx
xor edx,edx
lea esi,[arr1] ;приемный массив с исх. данными
lea edi,[arr2] ;массив получатель
mov ecx,len ;длина массива - счетчик цикла
@chng: 
lodsd ;загрузили число из исходных
not al ;инверсия бит
add al,1 ;прибвляем один
stosd ;загружаем измененное число во второй массив
loop @chng
lea esi,[arr2] ;адрес массива
mov eax,[esi] ;получили х`
mov ebx,[esi+4] ; получили y`
and eax,ebx 
mov edx,eax ;левая часть выражения в EDX
mov eax,[esi+8] ;получили z`
mov ebx,[esi+12] ;получили q`
or eax,ebx
add eax,edx ;M in eax
mov bl, 4
cmp al, bl
jl @pp2
jge @pp2
@pp1:
mov ebx,[esi+4] ; получили y`
add eax,ebx
jmp @cmp
@pp2:
mov ebx,eax
mov ecx,999h
sub ebx,ecx
xor eax,eax
lahf ;загрузили регистр флагов в AH
and ah,10b ;регистр cf 1 байт
cmp ah,2 ;если cf = 1
je @pp2_1 ;если CF=1, вычитаем один
jne @cmp ;иначе вычитаем , т.е. ничего не делаем
@pp2_1:
sub ebx,1
jmp @cmp
@cmp:
mov eax,ebx
cmp eax,0h
jl @adr1
jge @adr2
@adr1:
xor eax,[esi]
jmp @result
@adr2:
xor eax,1011h
jmp @result
@result:
mov ebx,eax
mov ecx,eax
mov edx,eax

exit:
Invoke ExitProcess,1
End Start
