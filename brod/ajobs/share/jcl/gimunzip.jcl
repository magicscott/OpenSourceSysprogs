//BRODSCO  JOB (000),'SCOTT BROD',CLASS=A,MSGCLASS=D,                   00001000
//     MSGLEVEL=(1,1),NOTIFY=BROD                                       00002000
//*
////GIMUNZIP EXEC PGM=GIMUNZIP,REGION=0M,COND=(0,LT)                      000100
//*STEPLIB  DD DISP=SHR,DSN=SYS1.MIGLIB                                 00020000
//SYSUT3   DD UNIT=SYSALLDA,SPACE=(CYL,(50,10))                         00030000
//SYSUT4   DD UNIT=SYSALLDA,SPACE=(CYL,(25,5))                          00040000
//SMPOUT   DD SYSOUT=*                                                  00050000
//SYSPRINT DD SYSOUT=*                                                  00060000
//SMPDIR   DD PATHDISP=KEEP,                                            00070000
// PATH='/tmp/'                                                         00080000
//SYSIN    DD *                                                         00090000
<GIMUNZIP>                                                              00100000
<ARCHDEF archid="AZWE001.SMPMCS"                                        00110000
newname="SMPE.ZOWE.AZWE001.SMPMCS"/>                                    00120000
<ARCHDEF archid="AZWE001.F1"                                            00130000
newname="SMPE.ZOWE.AZWE001.F1"/>                                        00140000
<ARCHDEF archid="AZWE001.F2"                                            00150000
newname="SMPE.ZOWE.AZWE001.F2"/>                                        00160000
<ARCHDEF archid="AZWE001.F3"                                            00170001
newname="SMPE.ZOWE.AZWE001.F3"/>                                        00180001
<ARCHDEF archid="AZWE001.F4"                                            00190000
newname="SMPE.ZOWE.AZWE001.F4"/>                                        00200000
</GIMUNZIP>                                                             00210000
//*                                                                     00220000
