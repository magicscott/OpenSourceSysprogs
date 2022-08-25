//BRODSCO  JOB (000),'SCOTT BROD',CLASS=A,MSGCLASS=D,                   00010000
//     MSGLEVEL=(1,1),NOTIFY=&SYSUID                                    00020000
//*.+....1....+....2....+....3....+....4....+....5....+....6....+....7..00030000
//**********************************************************************
//*
//* - Allow user to access to z/OSMF Nucleus.
//*
//**********************************************************************
//AUTHUSER EXEC PGM=IKJEFT01
//SYSPRINT DD SYSOUT=*
//SYSTSPRT DD SYSOUT=*
//SYSTSIN  DD DATA,DLM=@@

CONNECT brod GROUP(IZUADMIN)
CONNECT brosc01 GROUP(IZUADMIN)

/* CONNECT userid GROUP(IZUUSER) */

@@
//*--------------------- End of this Job -------------------------------
