//BRODSCO  JOB (000),'SCOTT BROD',CLASS=A,MSGCLASS=D,                   00010000
//     MSGLEVEL=(1,1),NOTIFY=BROD                                       00020000
//*                                                                     00030000
//********************************************************************  00040000
//*                                                                  *  00050000
//* PROPRIETARY STATEMENT:                                           *  00060000
//*    Licensed Materials - Property of IBM                          *  00070000
//*    5694-A01 Copyright IBM Corp. 2005,  2008                      *  00080000
//*                                                                  *  00090000
//*    STATUS=HPG7750                                                *  00100000
//*                                                                  *  00110000
//* DESCRIPTIVE NAME:                                                *  00120000
//*    CIM SERVER INSTALLATION VERIFICATION PROGRAM                  *  00130000
//*                                                                  *  00140000
//* NOTES:                                                           *  00150000
//*    1. ENSURE THAT THE CIMSERVER IS RUNNING.                      *  00160000
//*                                                                  *  00170000
//*    2. SUBMIT THIS JOB                                            *  00180000
//*       THE INSTALLATION VERIFICATION PROGRAM RUNS AS LOCAL        *  00190000
//*       CIM CLIENT PROGRAM AND RETRIEVES SYSTEM INFORMATION        *  00200000
//*       THROUGH THE CIM RUNTIME ENVIRONMENT AND OS MANAGEMENT      *  00210000
//*       INSTRUMENTATION.                                           *  00220000
//*                                                                  *  00230000
//*       A MAXCC OF 0 INDICATES A PROPERLY INSTALLED CIM RUNTIME    *  00240000
//*       ENVIRONMENT.                                               *  00250000
//*                                                                  *  00260000
//*    DEPENDENCIES:                                                 *  00270000
//*       - TCPIP MUST BE ACTIVE                                     *  00280000
//*       - UNIX SYSTEM SERVICES (AKA OPENEDITION): THE USERID       *  00290000
//*         RUNNING THIS SERVER MUST HAVE AN OMVS SEGMENT IN RACF    *  00300000
//*         AND A HOME DIRECTORY IN THE USS FILESYSTEM.              *  00310000
//*       - CIM SERVER MUST BE RUNNING                               *  00320000
//*                                                                  *  00330000
//********************************************************************  00340000
//*  STEP 1 - Start cimivp on local host                             *  00350000
//********************************************************************/ 00360000
//STEP1    EXEC PGM=BPXBATCH,TIME=NOLIMIT,REGION=0M,                    00370000
//         PARM='PGM /usr/lpp/wbem/bin/cimivp 127.0.0.1'                00380000
//STDENV   DD   PATH='/etc/wbem/cimserver.env'                          00390000
//STDOUT   DD SYSOUT=*                                                  00400000
//STDERR   DD SYSOUT=*                                                  00410000
//CEEDUMP  DD SYSOUT=*                                                  00420000
//SYSPRINT DD SYSOUT=*                                                  00430000
//SYSUDUMP DD SYSOUT=*                                                  00440000
//SYSMDUMP DD SYSOUT=*                                                  00450000
