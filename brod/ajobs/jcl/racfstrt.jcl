//BRODSCO  JOB (000),'SCOTT BROD',CLASS=A,MSGCLASS=D,                   00010000
//     MSGLEVEL=(1,1),NOTIFY=&SYSUID                                    00020000
//*.+....1....+....2....+....3....+....4....+....5....+....6....+....7..00030000
//STEPNAME EXEC PGM=ICHDSM00                                            00040000
//SYSPRINT DD   SYSOUT=A                                                00050000
//SYSUT2   DD   SYSOUT=A                                                00060000
//SYSIN    DD *                                                         00070000
LINECOUNT 55                                                            00080000
FUNCTION RACSPT                                                         00090000
