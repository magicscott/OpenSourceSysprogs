//BRODSCO  JOB (000),'SCOTT BROD',CLASS=A,MSGCLASS=D,                   00001000
//     MSGLEVEL=(1,1),NOTIFY=&SYSUID                                    00002000
//*.+....1....+....2....+....3....+....4....+....5....+....6....+....7..00003000
//FTPSTEP  EXEC PGM=FTP,REGION=2M,PARM='10.74.241.237'                  00020000
//SYSPRINT DD SYSOUT=H                                                  00030000
//OUTPUT    DD SYSOUT=H                                                 00040000
//INPUT     DD *                                                        00050000
scott                                                                   00060002
dir                                                                     00070000
BINARY                                                                  00090000
GET 18388209.zip '/tmp/18388209.zip'                                    00110002
quit                                                                    00120000
/*                                                                      00130000
//                                                                      00131000
//DETERSE EXEC PGM=TRSMAIN,PARM=UNPACK,TIME=1440                        00140000
//STEPLIB DD DSN=PTFLCG.TERSE409.LOADLIB,DISP=SHR                       00150000
//SYSPRINT DD SYSOUT=H                                                  00160000
//INFILE   DD DISP=SHR,DSN=H44IPCS.PMR75525.B7TD.C000.DUMP.TRS          00170000
//OUTFILE DD DSN=H44IPCS.PMR75525.B7TD.C000.DUMP1,                      00180000
//      SPACE=(CYL,(100,200),RLSE),UNIT=(3390,15),DISP=(NEW,CATLG)      00190000
