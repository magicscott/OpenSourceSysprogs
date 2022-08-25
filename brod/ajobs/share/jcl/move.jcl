//BRODSCO  JOB (000),'SCOTT BROD',CLASS=A,MSGCLASS=D,                   00010000
//     MSGLEVEL=(1,1),NOTIFY=BROD,REGION=0M                             00011000
//*                                                                     00012000
//STEP1    EXEC  PGM=ADRDSSU                                            00020000
//SYSPRINT DD    SYSOUT=A                                               00030000
//DASD1    DD    UNIT=SYSDA,VOL=(PRIVATE,SER=STG100),DISP=OLD           00040000
//DASD2    DD    UNIT=SYSDA,VOL=(PRIVATE,SER=ZMSHR1),DISP=OLD           00050000
//SYSIN    DD    *                                                      00060000
 COPY DATASET(INCLUDE(ZDNT.ZOWE.V122.**) BY(MULTI,=,NO)) -              00070004
      LOGINDDNAME(DASD1) OUTDDNAME(DASD2) DELETE CATALOG                00080001
/*                                                                      00090000
//                                                                      00091001
 COPY DATASET(INCLUDE(ZDNT.ZOWE.V1.**)) -                               00100001
      LOGINDDNAME(DASD1) OUTDDNAME(DASD2) DELETE CATALOG                00110001
/*                                                                      00120001
