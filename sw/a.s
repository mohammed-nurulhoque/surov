
/config/dhrystone/a.out:     file format elf32-littleriscv


Disassembly of section .text:

00010094 <main>:
   10094:	ef010113          	add	sp,sp,-272
   10098:	00013737          	lui	a4,0x13
   1009c:	e7070713          	add	a4,a4,-400 # 12e70 <_start+0x53c>
   100a0:	07010293          	add	t0,sp,112
   100a4:	000137b7          	lui	a5,0x13
   100a8:	e9078793          	add	a5,a5,-368 # 12e90 <_start+0x55c>
   100ac:	00072f03          	lw	t5,0(a4)
   100b0:	00472e83          	lw	t4,4(a4)
   100b4:	8251a823          	sw	t0,-2000(gp) # 1413c <Next_Ptr_Glob>
   100b8:	0f712623          	sw	s7,236(sp)
   100bc:	0a010f93          	add	t6,sp,160
   100c0:	00c72303          	lw	t1,12(a4)
   100c4:	00872e03          	lw	t3,8(a4)
   100c8:	01072883          	lw	a7,16(a4)
   100cc:	01472803          	lw	a6,20(a4)
   100d0:	01872503          	lw	a0,24(a4)
   100d4:	01c75583          	lhu	a1,28(a4)
   100d8:	01e74603          	lbu	a2,30(a4)
   100dc:	0007a683          	lw	a3,0(a5)
   100e0:	0047a703          	lw	a4,4(a5)
   100e4:	83f1aa23          	sw	t6,-1996(gp) # 14140 <Ptr_Glob>
   100e8:	00200f93          	li	t6,2
   100ec:	0bf12423          	sw	t6,168(sp)
   100f0:	02800f93          	li	t6,40
   100f4:	10112623          	sw	ra,268(sp)
   100f8:	0a512023          	sw	t0,160(sp)
   100fc:	0bf12623          	sw	t6,172(sp)
   10100:	0be12823          	sw	t5,176(sp)
   10104:	0bd12a23          	sw	t4,180(sp)
   10108:	0f912223          	sw	s9,228(sp)
   1010c:	10812423          	sw	s0,264(sp)
   10110:	10912223          	sw	s1,260(sp)
   10114:	11212023          	sw	s2,256(sp)
   10118:	0f312e23          	sw	s3,252(sp)
   1011c:	0f412c23          	sw	s4,248(sp)
   10120:	0f512a23          	sw	s5,244(sp)
   10124:	0f612823          	sw	s6,240(sp)
   10128:	0f812423          	sw	s8,232(sp)
   1012c:	0fa12023          	sw	s10,224(sp)
   10130:	0db12e23          	sw	s11,220(sp)
   10134:	0a012223          	sw	zero,164(sp)
   10138:	0bc12c23          	sw	t3,184(sp)
   1013c:	0d112023          	sw	a7,192(sp)
   10140:	0d012223          	sw	a6,196(sp)
   10144:	0087a883          	lw	a7,8(a5)
   10148:	00c7a803          	lw	a6,12(a5)
   1014c:	0cb11623          	sh	a1,204(sp)
   10150:	0cc10723          	sb	a2,206(sp)
   10154:	0107a583          	lw	a1,16(a5)
   10158:	0147a603          	lw	a2,20(a5)
   1015c:	02d12823          	sw	a3,48(sp)
   10160:	02e12a23          	sw	a4,52(sp)
   10164:	0187a683          	lw	a3,24(a5)
   10168:	01c7d703          	lhu	a4,28(a5)
   1016c:	01e7c783          	lbu	a5,30(a5)
   10170:	00014cb7          	lui	s9,0x14
   10174:	0ca12423          	sw	a0,200(sp)
   10178:	04e11623          	sh	a4,76(sp)
   1017c:	04f10723          	sb	a5,78(sp)
   10180:	218c8713          	add	a4,s9,536 # 14218 <Arr_2_Glob>
   10184:	00a00793          	li	a5,10
   10188:	00a00513          	li	a0,10
   1018c:	64f72e23          	sw	a5,1628(a4)
   10190:	0a612e23          	sw	t1,188(sp)
   10194:	03112c23          	sw	a7,56(sp)
   10198:	03012e23          	sw	a6,60(sp)
   1019c:	04b12023          	sw	a1,64(sp)
   101a0:	04c12223          	sw	a2,68(sp)
   101a4:	04d12423          	sw	a3,72(sp)
   101a8:	229000ef          	jal	10bd0 <putchar>
   101ac:	00013537          	lui	a0,0x13
   101b0:	94450513          	add	a0,a0,-1724 # 12944 <_start+0x10>
   101b4:	1ed000ef          	jal	10ba0 <puts>
   101b8:	00a00513          	li	a0,10
   101bc:	215000ef          	jal	10bd0 <putchar>
   101c0:	8201a783          	lw	a5,-2016(gp) # 1412c <Reg>
   101c4:	60078063          	beqz	a5,107c4 <main+0x730>
   101c8:	00013537          	lui	a0,0x13
   101cc:	97450513          	add	a0,a0,-1676 # 12974 <_start+0x40>
   101d0:	1d1000ef          	jal	10ba0 <puts>
   101d4:	00a00513          	li	a0,10
   101d8:	1f9000ef          	jal	10bd0 <putchar>
   101dc:	00013537          	lui	a0,0x13
   101e0:	7d000593          	li	a1,2000
   101e4:	9d050513          	add	a0,a0,-1584 # 129d0 <_start+0x9c>
   101e8:	149000ef          	jal	10b30 <printf>
   101ec:	00000513          	li	a0,0
   101f0:	209000ef          	jal	10bf8 <time>
   101f4:	000137b7          	lui	a5,0x13
   101f8:	eb078793          	add	a5,a5,-336 # 12eb0 <_start+0x57c>
   101fc:	0047a703          	lw	a4,4(a5)
   10200:	0007ad83          	lw	s11,0(a5)
   10204:	00100493          	li	s1,1
   10208:	00e12023          	sw	a4,0(sp)
   1020c:	0087a703          	lw	a4,8(a5)
   10210:	00e12223          	sw	a4,4(sp)
   10214:	00c7a703          	lw	a4,12(a5)
   10218:	00e12423          	sw	a4,8(sp)
   1021c:	0107a703          	lw	a4,16(a5)
   10220:	00e12623          	sw	a4,12(sp)
   10224:	0147a703          	lw	a4,20(a5)
   10228:	00e12823          	sw	a4,16(sp)
   1022c:	0187a703          	lw	a4,24(a5)
   10230:	00e12a23          	sw	a4,20(sp)
   10234:	01c7d703          	lhu	a4,28(a5)
   10238:	01e7c783          	lbu	a5,30(a5)
   1023c:	00e12c23          	sw	a4,24(sp)
   10240:	00f12e23          	sw	a5,28(sp)
   10244:	00013737          	lui	a4,0x13
   10248:	80a1ae23          	sw	a0,-2020(gp) # 14128 <Begin_Time>
   1024c:	ed070d13          	add	s10,a4,-304 # 12ed0 <_start+0x59c>
   10250:	04100713          	li	a4,65
   10254:	82e182a3          	sb	a4,-2011(gp) # 14131 <Ch_1_Glob>
   10258:	04200713          	li	a4,66
   1025c:	82e18223          	sb	a4,-2012(gp) # 14130 <Ch_2_Glob>
   10260:	00012703          	lw	a4,0(sp)
   10264:	00100793          	li	a5,1
   10268:	05010593          	add	a1,sp,80
   1026c:	04e12a23          	sw	a4,84(sp)
   10270:	00412703          	lw	a4,4(sp)
   10274:	03010513          	add	a0,sp,48
   10278:	82f1a423          	sw	a5,-2008(gp) # 14134 <Bool_Glob>
   1027c:	04e12c23          	sw	a4,88(sp)
   10280:	00812703          	lw	a4,8(sp)
   10284:	02f12623          	sw	a5,44(sp)
   10288:	05b12823          	sw	s11,80(sp)
   1028c:	04e12e23          	sw	a4,92(sp)
   10290:	00c12703          	lw	a4,12(sp)
   10294:	06e12023          	sw	a4,96(sp)
   10298:	01012703          	lw	a4,16(sp)
   1029c:	06e12223          	sw	a4,100(sp)
   102a0:	01412703          	lw	a4,20(sp)
   102a4:	06e12423          	sw	a4,104(sp)
   102a8:	01812703          	lw	a4,24(sp)
   102ac:	06e11623          	sh	a4,108(sp)
   102b0:	01c12703          	lw	a4,28(sp)
   102b4:	06e10723          	sb	a4,110(sp)
   102b8:	029000ef          	jal	10ae0 <Func_2>
   102bc:	00153793          	seqz	a5,a0
   102c0:	02810613          	add	a2,sp,40
   102c4:	00300593          	li	a1,3
   102c8:	82f1a423          	sw	a5,-2008(gp) # 14134 <Bool_Glob>
   102cc:	00200513          	li	a0,2
   102d0:	00700793          	li	a5,7
   102d4:	02f12423          	sw	a5,40(sp)
   102d8:	768000ef          	jal	10a40 <Proc_7>
   102dc:	02812683          	lw	a3,40(sp)
   102e0:	00300613          	li	a2,3
   102e4:	218c8593          	add	a1,s9,536
   102e8:	84418513          	add	a0,gp,-1980 # 14150 <Arr_1_Glob>
   102ec:	764000ef          	jal	10a50 <Proc_8>
   102f0:	8341a503          	lw	a0,-1996(gp) # 14140 <Ptr_Glob>
   102f4:	50c000ef          	jal	10800 <Proc_1>
   102f8:	8241c703          	lbu	a4,-2012(gp) # 14130 <Ch_2_Glob>
   102fc:	04000793          	li	a5,64
   10300:	4ae7fe63          	bgeu	a5,a4,107bc <main+0x728>
   10304:	04100a93          	li	s5,65
   10308:	00300913          	li	s2,3
   1030c:	04300593          	li	a1,67
   10310:	000a8513          	mv	a0,s5
   10314:	7ac000ef          	jal	10ac0 <Func_1>
   10318:	02c12783          	lw	a5,44(sp)
   1031c:	001a8713          	add	a4,s5,1
   10320:	42f50663          	beq	a0,a5,1074c <main+0x6b8>
   10324:	8241c783          	lbu	a5,-2012(gp) # 14130 <Ch_2_Glob>
   10328:	0ff77a93          	zext.b	s5,a4
   1032c:	ff57f0e3          	bgeu	a5,s5,1030c <main+0x278>
   10330:	00191793          	sll	a5,s2,0x1
   10334:	01278933          	add	s2,a5,s2
   10338:	02812a83          	lw	s5,40(sp)
   1033c:	00090513          	mv	a0,s2
   10340:	000a8593          	mv	a1,s5
   10344:	4f0020ef          	jal	12834 <__divsi3>
   10348:	8251c703          	lbu	a4,-2011(gp) # 14131 <Ch_1_Glob>
   1034c:	04100793          	li	a5,65
   10350:	00050693          	mv	a3,a0
   10354:	00f71863          	bne	a4,a5,10364 <main+0x2d0>
   10358:	82c1a783          	lw	a5,-2004(gp) # 14138 <Int_Glob>
   1035c:	00950693          	add	a3,a0,9
   10360:	40f686b3          	sub	a3,a3,a5
   10364:	00148493          	add	s1,s1,1
   10368:	7d100793          	li	a5,2001
   1036c:	eef492e3          	bne	s1,a5,10250 <main+0x1bc>
   10370:	00a12223          	sw	a0,4(sp)
   10374:	00000513          	li	a0,0
   10378:	00d12023          	sw	a3,0(sp)
   1037c:	07d000ef          	jal	10bf8 <time>
   10380:	00050713          	mv	a4,a0
   10384:	00013537          	lui	a0,0x13
   10388:	a0050513          	add	a0,a0,-1536 # 12a00 <_start+0xcc>
   1038c:	80e1ac23          	sw	a4,-2024(gp) # 14124 <End_Time>
   10390:	011000ef          	jal	10ba0 <puts>
   10394:	00a00513          	li	a0,10
   10398:	039000ef          	jal	10bd0 <putchar>
   1039c:	00013537          	lui	a0,0x13
   103a0:	a1050513          	add	a0,a0,-1520 # 12a10 <_start+0xdc>
   103a4:	7fc000ef          	jal	10ba0 <puts>
   103a8:	00a00513          	li	a0,10
   103ac:	025000ef          	jal	10bd0 <putchar>
   103b0:	82c1a583          	lw	a1,-2004(gp) # 14138 <Int_Glob>
   103b4:	00013537          	lui	a0,0x13
   103b8:	a4850513          	add	a0,a0,-1464 # 12a48 <_start+0x114>
   103bc:	000134b7          	lui	s1,0x13
   103c0:	770000ef          	jal	10b30 <printf>
   103c4:	00500593          	li	a1,5
   103c8:	a6448513          	add	a0,s1,-1436 # 12a64 <_start+0x130>
   103cc:	764000ef          	jal	10b30 <printf>
   103d0:	8281a583          	lw	a1,-2008(gp) # 14134 <Bool_Glob>
   103d4:	00013537          	lui	a0,0x13
   103d8:	a8050513          	add	a0,a0,-1408 # 12a80 <_start+0x14c>
   103dc:	754000ef          	jal	10b30 <printf>
   103e0:	00100593          	li	a1,1
   103e4:	a6448513          	add	a0,s1,-1436
   103e8:	748000ef          	jal	10b30 <printf>
   103ec:	8251c583          	lbu	a1,-2011(gp) # 14131 <Ch_1_Glob>
   103f0:	00013537          	lui	a0,0x13
   103f4:	a9c50513          	add	a0,a0,-1380 # 12a9c <_start+0x168>
   103f8:	738000ef          	jal	10b30 <printf>
   103fc:	000139b7          	lui	s3,0x13
   10400:	04100593          	li	a1,65
   10404:	ab898513          	add	a0,s3,-1352 # 12ab8 <_start+0x184>
   10408:	728000ef          	jal	10b30 <printf>
   1040c:	8241c583          	lbu	a1,-2012(gp) # 14130 <Ch_2_Glob>
   10410:	00013537          	lui	a0,0x13
   10414:	ad450513          	add	a0,a0,-1324 # 12ad4 <_start+0x1a0>
   10418:	718000ef          	jal	10b30 <printf>
   1041c:	04200593          	li	a1,66
   10420:	ab898513          	add	a0,s3,-1352
   10424:	70c000ef          	jal	10b30 <printf>
   10428:	84418c13          	add	s8,gp,-1980 # 14150 <Arr_1_Glob>
   1042c:	020c2583          	lw	a1,32(s8)
   10430:	00013537          	lui	a0,0x13
   10434:	af050513          	add	a0,a0,-1296 # 12af0 <_start+0x1bc>
   10438:	6f8000ef          	jal	10b30 <printf>
   1043c:	00700593          	li	a1,7
   10440:	a6448513          	add	a0,s1,-1436
   10444:	6ec000ef          	jal	10b30 <printf>
   10448:	000147b7          	lui	a5,0x14
   1044c:	21878793          	add	a5,a5,536 # 14218 <Arr_2_Glob>
   10450:	65c7a583          	lw	a1,1628(a5)
   10454:	00013537          	lui	a0,0x13
   10458:	b0c50513          	add	a0,a0,-1268 # 12b0c <_start+0x1d8>
   1045c:	6d4000ef          	jal	10b30 <printf>
   10460:	00013537          	lui	a0,0x13
   10464:	b2850513          	add	a0,a0,-1240 # 12b28 <_start+0x1f4>
   10468:	738000ef          	jal	10ba0 <puts>
   1046c:	00013537          	lui	a0,0x13
   10470:	b5450513          	add	a0,a0,-1196 # 12b54 <_start+0x220>
   10474:	72c000ef          	jal	10ba0 <puts>
   10478:	8341a703          	lw	a4,-1996(gp) # 14140 <Ptr_Glob>
   1047c:	00013d37          	lui	s10,0x13
   10480:	b60d0513          	add	a0,s10,-1184 # 12b60 <_start+0x22c>
   10484:	00072583          	lw	a1,0(a4)
   10488:	00013c37          	lui	s8,0x13
   1048c:	00013b37          	lui	s6,0x13
   10490:	6a0000ef          	jal	10b30 <printf>
   10494:	00013537          	lui	a0,0x13
   10498:	b7c50513          	add	a0,a0,-1156 # 12b7c <_start+0x248>
   1049c:	704000ef          	jal	10ba0 <puts>
   104a0:	8341a703          	lw	a4,-1996(gp) # 14140 <Ptr_Glob>
   104a4:	bacc0513          	add	a0,s8,-1108 # 12bac <_start+0x278>
   104a8:	00013a37          	lui	s4,0x13
   104ac:	00472583          	lw	a1,4(a4)
   104b0:	000139b7          	lui	s3,0x13
   104b4:	00013437          	lui	s0,0x13
   104b8:	678000ef          	jal	10b30 <printf>
   104bc:	00000593          	li	a1,0
   104c0:	a6448513          	add	a0,s1,-1436
   104c4:	66c000ef          	jal	10b30 <printf>
   104c8:	8341a703          	lw	a4,-1996(gp) # 14140 <Ptr_Glob>
   104cc:	bc8b0513          	add	a0,s6,-1080 # 12bc8 <_start+0x294>
   104d0:	41590933          	sub	s2,s2,s5
   104d4:	00872583          	lw	a1,8(a4)
   104d8:	658000ef          	jal	10b30 <printf>
   104dc:	00200593          	li	a1,2
   104e0:	a6448513          	add	a0,s1,-1436
   104e4:	64c000ef          	jal	10b30 <printf>
   104e8:	8341a703          	lw	a4,-1996(gp) # 14140 <Ptr_Glob>
   104ec:	be4a0513          	add	a0,s4,-1052 # 12be4 <_start+0x2b0>
   104f0:	00c72583          	lw	a1,12(a4)
   104f4:	63c000ef          	jal	10b30 <printf>
   104f8:	01100593          	li	a1,17
   104fc:	a6448513          	add	a0,s1,-1436
   10500:	630000ef          	jal	10b30 <printf>
   10504:	8341a583          	lw	a1,-1996(gp) # 14140 <Ptr_Glob>
   10508:	c0098513          	add	a0,s3,-1024 # 12c00 <_start+0x2cc>
   1050c:	01058593          	add	a1,a1,16
   10510:	620000ef          	jal	10b30 <printf>
   10514:	c1c40513          	add	a0,s0,-996 # 12c1c <_start+0x2e8>
   10518:	688000ef          	jal	10ba0 <puts>
   1051c:	00013537          	lui	a0,0x13
   10520:	c5050513          	add	a0,a0,-944 # 12c50 <_start+0x31c>
   10524:	67c000ef          	jal	10ba0 <puts>
   10528:	8301a703          	lw	a4,-2000(gp) # 1413c <Next_Ptr_Glob>
   1052c:	b60d0513          	add	a0,s10,-1184
   10530:	00072583          	lw	a1,0(a4)
   10534:	5fc000ef          	jal	10b30 <printf>
   10538:	00013537          	lui	a0,0x13
   1053c:	c6050513          	add	a0,a0,-928 # 12c60 <_start+0x32c>
   10540:	660000ef          	jal	10ba0 <puts>
   10544:	8301a703          	lw	a4,-2000(gp) # 1413c <Next_Ptr_Glob>
   10548:	bacc0513          	add	a0,s8,-1108
   1054c:	00472583          	lw	a1,4(a4)
   10550:	5e0000ef          	jal	10b30 <printf>
   10554:	00000593          	li	a1,0
   10558:	a6448513          	add	a0,s1,-1436
   1055c:	5d4000ef          	jal	10b30 <printf>
   10560:	8301a703          	lw	a4,-2000(gp) # 1413c <Next_Ptr_Glob>
   10564:	bc8b0513          	add	a0,s6,-1080
   10568:	00872583          	lw	a1,8(a4)
   1056c:	5c4000ef          	jal	10b30 <printf>
   10570:	00100593          	li	a1,1
   10574:	a6448513          	add	a0,s1,-1436
   10578:	5b8000ef          	jal	10b30 <printf>
   1057c:	8301a703          	lw	a4,-2000(gp) # 1413c <Next_Ptr_Glob>
   10580:	be4a0513          	add	a0,s4,-1052
   10584:	00c72583          	lw	a1,12(a4)
   10588:	5a8000ef          	jal	10b30 <printf>
   1058c:	01200593          	li	a1,18
   10590:	a6448513          	add	a0,s1,-1436
   10594:	59c000ef          	jal	10b30 <printf>
   10598:	8301a583          	lw	a1,-2000(gp) # 1413c <Next_Ptr_Glob>
   1059c:	c0098513          	add	a0,s3,-1024
   105a0:	01058593          	add	a1,a1,16
   105a4:	58c000ef          	jal	10b30 <printf>
   105a8:	c1c40513          	add	a0,s0,-996
   105ac:	5f4000ef          	jal	10ba0 <puts>
   105b0:	00012683          	lw	a3,0(sp)
   105b4:	00013537          	lui	a0,0x13
   105b8:	ca050513          	add	a0,a0,-864 # 12ca0 <_start+0x36c>
   105bc:	00068593          	mv	a1,a3
   105c0:	570000ef          	jal	10b30 <printf>
   105c4:	00500593          	li	a1,5
   105c8:	a6448513          	add	a0,s1,-1436
   105cc:	564000ef          	jal	10b30 <printf>
   105d0:	00412783          	lw	a5,4(sp)
   105d4:	00391593          	sll	a1,s2,0x3
   105d8:	412585b3          	sub	a1,a1,s2
   105dc:	00013537          	lui	a0,0x13
   105e0:	40f585b3          	sub	a1,a1,a5
   105e4:	cbc50513          	add	a0,a0,-836 # 12cbc <_start+0x388>
   105e8:	548000ef          	jal	10b30 <printf>
   105ec:	00d00593          	li	a1,13
   105f0:	a6448513          	add	a0,s1,-1436
   105f4:	53c000ef          	jal	10b30 <printf>
   105f8:	02812583          	lw	a1,40(sp)
   105fc:	00013537          	lui	a0,0x13
   10600:	cd850513          	add	a0,a0,-808 # 12cd8 <_start+0x3a4>
   10604:	52c000ef          	jal	10b30 <printf>
   10608:	00700593          	li	a1,7
   1060c:	a6448513          	add	a0,s1,-1436
   10610:	520000ef          	jal	10b30 <printf>
   10614:	02c12583          	lw	a1,44(sp)
   10618:	00013537          	lui	a0,0x13
   1061c:	cf450513          	add	a0,a0,-780 # 12cf4 <_start+0x3c0>
   10620:	510000ef          	jal	10b30 <printf>
   10624:	00100593          	li	a1,1
   10628:	a6448513          	add	a0,s1,-1436
   1062c:	504000ef          	jal	10b30 <printf>
   10630:	00013537          	lui	a0,0x13
   10634:	03010593          	add	a1,sp,48
   10638:	d1050513          	add	a0,a0,-752 # 12d10 <_start+0x3dc>
   1063c:	4f4000ef          	jal	10b30 <printf>
   10640:	00013537          	lui	a0,0x13
   10644:	d2c50513          	add	a0,a0,-724 # 12d2c <_start+0x3f8>
   10648:	558000ef          	jal	10ba0 <puts>
   1064c:	00013537          	lui	a0,0x13
   10650:	05010593          	add	a1,sp,80
   10654:	d6050513          	add	a0,a0,-672 # 12d60 <_start+0x42c>
   10658:	4d8000ef          	jal	10b30 <printf>
   1065c:	00013537          	lui	a0,0x13
   10660:	d7c50513          	add	a0,a0,-644 # 12d7c <_start+0x448>
   10664:	53c000ef          	jal	10ba0 <puts>
   10668:	00a00513          	li	a0,10
   1066c:	564000ef          	jal	10bd0 <putchar>
   10670:	81c1a703          	lw	a4,-2020(gp) # 14128 <Begin_Time>
   10674:	8181a503          	lw	a0,-2024(gp) # 14124 <End_Time>
   10678:	00100793          	li	a5,1
   1067c:	40e50533          	sub	a0,a0,a4
   10680:	80a1aa23          	sw	a0,-2028(gp) # 14120 <User_Time>
   10684:	14a7dc63          	bge	a5,a0,107dc <main+0x748>
   10688:	080020ef          	jal	12708 <__floatsisf>
   1068c:	000147b7          	lui	a5,0x14
   10690:	10c7a583          	lw	a1,268(a5) # 1410c <__SDATA_BEGIN__>
   10694:	00050413          	mv	s0,a0
   10698:	4b5010ef          	jal	1234c <__mulsf3>
   1069c:	8041a583          	lw	a1,-2044(gp) # 14110 <__SDATA_BEGIN__+0x4>
   106a0:	129010ef          	jal	11fc8 <__divsf3>
   106a4:	00050793          	mv	a5,a0
   106a8:	8041a503          	lw	a0,-2044(gp) # 14110 <__SDATA_BEGIN__+0x4>
   106ac:	00040593          	mv	a1,s0
   106b0:	80f1a823          	sw	a5,-2032(gp) # 1411c <Microseconds>
   106b4:	115010ef          	jal	11fc8 <__divsf3>
   106b8:	00050793          	mv	a5,a0
   106bc:	00013537          	lui	a0,0x13
   106c0:	e0850513          	add	a0,a0,-504 # 12e08 <_start+0x4d4>
   106c4:	80f1a623          	sw	a5,-2036(gp) # 14118 <Dhrystones_Per_Second>
   106c8:	468000ef          	jal	10b30 <printf>
   106cc:	8101a503          	lw	a0,-2032(gp) # 1411c <Microseconds>
   106d0:	00013437          	lui	s0,0x13
   106d4:	7c5010ef          	jal	12698 <__fixsfsi>
   106d8:	00050593          	mv	a1,a0
   106dc:	e3840513          	add	a0,s0,-456 # 12e38 <_start+0x504>
   106e0:	450000ef          	jal	10b30 <printf>
   106e4:	00013537          	lui	a0,0x13
   106e8:	e4050513          	add	a0,a0,-448 # 12e40 <_start+0x50c>
   106ec:	444000ef          	jal	10b30 <printf>
   106f0:	80c1a503          	lw	a0,-2036(gp) # 14118 <Dhrystones_Per_Second>
   106f4:	7a5010ef          	jal	12698 <__fixsfsi>
   106f8:	00050593          	mv	a1,a0
   106fc:	e3840513          	add	a0,s0,-456
   10700:	430000ef          	jal	10b30 <printf>
   10704:	00a00513          	li	a0,10
   10708:	4c8000ef          	jal	10bd0 <putchar>
   1070c:	10c12083          	lw	ra,268(sp)
   10710:	10812403          	lw	s0,264(sp)
   10714:	10412483          	lw	s1,260(sp)
   10718:	10012903          	lw	s2,256(sp)
   1071c:	0fc12983          	lw	s3,252(sp)
   10720:	0f812a03          	lw	s4,248(sp)
   10724:	0f412a83          	lw	s5,244(sp)
   10728:	0f012b03          	lw	s6,240(sp)
   1072c:	0ec12b83          	lw	s7,236(sp)
   10730:	0e812c03          	lw	s8,232(sp)
   10734:	0e412c83          	lw	s9,228(sp)
   10738:	0e012d03          	lw	s10,224(sp)
   1073c:	0dc12d83          	lw	s11,220(sp)
   10740:	00000513          	li	a0,0
   10744:	11010113          	add	sp,sp,272
   10748:	00008067          	ret
   1074c:	02c10593          	add	a1,sp,44
   10750:	00000513          	li	a0,0
   10754:	29c000ef          	jal	109f0 <Proc_6>
   10758:	000d2e03          	lw	t3,0(s10)
   1075c:	004d2303          	lw	t1,4(s10)
   10760:	008d2883          	lw	a7,8(s10)
   10764:	00cd2803          	lw	a6,12(s10)
   10768:	010d2503          	lw	a0,16(s10)
   1076c:	014d2583          	lw	a1,20(s10)
   10770:	018d2603          	lw	a2,24(s10)
   10774:	01cd5703          	lhu	a4,28(s10)
   10778:	01ed4783          	lbu	a5,30(s10)
   1077c:	8241c683          	lbu	a3,-2012(gp) # 14130 <Ch_2_Glob>
   10780:	001a8a93          	add	s5,s5,1
   10784:	05c12823          	sw	t3,80(sp)
   10788:	04612a23          	sw	t1,84(sp)
   1078c:	05112c23          	sw	a7,88(sp)
   10790:	05012e23          	sw	a6,92(sp)
   10794:	06a12023          	sw	a0,96(sp)
   10798:	06b12223          	sw	a1,100(sp)
   1079c:	06c12423          	sw	a2,104(sp)
   107a0:	06e11623          	sh	a4,108(sp)
   107a4:	06f10723          	sb	a5,110(sp)
   107a8:	8291a623          	sw	s1,-2004(gp) # 14138 <Int_Glob>
   107ac:	0ffafa93          	zext.b	s5,s5
   107b0:	00048913          	mv	s2,s1
   107b4:	b556fce3          	bgeu	a3,s5,1030c <main+0x278>
   107b8:	b79ff06f          	j	10330 <main+0x29c>
   107bc:	00900913          	li	s2,9
   107c0:	b79ff06f          	j	10338 <main+0x2a4>
   107c4:	00013537          	lui	a0,0x13
   107c8:	9a050513          	add	a0,a0,-1632 # 129a0 <_start+0x6c>
   107cc:	3d4000ef          	jal	10ba0 <puts>
   107d0:	00a00513          	li	a0,10
   107d4:	3fc000ef          	jal	10bd0 <putchar>
   107d8:	a05ff06f          	j	101dc <main+0x148>
   107dc:	00013537          	lui	a0,0x13
   107e0:	db050513          	add	a0,a0,-592 # 12db0 <_start+0x47c>
   107e4:	3bc000ef          	jal	10ba0 <puts>
   107e8:	00013537          	lui	a0,0x13
   107ec:	de850513          	add	a0,a0,-536 # 12de8 <_start+0x4b4>
   107f0:	3b0000ef          	jal	10ba0 <puts>
   107f4:	00a00513          	li	a0,10
   107f8:	3d8000ef          	jal	10bd0 <putchar>
   107fc:	f11ff06f          	j	1070c <main+0x678>

00010800 <Proc_1>:
   10800:	ff010113          	add	sp,sp,-16
   10804:	01212023          	sw	s2,0(sp)
   10808:	8341a783          	lw	a5,-1996(gp) # 14140 <Ptr_Glob>
   1080c:	00812423          	sw	s0,8(sp)
   10810:	00052403          	lw	s0,0(a0)
   10814:	0007a703          	lw	a4,0(a5)
   10818:	0047af83          	lw	t6,4(a5)
   1081c:	0087af03          	lw	t5,8(a5)
   10820:	0107ae83          	lw	t4,16(a5)
   10824:	0147ae03          	lw	t3,20(a5)
   10828:	0187a303          	lw	t1,24(a5)
   1082c:	01c7a883          	lw	a7,28(a5)
   10830:	0207a803          	lw	a6,32(a5)
   10834:	02c7a603          	lw	a2,44(a5)
   10838:	0287a583          	lw	a1,40(a5)
   1083c:	00112623          	sw	ra,12(sp)
   10840:	00912223          	sw	s1,4(sp)
   10844:	00050493          	mv	s1,a0
   10848:	0247a503          	lw	a0,36(a5)
   1084c:	00e42023          	sw	a4,0(s0)
   10850:	0004a683          	lw	a3,0(s1)
   10854:	00500713          	li	a4,5
   10858:	01f42223          	sw	t6,4(s0)
   1085c:	01e42423          	sw	t5,8(s0)
   10860:	01d42823          	sw	t4,16(s0)
   10864:	01c42a23          	sw	t3,20(s0)
   10868:	00642c23          	sw	t1,24(s0)
   1086c:	01142e23          	sw	a7,28(s0)
   10870:	03042023          	sw	a6,32(s0)
   10874:	02a42223          	sw	a0,36(s0)
   10878:	02c42623          	sw	a2,44(s0)
   1087c:	02b42423          	sw	a1,40(s0)
   10880:	00e4a623          	sw	a4,12(s1)
   10884:	00d42023          	sw	a3,0(s0)
   10888:	0007a783          	lw	a5,0(a5)
   1088c:	82c1a583          	lw	a1,-2004(gp) # 14138 <Int_Glob>
   10890:	00f42023          	sw	a5,0(s0)
   10894:	8341a603          	lw	a2,-1996(gp) # 14140 <Ptr_Glob>
   10898:	00e42623          	sw	a4,12(s0)
   1089c:	00a00513          	li	a0,10
   108a0:	00c60613          	add	a2,a2,12
   108a4:	19c000ef          	jal	10a40 <Proc_7>
   108a8:	00442783          	lw	a5,4(s0)
   108ac:	08078063          	beqz	a5,1092c <Proc_1+0x12c>
   108b0:	0004a783          	lw	a5,0(s1)
   108b4:	00c12083          	lw	ra,12(sp)
   108b8:	00812403          	lw	s0,8(sp)
   108bc:	0007af83          	lw	t6,0(a5)
   108c0:	0047af03          	lw	t5,4(a5)
   108c4:	0087ae83          	lw	t4,8(a5)
   108c8:	00c7ae03          	lw	t3,12(a5)
   108cc:	0107a303          	lw	t1,16(a5)
   108d0:	0147a883          	lw	a7,20(a5)
   108d4:	0187a803          	lw	a6,24(a5)
   108d8:	01c7a583          	lw	a1,28(a5)
   108dc:	0207a603          	lw	a2,32(a5)
   108e0:	0247a683          	lw	a3,36(a5)
   108e4:	0287a703          	lw	a4,40(a5)
   108e8:	02c7a783          	lw	a5,44(a5)
   108ec:	01f4a023          	sw	t6,0(s1)
   108f0:	01e4a223          	sw	t5,4(s1)
   108f4:	01d4a423          	sw	t4,8(s1)
   108f8:	01c4a623          	sw	t3,12(s1)
   108fc:	0064a823          	sw	t1,16(s1)
   10900:	0114aa23          	sw	a7,20(s1)
   10904:	0104ac23          	sw	a6,24(s1)
   10908:	00b4ae23          	sw	a1,28(s1)
   1090c:	02c4a023          	sw	a2,32(s1)
   10910:	02d4a223          	sw	a3,36(s1)
   10914:	02e4a423          	sw	a4,40(s1)
   10918:	02f4a623          	sw	a5,44(s1)
   1091c:	00012903          	lw	s2,0(sp)
   10920:	00412483          	lw	s1,4(sp)
   10924:	01010113          	add	sp,sp,16
   10928:	00008067          	ret
   1092c:	0084a503          	lw	a0,8(s1)
   10930:	00600793          	li	a5,6
   10934:	00f42623          	sw	a5,12(s0)
   10938:	00840593          	add	a1,s0,8
   1093c:	0b4000ef          	jal	109f0 <Proc_6>
   10940:	8341a783          	lw	a5,-1996(gp) # 14140 <Ptr_Glob>
   10944:	00c42503          	lw	a0,12(s0)
   10948:	00c40613          	add	a2,s0,12
   1094c:	0007a783          	lw	a5,0(a5)
   10950:	00c12083          	lw	ra,12(sp)
   10954:	00412483          	lw	s1,4(sp)
   10958:	00f42023          	sw	a5,0(s0)
   1095c:	00812403          	lw	s0,8(sp)
   10960:	00012903          	lw	s2,0(sp)
   10964:	00a00593          	li	a1,10
   10968:	01010113          	add	sp,sp,16
   1096c:	0d40006f          	j	10a40 <Proc_7>

00010970 <Proc_2>:
   10970:	8251c703          	lbu	a4,-2011(gp) # 14131 <Ch_1_Glob>
   10974:	04100793          	li	a5,65
   10978:	00f70463          	beq	a4,a5,10980 <Proc_2+0x10>
   1097c:	00008067          	ret
   10980:	00052783          	lw	a5,0(a0)
   10984:	82c1a703          	lw	a4,-2004(gp) # 14138 <Int_Glob>
   10988:	00978793          	add	a5,a5,9
   1098c:	40e787b3          	sub	a5,a5,a4
   10990:	00f52023          	sw	a5,0(a0)
   10994:	00008067          	ret

00010998 <Proc_3>:
   10998:	8341a603          	lw	a2,-1996(gp) # 14140 <Ptr_Glob>
   1099c:	00060863          	beqz	a2,109ac <Proc_3+0x14>
   109a0:	00062703          	lw	a4,0(a2)
   109a4:	00e52023          	sw	a4,0(a0)
   109a8:	8341a603          	lw	a2,-1996(gp) # 14140 <Ptr_Glob>
   109ac:	82c1a583          	lw	a1,-2004(gp) # 14138 <Int_Glob>
   109b0:	00c60613          	add	a2,a2,12
   109b4:	00a00513          	li	a0,10
   109b8:	0880006f          	j	10a40 <Proc_7>

000109bc <Proc_4>:
   109bc:	8251c783          	lbu	a5,-2011(gp) # 14131 <Ch_1_Glob>
   109c0:	8281a683          	lw	a3,-2008(gp) # 14134 <Bool_Glob>
   109c4:	fbf78793          	add	a5,a5,-65
   109c8:	0017b793          	seqz	a5,a5
   109cc:	00d7e7b3          	or	a5,a5,a3
   109d0:	82f1a423          	sw	a5,-2008(gp) # 14134 <Bool_Glob>
   109d4:	04200713          	li	a4,66
   109d8:	82e18223          	sb	a4,-2012(gp) # 14130 <Ch_2_Glob>
   109dc:	00008067          	ret

000109e0 <Proc_5>:
   109e0:	04100713          	li	a4,65
   109e4:	82e182a3          	sb	a4,-2011(gp) # 14131 <Ch_1_Glob>
   109e8:	8201a423          	sw	zero,-2008(gp) # 14134 <Bool_Glob>
   109ec:	00008067          	ret

000109f0 <Proc_6>:
   109f0:	00200793          	li	a5,2
   109f4:	02f50c63          	beq	a0,a5,10a2c <Proc_6+0x3c>
   109f8:	00300713          	li	a4,3
   109fc:	00e5a023          	sw	a4,0(a1)
   10a00:	00100713          	li	a4,1
   10a04:	00e50a63          	beq	a0,a4,10a18 <Proc_6+0x28>
   10a08:	00400713          	li	a4,4
   10a0c:	02e50663          	beq	a0,a4,10a38 <Proc_6+0x48>
   10a10:	00050a63          	beqz	a0,10a24 <Proc_6+0x34>
   10a14:	00008067          	ret
   10a18:	82c1a703          	lw	a4,-2004(gp) # 14138 <Int_Glob>
   10a1c:	06400793          	li	a5,100
   10a20:	fee7dae3          	bge	a5,a4,10a14 <Proc_6+0x24>
   10a24:	0005a023          	sw	zero,0(a1)
   10a28:	00008067          	ret
   10a2c:	00100793          	li	a5,1
   10a30:	00f5a023          	sw	a5,0(a1)
   10a34:	00008067          	ret
   10a38:	00f5a023          	sw	a5,0(a1)
   10a3c:	00008067          	ret

00010a40 <Proc_7>:
   10a40:	00250513          	add	a0,a0,2
   10a44:	00b505b3          	add	a1,a0,a1
   10a48:	00b62023          	sw	a1,0(a2)
   10a4c:	00008067          	ret

00010a50 <Proc_8>:
   10a50:	00560713          	add	a4,a2,5
   10a54:	00171793          	sll	a5,a4,0x1
   10a58:	00e787b3          	add	a5,a5,a4
   10a5c:	00379793          	sll	a5,a5,0x3
   10a60:	00e787b3          	add	a5,a5,a4
   10a64:	00379793          	sll	a5,a5,0x3
   10a68:	00261613          	sll	a2,a2,0x2
   10a6c:	00271813          	sll	a6,a4,0x2
   10a70:	01050533          	add	a0,a0,a6
   10a74:	00f60833          	add	a6,a2,a5
   10a78:	00d52023          	sw	a3,0(a0)
   10a7c:	00d52223          	sw	a3,4(a0)
   10a80:	06e52c23          	sw	a4,120(a0)
   10a84:	010586b3          	add	a3,a1,a6
   10a88:	0106a803          	lw	a6,16(a3)
   10a8c:	00e6aa23          	sw	a4,20(a3)
   10a90:	00e6ac23          	sw	a4,24(a3)
   10a94:	00180713          	add	a4,a6,1
   10a98:	00e6a823          	sw	a4,16(a3)
   10a9c:	00052703          	lw	a4,0(a0)
   10aa0:	00c585b3          	add	a1,a1,a2
   10aa4:	00f585b3          	add	a1,a1,a5
   10aa8:	000017b7          	lui	a5,0x1
   10aac:	00b787b3          	add	a5,a5,a1
   10ab0:	fae7aa23          	sw	a4,-76(a5) # fb4 <main-0xf0e0>
   10ab4:	00500713          	li	a4,5
   10ab8:	82e1a623          	sw	a4,-2004(gp) # 14138 <Int_Glob>
   10abc:	00008067          	ret

00010ac0 <Func_1>:
   10ac0:	0ff57513          	zext.b	a0,a0
   10ac4:	0ff5f593          	zext.b	a1,a1
   10ac8:	00b50663          	beq	a0,a1,10ad4 <Func_1+0x14>
   10acc:	00000513          	li	a0,0
   10ad0:	00008067          	ret
   10ad4:	82a182a3          	sb	a0,-2011(gp) # 14131 <Ch_1_Glob>
   10ad8:	00100513          	li	a0,1
   10adc:	00008067          	ret

00010ae0 <Func_2>:
   10ae0:	ff010113          	add	sp,sp,-16
   10ae4:	00112623          	sw	ra,12(sp)
   10ae8:	00254703          	lbu	a4,2(a0)
   10aec:	0035c783          	lbu	a5,3(a1)
   10af0:	02e78663          	beq	a5,a4,10b1c <Func_2+0x3c>
   10af4:	22c000ef          	jal	10d20 <strcmp>
   10af8:	00000793          	li	a5,0
   10afc:	00a05863          	blez	a0,10b0c <Func_2+0x2c>
   10b00:	00a00713          	li	a4,10
   10b04:	82e1a623          	sw	a4,-2004(gp) # 14138 <Int_Glob>
   10b08:	00100793          	li	a5,1
   10b0c:	00c12083          	lw	ra,12(sp)
   10b10:	00078513          	mv	a0,a5
   10b14:	01010113          	add	sp,sp,16
   10b18:	00008067          	ret
   10b1c:	82f182a3          	sb	a5,-2011(gp) # 14131 <Ch_1_Glob>
   10b20:	fd1ff06f          	j	10af0 <Func_2+0x10>

00010b24 <Func_3>:
   10b24:	ffe50513          	add	a0,a0,-2
   10b28:	00153513          	seqz	a0,a0
   10b2c:	00008067          	ret

00010b30 <printf>:
   10b30:	fc010113          	add	sp,sp,-64
   10b34:	00812c23          	sw	s0,24(sp)
   10b38:	02410313          	add	t1,sp,36
   10b3c:	00050413          	mv	s0,a0
   10b40:	02b12223          	sw	a1,36(sp)
   10b44:	00050593          	mv	a1,a0
   10b48:	00017537          	lui	a0,0x17
   10b4c:	02c12423          	sw	a2,40(sp)
   10b50:	92850513          	add	a0,a0,-1752 # 16928 <tmp.0>
   10b54:	00030613          	mv	a2,t1
   10b58:	00112e23          	sw	ra,28(sp)
   10b5c:	02d12623          	sw	a3,44(sp)
   10b60:	02e12823          	sw	a4,48(sp)
   10b64:	02f12a23          	sw	a5,52(sp)
   10b68:	03012c23          	sw	a6,56(sp)
   10b6c:	03112e23          	sw	a7,60(sp)
   10b70:	00612623          	sw	t1,12(sp)
   10b74:	17c000ef          	jal	10cf0 <vsiprintf>
   10b78:	00040513          	mv	a0,s0
   10b7c:	188000ef          	jal	10d04 <strlen>
   10b80:	00050613          	mv	a2,a0
   10b84:	00040593          	mv	a1,s0
   10b88:	00000513          	li	a0,0
   10b8c:	080000ef          	jal	10c0c <_write>
   10b90:	01c12083          	lw	ra,28(sp)
   10b94:	01812403          	lw	s0,24(sp)
   10b98:	04010113          	add	sp,sp,64
   10b9c:	00008067          	ret

00010ba0 <puts>:
   10ba0:	ff010113          	add	sp,sp,-16
   10ba4:	00812423          	sw	s0,8(sp)
   10ba8:	00112623          	sw	ra,12(sp)
   10bac:	00050413          	mv	s0,a0
   10bb0:	154000ef          	jal	10d04 <strlen>
   10bb4:	00040593          	mv	a1,s0
   10bb8:	00812403          	lw	s0,8(sp)
   10bbc:	00c12083          	lw	ra,12(sp)
   10bc0:	00050613          	mv	a2,a0
   10bc4:	00000513          	li	a0,0
   10bc8:	01010113          	add	sp,sp,16
   10bcc:	0400006f          	j	10c0c <_write>

00010bd0 <putchar>:
   10bd0:	fe010113          	add	sp,sp,-32
   10bd4:	00a12623          	sw	a0,12(sp)
   10bd8:	00c10593          	add	a1,sp,12
   10bdc:	00100613          	li	a2,1
   10be0:	00000513          	li	a0,0
   10be4:	00112e23          	sw	ra,28(sp)
   10be8:	024000ef          	jal	10c0c <_write>
   10bec:	01c12083          	lw	ra,28(sp)
   10bf0:	02010113          	add	sp,sp,32
   10bf4:	00008067          	ret

00010bf8 <time>:
   10bf8:	00050793          	mv	a5,a0
   10bfc:	c0002573          	rdcycle	a0
   10c00:	00078463          	beqz	a5,10c08 <time+0x10>
   10c04:	00a7a023          	sw	a0,0(a5)
   10c08:	00008067          	ret

00010c0c <_write>:
   10c0c:	00060693          	mv	a3,a2
   10c10:	00058613          	mv	a2,a1
   10c14:	00050593          	mv	a1,a0
   10c18:	04000513          	li	a0,64
   10c1c:	0740006f          	j	10c90 <syscall0>

00010c20 <_read>:
   10c20:	00060693          	mv	a3,a2
   10c24:	00058613          	mv	a2,a1
   10c28:	00050593          	mv	a1,a0
   10c2c:	03f00513          	li	a0,63
   10c30:	0600006f          	j	10c90 <syscall0>

00010c34 <_sbrk>:
   10c34:	00050593          	mv	a1,a0
   10c38:	0d600513          	li	a0,214
   10c3c:	0540006f          	j	10c90 <syscall0>

00010c40 <_lseek>:
   10c40:	00060693          	mv	a3,a2
   10c44:	00058613          	mv	a2,a1
   10c48:	00050593          	mv	a1,a0
   10c4c:	03e00513          	li	a0,62
   10c50:	0400006f          	j	10c90 <syscall0>

00010c54 <_isatty>:
   10c54:	00050593          	mv	a1,a0
   10c58:	00900513          	li	a0,9
   10c5c:	0340006f          	j	10c90 <syscall0>

00010c60 <_fstat>:
   10c60:	00058613          	mv	a2,a1
   10c64:	00050593          	mv	a1,a0
   10c68:	05000513          	li	a0,80
   10c6c:	0240006f          	j	10c90 <syscall0>

00010c70 <_close>:
   10c70:	00050593          	mv	a1,a0
   10c74:	03900513          	li	a0,57
   10c78:	0180006f          	j	10c90 <syscall0>

00010c7c <_exit>:
   10c7c:	ff010113          	add	sp,sp,-16
   10c80:	00050593          	mv	a1,a0
   10c84:	05d00513          	li	a0,93
   10c88:	00112623          	sw	ra,12(sp)
   10c8c:	004000ef          	jal	10c90 <syscall0>

00010c90 <syscall0>:
   10c90:	00050893          	mv	a7,a0
   10c94:	00058513          	mv	a0,a1
   10c98:	00060593          	mv	a1,a2
   10c9c:	00068613          	mv	a2,a3
   10ca0:	00000073          	ecall
   10ca4:	00008067          	ret

00010ca8 <_vsiprintf_r>:
   10ca8:	800007b7          	lui	a5,0x80000
   10cac:	f8010113          	add	sp,sp,-128
   10cb0:	fff78793          	add	a5,a5,-1 # 7fffffff <__BSS_END__+0x7ffe92d7>
   10cb4:	00f12e23          	sw	a5,28(sp)
   10cb8:	00f12823          	sw	a5,16(sp)
   10cbc:	ffff07b7          	lui	a5,0xffff0
   10cc0:	00b12423          	sw	a1,8(sp)
   10cc4:	00b12c23          	sw	a1,24(sp)
   10cc8:	20878793          	add	a5,a5,520 # ffff0208 <__BSS_END__+0xfffd94e0>
   10ccc:	00810593          	add	a1,sp,8
   10cd0:	06112e23          	sw	ra,124(sp)
   10cd4:	00f12a23          	sw	a5,20(sp)
   10cd8:	38c000ef          	jal	11064 <_svfiprintf_r>
   10cdc:	00812783          	lw	a5,8(sp)
   10ce0:	00078023          	sb	zero,0(a5)
   10ce4:	07c12083          	lw	ra,124(sp)
   10ce8:	08010113          	add	sp,sp,128
   10cec:	00008067          	ret

00010cf0 <vsiprintf>:
   10cf0:	00060693          	mv	a3,a2
   10cf4:	00058613          	mv	a2,a1
   10cf8:	00050593          	mv	a1,a0
   10cfc:	8081a503          	lw	a0,-2040(gp) # 14114 <_impure_ptr>
   10d00:	fa9ff06f          	j	10ca8 <_vsiprintf_r>

00010d04 <strlen>:
   10d04:	00050793          	mv	a5,a0
   10d08:	0007c703          	lbu	a4,0(a5)
   10d0c:	00178793          	add	a5,a5,1
   10d10:	fe071ce3          	bnez	a4,10d08 <strlen+0x4>
   10d14:	40a78533          	sub	a0,a5,a0
   10d18:	fff50513          	add	a0,a0,-1
   10d1c:	00008067          	ret

00010d20 <strcmp>:
   10d20:	00054603          	lbu	a2,0(a0)
   10d24:	0005c683          	lbu	a3,0(a1)
   10d28:	00150513          	add	a0,a0,1
   10d2c:	00158593          	add	a1,a1,1
   10d30:	00d61463          	bne	a2,a3,10d38 <strcmp+0x18>
   10d34:	fe0616e3          	bnez	a2,10d20 <strcmp>
   10d38:	40d60533          	sub	a0,a2,a3
   10d3c:	00008067          	ret

00010d40 <__ssputs_r>:
   10d40:	fe010113          	add	sp,sp,-32
   10d44:	01212823          	sw	s2,16(sp)
   10d48:	0085a903          	lw	s2,8(a1)
   10d4c:	00812c23          	sw	s0,24(sp)
   10d50:	01312623          	sw	s3,12(sp)
   10d54:	01512223          	sw	s5,4(sp)
   10d58:	01612023          	sw	s6,0(sp)
   10d5c:	00112e23          	sw	ra,28(sp)
   10d60:	00912a23          	sw	s1,20(sp)
   10d64:	01412423          	sw	s4,8(sp)
   10d68:	0005aa83          	lw	s5,0(a1)
   10d6c:	00058413          	mv	s0,a1
   10d70:	00060b13          	mv	s6,a2
   10d74:	00068993          	mv	s3,a3
   10d78:	0926ee63          	bltu	a3,s2,10e14 <__ssputs_r+0xd4>
   10d7c:	00c59783          	lh	a5,12(a1)
   10d80:	4807f713          	and	a4,a5,1152
   10d84:	08070663          	beqz	a4,10e10 <__ssputs_r+0xd0>
   10d88:	01442683          	lw	a3,20(s0)
   10d8c:	0105a583          	lw	a1,16(a1)
   10d90:	00050a13          	mv	s4,a0
   10d94:	00169713          	sll	a4,a3,0x1
   10d98:	00d70733          	add	a4,a4,a3
   10d9c:	01f75493          	srl	s1,a4,0x1f
   10da0:	00e484b3          	add	s1,s1,a4
   10da4:	40ba8ab3          	sub	s5,s5,a1
   10da8:	00198713          	add	a4,s3,1
   10dac:	4014d493          	sra	s1,s1,0x1
   10db0:	01570733          	add	a4,a4,s5
   10db4:	00e4f463          	bgeu	s1,a4,10dbc <__ssputs_r+0x7c>
   10db8:	00070493          	mv	s1,a4
   10dbc:	4007f793          	and	a5,a5,1024
   10dc0:	0a078663          	beqz	a5,10e6c <__ssputs_r+0x12c>
   10dc4:	00048593          	mv	a1,s1
   10dc8:	000a0513          	mv	a0,s4
   10dcc:	5a1000ef          	jal	11b6c <_malloc_r>
   10dd0:	00050913          	mv	s2,a0
   10dd4:	0a050c63          	beqz	a0,10e8c <__ssputs_r+0x14c>
   10dd8:	01042583          	lw	a1,16(s0)
   10ddc:	000a8613          	mv	a2,s5
   10de0:	3ed000ef          	jal	119cc <memcpy>
   10de4:	00c45783          	lhu	a5,12(s0)
   10de8:	b7f7f793          	and	a5,a5,-1153
   10dec:	0807e793          	or	a5,a5,128
   10df0:	00f41623          	sh	a5,12(s0)
   10df4:	01242823          	sw	s2,16(s0)
   10df8:	00942a23          	sw	s1,20(s0)
   10dfc:	01590933          	add	s2,s2,s5
   10e00:	415484b3          	sub	s1,s1,s5
   10e04:	01242023          	sw	s2,0(s0)
   10e08:	00942423          	sw	s1,8(s0)
   10e0c:	00098913          	mv	s2,s3
   10e10:	0129f463          	bgeu	s3,s2,10e18 <__ssputs_r+0xd8>
   10e14:	00098913          	mv	s2,s3
   10e18:	00042503          	lw	a0,0(s0)
   10e1c:	00090613          	mv	a2,s2
   10e20:	000b0593          	mv	a1,s6
   10e24:	36d000ef          	jal	11990 <memmove>
   10e28:	00842783          	lw	a5,8(s0)
   10e2c:	00000513          	li	a0,0
   10e30:	412787b3          	sub	a5,a5,s2
   10e34:	00f42423          	sw	a5,8(s0)
   10e38:	00042783          	lw	a5,0(s0)
   10e3c:	012787b3          	add	a5,a5,s2
   10e40:	00f42023          	sw	a5,0(s0)
   10e44:	01c12083          	lw	ra,28(sp)
   10e48:	01812403          	lw	s0,24(sp)
   10e4c:	01412483          	lw	s1,20(sp)
   10e50:	01012903          	lw	s2,16(sp)
   10e54:	00c12983          	lw	s3,12(sp)
   10e58:	00812a03          	lw	s4,8(sp)
   10e5c:	00412a83          	lw	s5,4(sp)
   10e60:	00012b03          	lw	s6,0(sp)
   10e64:	02010113          	add	sp,sp,32
   10e68:	00008067          	ret
   10e6c:	00048613          	mv	a2,s1
   10e70:	000a0513          	mv	a0,s4
   10e74:	6c1000ef          	jal	11d34 <_realloc_r>
   10e78:	00050913          	mv	s2,a0
   10e7c:	f6051ce3          	bnez	a0,10df4 <__ssputs_r+0xb4>
   10e80:	01042583          	lw	a1,16(s0)
   10e84:	000a0513          	mv	a0,s4
   10e88:	369000ef          	jal	119f0 <_free_r>
   10e8c:	00c00793          	li	a5,12
   10e90:	00fa2023          	sw	a5,0(s4)
   10e94:	00c45783          	lhu	a5,12(s0)
   10e98:	fff00513          	li	a0,-1
   10e9c:	0407e793          	or	a5,a5,64
   10ea0:	00f41623          	sh	a5,12(s0)
   10ea4:	fa1ff06f          	j	10e44 <__ssputs_r+0x104>

00010ea8 <__ssprint_r>:
   10ea8:	00862783          	lw	a5,8(a2)
   10eac:	fd010113          	add	sp,sp,-48
   10eb0:	01412c23          	sw	s4,24(sp)
   10eb4:	01712623          	sw	s7,12(sp)
   10eb8:	02112623          	sw	ra,44(sp)
   10ebc:	02812423          	sw	s0,40(sp)
   10ec0:	02912223          	sw	s1,36(sp)
   10ec4:	03212023          	sw	s2,32(sp)
   10ec8:	01312e23          	sw	s3,28(sp)
   10ecc:	01512a23          	sw	s5,20(sp)
   10ed0:	01612823          	sw	s6,16(sp)
   10ed4:	01812423          	sw	s8,8(sp)
   10ed8:	00062b83          	lw	s7,0(a2)
   10edc:	00060a13          	mv	s4,a2
   10ee0:	12079863          	bnez	a5,11010 <__ssprint_r+0x168>
   10ee4:	00000513          	li	a0,0
   10ee8:	02c12083          	lw	ra,44(sp)
   10eec:	02812403          	lw	s0,40(sp)
   10ef0:	000a2223          	sw	zero,4(s4)
   10ef4:	02412483          	lw	s1,36(sp)
   10ef8:	02012903          	lw	s2,32(sp)
   10efc:	01c12983          	lw	s3,28(sp)
   10f00:	01812a03          	lw	s4,24(sp)
   10f04:	01412a83          	lw	s5,20(sp)
   10f08:	01012b03          	lw	s6,16(sp)
   10f0c:	00c12b83          	lw	s7,12(sp)
   10f10:	00812c03          	lw	s8,8(sp)
   10f14:	03010113          	add	sp,sp,48
   10f18:	00008067          	ret
   10f1c:	000bab03          	lw	s6,0(s7)
   10f20:	004ba983          	lw	s3,4(s7)
   10f24:	008b8b93          	add	s7,s7,8
   10f28:	00842903          	lw	s2,8(s0)
   10f2c:	00042c03          	lw	s8,0(s0)
   10f30:	fe0986e3          	beqz	s3,10f1c <__ssprint_r+0x74>
   10f34:	0929ea63          	bltu	s3,s2,10fc8 <__ssprint_r+0x120>
   10f38:	00c41783          	lh	a5,12(s0)
   10f3c:	4807f713          	and	a4,a5,1152
   10f40:	08070863          	beqz	a4,10fd0 <__ssprint_r+0x128>
   10f44:	01442683          	lw	a3,20(s0)
   10f48:	01042583          	lw	a1,16(s0)
   10f4c:	00169713          	sll	a4,a3,0x1
   10f50:	00d70733          	add	a4,a4,a3
   10f54:	01f75493          	srl	s1,a4,0x1f
   10f58:	40bc0c33          	sub	s8,s8,a1
   10f5c:	00e484b3          	add	s1,s1,a4
   10f60:	001c0713          	add	a4,s8,1
   10f64:	4014d493          	sra	s1,s1,0x1
   10f68:	01370733          	add	a4,a4,s3
   10f6c:	00e4f463          	bgeu	s1,a4,10f74 <__ssprint_r+0xcc>
   10f70:	00070493          	mv	s1,a4
   10f74:	4007f793          	and	a5,a5,1024
   10f78:	0a078663          	beqz	a5,11024 <__ssprint_r+0x17c>
   10f7c:	00048593          	mv	a1,s1
   10f80:	000a8513          	mv	a0,s5
   10f84:	3e9000ef          	jal	11b6c <_malloc_r>
   10f88:	00050913          	mv	s2,a0
   10f8c:	0a050c63          	beqz	a0,11044 <__ssprint_r+0x19c>
   10f90:	01042583          	lw	a1,16(s0)
   10f94:	000c0613          	mv	a2,s8
   10f98:	235000ef          	jal	119cc <memcpy>
   10f9c:	00c45783          	lhu	a5,12(s0)
   10fa0:	b7f7f793          	and	a5,a5,-1153
   10fa4:	0807e793          	or	a5,a5,128
   10fa8:	00f41623          	sh	a5,12(s0)
   10fac:	01242823          	sw	s2,16(s0)
   10fb0:	00942a23          	sw	s1,20(s0)
   10fb4:	01890933          	add	s2,s2,s8
   10fb8:	418484b3          	sub	s1,s1,s8
   10fbc:	01242023          	sw	s2,0(s0)
   10fc0:	00942423          	sw	s1,8(s0)
   10fc4:	00098913          	mv	s2,s3
   10fc8:	0129f463          	bgeu	s3,s2,10fd0 <__ssprint_r+0x128>
   10fcc:	00098913          	mv	s2,s3
   10fd0:	00042503          	lw	a0,0(s0)
   10fd4:	000b0593          	mv	a1,s6
   10fd8:	00090613          	mv	a2,s2
   10fdc:	1b5000ef          	jal	11990 <memmove>
   10fe0:	00842783          	lw	a5,8(s0)
   10fe4:	013b0b33          	add	s6,s6,s3
   10fe8:	412787b3          	sub	a5,a5,s2
   10fec:	00f42423          	sw	a5,8(s0)
   10ff0:	00042783          	lw	a5,0(s0)
   10ff4:	012787b3          	add	a5,a5,s2
   10ff8:	00f42023          	sw	a5,0(s0)
   10ffc:	008a2783          	lw	a5,8(s4)
   11000:	413787b3          	sub	a5,a5,s3
   11004:	00fa2423          	sw	a5,8(s4)
   11008:	00079a63          	bnez	a5,1101c <__ssprint_r+0x174>
   1100c:	ed9ff06f          	j	10ee4 <__ssprint_r+0x3c>
   11010:	00050a93          	mv	s5,a0
   11014:	00058413          	mv	s0,a1
   11018:	00000b13          	li	s6,0
   1101c:	00000993          	li	s3,0
   11020:	f09ff06f          	j	10f28 <__ssprint_r+0x80>
   11024:	00048613          	mv	a2,s1
   11028:	000a8513          	mv	a0,s5
   1102c:	509000ef          	jal	11d34 <_realloc_r>
   11030:	00050913          	mv	s2,a0
   11034:	f6051ce3          	bnez	a0,10fac <__ssprint_r+0x104>
   11038:	01042583          	lw	a1,16(s0)
   1103c:	000a8513          	mv	a0,s5
   11040:	1b1000ef          	jal	119f0 <_free_r>
   11044:	00c00793          	li	a5,12
   11048:	00faa023          	sw	a5,0(s5)
   1104c:	00c45783          	lhu	a5,12(s0)
   11050:	fff00513          	li	a0,-1
   11054:	0407e793          	or	a5,a5,64
   11058:	00f41623          	sh	a5,12(s0)
   1105c:	000a2423          	sw	zero,8(s4)
   11060:	e89ff06f          	j	10ee8 <__ssprint_r+0x40>

00011064 <_svfiprintf_r>:
   11064:	00c5d783          	lhu	a5,12(a1)
   11068:	f5010113          	add	sp,sp,-176
   1106c:	0a812423          	sw	s0,168(sp)
   11070:	0a912223          	sw	s1,164(sp)
   11074:	0b212023          	sw	s2,160(sp)
   11078:	09412c23          	sw	s4,152(sp)
   1107c:	0a112623          	sw	ra,172(sp)
   11080:	09312e23          	sw	s3,156(sp)
   11084:	09512a23          	sw	s5,148(sp)
   11088:	09612823          	sw	s6,144(sp)
   1108c:	09712623          	sw	s7,140(sp)
   11090:	09812423          	sw	s8,136(sp)
   11094:	09912223          	sw	s9,132(sp)
   11098:	09a12023          	sw	s10,128(sp)
   1109c:	07b12e23          	sw	s11,124(sp)
   110a0:	0807f793          	and	a5,a5,128
   110a4:	00050a13          	mv	s4,a0
   110a8:	00058913          	mv	s2,a1
   110ac:	00060493          	mv	s1,a2
   110b0:	00068413          	mv	s0,a3
   110b4:	06078863          	beqz	a5,11124 <_svfiprintf_r+0xc0>
   110b8:	0105a783          	lw	a5,16(a1)
   110bc:	06079463          	bnez	a5,11124 <_svfiprintf_r+0xc0>
   110c0:	04000593          	li	a1,64
   110c4:	2a9000ef          	jal	11b6c <_malloc_r>
   110c8:	00a92023          	sw	a0,0(s2)
   110cc:	00a92823          	sw	a0,16(s2)
   110d0:	04051663          	bnez	a0,1111c <_svfiprintf_r+0xb8>
   110d4:	00c00793          	li	a5,12
   110d8:	00fa2023          	sw	a5,0(s4)
   110dc:	fff00513          	li	a0,-1
   110e0:	0ac12083          	lw	ra,172(sp)
   110e4:	0a812403          	lw	s0,168(sp)
   110e8:	0a412483          	lw	s1,164(sp)
   110ec:	0a012903          	lw	s2,160(sp)
   110f0:	09c12983          	lw	s3,156(sp)
   110f4:	09812a03          	lw	s4,152(sp)
   110f8:	09412a83          	lw	s5,148(sp)
   110fc:	09012b03          	lw	s6,144(sp)
   11100:	08c12b83          	lw	s7,140(sp)
   11104:	08812c03          	lw	s8,136(sp)
   11108:	08412c83          	lw	s9,132(sp)
   1110c:	08012d03          	lw	s10,128(sp)
   11110:	07c12d83          	lw	s11,124(sp)
   11114:	0b010113          	add	sp,sp,176
   11118:	00008067          	ret
   1111c:	04000793          	li	a5,64
   11120:	00f92a23          	sw	a5,20(s2)
   11124:	02000793          	li	a5,32
   11128:	02f104a3          	sb	a5,41(sp)
   1112c:	03000793          	li	a5,48
   11130:	02012223          	sw	zero,36(sp)
   11134:	02f10523          	sb	a5,42(sp)
   11138:	00812623          	sw	s0,12(sp)
   1113c:	02500c93          	li	s9,37
   11140:	00013b37          	lui	s6,0x13
   11144:	00013bb7          	lui	s7,0x13
   11148:	00013d37          	lui	s10,0x13
   1114c:	00011c37          	lui	s8,0x11
   11150:	00000a93          	li	s5,0
   11154:	00048413          	mv	s0,s1
   11158:	00044783          	lbu	a5,0(s0)
   1115c:	00078463          	beqz	a5,11164 <_svfiprintf_r+0x100>
   11160:	0d979863          	bne	a5,s9,11230 <_svfiprintf_r+0x1cc>
   11164:	40940db3          	sub	s11,s0,s1
   11168:	02940663          	beq	s0,s1,11194 <_svfiprintf_r+0x130>
   1116c:	000d8693          	mv	a3,s11
   11170:	00048613          	mv	a2,s1
   11174:	00090593          	mv	a1,s2
   11178:	000a0513          	mv	a0,s4
   1117c:	bc5ff0ef          	jal	10d40 <__ssputs_r>
   11180:	fff00793          	li	a5,-1
   11184:	24f50863          	beq	a0,a5,113d4 <_svfiprintf_r+0x370>
   11188:	02412783          	lw	a5,36(sp)
   1118c:	01b787b3          	add	a5,a5,s11
   11190:	02f12223          	sw	a5,36(sp)
   11194:	00044783          	lbu	a5,0(s0)
   11198:	22078e63          	beqz	a5,113d4 <_svfiprintf_r+0x370>
   1119c:	fff00793          	li	a5,-1
   111a0:	00140493          	add	s1,s0,1
   111a4:	00012823          	sw	zero,16(sp)
   111a8:	00012e23          	sw	zero,28(sp)
   111ac:	00f12a23          	sw	a5,20(sp)
   111b0:	00012c23          	sw	zero,24(sp)
   111b4:	040109a3          	sb	zero,83(sp)
   111b8:	06012423          	sw	zero,104(sp)
   111bc:	00100d93          	li	s11,1
   111c0:	0004c583          	lbu	a1,0(s1)
   111c4:	00500613          	li	a2,5
   111c8:	ef0b0513          	add	a0,s6,-272 # 12ef0 <_start+0x5bc>
   111cc:	7a0000ef          	jal	1196c <memchr>
   111d0:	01012783          	lw	a5,16(sp)
   111d4:	00148413          	add	s0,s1,1
   111d8:	06051063          	bnez	a0,11238 <_svfiprintf_r+0x1d4>
   111dc:	0107f713          	and	a4,a5,16
   111e0:	00070663          	beqz	a4,111ec <_svfiprintf_r+0x188>
   111e4:	02000713          	li	a4,32
   111e8:	04e109a3          	sb	a4,83(sp)
   111ec:	0087f713          	and	a4,a5,8
   111f0:	00070663          	beqz	a4,111fc <_svfiprintf_r+0x198>
   111f4:	02b00713          	li	a4,43
   111f8:	04e109a3          	sb	a4,83(sp)
   111fc:	0004c683          	lbu	a3,0(s1)
   11200:	02a00713          	li	a4,42
   11204:	04e68863          	beq	a3,a4,11254 <_svfiprintf_r+0x1f0>
   11208:	01c12703          	lw	a4,28(sp)
   1120c:	00048413          	mv	s0,s1
   11210:	00000793          	li	a5,0
   11214:	00900613          	li	a2,9
   11218:	00044683          	lbu	a3,0(s0)
   1121c:	00140593          	add	a1,s0,1
   11220:	fd068693          	add	a3,a3,-48
   11224:	10d67863          	bgeu	a2,a3,11334 <_svfiprintf_r+0x2d0>
   11228:	04079063          	bnez	a5,11268 <_svfiprintf_r+0x204>
   1122c:	0540006f          	j	11280 <_svfiprintf_r+0x21c>
   11230:	00140413          	add	s0,s0,1
   11234:	f25ff06f          	j	11158 <_svfiprintf_r+0xf4>
   11238:	ef0b0713          	add	a4,s6,-272
   1123c:	40e50533          	sub	a0,a0,a4
   11240:	00ad9533          	sll	a0,s11,a0
   11244:	00a7e7b3          	or	a5,a5,a0
   11248:	00f12823          	sw	a5,16(sp)
   1124c:	00040493          	mv	s1,s0
   11250:	f71ff06f          	j	111c0 <_svfiprintf_r+0x15c>
   11254:	00c12703          	lw	a4,12(sp)
   11258:	00470693          	add	a3,a4,4
   1125c:	00072703          	lw	a4,0(a4)
   11260:	00d12623          	sw	a3,12(sp)
   11264:	00074663          	bltz	a4,11270 <_svfiprintf_r+0x20c>
   11268:	00e12e23          	sw	a4,28(sp)
   1126c:	0140006f          	j	11280 <_svfiprintf_r+0x21c>
   11270:	40e00733          	neg	a4,a4
   11274:	0027e793          	or	a5,a5,2
   11278:	00e12e23          	sw	a4,28(sp)
   1127c:	00f12823          	sw	a5,16(sp)
   11280:	00044703          	lbu	a4,0(s0)
   11284:	02e00793          	li	a5,46
   11288:	02f71863          	bne	a4,a5,112b8 <_svfiprintf_r+0x254>
   1128c:	00144703          	lbu	a4,1(s0)
   11290:	02a00793          	li	a5,42
   11294:	0af71e63          	bne	a4,a5,11350 <_svfiprintf_r+0x2ec>
   11298:	00c12783          	lw	a5,12(sp)
   1129c:	00240413          	add	s0,s0,2
   112a0:	00478713          	add	a4,a5,4
   112a4:	0007a783          	lw	a5,0(a5)
   112a8:	00e12623          	sw	a4,12(sp)
   112ac:	0007d463          	bgez	a5,112b4 <_svfiprintf_r+0x250>
   112b0:	fff00793          	li	a5,-1
   112b4:	00f12a23          	sw	a5,20(sp)
   112b8:	00044583          	lbu	a1,0(s0)
   112bc:	00300613          	li	a2,3
   112c0:	ef8b8513          	add	a0,s7,-264 # 12ef8 <_start+0x5c4>
   112c4:	6a8000ef          	jal	1196c <memchr>
   112c8:	02050263          	beqz	a0,112ec <_svfiprintf_r+0x288>
   112cc:	ef8b8793          	add	a5,s7,-264
   112d0:	40f50533          	sub	a0,a0,a5
   112d4:	01012783          	lw	a5,16(sp)
   112d8:	04000713          	li	a4,64
   112dc:	00a71733          	sll	a4,a4,a0
   112e0:	00e7e7b3          	or	a5,a5,a4
   112e4:	00140413          	add	s0,s0,1
   112e8:	00f12823          	sw	a5,16(sp)
   112ec:	00044583          	lbu	a1,0(s0)
   112f0:	00600613          	li	a2,6
   112f4:	efcd0513          	add	a0,s10,-260 # 12efc <_start+0x5c8>
   112f8:	00140493          	add	s1,s0,1
   112fc:	02b10423          	sb	a1,40(sp)
   11300:	66c000ef          	jal	1196c <memchr>
   11304:	0e050263          	beqz	a0,113e8 <_svfiprintf_r+0x384>
   11308:	0a0a9263          	bnez	s5,113ac <_svfiprintf_r+0x348>
   1130c:	01012703          	lw	a4,16(sp)
   11310:	00c12783          	lw	a5,12(sp)
   11314:	10077713          	and	a4,a4,256
   11318:	08070263          	beqz	a4,1139c <_svfiprintf_r+0x338>
   1131c:	00478793          	add	a5,a5,4
   11320:	00f12623          	sw	a5,12(sp)
   11324:	02412783          	lw	a5,36(sp)
   11328:	013787b3          	add	a5,a5,s3
   1132c:	02f12223          	sw	a5,36(sp)
   11330:	e25ff06f          	j	11154 <_svfiprintf_r+0xf0>
   11334:	00271793          	sll	a5,a4,0x2
   11338:	00e787b3          	add	a5,a5,a4
   1133c:	00179793          	sll	a5,a5,0x1
   11340:	00d78733          	add	a4,a5,a3
   11344:	00058413          	mv	s0,a1
   11348:	00100793          	li	a5,1
   1134c:	ecdff06f          	j	11218 <_svfiprintf_r+0x1b4>
   11350:	00140413          	add	s0,s0,1
   11354:	00012a23          	sw	zero,20(sp)
   11358:	00000793          	li	a5,0
   1135c:	00000713          	li	a4,0
   11360:	00900613          	li	a2,9
   11364:	00044683          	lbu	a3,0(s0)
   11368:	00140593          	add	a1,s0,1
   1136c:	fd068693          	add	a3,a3,-48
   11370:	00d67863          	bgeu	a2,a3,11380 <_svfiprintf_r+0x31c>
   11374:	f40782e3          	beqz	a5,112b8 <_svfiprintf_r+0x254>
   11378:	00e12a23          	sw	a4,20(sp)
   1137c:	f3dff06f          	j	112b8 <_svfiprintf_r+0x254>
   11380:	00271793          	sll	a5,a4,0x2
   11384:	00e787b3          	add	a5,a5,a4
   11388:	00179793          	sll	a5,a5,0x1
   1138c:	00d78733          	add	a4,a5,a3
   11390:	00058413          	mv	s0,a1
   11394:	00100793          	li	a5,1
   11398:	fcdff06f          	j	11364 <_svfiprintf_r+0x300>
   1139c:	00778793          	add	a5,a5,7
   113a0:	ff87f793          	and	a5,a5,-8
   113a4:	00878793          	add	a5,a5,8
   113a8:	f79ff06f          	j	11320 <_svfiprintf_r+0x2bc>
   113ac:	00c10713          	add	a4,sp,12
   113b0:	d40c0693          	add	a3,s8,-704 # 10d40 <__ssputs_r>
   113b4:	00090613          	mv	a2,s2
   113b8:	01010593          	add	a1,sp,16
   113bc:	000a0513          	mv	a0,s4
   113c0:	00000097          	auipc	ra,0x0
   113c4:	000000e7          	jalr	zero # 0 <main-0x10094>
   113c8:	fff00793          	li	a5,-1
   113cc:	00050993          	mv	s3,a0
   113d0:	f4f51ae3          	bne	a0,a5,11324 <_svfiprintf_r+0x2c0>
   113d4:	00c95783          	lhu	a5,12(s2)
   113d8:	0407f793          	and	a5,a5,64
   113dc:	d00790e3          	bnez	a5,110dc <_svfiprintf_r+0x78>
   113e0:	02412503          	lw	a0,36(sp)
   113e4:	cfdff06f          	j	110e0 <_svfiprintf_r+0x7c>
   113e8:	00c10713          	add	a4,sp,12
   113ec:	d40c0693          	add	a3,s8,-704
   113f0:	00090613          	mv	a2,s2
   113f4:	01010593          	add	a1,sp,16
   113f8:	000a0513          	mv	a0,s4
   113fc:	1b8000ef          	jal	115b4 <_printf_i>
   11400:	fc9ff06f          	j	113c8 <_svfiprintf_r+0x364>

00011404 <_printf_common>:
   11404:	fd010113          	add	sp,sp,-48
   11408:	01512a23          	sw	s5,20(sp)
   1140c:	0105a783          	lw	a5,16(a1)
   11410:	00070a93          	mv	s5,a4
   11414:	0085a703          	lw	a4,8(a1)
   11418:	02812423          	sw	s0,40(sp)
   1141c:	03212023          	sw	s2,32(sp)
   11420:	01312e23          	sw	s3,28(sp)
   11424:	01412c23          	sw	s4,24(sp)
   11428:	02112623          	sw	ra,44(sp)
   1142c:	02912223          	sw	s1,36(sp)
   11430:	01612823          	sw	s6,16(sp)
   11434:	01712623          	sw	s7,12(sp)
   11438:	00050993          	mv	s3,a0
   1143c:	00058413          	mv	s0,a1
   11440:	00060913          	mv	s2,a2
   11444:	00068a13          	mv	s4,a3
   11448:	00e7d463          	bge	a5,a4,11450 <_printf_common+0x4c>
   1144c:	00070793          	mv	a5,a4
   11450:	00f92023          	sw	a5,0(s2)
   11454:	04344703          	lbu	a4,67(s0)
   11458:	00070663          	beqz	a4,11464 <_printf_common+0x60>
   1145c:	00178793          	add	a5,a5,1
   11460:	00f92023          	sw	a5,0(s2)
   11464:	00042783          	lw	a5,0(s0)
   11468:	0207f793          	and	a5,a5,32
   1146c:	00078863          	beqz	a5,1147c <_printf_common+0x78>
   11470:	00092783          	lw	a5,0(s2)
   11474:	00278793          	add	a5,a5,2
   11478:	00f92023          	sw	a5,0(s2)
   1147c:	00042483          	lw	s1,0(s0)
   11480:	0064f493          	and	s1,s1,6
   11484:	00049e63          	bnez	s1,114a0 <_printf_common+0x9c>
   11488:	01940b13          	add	s6,s0,25
   1148c:	fff00b93          	li	s7,-1
   11490:	00c42783          	lw	a5,12(s0)
   11494:	00092703          	lw	a4,0(s2)
   11498:	40e787b3          	sub	a5,a5,a4
   1149c:	08f4c263          	blt	s1,a5,11520 <_printf_common+0x11c>
   114a0:	04344783          	lbu	a5,67(s0)
   114a4:	00f036b3          	snez	a3,a5
   114a8:	00042783          	lw	a5,0(s0)
   114ac:	0207f793          	and	a5,a5,32
   114b0:	0c079063          	bnez	a5,11570 <_printf_common+0x16c>
   114b4:	04340613          	add	a2,s0,67
   114b8:	000a0593          	mv	a1,s4
   114bc:	00098513          	mv	a0,s3
   114c0:	000a80e7          	jalr	s5
   114c4:	fff00793          	li	a5,-1
   114c8:	06f50863          	beq	a0,a5,11538 <_printf_common+0x134>
   114cc:	00042783          	lw	a5,0(s0)
   114d0:	00400713          	li	a4,4
   114d4:	00000493          	li	s1,0
   114d8:	0067f793          	and	a5,a5,6
   114dc:	00e79c63          	bne	a5,a4,114f4 <_printf_common+0xf0>
   114e0:	00c42483          	lw	s1,12(s0)
   114e4:	00092783          	lw	a5,0(s2)
   114e8:	40f484b3          	sub	s1,s1,a5
   114ec:	0004d463          	bgez	s1,114f4 <_printf_common+0xf0>
   114f0:	00000493          	li	s1,0
   114f4:	00842783          	lw	a5,8(s0)
   114f8:	01042703          	lw	a4,16(s0)
   114fc:	00f75663          	bge	a4,a5,11508 <_printf_common+0x104>
   11500:	40e787b3          	sub	a5,a5,a4
   11504:	00f484b3          	add	s1,s1,a5
   11508:	00000913          	li	s2,0
   1150c:	01a40413          	add	s0,s0,26
   11510:	fff00b13          	li	s6,-1
   11514:	09249063          	bne	s1,s2,11594 <_printf_common+0x190>
   11518:	00000513          	li	a0,0
   1151c:	0200006f          	j	1153c <_printf_common+0x138>
   11520:	00100693          	li	a3,1
   11524:	000b0613          	mv	a2,s6
   11528:	000a0593          	mv	a1,s4
   1152c:	00098513          	mv	a0,s3
   11530:	000a80e7          	jalr	s5
   11534:	03751a63          	bne	a0,s7,11568 <_printf_common+0x164>
   11538:	fff00513          	li	a0,-1
   1153c:	02c12083          	lw	ra,44(sp)
   11540:	02812403          	lw	s0,40(sp)
   11544:	02412483          	lw	s1,36(sp)
   11548:	02012903          	lw	s2,32(sp)
   1154c:	01c12983          	lw	s3,28(sp)
   11550:	01812a03          	lw	s4,24(sp)
   11554:	01412a83          	lw	s5,20(sp)
   11558:	01012b03          	lw	s6,16(sp)
   1155c:	00c12b83          	lw	s7,12(sp)
   11560:	03010113          	add	sp,sp,48
   11564:	00008067          	ret
   11568:	00148493          	add	s1,s1,1
   1156c:	f25ff06f          	j	11490 <_printf_common+0x8c>
   11570:	00d40733          	add	a4,s0,a3
   11574:	03000613          	li	a2,48
   11578:	04c701a3          	sb	a2,67(a4)
   1157c:	04544703          	lbu	a4,69(s0)
   11580:	00168793          	add	a5,a3,1
   11584:	00f407b3          	add	a5,s0,a5
   11588:	00268693          	add	a3,a3,2
   1158c:	04e781a3          	sb	a4,67(a5)
   11590:	f25ff06f          	j	114b4 <_printf_common+0xb0>
   11594:	00100693          	li	a3,1
   11598:	00040613          	mv	a2,s0
   1159c:	000a0593          	mv	a1,s4
   115a0:	00098513          	mv	a0,s3
   115a4:	000a80e7          	jalr	s5
   115a8:	f96508e3          	beq	a0,s6,11538 <_printf_common+0x134>
   115ac:	00190913          	add	s2,s2,1
   115b0:	f65ff06f          	j	11514 <_printf_common+0x110>

000115b4 <_printf_i>:
   115b4:	fc010113          	add	sp,sp,-64
   115b8:	02812c23          	sw	s0,56(sp)
   115bc:	03412423          	sw	s4,40(sp)
   115c0:	03512223          	sw	s5,36(sp)
   115c4:	03612023          	sw	s6,32(sp)
   115c8:	02112e23          	sw	ra,60(sp)
   115cc:	02912a23          	sw	s1,52(sp)
   115d0:	03212823          	sw	s2,48(sp)
   115d4:	03312623          	sw	s3,44(sp)
   115d8:	01712e23          	sw	s7,28(sp)
   115dc:	01812c23          	sw	s8,24(sp)
   115e0:	01912a23          	sw	s9,20(sp)
   115e4:	0185c783          	lbu	a5,24(a1)
   115e8:	00068b13          	mv	s6,a3
   115ec:	07800693          	li	a3,120
   115f0:	00050a13          	mv	s4,a0
   115f4:	00058413          	mv	s0,a1
   115f8:	00060a93          	mv	s5,a2
   115fc:	00f6ee63          	bltu	a3,a5,11618 <_printf_i+0x64>
   11600:	06200693          	li	a3,98
   11604:	04358b93          	add	s7,a1,67
   11608:	00f6ec63          	bltu	a3,a5,11620 <_printf_i+0x6c>
   1160c:	2a078063          	beqz	a5,118ac <_printf_i+0x2f8>
   11610:	05800693          	li	a3,88
   11614:	24d78063          	beq	a5,a3,11854 <_printf_i+0x2a0>
   11618:	04240c93          	add	s9,s0,66
   1161c:	0400006f          	j	1165c <_printf_i+0xa8>
   11620:	f9d78813          	add	a6,a5,-99
   11624:	0ff87813          	zext.b	a6,a6
   11628:	01500693          	li	a3,21
   1162c:	ff06e6e3          	bltu	a3,a6,11618 <_printf_i+0x64>
   11630:	000136b7          	lui	a3,0x13
   11634:	f2c68693          	add	a3,a3,-212 # 12f2c <_start+0x5f8>
   11638:	00281813          	sll	a6,a6,0x2
   1163c:	00d80833          	add	a6,a6,a3
   11640:	00082683          	lw	a3,0(a6)
   11644:	00068067          	jr	a3
   11648:	00072783          	lw	a5,0(a4)
   1164c:	04258c93          	add	s9,a1,66
   11650:	00478693          	add	a3,a5,4
   11654:	0007a783          	lw	a5,0(a5)
   11658:	00d72023          	sw	a3,0(a4)
   1165c:	04f40123          	sb	a5,66(s0)
   11660:	00100793          	li	a5,1
   11664:	2840006f          	j	118e8 <_printf_i+0x334>
   11668:	0005a783          	lw	a5,0(a1)
   1166c:	00072603          	lw	a2,0(a4)
   11670:	0807f593          	and	a1,a5,128
   11674:	00460693          	add	a3,a2,4
   11678:	02058663          	beqz	a1,116a4 <_printf_i+0xf0>
   1167c:	00062483          	lw	s1,0(a2)
   11680:	00d72023          	sw	a3,0(a4)
   11684:	00013937          	lui	s2,0x13
   11688:	0004d863          	bgez	s1,11698 <_printf_i+0xe4>
   1168c:	02d00793          	li	a5,45
   11690:	409004b3          	neg	s1,s1
   11694:	04f401a3          	sb	a5,67(s0)
   11698:	f0490913          	add	s2,s2,-252 # 12f04 <_start+0x5d0>
   1169c:	00a00993          	li	s3,10
   116a0:	0cc0006f          	j	1176c <_printf_i+0x1b8>
   116a4:	00062483          	lw	s1,0(a2)
   116a8:	0407f793          	and	a5,a5,64
   116ac:	00d72023          	sw	a3,0(a4)
   116b0:	fc078ae3          	beqz	a5,11684 <_printf_i+0xd0>
   116b4:	01049493          	sll	s1,s1,0x10
   116b8:	4104d493          	sra	s1,s1,0x10
   116bc:	fc9ff06f          	j	11684 <_printf_i+0xd0>
   116c0:	0005a603          	lw	a2,0(a1)
   116c4:	00072683          	lw	a3,0(a4)
   116c8:	08067593          	and	a1,a2,128
   116cc:	0006a483          	lw	s1,0(a3)
   116d0:	00468693          	add	a3,a3,4
   116d4:	00059a63          	bnez	a1,116e8 <_printf_i+0x134>
   116d8:	04067613          	and	a2,a2,64
   116dc:	00060663          	beqz	a2,116e8 <_printf_i+0x134>
   116e0:	01049493          	sll	s1,s1,0x10
   116e4:	0104d493          	srl	s1,s1,0x10
   116e8:	00d72023          	sw	a3,0(a4)
   116ec:	00013937          	lui	s2,0x13
   116f0:	06f00713          	li	a4,111
   116f4:	f0490913          	add	s2,s2,-252 # 12f04 <_start+0x5d0>
   116f8:	00800993          	li	s3,8
   116fc:	06e78663          	beq	a5,a4,11768 <_printf_i+0x1b4>
   11700:	00a00993          	li	s3,10
   11704:	0640006f          	j	11768 <_printf_i+0x1b4>
   11708:	0005a783          	lw	a5,0(a1)
   1170c:	0207e793          	or	a5,a5,32
   11710:	00f5a023          	sw	a5,0(a1)
   11714:	00013937          	lui	s2,0x13
   11718:	07800793          	li	a5,120
   1171c:	f1890913          	add	s2,s2,-232 # 12f18 <_start+0x5e4>
   11720:	04f402a3          	sb	a5,69(s0)
   11724:	00042783          	lw	a5,0(s0)
   11728:	00072683          	lw	a3,0(a4)
   1172c:	0807f613          	and	a2,a5,128
   11730:	0006a483          	lw	s1,0(a3)
   11734:	00468693          	add	a3,a3,4
   11738:	00061a63          	bnez	a2,1174c <_printf_i+0x198>
   1173c:	0407f613          	and	a2,a5,64
   11740:	00060663          	beqz	a2,1174c <_printf_i+0x198>
   11744:	01049493          	sll	s1,s1,0x10
   11748:	0104d493          	srl	s1,s1,0x10
   1174c:	00d72023          	sw	a3,0(a4)
   11750:	0017f713          	and	a4,a5,1
   11754:	00070663          	beqz	a4,11760 <_printf_i+0x1ac>
   11758:	0207e793          	or	a5,a5,32
   1175c:	00f42023          	sw	a5,0(s0)
   11760:	10048063          	beqz	s1,11860 <_printf_i+0x2ac>
   11764:	01000993          	li	s3,16
   11768:	040401a3          	sb	zero,67(s0)
   1176c:	00442783          	lw	a5,4(s0)
   11770:	00f42423          	sw	a5,8(s0)
   11774:	0007ce63          	bltz	a5,11790 <_printf_i+0x1dc>
   11778:	00042703          	lw	a4,0(s0)
   1177c:	00f4e7b3          	or	a5,s1,a5
   11780:	000b8c93          	mv	s9,s7
   11784:	ffb77713          	and	a4,a4,-5
   11788:	00e42023          	sw	a4,0(s0)
   1178c:	02078e63          	beqz	a5,117c8 <_printf_i+0x214>
   11790:	000b8c93          	mv	s9,s7
   11794:	00098593          	mv	a1,s3
   11798:	00048513          	mv	a0,s1
   1179c:	0e8010ef          	jal	12884 <__umodsi3>
   117a0:	00a90533          	add	a0,s2,a0
   117a4:	00054783          	lbu	a5,0(a0)
   117a8:	00098593          	mv	a1,s3
   117ac:	00048513          	mv	a0,s1
   117b0:	fefc8fa3          	sb	a5,-1(s9)
   117b4:	00048c13          	mv	s8,s1
   117b8:	084010ef          	jal	1283c <__hidden___udivsi3>
   117bc:	fffc8c93          	add	s9,s9,-1
   117c0:	00050493          	mv	s1,a0
   117c4:	fd3c78e3          	bgeu	s8,s3,11794 <_printf_i+0x1e0>
   117c8:	00800793          	li	a5,8
   117cc:	02f99463          	bne	s3,a5,117f4 <_printf_i+0x240>
   117d0:	00042783          	lw	a5,0(s0)
   117d4:	0017f793          	and	a5,a5,1
   117d8:	00078e63          	beqz	a5,117f4 <_printf_i+0x240>
   117dc:	00442703          	lw	a4,4(s0)
   117e0:	01042783          	lw	a5,16(s0)
   117e4:	00e7c863          	blt	a5,a4,117f4 <_printf_i+0x240>
   117e8:	03000793          	li	a5,48
   117ec:	fefc8fa3          	sb	a5,-1(s9)
   117f0:	fffc8c93          	add	s9,s9,-1
   117f4:	419b8bb3          	sub	s7,s7,s9
   117f8:	01742823          	sw	s7,16(s0)
   117fc:	000b0713          	mv	a4,s6
   11800:	000a8693          	mv	a3,s5
   11804:	00c10613          	add	a2,sp,12
   11808:	00040593          	mv	a1,s0
   1180c:	000a0513          	mv	a0,s4
   11810:	bf5ff0ef          	jal	11404 <_printf_common>
   11814:	fff00493          	li	s1,-1
   11818:	0c951e63          	bne	a0,s1,118f4 <_printf_i+0x340>
   1181c:	fff00513          	li	a0,-1
   11820:	03c12083          	lw	ra,60(sp)
   11824:	03812403          	lw	s0,56(sp)
   11828:	03412483          	lw	s1,52(sp)
   1182c:	03012903          	lw	s2,48(sp)
   11830:	02c12983          	lw	s3,44(sp)
   11834:	02812a03          	lw	s4,40(sp)
   11838:	02412a83          	lw	s5,36(sp)
   1183c:	02012b03          	lw	s6,32(sp)
   11840:	01c12b83          	lw	s7,28(sp)
   11844:	01812c03          	lw	s8,24(sp)
   11848:	01412c83          	lw	s9,20(sp)
   1184c:	04010113          	add	sp,sp,64
   11850:	00008067          	ret
   11854:	00013937          	lui	s2,0x13
   11858:	f0490913          	add	s2,s2,-252 # 12f04 <_start+0x5d0>
   1185c:	ec5ff06f          	j	11720 <_printf_i+0x16c>
   11860:	00042783          	lw	a5,0(s0)
   11864:	fdf7f793          	and	a5,a5,-33
   11868:	00f42023          	sw	a5,0(s0)
   1186c:	ef9ff06f          	j	11764 <_printf_i+0x1b0>
   11870:	0005a683          	lw	a3,0(a1)
   11874:	00072783          	lw	a5,0(a4)
   11878:	0145a603          	lw	a2,20(a1)
   1187c:	0806f513          	and	a0,a3,128
   11880:	00478593          	add	a1,a5,4
   11884:	00050a63          	beqz	a0,11898 <_printf_i+0x2e4>
   11888:	00b72023          	sw	a1,0(a4)
   1188c:	0007a783          	lw	a5,0(a5)
   11890:	00c7a023          	sw	a2,0(a5)
   11894:	0180006f          	j	118ac <_printf_i+0x2f8>
   11898:	00b72023          	sw	a1,0(a4)
   1189c:	0406f693          	and	a3,a3,64
   118a0:	0007a783          	lw	a5,0(a5)
   118a4:	fe0686e3          	beqz	a3,11890 <_printf_i+0x2dc>
   118a8:	00c79023          	sh	a2,0(a5)
   118ac:	00042823          	sw	zero,16(s0)
   118b0:	000b8c93          	mv	s9,s7
   118b4:	f49ff06f          	j	117fc <_printf_i+0x248>
   118b8:	00072783          	lw	a5,0(a4)
   118bc:	0045a603          	lw	a2,4(a1)
   118c0:	00000593          	li	a1,0
   118c4:	00478693          	add	a3,a5,4
   118c8:	00d72023          	sw	a3,0(a4)
   118cc:	0007ac83          	lw	s9,0(a5)
   118d0:	000c8513          	mv	a0,s9
   118d4:	098000ef          	jal	1196c <memchr>
   118d8:	00050663          	beqz	a0,118e4 <_printf_i+0x330>
   118dc:	41950533          	sub	a0,a0,s9
   118e0:	00a42223          	sw	a0,4(s0)
   118e4:	00442783          	lw	a5,4(s0)
   118e8:	00f42823          	sw	a5,16(s0)
   118ec:	040401a3          	sb	zero,67(s0)
   118f0:	f0dff06f          	j	117fc <_printf_i+0x248>
   118f4:	01042683          	lw	a3,16(s0)
   118f8:	000c8613          	mv	a2,s9
   118fc:	000a8593          	mv	a1,s5
   11900:	000a0513          	mv	a0,s4
   11904:	000b00e7          	jalr	s6
   11908:	f0950ae3          	beq	a0,s1,1181c <_printf_i+0x268>
   1190c:	00042783          	lw	a5,0(s0)
   11910:	0027f793          	and	a5,a5,2
   11914:	04079463          	bnez	a5,1195c <_printf_i+0x3a8>
   11918:	00c12783          	lw	a5,12(sp)
   1191c:	00c42503          	lw	a0,12(s0)
   11920:	f0f550e3          	bge	a0,a5,11820 <_printf_i+0x26c>
   11924:	00078513          	mv	a0,a5
   11928:	ef9ff06f          	j	11820 <_printf_i+0x26c>
   1192c:	00100693          	li	a3,1
   11930:	00090613          	mv	a2,s2
   11934:	000a8593          	mv	a1,s5
   11938:	000a0513          	mv	a0,s4
   1193c:	000b00e7          	jalr	s6
   11940:	ed350ee3          	beq	a0,s3,1181c <_printf_i+0x268>
   11944:	00148493          	add	s1,s1,1
   11948:	00c42783          	lw	a5,12(s0)
   1194c:	00c12703          	lw	a4,12(sp)
   11950:	40e787b3          	sub	a5,a5,a4
   11954:	fcf4cce3          	blt	s1,a5,1192c <_printf_i+0x378>
   11958:	fc1ff06f          	j	11918 <_printf_i+0x364>
   1195c:	00000493          	li	s1,0
   11960:	01940913          	add	s2,s0,25
   11964:	fff00993          	li	s3,-1
   11968:	fe1ff06f          	j	11948 <_printf_i+0x394>

0001196c <memchr>:
   1196c:	0ff5f593          	zext.b	a1,a1
   11970:	00c50633          	add	a2,a0,a2
   11974:	00c51663          	bne	a0,a2,11980 <memchr+0x14>
   11978:	00000513          	li	a0,0
   1197c:	00008067          	ret
   11980:	00054783          	lbu	a5,0(a0)
   11984:	feb78ce3          	beq	a5,a1,1197c <memchr+0x10>
   11988:	00150513          	add	a0,a0,1
   1198c:	fe9ff06f          	j	11974 <memchr+0x8>

00011990 <memmove>:
   11990:	02060c63          	beqz	a2,119c8 <memmove+0x38>
   11994:	00050313          	mv	t1,a0
   11998:	00100693          	li	a3,1
   1199c:	00b56a63          	bltu	a0,a1,119b0 <memmove+0x20>
   119a0:	fff00693          	li	a3,-1
   119a4:	fff60713          	add	a4,a2,-1
   119a8:	00e30333          	add	t1,t1,a4
   119ac:	00e585b3          	add	a1,a1,a4
   119b0:	00058383          	lb	t2,0(a1)
   119b4:	00730023          	sb	t2,0(t1)
   119b8:	fff60613          	add	a2,a2,-1
   119bc:	00d30333          	add	t1,t1,a3
   119c0:	00d585b3          	add	a1,a1,a3
   119c4:	fe0616e3          	bnez	a2,119b0 <memmove+0x20>
   119c8:	00008067          	ret

000119cc <memcpy>:
   119cc:	00050313          	mv	t1,a0
   119d0:	00060e63          	beqz	a2,119ec <memcpy+0x20>
   119d4:	00058383          	lb	t2,0(a1)
   119d8:	00730023          	sb	t2,0(t1)
   119dc:	fff60613          	add	a2,a2,-1
   119e0:	00130313          	add	t1,t1,1
   119e4:	00158593          	add	a1,a1,1
   119e8:	fe0616e3          	bnez	a2,119d4 <memcpy+0x8>
   119ec:	00008067          	ret

000119f0 <_free_r>:
   119f0:	0e058a63          	beqz	a1,11ae4 <_free_r+0xf4>
   119f4:	ffc5a783          	lw	a5,-4(a1)
   119f8:	fe010113          	add	sp,sp,-32
   119fc:	00812c23          	sw	s0,24(sp)
   11a00:	00112e23          	sw	ra,28(sp)
   11a04:	ffc58413          	add	s0,a1,-4
   11a08:	0007d463          	bgez	a5,11a10 <_free_r+0x20>
   11a0c:	00f40433          	add	s0,s0,a5
   11a10:	00a12623          	sw	a0,12(sp)
   11a14:	318000ef          	jal	11d2c <__malloc_lock>
   11a18:	83c1a783          	lw	a5,-1988(gp) # 14148 <__malloc_free_list>
   11a1c:	00c12503          	lw	a0,12(sp)
   11a20:	00079e63          	bnez	a5,11a3c <_free_r+0x4c>
   11a24:	00042223          	sw	zero,4(s0)
   11a28:	8281ae23          	sw	s0,-1988(gp) # 14148 <__malloc_free_list>
   11a2c:	01812403          	lw	s0,24(sp)
   11a30:	01c12083          	lw	ra,28(sp)
   11a34:	02010113          	add	sp,sp,32
   11a38:	2f80006f          	j	11d30 <__malloc_unlock>
   11a3c:	02f47463          	bgeu	s0,a5,11a64 <_free_r+0x74>
   11a40:	00042603          	lw	a2,0(s0)
   11a44:	00c406b3          	add	a3,s0,a2
   11a48:	00d79a63          	bne	a5,a3,11a5c <_free_r+0x6c>
   11a4c:	0007a683          	lw	a3,0(a5)
   11a50:	0047a783          	lw	a5,4(a5)
   11a54:	00c686b3          	add	a3,a3,a2
   11a58:	00d42023          	sw	a3,0(s0)
   11a5c:	00f42223          	sw	a5,4(s0)
   11a60:	fc9ff06f          	j	11a28 <_free_r+0x38>
   11a64:	00078713          	mv	a4,a5
   11a68:	0047a783          	lw	a5,4(a5)
   11a6c:	00078463          	beqz	a5,11a74 <_free_r+0x84>
   11a70:	fef47ae3          	bgeu	s0,a5,11a64 <_free_r+0x74>
   11a74:	00072683          	lw	a3,0(a4)
   11a78:	00d70633          	add	a2,a4,a3
   11a7c:	02861863          	bne	a2,s0,11aac <_free_r+0xbc>
   11a80:	00042603          	lw	a2,0(s0)
   11a84:	00c686b3          	add	a3,a3,a2
   11a88:	00d72023          	sw	a3,0(a4)
   11a8c:	00d70633          	add	a2,a4,a3
   11a90:	f8c79ee3          	bne	a5,a2,11a2c <_free_r+0x3c>
   11a94:	0007a603          	lw	a2,0(a5)
   11a98:	0047a783          	lw	a5,4(a5)
   11a9c:	00d606b3          	add	a3,a2,a3
   11aa0:	00d72023          	sw	a3,0(a4)
   11aa4:	00f72223          	sw	a5,4(a4)
   11aa8:	f85ff06f          	j	11a2c <_free_r+0x3c>
   11aac:	00c47863          	bgeu	s0,a2,11abc <_free_r+0xcc>
   11ab0:	00c00793          	li	a5,12
   11ab4:	00f52023          	sw	a5,0(a0)
   11ab8:	f75ff06f          	j	11a2c <_free_r+0x3c>
   11abc:	00042603          	lw	a2,0(s0)
   11ac0:	00c406b3          	add	a3,s0,a2
   11ac4:	00d79a63          	bne	a5,a3,11ad8 <_free_r+0xe8>
   11ac8:	0007a683          	lw	a3,0(a5)
   11acc:	0047a783          	lw	a5,4(a5)
   11ad0:	00c686b3          	add	a3,a3,a2
   11ad4:	00d42023          	sw	a3,0(s0)
   11ad8:	00f42223          	sw	a5,4(s0)
   11adc:	00872223          	sw	s0,4(a4)
   11ae0:	f4dff06f          	j	11a2c <_free_r+0x3c>
   11ae4:	00008067          	ret

00011ae8 <sbrk_aligned>:
   11ae8:	ff010113          	add	sp,sp,-16
   11aec:	01212023          	sw	s2,0(sp)
   11af0:	8381a783          	lw	a5,-1992(gp) # 14144 <__malloc_sbrk_start>
   11af4:	00812423          	sw	s0,8(sp)
   11af8:	00912223          	sw	s1,4(sp)
   11afc:	00112623          	sw	ra,12(sp)
   11b00:	00050493          	mv	s1,a0
   11b04:	00058413          	mv	s0,a1
   11b08:	00079863          	bnez	a5,11b18 <sbrk_aligned+0x30>
   11b0c:	00000593          	li	a1,0
   11b10:	2fc000ef          	jal	11e0c <_sbrk_r>
   11b14:	82a1ac23          	sw	a0,-1992(gp) # 14144 <__malloc_sbrk_start>
   11b18:	00040593          	mv	a1,s0
   11b1c:	00048513          	mv	a0,s1
   11b20:	2ec000ef          	jal	11e0c <_sbrk_r>
   11b24:	fff00913          	li	s2,-1
   11b28:	03251263          	bne	a0,s2,11b4c <sbrk_aligned+0x64>
   11b2c:	fff00413          	li	s0,-1
   11b30:	00c12083          	lw	ra,12(sp)
   11b34:	00040513          	mv	a0,s0
   11b38:	00812403          	lw	s0,8(sp)
   11b3c:	00412483          	lw	s1,4(sp)
   11b40:	00012903          	lw	s2,0(sp)
   11b44:	01010113          	add	sp,sp,16
   11b48:	00008067          	ret
   11b4c:	00350413          	add	s0,a0,3
   11b50:	ffc47413          	and	s0,s0,-4
   11b54:	fc850ee3          	beq	a0,s0,11b30 <sbrk_aligned+0x48>
   11b58:	40a405b3          	sub	a1,s0,a0
   11b5c:	00048513          	mv	a0,s1
   11b60:	2ac000ef          	jal	11e0c <_sbrk_r>
   11b64:	fd2516e3          	bne	a0,s2,11b30 <sbrk_aligned+0x48>
   11b68:	fc5ff06f          	j	11b2c <sbrk_aligned+0x44>

00011b6c <_malloc_r>:
   11b6c:	fe010113          	add	sp,sp,-32
   11b70:	00912a23          	sw	s1,20(sp)
   11b74:	00358493          	add	s1,a1,3
   11b78:	ffc4f493          	and	s1,s1,-4
   11b7c:	01212823          	sw	s2,16(sp)
   11b80:	00112e23          	sw	ra,28(sp)
   11b84:	00812c23          	sw	s0,24(sp)
   11b88:	01312623          	sw	s3,12(sp)
   11b8c:	01412423          	sw	s4,8(sp)
   11b90:	00848493          	add	s1,s1,8
   11b94:	00c00793          	li	a5,12
   11b98:	00050913          	mv	s2,a0
   11b9c:	0af4f063          	bgeu	s1,a5,11c3c <_malloc_r+0xd0>
   11ba0:	00c00493          	li	s1,12
   11ba4:	08b4ee63          	bltu	s1,a1,11c40 <_malloc_r+0xd4>
   11ba8:	00090513          	mv	a0,s2
   11bac:	180000ef          	jal	11d2c <__malloc_lock>
   11bb0:	83c1a783          	lw	a5,-1988(gp) # 14148 <__malloc_free_list>
   11bb4:	00078413          	mv	s0,a5
   11bb8:	0a041a63          	bnez	s0,11c6c <_malloc_r+0x100>
   11bbc:	00048593          	mv	a1,s1
   11bc0:	00090513          	mv	a0,s2
   11bc4:	f25ff0ef          	jal	11ae8 <sbrk_aligned>
   11bc8:	fff00793          	li	a5,-1
   11bcc:	00050413          	mv	s0,a0
   11bd0:	14f51663          	bne	a0,a5,11d1c <_malloc_r+0x1b0>
   11bd4:	83c1a403          	lw	s0,-1988(gp) # 14148 <__malloc_free_list>
   11bd8:	00040793          	mv	a5,s0
   11bdc:	10079c63          	bnez	a5,11cf4 <_malloc_r+0x188>
   11be0:	12040463          	beqz	s0,11d08 <_malloc_r+0x19c>
   11be4:	00042a03          	lw	s4,0(s0)
   11be8:	00000593          	li	a1,0
   11bec:	00090513          	mv	a0,s2
   11bf0:	01440a33          	add	s4,s0,s4
   11bf4:	218000ef          	jal	11e0c <_sbrk_r>
   11bf8:	10aa1863          	bne	s4,a0,11d08 <_malloc_r+0x19c>
   11bfc:	00042783          	lw	a5,0(s0)
   11c00:	00090513          	mv	a0,s2
   11c04:	40f484b3          	sub	s1,s1,a5
   11c08:	00048593          	mv	a1,s1
   11c0c:	eddff0ef          	jal	11ae8 <sbrk_aligned>
   11c10:	fff00793          	li	a5,-1
   11c14:	0ef50a63          	beq	a0,a5,11d08 <_malloc_r+0x19c>
   11c18:	00042783          	lw	a5,0(s0)
   11c1c:	009787b3          	add	a5,a5,s1
   11c20:	00f42023          	sw	a5,0(s0)
   11c24:	83c1a783          	lw	a5,-1988(gp) # 14148 <__malloc_free_list>
   11c28:	0e078e63          	beqz	a5,11d24 <_malloc_r+0x1b8>
   11c2c:	0047a703          	lw	a4,4(a5)
   11c30:	0c871863          	bne	a4,s0,11d00 <_malloc_r+0x194>
   11c34:	0007a223          	sw	zero,4(a5)
   11c38:	0640006f          	j	11c9c <_malloc_r+0x130>
   11c3c:	f604d4e3          	bgez	s1,11ba4 <_malloc_r+0x38>
   11c40:	00c00793          	li	a5,12
   11c44:	00f92023          	sw	a5,0(s2)
   11c48:	00000513          	li	a0,0
   11c4c:	01c12083          	lw	ra,28(sp)
   11c50:	01812403          	lw	s0,24(sp)
   11c54:	01412483          	lw	s1,20(sp)
   11c58:	01012903          	lw	s2,16(sp)
   11c5c:	00c12983          	lw	s3,12(sp)
   11c60:	00812a03          	lw	s4,8(sp)
   11c64:	02010113          	add	sp,sp,32
   11c68:	00008067          	ret
   11c6c:	00042683          	lw	a3,0(s0)
   11c70:	409686b3          	sub	a3,a3,s1
   11c74:	0606ca63          	bltz	a3,11ce8 <_malloc_r+0x17c>
   11c78:	00b00713          	li	a4,11
   11c7c:	04d77a63          	bgeu	a4,a3,11cd0 <_malloc_r+0x164>
   11c80:	00942023          	sw	s1,0(s0)
   11c84:	00940733          	add	a4,s0,s1
   11c88:	04879063          	bne	a5,s0,11cc8 <_malloc_r+0x15c>
   11c8c:	82e1ae23          	sw	a4,-1988(gp) # 14148 <__malloc_free_list>
   11c90:	00442783          	lw	a5,4(s0)
   11c94:	00d72023          	sw	a3,0(a4)
   11c98:	00f72223          	sw	a5,4(a4)
   11c9c:	00090513          	mv	a0,s2
   11ca0:	090000ef          	jal	11d30 <__malloc_unlock>
   11ca4:	00b40513          	add	a0,s0,11
   11ca8:	00440793          	add	a5,s0,4
   11cac:	ff857513          	and	a0,a0,-8
   11cb0:	40f50733          	sub	a4,a0,a5
   11cb4:	f8f50ce3          	beq	a0,a5,11c4c <_malloc_r+0xe0>
   11cb8:	00e40433          	add	s0,s0,a4
   11cbc:	40a787b3          	sub	a5,a5,a0
   11cc0:	00f42023          	sw	a5,0(s0)
   11cc4:	f89ff06f          	j	11c4c <_malloc_r+0xe0>
   11cc8:	00e7a223          	sw	a4,4(a5)
   11ccc:	fc5ff06f          	j	11c90 <_malloc_r+0x124>
   11cd0:	00442703          	lw	a4,4(s0)
   11cd4:	00879663          	bne	a5,s0,11ce0 <_malloc_r+0x174>
   11cd8:	82e1ae23          	sw	a4,-1988(gp) # 14148 <__malloc_free_list>
   11cdc:	fc1ff06f          	j	11c9c <_malloc_r+0x130>
   11ce0:	00e7a223          	sw	a4,4(a5)
   11ce4:	fb9ff06f          	j	11c9c <_malloc_r+0x130>
   11ce8:	00040793          	mv	a5,s0
   11cec:	00442403          	lw	s0,4(s0)
   11cf0:	ec9ff06f          	j	11bb8 <_malloc_r+0x4c>
   11cf4:	00078413          	mv	s0,a5
   11cf8:	0047a783          	lw	a5,4(a5)
   11cfc:	ee1ff06f          	j	11bdc <_malloc_r+0x70>
   11d00:	00070793          	mv	a5,a4
   11d04:	f25ff06f          	j	11c28 <_malloc_r+0xbc>
   11d08:	00c00793          	li	a5,12
   11d0c:	00f92023          	sw	a5,0(s2)
   11d10:	00090513          	mv	a0,s2
   11d14:	01c000ef          	jal	11d30 <__malloc_unlock>
   11d18:	f31ff06f          	j	11c48 <_malloc_r+0xdc>
   11d1c:	00952023          	sw	s1,0(a0)
   11d20:	f7dff06f          	j	11c9c <_malloc_r+0x130>
   11d24:	00002223          	sw	zero,4(zero) # 4 <main-0x10090>
   11d28:	00100073          	ebreak

00011d2c <__malloc_lock>:
   11d2c:	00008067          	ret

00011d30 <__malloc_unlock>:
   11d30:	00008067          	ret

00011d34 <_realloc_r>:
   11d34:	fe010113          	add	sp,sp,-32
   11d38:	00812c23          	sw	s0,24(sp)
   11d3c:	00112e23          	sw	ra,28(sp)
   11d40:	00912a23          	sw	s1,20(sp)
   11d44:	01212823          	sw	s2,16(sp)
   11d48:	01312623          	sw	s3,12(sp)
   11d4c:	01412423          	sw	s4,8(sp)
   11d50:	00060413          	mv	s0,a2
   11d54:	02059463          	bnez	a1,11d7c <_realloc_r+0x48>
   11d58:	01812403          	lw	s0,24(sp)
   11d5c:	01c12083          	lw	ra,28(sp)
   11d60:	01412483          	lw	s1,20(sp)
   11d64:	01012903          	lw	s2,16(sp)
   11d68:	00c12983          	lw	s3,12(sp)
   11d6c:	00812a03          	lw	s4,8(sp)
   11d70:	00060593          	mv	a1,a2
   11d74:	02010113          	add	sp,sp,32
   11d78:	df5ff06f          	j	11b6c <_malloc_r>
   11d7c:	02061863          	bnez	a2,11dac <_realloc_r+0x78>
   11d80:	c71ff0ef          	jal	119f0 <_free_r>
   11d84:	00000493          	li	s1,0
   11d88:	01c12083          	lw	ra,28(sp)
   11d8c:	01812403          	lw	s0,24(sp)
   11d90:	01012903          	lw	s2,16(sp)
   11d94:	00c12983          	lw	s3,12(sp)
   11d98:	00812a03          	lw	s4,8(sp)
   11d9c:	00048513          	mv	a0,s1
   11da0:	01412483          	lw	s1,20(sp)
   11da4:	02010113          	add	sp,sp,32
   11da8:	00008067          	ret
   11dac:	00050a13          	mv	s4,a0
   11db0:	00058493          	mv	s1,a1
   11db4:	0a0000ef          	jal	11e54 <_malloc_usable_size_r>
   11db8:	00050913          	mv	s2,a0
   11dbc:	00856663          	bltu	a0,s0,11dc8 <_realloc_r+0x94>
   11dc0:	00155793          	srl	a5,a0,0x1
   11dc4:	fc87e2e3          	bltu	a5,s0,11d88 <_realloc_r+0x54>
   11dc8:	00040593          	mv	a1,s0
   11dcc:	000a0513          	mv	a0,s4
   11dd0:	d9dff0ef          	jal	11b6c <_malloc_r>
   11dd4:	00050993          	mv	s3,a0
   11dd8:	00051663          	bnez	a0,11de4 <_realloc_r+0xb0>
   11ddc:	00098493          	mv	s1,s3
   11de0:	fa9ff06f          	j	11d88 <_realloc_r+0x54>
   11de4:	00040613          	mv	a2,s0
   11de8:	00897463          	bgeu	s2,s0,11df0 <_realloc_r+0xbc>
   11dec:	00090613          	mv	a2,s2
   11df0:	00048593          	mv	a1,s1
   11df4:	00098513          	mv	a0,s3
   11df8:	bd5ff0ef          	jal	119cc <memcpy>
   11dfc:	00048593          	mv	a1,s1
   11e00:	000a0513          	mv	a0,s4
   11e04:	bedff0ef          	jal	119f0 <_free_r>
   11e08:	fd5ff06f          	j	11ddc <_realloc_r+0xa8>

00011e0c <_sbrk_r>:
   11e0c:	ff010113          	add	sp,sp,-16
   11e10:	00812423          	sw	s0,8(sp)
   11e14:	00912223          	sw	s1,4(sp)
   11e18:	00050413          	mv	s0,a0
   11e1c:	00058513          	mv	a0,a1
   11e20:	00112623          	sw	ra,12(sp)
   11e24:	8401a023          	sw	zero,-1984(gp) # 1414c <errno>
   11e28:	e0dfe0ef          	jal	10c34 <_sbrk>
   11e2c:	fff00793          	li	a5,-1
   11e30:	00f51863          	bne	a0,a5,11e40 <_sbrk_r+0x34>
   11e34:	8401a783          	lw	a5,-1984(gp) # 1414c <errno>
   11e38:	00078463          	beqz	a5,11e40 <_sbrk_r+0x34>
   11e3c:	00f42023          	sw	a5,0(s0)
   11e40:	00c12083          	lw	ra,12(sp)
   11e44:	00812403          	lw	s0,8(sp)
   11e48:	00412483          	lw	s1,4(sp)
   11e4c:	01010113          	add	sp,sp,16
   11e50:	00008067          	ret

00011e54 <_malloc_usable_size_r>:
   11e54:	ffc5a783          	lw	a5,-4(a1)
   11e58:	ffc78513          	add	a0,a5,-4
   11e5c:	0007d863          	bgez	a5,11e6c <_malloc_usable_size_r+0x18>
   11e60:	00a585b3          	add	a1,a1,a0
   11e64:	0005a783          	lw	a5,0(a1)
   11e68:	00f50533          	add	a0,a0,a5
   11e6c:	00008067          	ret

00011e70 <_reclaim_reent>:
   11e70:	8081a783          	lw	a5,-2040(gp) # 14114 <_impure_ptr>
   11e74:	14a78863          	beq	a5,a0,11fc4 <_reclaim_reent+0x154>
   11e78:	01c52783          	lw	a5,28(a0)
   11e7c:	fe010113          	add	sp,sp,-32
   11e80:	00812c23          	sw	s0,24(sp)
   11e84:	00112e23          	sw	ra,28(sp)
   11e88:	00912a23          	sw	s1,20(sp)
   11e8c:	01212823          	sw	s2,16(sp)
   11e90:	01312623          	sw	s3,12(sp)
   11e94:	00050413          	mv	s0,a0
   11e98:	04078a63          	beqz	a5,11eec <_reclaim_reent+0x7c>
   11e9c:	00c7a783          	lw	a5,12(a5)
   11ea0:	02078c63          	beqz	a5,11ed8 <_reclaim_reent+0x68>
   11ea4:	00000493          	li	s1,0
   11ea8:	08000913          	li	s2,128
   11eac:	01c42783          	lw	a5,28(s0)
   11eb0:	00c7a783          	lw	a5,12(a5)
   11eb4:	009787b3          	add	a5,a5,s1
   11eb8:	0007a583          	lw	a1,0(a5)
   11ebc:	0c059c63          	bnez	a1,11f94 <_reclaim_reent+0x124>
   11ec0:	00448493          	add	s1,s1,4
   11ec4:	ff2494e3          	bne	s1,s2,11eac <_reclaim_reent+0x3c>
   11ec8:	01c42783          	lw	a5,28(s0)
   11ecc:	00040513          	mv	a0,s0
   11ed0:	00c7a583          	lw	a1,12(a5)
   11ed4:	b1dff0ef          	jal	119f0 <_free_r>
   11ed8:	01c42783          	lw	a5,28(s0)
   11edc:	0007a583          	lw	a1,0(a5)
   11ee0:	00058663          	beqz	a1,11eec <_reclaim_reent+0x7c>
   11ee4:	00040513          	mv	a0,s0
   11ee8:	b09ff0ef          	jal	119f0 <_free_r>
   11eec:	01442583          	lw	a1,20(s0)
   11ef0:	00058663          	beqz	a1,11efc <_reclaim_reent+0x8c>
   11ef4:	00040513          	mv	a0,s0
   11ef8:	af9ff0ef          	jal	119f0 <_free_r>
   11efc:	01c42583          	lw	a1,28(s0)
   11f00:	00058663          	beqz	a1,11f0c <_reclaim_reent+0x9c>
   11f04:	00040513          	mv	a0,s0
   11f08:	ae9ff0ef          	jal	119f0 <_free_r>
   11f0c:	03042583          	lw	a1,48(s0)
   11f10:	00058663          	beqz	a1,11f1c <_reclaim_reent+0xac>
   11f14:	00040513          	mv	a0,s0
   11f18:	ad9ff0ef          	jal	119f0 <_free_r>
   11f1c:	03442583          	lw	a1,52(s0)
   11f20:	00058663          	beqz	a1,11f2c <_reclaim_reent+0xbc>
   11f24:	00040513          	mv	a0,s0
   11f28:	ac9ff0ef          	jal	119f0 <_free_r>
   11f2c:	03842583          	lw	a1,56(s0)
   11f30:	00058663          	beqz	a1,11f3c <_reclaim_reent+0xcc>
   11f34:	00040513          	mv	a0,s0
   11f38:	ab9ff0ef          	jal	119f0 <_free_r>
   11f3c:	04842583          	lw	a1,72(s0)
   11f40:	00058663          	beqz	a1,11f4c <_reclaim_reent+0xdc>
   11f44:	00040513          	mv	a0,s0
   11f48:	aa9ff0ef          	jal	119f0 <_free_r>
   11f4c:	04442583          	lw	a1,68(s0)
   11f50:	00058663          	beqz	a1,11f5c <_reclaim_reent+0xec>
   11f54:	00040513          	mv	a0,s0
   11f58:	a99ff0ef          	jal	119f0 <_free_r>
   11f5c:	02c42583          	lw	a1,44(s0)
   11f60:	00058663          	beqz	a1,11f6c <_reclaim_reent+0xfc>
   11f64:	00040513          	mv	a0,s0
   11f68:	a89ff0ef          	jal	119f0 <_free_r>
   11f6c:	02042783          	lw	a5,32(s0)
   11f70:	02078c63          	beqz	a5,11fa8 <_reclaim_reent+0x138>
   11f74:	00040513          	mv	a0,s0
   11f78:	01812403          	lw	s0,24(sp)
   11f7c:	01c12083          	lw	ra,28(sp)
   11f80:	01412483          	lw	s1,20(sp)
   11f84:	01012903          	lw	s2,16(sp)
   11f88:	00c12983          	lw	s3,12(sp)
   11f8c:	02010113          	add	sp,sp,32
   11f90:	00078067          	jr	a5
   11f94:	0005a983          	lw	s3,0(a1)
   11f98:	00040513          	mv	a0,s0
   11f9c:	a55ff0ef          	jal	119f0 <_free_r>
   11fa0:	00098593          	mv	a1,s3
   11fa4:	f19ff06f          	j	11ebc <_reclaim_reent+0x4c>
   11fa8:	01c12083          	lw	ra,28(sp)
   11fac:	01812403          	lw	s0,24(sp)
   11fb0:	01412483          	lw	s1,20(sp)
   11fb4:	01012903          	lw	s2,16(sp)
   11fb8:	00c12983          	lw	s3,12(sp)
   11fbc:	02010113          	add	sp,sp,32
   11fc0:	00008067          	ret
   11fc4:	00008067          	ret

00011fc8 <__divsf3>:
   11fc8:	fd010113          	add	sp,sp,-48
   11fcc:	02912223          	sw	s1,36(sp)
   11fd0:	01755493          	srl	s1,a0,0x17
   11fd4:	01312e23          	sw	s3,28(sp)
   11fd8:	01512a23          	sw	s5,20(sp)
   11fdc:	01612823          	sw	s6,16(sp)
   11fe0:	00951a93          	sll	s5,a0,0x9
   11fe4:	02112623          	sw	ra,44(sp)
   11fe8:	02812423          	sw	s0,40(sp)
   11fec:	03212023          	sw	s2,32(sp)
   11ff0:	01412c23          	sw	s4,24(sp)
   11ff4:	01712623          	sw	s7,12(sp)
   11ff8:	01812423          	sw	s8,8(sp)
   11ffc:	0ff4f493          	zext.b	s1,s1
   12000:	00058b13          	mv	s6,a1
   12004:	009ada93          	srl	s5,s5,0x9
   12008:	01f55993          	srl	s3,a0,0x1f
   1200c:	08048463          	beqz	s1,12094 <__divsf3+0xcc>
   12010:	0ff00793          	li	a5,255
   12014:	0af48063          	beq	s1,a5,120b4 <__divsf3+0xec>
   12018:	003a9a93          	sll	s5,s5,0x3
   1201c:	040007b7          	lui	a5,0x4000
   12020:	00faeab3          	or	s5,s5,a5
   12024:	f8148493          	add	s1,s1,-127
   12028:	00000b93          	li	s7,0
   1202c:	017b5793          	srl	a5,s6,0x17
   12030:	009b1413          	sll	s0,s6,0x9
   12034:	0ff7f793          	zext.b	a5,a5
   12038:	00945413          	srl	s0,s0,0x9
   1203c:	01fb5b13          	srl	s6,s6,0x1f
   12040:	08078a63          	beqz	a5,120d4 <__divsf3+0x10c>
   12044:	0ff00713          	li	a4,255
   12048:	0ae78663          	beq	a5,a4,120f4 <__divsf3+0x12c>
   1204c:	00341413          	sll	s0,s0,0x3
   12050:	04000737          	lui	a4,0x4000
   12054:	00e46433          	or	s0,s0,a4
   12058:	f8178793          	add	a5,a5,-127 # 3ffff81 <__BSS_END__+0x3fe9259>
   1205c:	00000713          	li	a4,0
   12060:	40f48a33          	sub	s4,s1,a5
   12064:	002b9793          	sll	a5,s7,0x2
   12068:	00e7e7b3          	or	a5,a5,a4
   1206c:	fff78793          	add	a5,a5,-1
   12070:	00e00693          	li	a3,14
   12074:	0169c933          	xor	s2,s3,s6
   12078:	08f6ee63          	bltu	a3,a5,12114 <__divsf3+0x14c>
   1207c:	000136b7          	lui	a3,0x13
   12080:	00279793          	sll	a5,a5,0x2
   12084:	f8468693          	add	a3,a3,-124 # 12f84 <_start+0x650>
   12088:	00d787b3          	add	a5,a5,a3
   1208c:	0007a783          	lw	a5,0(a5)
   12090:	00078067          	jr	a5
   12094:	020a8a63          	beqz	s5,120c8 <__divsf3+0x100>
   12098:	000a8513          	mv	a0,s5
   1209c:	04d000ef          	jal	128e8 <__clzsi2>
   120a0:	ffb50793          	add	a5,a0,-5
   120a4:	f8a00493          	li	s1,-118
   120a8:	00fa9ab3          	sll	s5,s5,a5
   120ac:	40a484b3          	sub	s1,s1,a0
   120b0:	f79ff06f          	j	12028 <__divsf3+0x60>
   120b4:	0ff00493          	li	s1,255
   120b8:	00200b93          	li	s7,2
   120bc:	f60a88e3          	beqz	s5,1202c <__divsf3+0x64>
   120c0:	00300b93          	li	s7,3
   120c4:	f69ff06f          	j	1202c <__divsf3+0x64>
   120c8:	00000493          	li	s1,0
   120cc:	00100b93          	li	s7,1
   120d0:	f5dff06f          	j	1202c <__divsf3+0x64>
   120d4:	02040a63          	beqz	s0,12108 <__divsf3+0x140>
   120d8:	00040513          	mv	a0,s0
   120dc:	00d000ef          	jal	128e8 <__clzsi2>
   120e0:	ffb50793          	add	a5,a0,-5
   120e4:	00f41433          	sll	s0,s0,a5
   120e8:	f8a00793          	li	a5,-118
   120ec:	40a787b3          	sub	a5,a5,a0
   120f0:	f6dff06f          	j	1205c <__divsf3+0x94>
   120f4:	0ff00793          	li	a5,255
   120f8:	00200713          	li	a4,2
   120fc:	f60402e3          	beqz	s0,12060 <__divsf3+0x98>
   12100:	00300713          	li	a4,3
   12104:	f5dff06f          	j	12060 <__divsf3+0x98>
   12108:	00000793          	li	a5,0
   1210c:	00100713          	li	a4,1
   12110:	f51ff06f          	j	12060 <__divsf3+0x98>
   12114:	00541c13          	sll	s8,s0,0x5
   12118:	168af863          	bgeu	s5,s0,12288 <__divsf3+0x2c0>
   1211c:	fffa0a13          	add	s4,s4,-1
   12120:	00000413          	li	s0,0
   12124:	010c5b13          	srl	s6,s8,0x10
   12128:	000109b7          	lui	s3,0x10
   1212c:	000b0593          	mv	a1,s6
   12130:	fe098993          	add	s3,s3,-32 # ffe0 <main-0xb4>
   12134:	000a8513          	mv	a0,s5
   12138:	704000ef          	jal	1283c <__hidden___udivsi3>
   1213c:	013c79b3          	and	s3,s8,s3
   12140:	00050593          	mv	a1,a0
   12144:	00050b93          	mv	s7,a0
   12148:	00098513          	mv	a0,s3
   1214c:	6c4000ef          	jal	12810 <__mulsi3>
   12150:	00050493          	mv	s1,a0
   12154:	000b0593          	mv	a1,s6
   12158:	000a8513          	mv	a0,s5
   1215c:	728000ef          	jal	12884 <__umodsi3>
   12160:	01045793          	srl	a5,s0,0x10
   12164:	01051513          	sll	a0,a0,0x10
   12168:	00a7e7b3          	or	a5,a5,a0
   1216c:	000b8413          	mv	s0,s7
   12170:	0097fe63          	bgeu	a5,s1,1218c <__divsf3+0x1c4>
   12174:	00fc07b3          	add	a5,s8,a5
   12178:	fffb8413          	add	s0,s7,-1
   1217c:	0187e863          	bltu	a5,s8,1218c <__divsf3+0x1c4>
   12180:	0097f663          	bgeu	a5,s1,1218c <__divsf3+0x1c4>
   12184:	ffeb8413          	add	s0,s7,-2
   12188:	018787b3          	add	a5,a5,s8
   1218c:	409784b3          	sub	s1,a5,s1
   12190:	000b0593          	mv	a1,s6
   12194:	00048513          	mv	a0,s1
   12198:	6a4000ef          	jal	1283c <__hidden___udivsi3>
   1219c:	00050593          	mv	a1,a0
   121a0:	00050a93          	mv	s5,a0
   121a4:	00098513          	mv	a0,s3
   121a8:	668000ef          	jal	12810 <__mulsi3>
   121ac:	00050993          	mv	s3,a0
   121b0:	000b0593          	mv	a1,s6
   121b4:	00048513          	mv	a0,s1
   121b8:	6cc000ef          	jal	12884 <__umodsi3>
   121bc:	01051793          	sll	a5,a0,0x10
   121c0:	000a8713          	mv	a4,s5
   121c4:	0337f263          	bgeu	a5,s3,121e8 <__divsf3+0x220>
   121c8:	018786b3          	add	a3,a5,s8
   121cc:	00f6b633          	sltu	a2,a3,a5
   121d0:	fffa8713          	add	a4,s5,-1
   121d4:	00068793          	mv	a5,a3
   121d8:	00061863          	bnez	a2,121e8 <__divsf3+0x220>
   121dc:	0136f663          	bgeu	a3,s3,121e8 <__divsf3+0x220>
   121e0:	ffea8713          	add	a4,s5,-2
   121e4:	018687b3          	add	a5,a3,s8
   121e8:	01041413          	sll	s0,s0,0x10
   121ec:	413787b3          	sub	a5,a5,s3
   121f0:	00e46433          	or	s0,s0,a4
   121f4:	00f037b3          	snez	a5,a5
   121f8:	00f46433          	or	s0,s0,a5
   121fc:	07fa0713          	add	a4,s4,127
   12200:	0ce05e63          	blez	a4,122dc <__divsf3+0x314>
   12204:	00747793          	and	a5,s0,7
   12208:	00078a63          	beqz	a5,1221c <__divsf3+0x254>
   1220c:	00f47793          	and	a5,s0,15
   12210:	00400693          	li	a3,4
   12214:	00d78463          	beq	a5,a3,1221c <__divsf3+0x254>
   12218:	00440413          	add	s0,s0,4
   1221c:	00441793          	sll	a5,s0,0x4
   12220:	0007da63          	bgez	a5,12234 <__divsf3+0x26c>
   12224:	f80007b7          	lui	a5,0xf8000
   12228:	fff78793          	add	a5,a5,-1 # f7ffffff <__BSS_END__+0xf7fe92d7>
   1222c:	00f47433          	and	s0,s0,a5
   12230:	080a0713          	add	a4,s4,128
   12234:	0fe00793          	li	a5,254
   12238:	08e7c063          	blt	a5,a4,122b8 <__divsf3+0x2f0>
   1223c:	00345793          	srl	a5,s0,0x3
   12240:	02c12083          	lw	ra,44(sp)
   12244:	02812403          	lw	s0,40(sp)
   12248:	00979793          	sll	a5,a5,0x9
   1224c:	01771713          	sll	a4,a4,0x17
   12250:	0097d793          	srl	a5,a5,0x9
   12254:	01f91513          	sll	a0,s2,0x1f
   12258:	00f76733          	or	a4,a4,a5
   1225c:	02412483          	lw	s1,36(sp)
   12260:	02012903          	lw	s2,32(sp)
   12264:	01c12983          	lw	s3,28(sp)
   12268:	01812a03          	lw	s4,24(sp)
   1226c:	01412a83          	lw	s5,20(sp)
   12270:	01012b03          	lw	s6,16(sp)
   12274:	00c12b83          	lw	s7,12(sp)
   12278:	00812c03          	lw	s8,8(sp)
   1227c:	00a76533          	or	a0,a4,a0
   12280:	03010113          	add	sp,sp,48
   12284:	00008067          	ret
   12288:	01fa9413          	sll	s0,s5,0x1f
   1228c:	001ada93          	srl	s5,s5,0x1
   12290:	e95ff06f          	j	12124 <__divsf3+0x15c>
   12294:	00098913          	mv	s2,s3
   12298:	000a8413          	mv	s0,s5
   1229c:	000b8713          	mv	a4,s7
   122a0:	00300793          	li	a5,3
   122a4:	08f70663          	beq	a4,a5,12330 <__divsf3+0x368>
   122a8:	00100793          	li	a5,1
   122ac:	08f70a63          	beq	a4,a5,12340 <__divsf3+0x378>
   122b0:	00200793          	li	a5,2
   122b4:	f4f714e3          	bne	a4,a5,121fc <__divsf3+0x234>
   122b8:	00000793          	li	a5,0
   122bc:	0ff00713          	li	a4,255
   122c0:	f81ff06f          	j	12240 <__divsf3+0x278>
   122c4:	000b0913          	mv	s2,s6
   122c8:	fd9ff06f          	j	122a0 <__divsf3+0x2d8>
   122cc:	00400437          	lui	s0,0x400
   122d0:	00000913          	li	s2,0
   122d4:	00300713          	li	a4,3
   122d8:	fc9ff06f          	j	122a0 <__divsf3+0x2d8>
   122dc:	00100793          	li	a5,1
   122e0:	40e787b3          	sub	a5,a5,a4
   122e4:	01b00713          	li	a4,27
   122e8:	04f74c63          	blt	a4,a5,12340 <__divsf3+0x378>
   122ec:	09ea0493          	add	s1,s4,158
   122f0:	00f457b3          	srl	a5,s0,a5
   122f4:	00941433          	sll	s0,s0,s1
   122f8:	00803433          	snez	s0,s0
   122fc:	0087e7b3          	or	a5,a5,s0
   12300:	0077f713          	and	a4,a5,7
   12304:	00070a63          	beqz	a4,12318 <__divsf3+0x350>
   12308:	00f7f713          	and	a4,a5,15
   1230c:	00400693          	li	a3,4
   12310:	00d70463          	beq	a4,a3,12318 <__divsf3+0x350>
   12314:	00478793          	add	a5,a5,4
   12318:	00579713          	sll	a4,a5,0x5
   1231c:	0037d793          	srl	a5,a5,0x3
   12320:	02075263          	bgez	a4,12344 <__divsf3+0x37c>
   12324:	00000793          	li	a5,0
   12328:	00100713          	li	a4,1
   1232c:	f15ff06f          	j	12240 <__divsf3+0x278>
   12330:	004007b7          	lui	a5,0x400
   12334:	0ff00713          	li	a4,255
   12338:	00000913          	li	s2,0
   1233c:	f05ff06f          	j	12240 <__divsf3+0x278>
   12340:	00000793          	li	a5,0
   12344:	00000713          	li	a4,0
   12348:	ef9ff06f          	j	12240 <__divsf3+0x278>

0001234c <__mulsf3>:
   1234c:	fe010113          	add	sp,sp,-32
   12350:	01212823          	sw	s2,16(sp)
   12354:	01755913          	srl	s2,a0,0x17
   12358:	00912a23          	sw	s1,20(sp)
   1235c:	01312623          	sw	s3,12(sp)
   12360:	01512223          	sw	s5,4(sp)
   12364:	00951493          	sll	s1,a0,0x9
   12368:	00112e23          	sw	ra,28(sp)
   1236c:	00812c23          	sw	s0,24(sp)
   12370:	01412423          	sw	s4,8(sp)
   12374:	0ff97913          	zext.b	s2,s2
   12378:	00058a93          	mv	s5,a1
   1237c:	0094d493          	srl	s1,s1,0x9
   12380:	01f55993          	srl	s3,a0,0x1f
   12384:	14090063          	beqz	s2,124c4 <__mulsf3+0x178>
   12388:	0ff00793          	li	a5,255
   1238c:	14f90c63          	beq	s2,a5,124e4 <__mulsf3+0x198>
   12390:	00349493          	sll	s1,s1,0x3
   12394:	040007b7          	lui	a5,0x4000
   12398:	00f4e4b3          	or	s1,s1,a5
   1239c:	f8190913          	add	s2,s2,-127
   123a0:	00000a13          	li	s4,0
   123a4:	017ad793          	srl	a5,s5,0x17
   123a8:	009a9413          	sll	s0,s5,0x9
   123ac:	0ff7f793          	zext.b	a5,a5
   123b0:	00945413          	srl	s0,s0,0x9
   123b4:	01fada93          	srl	s5,s5,0x1f
   123b8:	14078663          	beqz	a5,12504 <__mulsf3+0x1b8>
   123bc:	0ff00713          	li	a4,255
   123c0:	16e78263          	beq	a5,a4,12524 <__mulsf3+0x1d8>
   123c4:	00341413          	sll	s0,s0,0x3
   123c8:	04000737          	lui	a4,0x4000
   123cc:	00e46433          	or	s0,s0,a4
   123d0:	f8178793          	add	a5,a5,-127 # 3ffff81 <__BSS_END__+0x3fe9259>
   123d4:	00000713          	li	a4,0
   123d8:	00f90933          	add	s2,s2,a5
   123dc:	002a1793          	sll	a5,s4,0x2
   123e0:	00e7e7b3          	or	a5,a5,a4
   123e4:	00a00693          	li	a3,10
   123e8:	00190813          	add	a6,s2,1
   123ec:	20f6ca63          	blt	a3,a5,12600 <__mulsf3+0x2b4>
   123f0:	00200693          	li	a3,2
   123f4:	0159c9b3          	xor	s3,s3,s5
   123f8:	14f6c663          	blt	a3,a5,12544 <__mulsf3+0x1f8>
   123fc:	fff78793          	add	a5,a5,-1
   12400:	00100693          	li	a3,1
   12404:	16f6f263          	bgeu	a3,a5,12568 <__mulsf3+0x21c>
   12408:	00010eb7          	lui	t4,0x10
   1240c:	fffe8313          	add	t1,t4,-1 # ffff <main-0x95>
   12410:	0104df13          	srl	t5,s1,0x10
   12414:	01045793          	srl	a5,s0,0x10
   12418:	0064f4b3          	and	s1,s1,t1
   1241c:	00647433          	and	s0,s0,t1
   12420:	00048513          	mv	a0,s1
   12424:	00040593          	mv	a1,s0
   12428:	3e8000ef          	jal	12810 <__mulsi3>
   1242c:	00050893          	mv	a7,a0
   12430:	00078593          	mv	a1,a5
   12434:	00048513          	mv	a0,s1
   12438:	3d8000ef          	jal	12810 <__mulsi3>
   1243c:	00050713          	mv	a4,a0
   12440:	00040593          	mv	a1,s0
   12444:	000f0513          	mv	a0,t5
   12448:	3c8000ef          	jal	12810 <__mulsi3>
   1244c:	00050e13          	mv	t3,a0
   12450:	00078593          	mv	a1,a5
   12454:	000f0513          	mv	a0,t5
   12458:	3b8000ef          	jal	12810 <__mulsi3>
   1245c:	0108d793          	srl	a5,a7,0x10
   12460:	01c70733          	add	a4,a4,t3
   12464:	00e787b3          	add	a5,a5,a4
   12468:	00050693          	mv	a3,a0
   1246c:	01c7f463          	bgeu	a5,t3,12474 <__mulsf3+0x128>
   12470:	01d506b3          	add	a3,a0,t4
   12474:	0067f733          	and	a4,a5,t1
   12478:	01071713          	sll	a4,a4,0x10
   1247c:	0068f8b3          	and	a7,a7,t1
   12480:	01170733          	add	a4,a4,a7
   12484:	0107d793          	srl	a5,a5,0x10
   12488:	00671413          	sll	s0,a4,0x6
   1248c:	00d787b3          	add	a5,a5,a3
   12490:	01a75713          	srl	a4,a4,0x1a
   12494:	00679793          	sll	a5,a5,0x6
   12498:	00803433          	snez	s0,s0
   1249c:	00e46433          	or	s0,s0,a4
   124a0:	00479713          	sll	a4,a5,0x4
   124a4:	0087e433          	or	s0,a5,s0
   124a8:	00075a63          	bgez	a4,124bc <__mulsf3+0x170>
   124ac:	00145793          	srl	a5,s0,0x1
   124b0:	00147413          	and	s0,s0,1
   124b4:	0087e433          	or	s0,a5,s0
   124b8:	00080913          	mv	s2,a6
   124bc:	00090813          	mv	a6,s2
   124c0:	0c00006f          	j	12580 <__mulsf3+0x234>
   124c4:	02048a63          	beqz	s1,124f8 <__mulsf3+0x1ac>
   124c8:	00048513          	mv	a0,s1
   124cc:	41c000ef          	jal	128e8 <__clzsi2>
   124d0:	ffb50793          	add	a5,a0,-5
   124d4:	f8a00913          	li	s2,-118
   124d8:	00f494b3          	sll	s1,s1,a5
   124dc:	40a90933          	sub	s2,s2,a0
   124e0:	ec1ff06f          	j	123a0 <__mulsf3+0x54>
   124e4:	0ff00913          	li	s2,255
   124e8:	00200a13          	li	s4,2
   124ec:	ea048ce3          	beqz	s1,123a4 <__mulsf3+0x58>
   124f0:	00300a13          	li	s4,3
   124f4:	eb1ff06f          	j	123a4 <__mulsf3+0x58>
   124f8:	00000913          	li	s2,0
   124fc:	00100a13          	li	s4,1
   12500:	ea5ff06f          	j	123a4 <__mulsf3+0x58>
   12504:	02040a63          	beqz	s0,12538 <__mulsf3+0x1ec>
   12508:	00040513          	mv	a0,s0
   1250c:	3dc000ef          	jal	128e8 <__clzsi2>
   12510:	ffb50793          	add	a5,a0,-5
   12514:	00f41433          	sll	s0,s0,a5
   12518:	f8a00793          	li	a5,-118
   1251c:	40a787b3          	sub	a5,a5,a0
   12520:	eb5ff06f          	j	123d4 <__mulsf3+0x88>
   12524:	0ff00793          	li	a5,255
   12528:	00200713          	li	a4,2
   1252c:	ea0406e3          	beqz	s0,123d8 <__mulsf3+0x8c>
   12530:	00300713          	li	a4,3
   12534:	ea5ff06f          	j	123d8 <__mulsf3+0x8c>
   12538:	00000793          	li	a5,0
   1253c:	00100713          	li	a4,1
   12540:	e99ff06f          	j	123d8 <__mulsf3+0x8c>
   12544:	00100693          	li	a3,1
   12548:	00f697b3          	sll	a5,a3,a5
   1254c:	5307f693          	and	a3,a5,1328
   12550:	0c069063          	bnez	a3,12610 <__mulsf3+0x2c4>
   12554:	2407f693          	and	a3,a5,576
   12558:	12069263          	bnez	a3,1267c <__mulsf3+0x330>
   1255c:	0887f793          	and	a5,a5,136
   12560:	ea0784e3          	beqz	a5,12408 <__mulsf3+0xbc>
   12564:	000a8993          	mv	s3,s5
   12568:	00200793          	li	a5,2
   1256c:	10f70263          	beq	a4,a5,12670 <__mulsf3+0x324>
   12570:	00300793          	li	a5,3
   12574:	10f70463          	beq	a4,a5,1267c <__mulsf3+0x330>
   12578:	00100793          	li	a5,1
   1257c:	10f70863          	beq	a4,a5,1268c <__mulsf3+0x340>
   12580:	07f80713          	add	a4,a6,127
   12584:	08e05c63          	blez	a4,1261c <__mulsf3+0x2d0>
   12588:	00747793          	and	a5,s0,7
   1258c:	00078a63          	beqz	a5,125a0 <__mulsf3+0x254>
   12590:	00f47793          	and	a5,s0,15
   12594:	00400693          	li	a3,4
   12598:	00d78463          	beq	a5,a3,125a0 <__mulsf3+0x254>
   1259c:	00440413          	add	s0,s0,4 # 400004 <__BSS_END__+0x3e92dc>
   125a0:	00441793          	sll	a5,s0,0x4
   125a4:	0007da63          	bgez	a5,125b8 <__mulsf3+0x26c>
   125a8:	f80007b7          	lui	a5,0xf8000
   125ac:	fff78793          	add	a5,a5,-1 # f7ffffff <__BSS_END__+0xf7fe92d7>
   125b0:	00f47433          	and	s0,s0,a5
   125b4:	08080713          	add	a4,a6,128
   125b8:	0fe00793          	li	a5,254
   125bc:	0ae7ca63          	blt	a5,a4,12670 <__mulsf3+0x324>
   125c0:	00345793          	srl	a5,s0,0x3
   125c4:	01c12083          	lw	ra,28(sp)
   125c8:	01812403          	lw	s0,24(sp)
   125cc:	00979793          	sll	a5,a5,0x9
   125d0:	01771513          	sll	a0,a4,0x17
   125d4:	0097d793          	srl	a5,a5,0x9
   125d8:	01f99993          	sll	s3,s3,0x1f
   125dc:	00f56533          	or	a0,a0,a5
   125e0:	01412483          	lw	s1,20(sp)
   125e4:	01012903          	lw	s2,16(sp)
   125e8:	00812a03          	lw	s4,8(sp)
   125ec:	00412a83          	lw	s5,4(sp)
   125f0:	01356533          	or	a0,a0,s3
   125f4:	00c12983          	lw	s3,12(sp)
   125f8:	02010113          	add	sp,sp,32
   125fc:	00008067          	ret
   12600:	00f00693          	li	a3,15
   12604:	06d78c63          	beq	a5,a3,1267c <__mulsf3+0x330>
   12608:	00b00693          	li	a3,11
   1260c:	f4d78ce3          	beq	a5,a3,12564 <__mulsf3+0x218>
   12610:	00048413          	mv	s0,s1
   12614:	000a0713          	mv	a4,s4
   12618:	f51ff06f          	j	12568 <__mulsf3+0x21c>
   1261c:	00100793          	li	a5,1
   12620:	40e787b3          	sub	a5,a5,a4
   12624:	01b00713          	li	a4,27
   12628:	06f74263          	blt	a4,a5,1268c <__mulsf3+0x340>
   1262c:	09e80813          	add	a6,a6,158
   12630:	01041833          	sll	a6,s0,a6
   12634:	00f457b3          	srl	a5,s0,a5
   12638:	01003833          	snez	a6,a6
   1263c:	0107e7b3          	or	a5,a5,a6
   12640:	0077f713          	and	a4,a5,7
   12644:	00070a63          	beqz	a4,12658 <__mulsf3+0x30c>
   12648:	00f7f713          	and	a4,a5,15
   1264c:	00400693          	li	a3,4
   12650:	00d70463          	beq	a4,a3,12658 <__mulsf3+0x30c>
   12654:	00478793          	add	a5,a5,4
   12658:	00579713          	sll	a4,a5,0x5
   1265c:	0037d793          	srl	a5,a5,0x3
   12660:	02075863          	bgez	a4,12690 <__mulsf3+0x344>
   12664:	00000793          	li	a5,0
   12668:	00100713          	li	a4,1
   1266c:	f59ff06f          	j	125c4 <__mulsf3+0x278>
   12670:	00000793          	li	a5,0
   12674:	0ff00713          	li	a4,255
   12678:	f4dff06f          	j	125c4 <__mulsf3+0x278>
   1267c:	004007b7          	lui	a5,0x400
   12680:	0ff00713          	li	a4,255
   12684:	00000993          	li	s3,0
   12688:	f3dff06f          	j	125c4 <__mulsf3+0x278>
   1268c:	00000793          	li	a5,0
   12690:	00000713          	li	a4,0
   12694:	f31ff06f          	j	125c4 <__mulsf3+0x278>

00012698 <__fixsfsi>:
   12698:	00800637          	lui	a2,0x800
   1269c:	01755713          	srl	a4,a0,0x17
   126a0:	fff60793          	add	a5,a2,-1 # 7fffff <__BSS_END__+0x7e92d7>
   126a4:	0ff77713          	zext.b	a4,a4
   126a8:	07e00593          	li	a1,126
   126ac:	00a7f7b3          	and	a5,a5,a0
   126b0:	01f55693          	srl	a3,a0,0x1f
   126b4:	04e5d663          	bge	a1,a4,12700 <__fixsfsi+0x68>
   126b8:	09d00593          	li	a1,157
   126bc:	00e5da63          	bge	a1,a4,126d0 <__fixsfsi+0x38>
   126c0:	80000537          	lui	a0,0x80000
   126c4:	fff50513          	add	a0,a0,-1 # 7fffffff <__BSS_END__+0x7ffe92d7>
   126c8:	00a68533          	add	a0,a3,a0
   126cc:	00008067          	ret
   126d0:	00c7e533          	or	a0,a5,a2
   126d4:	09500793          	li	a5,149
   126d8:	00e7dc63          	bge	a5,a4,126f0 <__fixsfsi+0x58>
   126dc:	f6a70713          	add	a4,a4,-150 # 3ffff6a <__BSS_END__+0x3fe9242>
   126e0:	00e51533          	sll	a0,a0,a4
   126e4:	02068063          	beqz	a3,12704 <__fixsfsi+0x6c>
   126e8:	40a00533          	neg	a0,a0
   126ec:	00008067          	ret
   126f0:	09600793          	li	a5,150
   126f4:	40e787b3          	sub	a5,a5,a4
   126f8:	00f55533          	srl	a0,a0,a5
   126fc:	fe9ff06f          	j	126e4 <__fixsfsi+0x4c>
   12700:	00000513          	li	a0,0
   12704:	00008067          	ret

00012708 <__floatsisf>:
   12708:	ff010113          	add	sp,sp,-16
   1270c:	00112623          	sw	ra,12(sp)
   12710:	00812423          	sw	s0,8(sp)
   12714:	00912223          	sw	s1,4(sp)
   12718:	00050793          	mv	a5,a0
   1271c:	0e050063          	beqz	a0,127fc <__floatsisf+0xf4>
   12720:	41f55713          	sra	a4,a0,0x1f
   12724:	00a74433          	xor	s0,a4,a0
   12728:	40e40433          	sub	s0,s0,a4
   1272c:	01f55493          	srl	s1,a0,0x1f
   12730:	00040513          	mv	a0,s0
   12734:	1b4000ef          	jal	128e8 <__clzsi2>
   12738:	09e00793          	li	a5,158
   1273c:	40a787b3          	sub	a5,a5,a0
   12740:	09600713          	li	a4,150
   12744:	04f74063          	blt	a4,a5,12784 <__floatsisf+0x7c>
   12748:	00800713          	li	a4,8
   1274c:	0ae50e63          	beq	a0,a4,12808 <__floatsisf+0x100>
   12750:	ff850513          	add	a0,a0,-8
   12754:	00a41433          	sll	s0,s0,a0
   12758:	00941413          	sll	s0,s0,0x9
   1275c:	00945413          	srl	s0,s0,0x9
   12760:	01779793          	sll	a5,a5,0x17
   12764:	00c12083          	lw	ra,12(sp)
   12768:	0087e7b3          	or	a5,a5,s0
   1276c:	00812403          	lw	s0,8(sp)
   12770:	01f49513          	sll	a0,s1,0x1f
   12774:	00a7e533          	or	a0,a5,a0
   12778:	00412483          	lw	s1,4(sp)
   1277c:	01010113          	add	sp,sp,16
   12780:	00008067          	ret
   12784:	09900713          	li	a4,153
   12788:	06f75463          	bge	a4,a5,127f0 <__floatsisf+0xe8>
   1278c:	00500713          	li	a4,5
   12790:	40a70733          	sub	a4,a4,a0
   12794:	01b50693          	add	a3,a0,27
   12798:	00e45733          	srl	a4,s0,a4
   1279c:	00d41433          	sll	s0,s0,a3
   127a0:	00803433          	snez	s0,s0
   127a4:	00876733          	or	a4,a4,s0
   127a8:	fc000437          	lui	s0,0xfc000
   127ac:	fff40413          	add	s0,s0,-1 # fbffffff <__BSS_END__+0xfbfe92d7>
   127b0:	00777693          	and	a3,a4,7
   127b4:	00877433          	and	s0,a4,s0
   127b8:	00068a63          	beqz	a3,127cc <__floatsisf+0xc4>
   127bc:	00f77713          	and	a4,a4,15
   127c0:	00400693          	li	a3,4
   127c4:	00d70463          	beq	a4,a3,127cc <__floatsisf+0xc4>
   127c8:	00440413          	add	s0,s0,4
   127cc:	00541713          	sll	a4,s0,0x5
   127d0:	00075c63          	bgez	a4,127e8 <__floatsisf+0xe0>
   127d4:	fc0007b7          	lui	a5,0xfc000
   127d8:	fff78793          	add	a5,a5,-1 # fbffffff <__BSS_END__+0xfbfe92d7>
   127dc:	00f47433          	and	s0,s0,a5
   127e0:	09f00793          	li	a5,159
   127e4:	40a787b3          	sub	a5,a5,a0
   127e8:	00345413          	srl	s0,s0,0x3
   127ec:	f6dff06f          	j	12758 <__floatsisf+0x50>
   127f0:	ffb50713          	add	a4,a0,-5
   127f4:	00e41733          	sll	a4,s0,a4
   127f8:	fb1ff06f          	j	127a8 <__floatsisf+0xa0>
   127fc:	00000493          	li	s1,0
   12800:	00000413          	li	s0,0
   12804:	f55ff06f          	j	12758 <__floatsisf+0x50>
   12808:	09600793          	li	a5,150
   1280c:	f4dff06f          	j	12758 <__floatsisf+0x50>

00012810 <__mulsi3>:
   12810:	00050613          	mv	a2,a0
   12814:	00000513          	li	a0,0
   12818:	0015f693          	and	a3,a1,1
   1281c:	00068463          	beqz	a3,12824 <__mulsi3+0x14>
   12820:	00c50533          	add	a0,a0,a2
   12824:	0015d593          	srl	a1,a1,0x1
   12828:	00161613          	sll	a2,a2,0x1
   1282c:	fe0596e3          	bnez	a1,12818 <__mulsi3+0x8>
   12830:	00008067          	ret

00012834 <__divsi3>:
   12834:	06054063          	bltz	a0,12894 <__umodsi3+0x10>
   12838:	0605c663          	bltz	a1,128a4 <__umodsi3+0x20>

0001283c <__hidden___udivsi3>:
   1283c:	00058613          	mv	a2,a1
   12840:	00050593          	mv	a1,a0
   12844:	fff00513          	li	a0,-1
   12848:	02060c63          	beqz	a2,12880 <__hidden___udivsi3+0x44>
   1284c:	00100693          	li	a3,1
   12850:	00b67a63          	bgeu	a2,a1,12864 <__hidden___udivsi3+0x28>
   12854:	00c05863          	blez	a2,12864 <__hidden___udivsi3+0x28>
   12858:	00161613          	sll	a2,a2,0x1
   1285c:	00169693          	sll	a3,a3,0x1
   12860:	feb66ae3          	bltu	a2,a1,12854 <__hidden___udivsi3+0x18>
   12864:	00000513          	li	a0,0
   12868:	00c5e663          	bltu	a1,a2,12874 <__hidden___udivsi3+0x38>
   1286c:	40c585b3          	sub	a1,a1,a2
   12870:	00d56533          	or	a0,a0,a3
   12874:	0016d693          	srl	a3,a3,0x1
   12878:	00165613          	srl	a2,a2,0x1
   1287c:	fe0696e3          	bnez	a3,12868 <__hidden___udivsi3+0x2c>
   12880:	00008067          	ret

00012884 <__umodsi3>:
   12884:	00008293          	mv	t0,ra
   12888:	fb5ff0ef          	jal	1283c <__hidden___udivsi3>
   1288c:	00058513          	mv	a0,a1
   12890:	00028067          	jr	t0
   12894:	40a00533          	neg	a0,a0
   12898:	00b04863          	bgtz	a1,128a8 <__umodsi3+0x24>
   1289c:	40b005b3          	neg	a1,a1
   128a0:	f9dff06f          	j	1283c <__hidden___udivsi3>
   128a4:	40b005b3          	neg	a1,a1
   128a8:	00008293          	mv	t0,ra
   128ac:	f91ff0ef          	jal	1283c <__hidden___udivsi3>
   128b0:	40a00533          	neg	a0,a0
   128b4:	00028067          	jr	t0

000128b8 <__modsi3>:
   128b8:	00008293          	mv	t0,ra
   128bc:	0005ca63          	bltz	a1,128d0 <__modsi3+0x18>
   128c0:	00054c63          	bltz	a0,128d8 <__modsi3+0x20>
   128c4:	f79ff0ef          	jal	1283c <__hidden___udivsi3>
   128c8:	00058513          	mv	a0,a1
   128cc:	00028067          	jr	t0
   128d0:	40b005b3          	neg	a1,a1
   128d4:	fe0558e3          	bgez	a0,128c4 <__modsi3+0xc>
   128d8:	40a00533          	neg	a0,a0
   128dc:	f61ff0ef          	jal	1283c <__hidden___udivsi3>
   128e0:	40b00533          	neg	a0,a1
   128e4:	00028067          	jr	t0

000128e8 <__clzsi2>:
   128e8:	000107b7          	lui	a5,0x10
   128ec:	02f57a63          	bgeu	a0,a5,12920 <__clzsi2+0x38>
   128f0:	10053793          	sltiu	a5,a0,256
   128f4:	0017b793          	seqz	a5,a5
   128f8:	00379793          	sll	a5,a5,0x3
   128fc:	00013737          	lui	a4,0x13
   12900:	02000693          	li	a3,32
   12904:	40f686b3          	sub	a3,a3,a5
   12908:	00f55533          	srl	a0,a0,a5
   1290c:	fc070793          	add	a5,a4,-64 # 12fc0 <__clz_tab>
   12910:	00a787b3          	add	a5,a5,a0
   12914:	0007c503          	lbu	a0,0(a5) # 10000 <main-0x94>
   12918:	40a68533          	sub	a0,a3,a0
   1291c:	00008067          	ret
   12920:	01000737          	lui	a4,0x1000
   12924:	01800793          	li	a5,24
   12928:	fce57ae3          	bgeu	a0,a4,128fc <__clzsi2+0x14>
   1292c:	01000793          	li	a5,16
   12930:	fcdff06f          	j	128fc <__clzsi2+0x14>

Disassembly of section .start:

00012934 <_start>:
   12934:	00018193          	mv	gp,gp
   12938:	f5cfd0ef          	jal	10094 <main>
   1293c:	05d00893          	li	a7,93
   12940:	00000073          	ecall
