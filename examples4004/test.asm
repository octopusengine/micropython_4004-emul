;run 'python main.py test.asm N'
;where N is some value
;program will calculate sum of 1 + 2 + ... + N
;in registers r2 and r3
;by default N = 5

ldm 0               ; acc = 0
jms $3f0            ; output acc to exp8 + sleep
add r0              ; acc += r0
jms $3f0            ; output acc to exp8 + sleep
jcn an main_loop    ; if acc == 0 jump to main_loop

ldm 5               ; acc = 5
xch r0              ; store it to r0

main_loop:
clc                 ; clear carry
ld r0               ; acc = r0
add r2              ; acc += r2
xch r2              ; store result to r2
tcc                 ; acc = carry
add r3              ; acc += r3 + carry
xch r3              ; store result to r3

ld r0               ; acc = r0
dac                 ; acc -= 1
jcn az end          ; if acc == 0 jump to end
xch r0              ; exchange acc to r0
jun main_loop       ; jump to main_loop

end:
                    ; call custom subroutine for:
jms $3ff            ; printing regs
jms $3fe            ; printMemory(8, 32)
jms $3fd            ; printMemory(4, 16)
