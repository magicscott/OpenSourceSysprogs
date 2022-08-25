//BRODSCO  JOB (000),'SCOTT BROD',CLASS=A,MSGCLASS=D,
//     MSGLEVEL=(1,1),NOTIFY=BROD
//*
//APPLY    EXEC PGM=GIMSMP,PARM='DATE=U',REGION=0M
//SMPCSI   DD DISP=SHR,DSN=SMPE.CAI.CSI
//SMPCNTL  DD *
 SET BOUNDARY (CAIT0) .
 APPLY
  CHECK      /*** Remove to APPLY all functions ***/
  GROUPEXTEND(NOAPARS NOUSERMODS)
  SELECT (
   CAZ1C00 /*CA JCLCheck                                           */
   CAZ2C00 /*CA JCLCheck Common Component                          */
   CAZ1C01 /*CA JCLCheck Roscoe RPF Support                        */
   CAZ1C02 /*CA JCLCheck CA 1 Interface                            */
   CAZ1C03 /*CA JCLCheck TLMS Interface                            */
   CD51C00 /*CA General Transaction Server                         */
          )
  BYPASS(HOLDSYSTEM).
//*
