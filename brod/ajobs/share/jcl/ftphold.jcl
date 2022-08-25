//BRODSCO  JOB (000),'SCOTT BROD',CLASS=A,MSGCLASS=D,                   00010000
//     MSGLEVEL=(1,1),NOTIFY=&SYSUID                                    00020000
//*.+....1....+....2....+....3....+....4....+....5....+....6....+....7..00030000
//FTPSTEP  EXEC PGM=FTP,PARM='(EXIT=08'
//*SYSTCPD  DD   DSN=TCP/IP_data_set,DISP=SHR
//SYSPRINT DD   SYSOUT=*
//OUTPUT   DD   SYSOUT=*
//INPUT    DD *
10.74.241.237 21
scott

bin
locsite fwfriendly
dir
get 18388209.zip '/tmp/18388209.zip'
quit
