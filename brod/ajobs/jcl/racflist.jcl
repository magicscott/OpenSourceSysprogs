//BRODSCO  JOB (000),'SCOTT BROD',CLASS=A,MSGCLASS=D,
//     MSGLEVEL=(1,1),NOTIFY=&SYSUID
//*-------------------------------------------------------------------*
//* This JCL lists the RACF and UADS definitions for a user.          *
//*                                                                   *
//* Change all occurrences of UUU to the userID.                      *
//*                                                                   *
//*-------------------------------------------------------------------*
//*
//LSTUSER EXEC PGM=IKJEFT01,REGION=2M,DYNAMNBR=25
//SYSEXEC   DD DISP=SHR,DSN=SYS1.SBPXEXEC
//SYSUADS  DD   DISP=SHR,DSN=SYS1.UADS.NEW
//SYSLBC   DD   DISP=SHR,DSN=SYS1.BRODCAST
//SYSTSPRT  DD SYSOUT=*
//SYSTSIN   DD *
LISTGRP *
//
LISTUSER UUU TSO OMVS

 ACCOUNT
  LIST (UUU)
 END
/*
//
