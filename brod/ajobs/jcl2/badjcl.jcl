//TESTEXIT JOB ACCOUNT,'CA',                                            00010000
//         PRTY=12                                                      00020000
//*                                                                     00030000
//*        JOB STMT WITHOUT JOB CLASS, WITH PRIORITY                    00040000
//*    scott was here                                                   00050000
//*   Copyright (C) 2007 CA. All rights reserved.                       00050100
//*                                                                     00050200
//DUMMY  PROC                                                            0006000
//*                                                                    00070000
//*      INSTREAM PROCEDURE WITH BAD STEP NUMBER                        00080000
//*                                                                     00090000
//PSTP0001  EXEC  PGM=INVALID                                           00100000
//SYSPRINT  DD  SYSOUT=A                                                00110000
//SYSIN     DD  DUMMY                                                   00120000
//       PEND                                                           00130000
//*                                                                     00140000
//*      EXECUTE INSTREAM PROC WITH GOOD STEP NUMBER HERE, BUT          00150000
//*      PROGRAM "INVALID" WILL NOT BE FOUND                            00160000
//*                                                                     00170000
//JSTP0001  EXEC  DUMMY                                                 00180000
//*                                                                     00190000
//*      EXEC STMT WITH ILLEGAL STEP NAME, INVOKES PROC                 00200000
//*      ALSO WITH ILLEGAL STEP NAME.                                   00210000
//*                                                                     00220000
//*      ALSO ASK FOR A NON-EXISTING DATASET                            00230000
//*                                                                     00240000
//SA     EXEC  ASMFC,MAC1='BAD.DATASET.NAME'                            00250000
//*                                                                     00260000
//ASM.SYSIN  DD  DSN=SYS1.PROCLIB(MISSING),DISP=SHR                     00270000
//*                                                                     00280000
//*      CALL FOR MEMBER OF PDS THAT DOESN'T EXIST                      00290000
//*                                                                     00300000
//JSTP0010 EXEC  PGM=SORT                                               00310000
//*                                                                     00320000
//*      EXECUTE "SORT" WITH A GOOD STEP NAME.                          00330000
//*                                                                     00340000
//*      CREATE A "TEMP" DATASET, WITH NO DCB BLKSIZE, BUT              00350000
//*      ITS SORT.SORTOUT SO JCL087 WILL BE BYPASSED                    00360000
//*                                                                     00370000
//SORTOUT  DD  DSN=THIS.IS.TEMP.DATASET,DISP=(,CATLG),UNIT=SYSDA,       00380000
//         SPACE=(4000,(100,50),RLSE)                                   00390000
//*                                                                     00400000
//*      CREATE A "PERM" DATASET WITHOUT BLKSIZE AND GET JCL087,        00410000
//*      NOT DISP OF CATLG SO GET JCL706                                00420000
//*                                                                     00430000
//OTHEROUT DD  DSN=THIS.IS.PERM.DATASET,DISP=(,KEEP),UNIT=SYSDA,        00440000
//         SPACE=(4000,(100,50),RLSE)                                   00450000
//JSTP0005 EXEC  PGM=IEBGENER                                           00460000
//*                                                                     00470000
//*      EXECUTE STEP WITH STEP NUMBER LESS THAN PREVIOUS STEP          00480000
//*      ALSO REQUIRED DD "SYSIN" IS MISSING                            00490000
//*                                                                     00500000
//SYSPRINT DD  SYSOUT=A                                                 00510000
//SYSUT1   DD  DSN=THIS.IS.TEMP.DATASET,DISP=(OLD,KEEP)                 00520000
//*                                                                     00530000
//*      LAST USE OF TEMP DATASET, BUT DOESN'T DELETE IT                00540000
//*                                                                     00550000
//SYSUT2   DD  SYSOUT=A                                                 00560000
