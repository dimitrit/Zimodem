!--------------------------------------------------
!- Saturday, July 08, 2017 9:16:56 PM
!- Import of : 
!- c:\src\zimodem\cbm8bit\src\telnetd64.prg
!- Commodore 64
!--------------------------------------------------
1 REM TELNETD64  1200B 2.7+
2 REM UPDATED 07/07/2017 03:39P
5 POKE254,8:IFPEEK(186)>7THENPOKE254,PEEK(186)
6 IFPEEK(49153)<>43THENLOAD"rds64.bin",PEEK(254),1:RUN
8 POKE53280,14:POKE53281,6
10 PRINTCHR$(14);"telnetd64 v1.0":PRINT"Requires 64Net WiFi firmware 2.7+"
20 PRINT"1200 baud version"
30 PRINT"By Bo Zimmerman (bo@zimmers.net)":PRINT:PRINT
1000 PRINT"Configure Server:":PRINT
1010 INPUT"Time Limit: hrs, mins  0, 55{left*7}";H,M
1020 X=H:GOSUB5000:H=X
1030 X=M:GOSUB5000:M=X
1040 POKE49152+22,H:POKE49152+23,M
1050 INPUT"Idle Time/Mins  4{left*3}";X
1060 GOSUB5000:POKE49152+21,X
1070 INPUT"Security (0/1=on)  1{left*3}";I
1080 POKE49152+24,I
1100 INPUT"Listen Port  6400{left*6}";P
1110 IFP<0ORP>65535THEN1100
1120 GOSUB4100:P$=MID$(STR$(P),2)
1130 FORI=1TOLEN(P$):POKEA+I-1,ASC(MID$(P$,I,1)):NEXTI
1140 A=A+LEN(P$):POKEA,13:POKEA+1,0
1200 I$="":GOSUB4000:A=A+2:OA=A
1210 IFPEEK(A)<>13THENI$=I$+CHR$(PEEK(A)):A=A+1:GOTO1210
1220 PR$="Modem init  "+I$:FORI=1TOLEN(I$)+2:PR$=PR$+"{left}":NEXTI
1230 PRINTPR$;:INPUTI$
1240 IFLEN(I$)>28THEN1220
1250 FORI=1TOLEN(I$):POKEOA+I-1,ASC(MID$(I$,I,1)):NEXTI
1260 OA=OA+LEN(I$):POKEOA,13:POKEOA+1,0
2000 IF(PEEK(56577)AND16)=0THEN3000
2010 PRINT"Carrier detected."
2020 PRINT"Reset modem, wait 30 seconds,"
2030 PRINT"then hit enter:"
2040 GETA$:IFA$<>CHR$(13)THEN2040
2050 GOTO 2000
3000 PRINT:PRINT"Starting server:"
3010 SYS49152
3020 IF(PEEK(53280)AND15)<>14THENPRINT"ERROR! See manual.":STOP
3030 PRINT"Set router to redirect":PRINT"to the above address and port."
3040 PRINT"Server is awaiting connection..."
3050 NEW
4000 I=49152
4010 IF(CHR$(PEEK(I))+CHR$(PEEK(I+1)))="at"THEN4030
4020 I=I+1:IFI<49152+256THEN4010
4030 A=I:RETURN
4100 GOSUB4000
4130 I=A+1
4140 IF(CHR$(PEEK(I))+CHR$(PEEK(I+1)))="at"THEN4160
4150 I=I+1:IFI<49152+256THEN4140
4160 I=I+1
4170 IFCHR$(PEEK(I))="a"THEN4190
4180 I=I+1:IFI<49152+256THEN4170
4190 I=I+1:A=I
4199 RETURN
5000 X0=INT(X/10):X=X-(10*X0):X=(X0*16)+X:RETURN
55555 F$="telnetd64":OPEN1,8,15,"s0:"+F$:CLOSE1:SAVEF$,8:VERIFYF$,8
