//BRODSCO  JOB (000),'SCOTT BROD',CLASS=A,MSGCLASS=D,
//     MSGLEVEL=(1,1),NOTIFY=BROD
//*
//* Use this JCL to add a new user
//*
//* Change diego to the new ID and 'mister user' to the person's name
//*
//* -----------------------------------------------------------------
//* MAKE SURE that the diego is lower case (for the home directory)
//* -----------------------------------------------------------------
//*
//* Application Identity Mapping (AIM) has been implemented.  We are at
//* Stage 3, which uses alias index for lookups and deletes mapping
//* profiles.  AIM allows us to use AUTOUID for the OMVS segment and
//* automatically assigns a UID (starting at 700) to a new user. To
//* accomplish this also required a new facility class:
//*
//* RDEFINE FACILITY BPX.NEXT.USER APPLDATA('700/0')
//*
//* Remember to CANCEL out of this JCL once you submit it
//*
//ADDUSER EXEC PGM=IKJEFT01,REGION=2M,DYNAMNBR=25
//SYSTSPRT  DD SYSOUT=*
//SYSTSIN   DD *
ADDUSER ZCXPRV1 PASSWORD(password) NAME('zCX Provision User 1') +
OWNER(SYS1) +
UACC(ALTER) DFLTGRP(ZCXPRVG) AUTHORITY(JOIN) GRPACC TSO(ACCTNUM(ACCT#) +
PROC(PROC394) SIZE(2096128) MAXSIZE(0) UNIT(SYSDA) +
COMMAND(ISPF NOLOGO)) OMVS(AUTOUID  HOME(/u/zcxprv1) PROGRAM(/bin/sh))
ADDUSER ZCXSTC1 NOPASSWORD NAME('zCX STC User 1') +
OWNER(SYS1) NOOIDCARD +
UACC(ALTER) DFLTGRP(ZCXSTCG) AUTHORITY(JOIN) GRPACC TSO(ACCTNUM(ACCT#) +
PROC(PROC394) SIZE(2096128) MAXSIZE(0) UNIT(SYSDA) +
COMMAND(ISPF NOLOGO)) OMVS(AUTOUID  HOME(/u/zcxstc1) PROGRAM(/bin/sh))
//
AU JAGBR01 DFLTGRP(SYS1) NAME('Brian Jagos') PASSWORD(bc123456) +
    OWNER(IBMUSER) SPECIAL OPERATIONS
ALU JAGBR01 OMVS(AUTOUID HOME('/u/users/JAGBR01') PROGRAM('/bin/sh'))
ALU JAGBR01 TSO(ACCTNUM(ACCT#) SIZE(200000) UNIT(3390) +
    SYSOUT(X) PROC(PROC394) NOMAXSIZE)
CONNECT JAGBR01 GROUP(sysprog) OWNER(SYS1)
CONNECT JAGBR01 GROUP(cfzusrgp) OWNER(SYS1)
CONNECT JAGBR01 GROUP(cfzadmgp) OWNER(SYS1)
CONNECT JAGBR01 GROUP(izuuser) OWNER(SYS1)
CONNECT JAGBR01 GROUP(izuadmin) OWNER(SYS1)
PERMIT BPX.SUPERUSER CLASS(FACILITY) ID(JAGBR01) ACCESS(READ)
SETROPTS RACLIST(SERVAUTH) REFRESH
SETROPTS GENERIC(*) REFRESH
/*
//*
//*  MAKE SURE THAT THE diego BELOW IS IN LOWER-CASE !!!
//*
//*  DS - 04/01/20 - removed since this is performed when the alias
//*                  is defined as part of the ADDUSER process under
//*                  TSS.
//*
//MKDIR    EXEC PGM=BPXBATCH,REGION=0M
//STDOUT DD SYSOUT=*
//STDPARM      DD *
sh mkdir /u/users/diego
/*
//step EXEC PGM=sdsd
//        DD DISP
