start:
	move.l	#1526945273,d0
	bsr	SquareRoot
	rts

; d0.l -> x
; sqrt(x) -> d0.w

SquareRoot:
	movem.l	d1-d3,-(sp)
	moveq	#0,d1	;x'=0
	moveq	#0,d2	;y=0
	moveq	#15,d3
.loop
	lsl.l	d0
	roxl.l	d1
	lsl.l	d0
	roxl.l	d1	;2 décalage
	lsl.l	#2,d2
	addq.l	#1,d2	;4*y+1
	cmp.l	d2,d1	;((4*y+1)<=x') ?
	bcs.s	.jump	;Non
	sub.l	d2,d1
	addq.l	#1,d2	;Oui
.jump
	lsr.l	d2
	dbra	d3,.loop
	move.l	d2,d0
	movem.l	(sp)+,d1-d3
	rts
