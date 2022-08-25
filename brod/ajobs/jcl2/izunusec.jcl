//BRODSCO  JOB (000),'SCOTT BROD',CLASS=A,MSGCLASS=D,
//     MSGLEVEL=(1,1),NOTIFY=&SYSUID
//*.+....1....+....2....+....3....+....4....+....5....+....6....+....7.
//* -----------------------------------------------------------------*/
//* PROPRIETARY STATEMENT:                                           */
//* Licensed Materials - Property of IBM                             */
//* 5650-ZOS                                                         */
//* Copyright IBM Corp. 2019                                         */
//* Status = HSMA240                                                 */
//*                                                                  */
//* -----------------------------------------------------------------*/
//********************************************************************/
//* Replace with your job card
//*
//* -------------------------------------------------------------------
//*
//* - Security setup for z/OSMF Nucleus basic
//*
//*********************************************************************
//********************************************************************
//*                                                                  *
//* REQUIRES:                                                        *
//*                                                                  *
//* This job must be run using a user ID that has the RACF SPECIAL   *
//* attribute.                                                       *
//*                                                                  *
//* This job assumes that the BPX.NEXT.USER profile has been         *
//* defined in the FACILITY class to enable the use of AUTOUID       *
//* and AUTOGID.  See the topic "Automatically assigning unique      *
//* IDs through UNIX services" in z/OS Security Server RACF          *
//* Security Administrator's Guide for additional information        *
//* about automatic UID and GID assignment.  If this function has    *
//* not been enabled, you must assign unique UIDs to the IZUSVR      *
//* and IZUGUEST user IDs, and unique GIDs to the groups             *
//* IZUADMIN, IZUSECAD, IZUUSER, and IZUUNGRP.                       *
//*                                                                  *
//********************************************************************
//BASIC01  EXEC PGM=IKJEFT01
//SYSPRINT DD SYSOUT=*
//SYSTSPRT DD SYSOUT=*
//SYSTSIN  DD DATA,DLM=@@
ADDGROUP IZUADMIN OMVS(AUTOGID)
ADDGROUP IZUUSER  OMVS(AUTOGID)
ADDGROUP IZUUNGRP OMVS(AUTOGID)
ADDGROUP IZUSECAD OMVS(AUTOGID)

ADDUSER IZUSVR DFLTGRP(IZUADMIN) NOPASSWORD OMVS(AUTOUID   +
  HOME(/global/zosmf/data/home/izusvr) +
  PROGRAM(/bin/sh)) NAME('zOSMF Started Task USERID')

ALTUSER IZUSVR OMVS(FILEPROC(10000))
CONNECT IZUSVR GROUP(IZUSECAD)

ADDUSER IZUGUEST RESTRICTED DFLTGRP(IZUUNGRP) OMVS(AUTOUID)   +
  NAME('zOSMF Unauthenticated USERID') NOPASSWORD


SETROPTS CLASSACT(SERVER) RACLIST(SERVER) GENERIC(SERVER)

RDEFINE SERVER BBG.ANGEL.IZUANG1 UACC(NONE)
PERMIT  BBG.ANGEL.IZUANG1 CLASS(SERVER) ACCESS(READ) ID(IZUSVR)

RDEFINE SERVER BBG.AUTHMOD.BBGZSAFM UACC(NONE)
PERMIT  BBG.AUTHMOD.BBGZSAFM CLASS(SERVER) ACCESS(READ) ID(IZUSVR)

RDEFINE SERVER BBG.AUTHMOD.BBGZSAFM.SAFCRED UACC(NONE)
PERMIT  BBG.AUTHMOD.BBGZSAFM.SAFCRED CLASS(SERVER) ACCESS(READ) +
  ID(IZUSVR)

RDEFINE SERVER BBG.AUTHMOD.BBGZSAFM.ZOSWLM UACC(NONE)
PERMIT BBG.AUTHMOD.BBGZSAFM.ZOSWLM CLASS(SERVER) ACCESS(READ) ID(IZUSVR)

RDEFINE SERVER BBG.AUTHMOD.BBGZSAFM.TXRRS UACC(NONE)
PERMIT  BBG.AUTHMOD.BBGZSAFM.TXRRS CLASS(SERVER) ACCESS(READ) ID(IZUSVR)

RDEFINE SERVER BBG.AUTHMOD.BBGZSAFM.ZOSDUMP UACC(NONE)
PERMIT  BBG.AUTHMOD.BBGZSAFM.ZOSDUMP CLASS(SERVER) ACCESS(READ) +
  ID(IZUSVR)

RDEFINE SERVER BBG.SECPFX.IZUDFLT UACC(NONE)
PERMIT  BBG.SECPFX.IZUDFLT CLASS(SERVER) ACCESS(READ) ID(IZUSVR)

RDEFINE SERVER BBG.SECCLASS.ZMFAPLA UACC(NONE)
PERMIT  BBG.SECCLASS.ZMFAPLA CLASS(SERVER) ID(IZUSVR) ACCESS(READ)

SETROPTS RACLIST(SERVER) REFRESH

RDEFINE FACILITY BBG.SYNC.IZUDFLT UACC(NONE)
PERMIT  BBG.SYNC.IZUDFLT CLASS(FACILITY) ID(IZUSVR) ACCESS(CONTROL)

  /* RDEFINE FACILITY BPX.WLMSERVER UACC(NONE)    */
PERMIT  BPX.WLMSERVER CLASS(FACILITY) ID(IZUSVR) ACCESS(READ)
  /* RDEFINE FACILITY BPX.CONSOLE UACC(NONE)      */
PERMIT  BPX.CONSOLE CLASS(FACILITY) ID(IZUSVR) ACCESS(READ)
SETROPTS RACLIST(FACILITY) REFRESH

SETROPTS CLASSACT(APPL) RACLIST(APPL)
RDEFINE  APPL IZUDFLT UACC(NONE)
PERMIT   IZUDFLT CLASS(APPL) ACCESS(READ) ID(IZUADMIN IZUUSER IZUGUEST)
SETROPTS RACLIST(APPL) REFRESH

SETROPTS CLASSACT(EJBROLE) RACLIST(EJBROLE) GENERIC(EJBROLE)
RDEFINE  EJBROLE IZUDFLT.*.izuUsers UACC(NONE)
PERMIT   IZUDFLT.*.izuUsers CLASS(EJBROLE) ACCESS(READ) +
  ID(IZUADMIN IZUUSER)
SETROPTS RACLIST(EJBROLE) REFRESH

SETROPTS CLASSACT(ZMFAPLA) RACLIST(ZMFAPLA) GENERIC(ZMFAPLA)
/* By default, no users are allowed to perform z/OSMF tasks. Users    */
/* will only have access to z/OSMF tasks if it's specified explicitly.*/
RDEFINE ZMFAPLA IZUDFLT.** UACC(NONE)
RDEFINE ZMFAPLA IZUDFLT.ZOSMF UACC(NONE)
PERMIT  IZUDFLT.ZOSMF CLASS(ZMFAPLA) ACCESS(READ) ID(IZUADMIN IZUUSER)
SETROPTS RACLIST(ZMFAPLA) REFRESH

SETROPTS CLASSACT(SERVAUTH) RACLIST(SERVAUTH)
  /* RDEFINE SERVAUTH CEA.SIGNAL.ENF83 UACC(NONE) */
PERMIT CEA.SIGNAL.ENF83 CLASS(SERVAUTH) ID(IZUSVR) ACCESS(READ)
SETROPTS RACLIST(SERVAUTH ) REFRESH

@@
//********************************************************************
//*
//* - Key ring and Certficate definitions for z/OSMF server.
//*
//*
//KEYCERTS EXEC PGM=IKJEFT01
//SYSPRINT DD SYSOUT=*
//SYSTSPRT DD SYSOUT=*
//SYSTSIN  DD DATA,DLM=@@
RACDCERT CERTAUTH GENCERT +
  SUBJECTSDN(CN('z/OSMF CertAuth for Security Domain') +
  OU('IZUDFLT')) WITHLABEL('zOSMFCA')  +
  TRUST NOTAFTER(DATE(2028/05/17))
RACDCERT ADDRING(IZUKeyring.IZUDFLT) ID(IZUSVR)

/* Replace the HOST NAME with real hostname of your system. */
RACDCERT ID( IZUSVR ) GENCERT +
  SUBJECTSDN(CN('zm1m.bpc.broadcom.net') +
  O('IBM') OU('IZUDFLT')) WITHLABEL('DefaultzOSMFCert.IZUDFLT'), +
  SIGNWITH(CERTAUTH LABEL('zOSMFCA')) NOTAFTER(DATE(2028/05/17))
RACDCERT ALTER(LABEL('DefaultzOSMFCert.IZUDFLT')) ID(IZUSVR) TRUST
RACDCERT ID( IZUSVR ) CONNECT (LABEL('DefaultzOSMFCert.IZUDFLT') +
  RING(IZUKeyring.IZUDFLT) DEFAULT)
RACDCERT ID( IZUSVR ) CONNECT (LABEL('zOSMFCA') +
  RING(IZUKeyring.IZUDFLT) CERTAUTH)
SETROPTS RACLIST(DIGTCERT) REFRESH

RDEFINE  FACILITY IRR.DIGTCERT.LISTRING UACC(NONE)
PERMIT   IRR.DIGTCERT.LISTRING CLASS(FACILITY) ID(IZUSVR) ACCESS(READ)
SETROPTS RACLIST(FACILITY) REFRESH
@@
//********************************************************************
//*
//* - Started Task profiles for z/OSMF Angle and Server Address Spaces.
//*
//STCPROFS EXEC PGM=IKJEFT01
//SYSPRINT DD SYSOUT=*
//SYSTSPRT DD SYSOUT=*
//SYSTSIN  DD DATA,DLM=@@
RDEFINE STARTED IZUSVR1.* UACC(NONE) STDATA(USER(IZUSVR) +
  GROUP(IZUADMIN) PRIVILEGED(NO) TRUSTED(NO) TRACE(YES))
RDEFINE STARTED IZUANG1.* UACC(NONE) STDATA(USER(IZUSVR) +
  GROUP(IZUADMIN) PRIVILEGED(NO) TRUSTED(NO) TRACE(YES))
SETROPTS RACLIST(STARTED) REFRESH
@@
//*--------------------- End of this Job -------------------------------
