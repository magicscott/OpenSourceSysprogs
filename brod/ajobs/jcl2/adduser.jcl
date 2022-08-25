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
AU diego DFLTGRP(SYS1) NAME('Diego Rodriguez') PASSWORD(bc123456) +
    OWNER(IBMUSER) SPECIAL OPERATIONS
ALU diego OMVS(AUTOUID HOME('/u/users/diego') PROGRAM('/bin/sh'))
ALU diego TSO(ACCTNUM(ACCT#) SIZE(200000) UNIT(3390) +
    SYSOUT(X) PROC(PROC394) NOMAXSIZE)
CONNECT diego GROUP(sysprog) OWNER(SYS1)
CONNECT diego GROUP(cfzusrgp) OWNER(SYS1)
CONNECT diego GROUP(cfzadmgp) OWNER(SYS1)
CONNECT diego GROUP(izuuser) OWNER(SYS1)
CONNECT diego GROUP(izuadmin) OWNER(SYS1)
PERMIT BPX.SUPERUSER CLASS(FACILITY) ID(diego) ACCESS(READ)
SETROPTS RACLIST(SERVAUTH) REFRESH
SETROPTS GENERIC(*) REFRESH
/*
//*
//
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
