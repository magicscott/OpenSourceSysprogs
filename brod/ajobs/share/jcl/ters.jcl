//BRODSCO  JOB (000),'SCOTT BROD',CLASS=A,MSGCLASS=D,                   00010000
//     MSGLEVEL=(1,1),NOTIFY=&SYSUID                                    00020000
//*.+....1....+....2....+....3....+....4....+....5....+....6....+....7..00030000
//UNTERSE EXEC PGM=TRSMAIN,PARM='PACK'
//SYSPRINT DD SYSOUT=*
//INFILE   DD DISP=SHR,DSN=SMPE.CAI.NDVR181.CAI.SAMPJCL
//OUTFILE DD DSN=SMPE.CAI.NDVR181.CAI.SAMPJCL.TRS,
//         DISP=(NEW,CATLG,KEEP),UNIT=3390,
//         SPACE=(CYL,(1,1),RLSE),RECFM=FBS
