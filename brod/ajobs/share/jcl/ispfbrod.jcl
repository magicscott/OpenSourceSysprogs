PROC 0 VOL(STG100)                                                      00010000
CONTROL NOMSG NOFLUSH                                                   00020013
PROFILE NOMODE MSGID PROMPT INTERCOM WTPMSG                             00030003
/*                                                      */              00040000
/*    ALLOCATION CLIST FOR ISPF PROFILE DATA SET        */              00050000
/*                                                      */              00060000
FREE FILE(ISPPROF ISPTABL)                                              00070000
/*                                                      */              00080000
FREE FILE(ISPCTL0,ISPCTL1,ISPCTL2,ISPVIO)                               00090000
ATTRIB ISPVIO LRECL(80) BLKSIZE(800) RECFM(F B)                         00100000
SET &DSNAME = &SYSUID..&SYSSYMDEF(ZSYS).ISPF.ISPPROF                    00110000
ALLOC FI(ISPCTL0) SP(1 1) CYL UNIT(SYSDA) USING(ISPVIO)                 00120000
ALLOC FI(ISPCTL1) SP(1 1) CYL UNIT(SYSDA) USING(ISPVIO)                 00130000
ALLOC FI(ISPCTL2) SP(1 1) CYL UNIT(SYSDA) USING(ISPVIO)                 00140000
ALLOC FI(SMPTABL) DA('ZPDT.SHARED.SISPTENU') SHR                        00141016
ALLOC FI(ISPTLIB) DA('ISP.SISPTENU' +                                   00142002
                     'SYS1.DGTTLIB' +                                   00143002
                     'SYS1.SBLSTBL0' +                                  00144002
                     'SYS1.SBPXTENU' +                                  00145002
                     'SYS1.SCBDTENU' +                                  00146002
                     'GIM.SGIMTENU' +                                   00147002
                     'ISF.SISFTLIB' +                                   00148002
                     'SYS1.SERBT' +                                     00149002
                     'SYS1.SERBTENU' +                                  00149102
                     'ZPDT.SHARED.CAI.JCK.CAZ2TBL0' +                   00149209
                     'ZPDT.SHARED.SISPTENU' +                           00149314
                     ) SHR REUSE                                        00149414
/*                   '&DSNAME.' + */                                    00149514
/*                                                      */              00150000
AET &DSNAME = &STR(&SYSUID..&SYSSYMDEF(ZSYS).ISPF.ISPPROF)              00160015
ALLOC FI(ISPTABL) DA('ZPDT.SHARED.SISPTENU') SHR                        00180016
ALLOC FI(ISPPROF) DA('&DSNAME') SHR                                     00181016
IF &LASTCC ^= 0 THEN DO                                                 00190000
  FREE FILE(ISPCRTE)                                                    00200000
  DELETE '&DSNAME.'                                                     00210000
  DELETE '&DSNAME.' NOSCRATCH                                           00220000
  ATTRIB ISPCRTE DSORG(PO) RECFM(F B) LRECL(80) BLKSIZE(3120)           00230000
  ALLOC DA('&DSNAME.') SPACE(2 4) TRACKS DIR(2) VOL(&VOL) -             00240000
        USING (ISPCRTE) FILE(ISPPROF)                                   00250000
  IF &LASTCC = 0 THEN -                                                 00260000
    ALLOC DA('&DSNAME.') SHR FILE(ISPTABL)                              00270017
  ELSE DO                                                               00280000
    WRITE %%% UNABLE TO ALLOCATE OR CREATE ISPF PROFILE DATA SET "&DSNAM00290000
    FREE FILE(ISPPROF)                                                  00300000
    EXIT CODE(12)                                                       00310000
    END                                                                 00320000
  FREE FILE(ISPCRTE)                                                    00330000
  ISPF                                                                  00331017
  END                                                                   00340000
ELSE DO                                                                 00350000
  CONTROL MSG                                                           00360000
  WRITE                                                                 00370000
  ISPF                                                                  00371013
  EXIT CODE(0)                                                          00380000
  END                                                                   00390000
END                                                                     00390110
