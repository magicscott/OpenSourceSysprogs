//BRODSCO  JOB (000),'SCOTT BROD',CLASS=A,MSGCLASS=D,                   00001000
//     MSGLEVEL=(1,1),NOTIFY=BROD                                       00002000
//*                                                                     00003000
//SDSF  EXEC PGM=SDSF                                                   00010000
//ISFOUT DD SYSOUT=*                                                    00020000
//CMDOUT DD DSN=BROD.COMMAND.OUTPUT,                                    00030000
//          DISP=(,CATLG,DELETE),                                       00040000
//          DCB=(RECFM=FBA,LRECL=133,BLKSIZE=0),                        00050000
//          SPACE=(CYL,(1,1)),UNIT=SYSDA                                00060000
//ISFIN  DD *                                                           00070000
SET CONSOLE BATCH                                                       00080000
SET DELAY 600                                                           00090000
/D A,L                                                                  00100000
/$ D SPOOL                                                              00110000
PRINT FILE CMDOUT                                                       00120000
ULOG                                                                    00130000
PRINT                                                                   00140000
PRINT CLOSE                                                             00150000
/*                                                                      00160000
//                                                                      00170000
