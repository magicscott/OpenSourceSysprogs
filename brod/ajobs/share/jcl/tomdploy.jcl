//BRODSCO  JOB (000),'SCOTT BROD',CLASS=A,MSGCLASS=D,
//     MSGLEVEL=(1,1),NOTIFY=BROD
//*
//*********************************************************************
//*                                                                   *
//*              Proprietary and Confidential Information             *
//*                  and Intellectual Property of CA                  *
//*                       Copyright (C) 2019 CA                       *
//*                        All Rights Reserved.                       *
//*                                                                   *
//*********************************************************************
//*
//*  PURPOSE:
//*  This JOB allocates, initializes, and mounts a CCS Apache Tomcat
//*  deployment zFS and copys the files from the target CCS Apache
//*  Tomcat installation zFS.
//*
//*  NOTES:
//*       1. Update your BPXPARM to include the new mount
//*             point.
//*
//*
//*  INSTRUCTIONS:
//*
//*       1. Edit JOBCARD according to your specifications.
//*
//*       2. Edit JCLLIB ORDER. Specify the dataset(s) where your
//*          customized TOMSEDIT and $TOMDPLY members are located.  If
//*          the data set with the customized TOMSEDIT member is
//*          USER.CAW0JCL, and the data set with $TOMDPLY member is
//*          TARGET.CAW0JCL, then the JCLLIB ORDER statement is:
//*
//*          // JCLLIB ORDER=(USER.CAW0JCL,TARGET.CAW0JCL)
//*          // INCLUDE MEMBER=TOMSEDIT
//*          // INCLUDE MEMBER=$TOMDPLY
//*
//*       3. SUBMIT the JOB
//*
//*       4. Check the RETURN CODE. Expected Result:
//*            - RC = 0 if STORCLAS was used for data set allocation
//*            - RC = 2 if VOLNAME  was used for data set allocation
//*
//*
// JCLLIB ORDER=(BROD.AJOBS.JCL)
// INCLUDE MEMBER=TOMSEDIT
// INCLUDE MEMBER=$TOMDPLY
