//BRODSCO  JOB (000),'SCOTT BROD',CLASS=A,MSGCLASS=D,                   00010000
//     MSGLEVEL=(1,1),NOTIFY=&SYSUID                                    00020000
//*.+....1....+....2....+....3....+....4....+....5....+....6....+....7..00030000
//CREATE   EXEC PGM=IDCAMS,REGION=0M,COND=(0,LT)                        00040000
//SYSPRINT DD SYSOUT=*                                                  00050000
//SYSIN    DD *                                                         00060000
DEFINE CLUSTER ( -                                                      00070000
NAME(OMVS24) -                                                          00080000
TRK(#SIZE) -                                                            00090000
/*VOLUME(VOLSER)*/ -                                                    00100000
LINEAR -                                                                00110000
SHAREOPTIONS(3) -                                                       00120000
)                                                                       00130000
//*                                                                     00140000
//         SET ZFSDSN='@ZFS_DSN@'                                       00150000
//FORMAT   EXEC PGM=IOEAGFMT,REGION=0M,COND=(0,LT),                     00160000
//            PARM='-AGGREGATE &ZFSDSN -COMPAT'                         00170000
//*STEPLIB  DD DISP=SHR,DSN=IOE.SIOELMOD        BEFORE Z/OS 1.13        00180000
//*STEPLIB  DD DISP=SHR,DSN=SYS1.SIEALNKE       FROM Z/OS 1.13          00190000
//SYSPRINT DD SYSOUT=*                                                  00200000
//*                                                                     00210000
//MOUNT    EXEC PGM=IKJEFT01,REGION=0M,COND=(0,LT)                      00220000
//SYSEXEC  DD DISP=SHR,DSN=SYS1.SBPXEXEC                                00230000
//SYSTSPRT DD SYSOUT=*                                                  00240000
//SYSTSIN  DD *                                                         00250000
PROFILE MSGID WTPMSG                                                    00260000
OSHELL UMASK 0022; +                                                    00270000
MKDIR -P @ZFS_PATH@                                                     00280000
MOUNT +                                                                 00290000
FILESYSTEM('@ZFS_DSN@') +                                               00300000
MOUNTPOINT('@ZFS_PATH@') +                                              00310000
MODE(RDWR) TYPE(ZFS) PARM('AGGRGROW')                                   00320000
//*                                                                     00330000
