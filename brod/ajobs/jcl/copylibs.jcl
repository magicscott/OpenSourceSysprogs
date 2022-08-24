//BRODSCO  JOB (000),'SCOTT BROD',CLASS=A,MSGCLASS=D,                   00010000
//     MSGLEVEL=(1,1),NOTIFY=&SYSUID                                    00020000
//*.+....1....+....2....+....3....+....4....+....5....+....6....+....7..00030000
//*                                                                     00040000
//STEP1    EXEC  PGM=IEBCOPY                                            00041000
//SYSPRINT DD  SYSOUT=A                                                 00042000
//SYSUT1   DD  DSNAME=ZDNT.NDVR.R181.CSIQLOAD,UNIT=3390,                00043002
//             DISP=SHR                                                 00044000
//SYSUT2   DD  DSNAME=SYS3.NDVR.R181.CSIQLOAD,                          00045002
//             DISP=(NEW,CATLG),LIKE=ZDNT.NDVR.R181.CSIQLOAD            00046002
//                                                                      00046102
//STEP2    EXEC  PGM=IEBCOPY                                            00046201
//SYSPRINT DD  SYSOUT=A                                                 00046301
//SYSUT1   DD  DSNAME=ZDNT.NDVR.R181.CSIQAUTU,UNIT=3390,                00046401
//             DISP=SHR                                                 00046501
//SYSUT2   DD  DSNAME=SYS3.NDVR.R181.CSIQAUTU,                          00046601
//             DISP=(NEW,CATLG),LIKE=ZDNT.NDVR.R181.CSIQAUTU            00046701
//                                                                      00047001
//STEP3    EXEC  PGM=IEBCOPY                                            00048000
//SYSPRINT DD  SYSOUT=A                                                 00049000
//SYSUT1   DD  DSNAME=ZPDT.SHARED.CDBIMAC,UNIT=3390,                    00049100
//             DISP=SHR                                                 00049200
//SYSUT2   DD  DSNAME=ZPDT.SHARED.CAI.FMP.CDBIMAC,                      00049300
//             DISP=(NEW,CATLG),LIKE=ZPDT.SHARED.CDBIMAC                00049400
//*                                                                     00049500
//STEP4    EXEC  PGM=IEBCOPY                                            00049600
//SYSPRINT DD  SYSOUT=A                                                 00049700
//SYSUT1   DD  DSNAME=ZPDT.SHARED.CDBIMSG0,UNIT=3390,                   00049800
//             DISP=SHR                                                 00049900
//SYSUT2   DD  DSNAME=ZPDT.SHARED.CAI.FMP.CDBIMSG0,                     00050000
//             DISP=(NEW,CATLG),LIKE=ZPDT.SHARED.CDBIMSG0               00050100
//*                                                                     00050200
//STEP5    EXEC  PGM=IEBCOPY                                            00050300
//SYSPRINT DD  SYSOUT=A                                                 00050400
//SYSUT1   DD  DSNAME=ZPDT.SHARED.CDBIPNL0,UNIT=3390,                   00050500
//             DISP=SHR                                                 00050600
//SYSUT2   DD  DSNAME=ZPDT.SHARED.CAI.FMP.CDBIPNL0,                     00050700
//             DISP=(NEW,CATLG),LIKE=ZPDT.SHARED.CDBIPNL0               00050800
//*                                                                     00050900
//STEP6    EXEC  PGM=IEBCOPY                                            00051000
//SYSPRINT DD  SYSOUT=A                                                 00051100
//SYSUT1   DD  DSNAME=ZPDT.SHARED.CDBISAMP,UNIT=3390,                   00051200
//             DISP=SHR                                                 00051300
//SYSUT2   DD  DSNAME=ZPDT.SHARED.CAI.FMP.CDBISAMP,                     00051400
//             DISP=(NEW,CATLG),LIKE=ZPDT.SHARED.CDBISAMP               00051500
//*                                                                     00051600
//STEP7    EXEC  PGM=IEBCOPY                                            00051700
//SYSPRINT DD  SYSOUT=A                                                 00051800
//SYSUT1   DD  DSNAME=ZPDT.SHARED.CDBISKL0,UNIT=3390,                   00051900
//             DISP=SHR                                                 00052000
//SYSUT2   DD  DSNAME=ZPDT.SHARED.CAI.FMP.CDBISKL0,                     00052100
//             DISP=(NEW,CATLG),LIKE=ZPDT.SHARED.CDBISKL0               00052200
//*                                                                     00052300
//STEP8    EXEC  PGM=IEBCOPY                                            00052400
//SYSPRINT DD  SYSOUT=A                                                 00052500
//SYSUT1   DD  DSNAME=ZPDT.SHARED.CDBISRC,UNIT=3390,                    00052600
//             DISP=SHR                                                 00052700
//SYSUT2   DD  DSNAME=ZPDT.SHARED.CAI.FMP.CDBISRC,                      00052800
//             DISP=(NEW,CATLG),LIKE=ZPDT.SHARED.CDBISRC                00052900
//*                                                                     00053000
//STEP9    EXEC  PGM=IEBCOPY                                            00053100
//SYSPRINT DD  SYSOUT=A                                                 00053200
//SYSUT1   DD  DSNAME=ZPDT.SHARED.CDBITBL0,UNIT=3390,                   00053300
//             DISP=SHR                                                 00053400
//SYSUT2   DD  DSNAME=ZPDT.SHARED.CAI.FMP.CDBITBL0,                     00053500
//             DISP=(NEW,CATLG),LIKE=ZPDT.SHARED.CDBITBL0               00053600
//*                                                                     00053700
