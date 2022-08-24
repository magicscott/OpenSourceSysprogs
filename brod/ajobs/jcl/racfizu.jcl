//BRODSCO  JOB (000),'SCOTT BROD',CLASS=A,MSGCLASS=D,
//     MSGLEVEL=(1,1),NOTIFY=BROD
//*
//STEP1  EXEC PGM=IKJEFT01,DYNAMNBR=99
//SYSPRINT DD SYSOUT=*
//SYSTSPRT DD SYSOUT=*
//SYSTSIN  DD *
/*                                                                */
/*  Begin "authorize user" Setup                                  */
/*                                                                */
/*   Begin zOSMF User Role by default                             */
/*                                                                */
/*  Connect the user to z/OSMF user group by default              */
Connect BROD group(IZUUSER)
/*  Connect the user to group of CIM by default                   */
Connect BROD group(CFZUSRGP)
/*                                                                */
/*   End zOSMF User Role by default                               */
/*                                                                */
/*   Begin zOSMF adminstrator Role                                */
/*                                                                */
/*  Connect the user to z/OSMF administrator group                */
/*  if the role the user is administrator                         */
Connect BROD group(IZUADMIN)
/*  Connect the user to CIM administrator group                   */
/*  if the role the user is administrator                         */
Connect BROD group(CFZADMGP)
/*   End zOSMF adminstrator Role                                  */
/*                                                                */
