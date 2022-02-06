stm8/

	#include "mapping.inc"
	#include "stm8s103f.inc"
	
pointerX MACRO first
	ldw X,first
	MEND
pointerY MACRO first
	ldw Y,first
	MEND	
	
	
	
	
	
	
	
	segment byte at 100 'ram1'
buffer1  ds.b
buffer2  ds.b
buffer3  ds.b
nibble1  ds.b
data	 ds.b
address  ds.b
buffer4  ds.b 23








	segment 'rom'
main.l
	; initialize SP
	ldw X,#stack_end
	ldw SP,X

	#ifdef RAM0	
	; clear RAM0
ram0_start.b EQU $ram0_segment_start
ram0_end.b EQU $ram0_segment_end
	ldw X,#ram0_start
clear_ram0.l
	clr (X)
	incw X
	cpw X,#ram0_end	
	jrule clear_ram0
	#endif

	#ifdef RAM1
	; clear RAM1
ram1_start.w EQU $ram1_segment_start
ram1_end.w EQU $ram1_segment_end	
	ldw X,#ram1_start
clear_ram1.l
	clr (X)
	incw X
	cpw X,#ram1_end	
	jrule clear_ram1
	#endif

	; clear stack
stack_start.w EQU $stack_segment_start
stack_end.w EQU $stack_segment_end
	ldw X,#stack_start
clear_stack.l
	clr (X)
	incw X
	cpw X,#stack_end	
	jrule clear_stack

infinite_loop.l
	
	mov CLK_CKDIVR,#$00	; cpu clock no divisor = 16mhz
	;UART1_CK PD4
	;UART1_TX PD5
	;UART1_RX PD6
	ld a,#$03			  ;$0683 = 9600 ,$008B = 115200, 
	ld UART1_BRR2,a		  ; write BRR2 firdt
	ld a,#$68
	ld UART1_BRR1,a		  ; write BRR1 next
	bset UART1_CR2,#3	  ; enable TX
	bset UART1_CR2,#2	  ; enable RX
	
write:
	mov buffer1,#$ff
	call delay
;	pointerX #string
;	call loop
	mov buffer2,#21
	pointerX #buffer4
loop1:
	call UART_RX
	mov buffer1,#$ff
	call delay
	ld a,data
	ld (X),a
	incw X
	dec buffer2
	jrne loop1
	ld a,#'\n'
	ld (x),a
	incw x
	ld a,#'\r'
	ld (x),a
	mov data,#'\n'
	call UART_TX
	mov data,#'\r'
	call UART_TX
	mov buffer2,#23
	pointerX #buffer4
loop2:
	ld a,(x)
	ld data,a
	call UART_TX
	incw x
	dec buffer2
	jrne loop2
	
	jp write
	
	
loop:
	ld a,(X)
	incw X
	cp a,#$00
	jreq exit
	ld data,a
	call UART_TX
	jp loop
exit:
	nop
	ret
	
	
UART_TX:
	ld a,data
	ld UART1_DR,a
TC_FLAG:
	btjf UART1_SR,#6 ,TC_FLAG
	ret
	
UART_RX:
    btjf UART1_SR,#5 ,UART_RX
	mov data,UART1_DR
	ret
	
string:
	  dc.B " Hello world!" ,'\n','\n','\r',0


	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;DELAY ROUTINE								  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
delay 
     ld a , buffer1
load_ms	 
     ldw y , #$C80                ; 0x61a80 = 400000 ie (2 * 10 ^ 6 MHz) / 5cycles 
loopd 
     subw y , #01                 ; decrement with set carry 
     jrne loopd
	 dec a
	 jrne load_ms
	 
    ret 


usdelay
	dec buffer1
	jrne usdelay
	ret	
	
	
	
	
	
	
	
	
	
	
	
	
	

	interrupt NonHandledInterrupt
NonHandledInterrupt.l
	iret

	segment 'vectit'
	dc.l {$82000000+main}									; reset
	dc.l {$82000000+NonHandledInterrupt}	; trap
	dc.l {$82000000+NonHandledInterrupt}	; irq0
	dc.l {$82000000+NonHandledInterrupt}	; irq1
	dc.l {$82000000+NonHandledInterrupt}	; irq2
	dc.l {$82000000+NonHandledInterrupt}	; irq3
	dc.l {$82000000+NonHandledInterrupt}	; irq4
	dc.l {$82000000+NonHandledInterrupt}	; irq5
	dc.l {$82000000+NonHandledInterrupt}	; irq6
	dc.l {$82000000+NonHandledInterrupt}	; irq7
	dc.l {$82000000+NonHandledInterrupt}	; irq8
	dc.l {$82000000+NonHandledInterrupt}	; irq9
	dc.l {$82000000+NonHandledInterrupt}	; irq10
	dc.l {$82000000+NonHandledInterrupt}	; irq11
	dc.l {$82000000+NonHandledInterrupt}	; irq12
	dc.l {$82000000+NonHandledInterrupt}	; irq13
	dc.l {$82000000+NonHandledInterrupt}	; irq14
	dc.l {$82000000+NonHandledInterrupt}	; irq15
	dc.l {$82000000+NonHandledInterrupt}	; irq16
	dc.l {$82000000+NonHandledInterrupt}	; irq17
	dc.l {$82000000+NonHandledInterrupt}	; irq18
	dc.l {$82000000+NonHandledInterrupt}	; irq19
	dc.l {$82000000+NonHandledInterrupt}	; irq20
	dc.l {$82000000+NonHandledInterrupt}	; irq21
	dc.l {$82000000+NonHandledInterrupt}	; irq22
	dc.l {$82000000+NonHandledInterrupt}	; irq23
	dc.l {$82000000+NonHandledInterrupt}	; irq24
	dc.l {$82000000+NonHandledInterrupt}	; irq25
	dc.l {$82000000+NonHandledInterrupt}	; irq26
	dc.l {$82000000+NonHandledInterrupt}	; irq27
	dc.l {$82000000+NonHandledInterrupt}	; irq28
	dc.l {$82000000+NonHandledInterrupt}	; irq29

	end
