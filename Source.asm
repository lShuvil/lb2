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
lea esi,[arr1] ;�������� ������ � ���. �������
lea edi,[arr2] ;������ ����������
mov ecx,len ;����� ������� - ������� �����
@chng: 
lodsd ;��������� ����� �� ��������
not al ;�������� ���
add al,1 ;��������� ����
stosd ;��������� ���������� ����� �� ������ ������
loop @chng
lea esi,[arr2] ;����� �������
mov eax,[esi] ;�������� �`
mov ebx,[esi+4] ; �������� y`
and eax,ebx 
mov edx,eax ;����� ����� ��������� � EDX
mov eax,[esi+8] ;�������� z`
mov ebx,[esi+12] ;�������� q`
or eax,ebx
add eax,edx ;M in eax
mov bl, 4
cmp al, bl
jl @pp2
jge @pp2
@pp1:
mov ebx,[esi+4] ; �������� y`
add eax,ebx
jmp @cmp
@pp2:
mov ebx,eax
mov ecx,999h
sub ebx,ecx
xor eax,eax
lahf ;��������� ������� ������ � AH
and ah,10b ;������� cf 1 ����
cmp ah,2 ;���� cf = 1
je @pp2_1 ;���� CF=1, �������� ����
jne @cmp ;����� �������� , �.�. ������ �� ������
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
