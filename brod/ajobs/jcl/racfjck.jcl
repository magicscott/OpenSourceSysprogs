//BRODSCO  JOB (000),'SCOTT BROD',CLASS=A,MSGCLASS=D,                   00010001
//     MSGLEVEL=(1,1),NOTIFY=&SYSUID                                    00020000
//*.+....1....+....2....+....3....+....4....+....5....+....6....+....7..00030000
//RACFSTRT EXEC PGM=IKJEFT01,REGION=2M,DYNAMNBR=25                      00350001
//SYSEXEC  DD   DISP=SHR,DSN=SYS1.SBPXEXEC                              00360000
//SYSUADS  DD   DISP=SHR,DSN=SYS1.UADS.NEW                              00370000
//SYSLBC   DD   DISP=SHR,DSN=SYS1.BRODCAST                              00380000
//SYSTSPRT DD   SYSOUT=*                                                00390000
//SYSTSIN  DD   *                                                       00400000
ADDGROUP RESTAPIS OMVS(AUTOGID)                                         00400101
ADDUSER JCKREST DFLTGRP(RESTAPIS) OMVS(AUTOUID   +                      00401001
HOME(/u) +                                                              00402001
PROGRAM(/bin/sh)) NAME('JCK REST API STARTED TASK USERID')  +           00403001
NOPASSWORD                                                              00404001
RDEFINE STARTED AJ6ZJCKR.* UACC(NONE) STDATA(USER(JCKREST) +            00410001
GROUP(RESTAPIS) PRIVILEGED(NO) TRUSTED(NO) TRACE(YES))                  00420001
PERMIT BPX.SUPERUSER CLASS(FACILITY) ID(JCKREST) ACCESS(READ)           00430001
SETROPTS RACLIST(UNIXPRIV) REFRESH                                      00440001
PERMIT BPX.FILEATTR.PROGCTL CLASS(FACILITY) ID(JCKREST) ACCESS(READ)    00450001
PERMIT BPX.SERVER CLASS(FACILITY) ID(JCKREST) ACCESS(READ)              00460001
PERMIT BPX.DAEMON CLASS(FACILITY) ID(JCKREST) ACCESS(UPDATE)            00470001
RDEFINE FACILITY JCLCHECK.SERVICE UACC(NONE)                            00480001
PERMIT JCLCHECK.SERVICE CLASS(FACILITY) ID(JCKREST) ACCESS(READ)        00490001
PERMIT JCLCHECK.SERVICE CLASS(FACILITY) ID(BROD) ACCESS(READ)           00491002
SETROPTS RACLIST(FACILITY) REFRESH                                      00500001
/*                                                                      00580000
//                                                                      00590000
