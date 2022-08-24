//* Insert JOBCARD here
//*--------------------------------------------------------------------
//* Copyright (C) 2019 CA Technologies, Inc. All Rights Reserved.
//*
//* ----------------------------- WARNING -----------------------------
//* This JCL file contains sample IBM Resource Access Control Facility
//* (RACF) commands for creating digital certificates for
//* CCS Apache Tomcat.
//*
//* The security administrator must review these commands carefully
//* to ensure that they do not conflict or interfere with existing
//* security elements and that they conform to your site requirements.
//* Make the required modifications and ensure that existing legitimate
//* access authority is preserved.
//*
//* This JCL file must be submitted with a user ID that has the
//* appropriate authorities to issue the security commands.
//*
//*--------------------------------------------------------------------
//* Notes:
//*
//* - Set CAPS OFF.
//*   This file contains case-sensitive values. Lower case might be
//*   needed for certain values.
//*
//* - Update the JOB card to conform to your site standards.
//*
//* - Edit JCLLIB ORDER. Specify the dataset(s) where your
//*   customized TOMSEDIT member is located.
//*
//* - This sample file assumes that none of the security elements exist
//*   in the security database. If this JOB is re-run, then warnings
//*   can be produced for elements that are duplicated.
//*
//* - In some cases, you might want to use existing resources to
//*   conform to your site standards.
//*--------------------------------------------------------------------
// JCLLIB ORDER=(CAI.CAW0JCL)
// INCLUDE MEMBER=TOMSEDIT
//*-------------------------------------------------------------------
//CRTCERT EXEC PGM=IKJEFT01
//SYSTSPRT  DD SYSOUT=*
//SYSTSIN   DD *,SYMBOLS=JCLONLY

 /*------------------------------------------------------------*/
 /* Create Internal CA Certificate                             */
 /*------------------------------------------------------------*/
 RACDCERT CERTAUTH GENCERT SUBJECTSDN( -
    CN('&CACN.') -
    O('&COMPANY.') -
    OU('&ORG.') -
    C('&COUNTRY.')) -
    SIZE(2048) -
    NOTAFTER(DATE(&CAEXPDT.) TIME(&CAEXPTM.)) -
    KEYUSAGE(HANDSHAKE, CERTSIGN) -
    WITHLABEL('&CALABL.')

 /*------------------------------------------------------------*/
 /* Create Server Certificate signed by Internal CA            */
 /*------------------------------------------------------------*/
 RACDCERT ID(&SRVID.) GENCERT SUBJECTSDN( -
    CN('&SRVCN.') -
    O('&COMPANY.') -
    OU('&ORG.') -
    C('&COUNTRY.')) -
    SIZE(2048) -
    KEYUSAGE(HANDSHAKE) -
    WITHLABEL('&SRVLABL.') -
    NOTAFTER(DATE(&SRVEXPDT.) TIME(&SRVEXPTM.)) -
    SIGNWITH(CERTAUTH -
    LABEL('&CALABL.'))
/*
//*
//CRTKEYR EXEC PGM=IKJEFT01,COND=(0,NE)
//SYSTSPRT  DD SYSOUT=*
//SYSTSIN   DD *,SYMBOLS=JCLONLY

 /*------------------------------------------------------------*/
 /* Create Server Side Keyring                                 */
 /*------------------------------------------------------------*/
 RACDCERT ID(&SRVID.) -
    ADDRING(&SRVKYRNG.)

 /*------------------------------------------------------------*/
 /* Create Internal CA Keyring                                 */
 /*------------------------------------------------------------*/
 RACDCERT ID(&CAID.) -
    ADDRING(&CAKYRNG.)

/*
//*
//CNTCERT EXEC PGM=IKJEFT01,COND=(0,NE)
//SYSTSPRT  DD SYSOUT=*
//SYSTSIN   DD *,SYMBOLS=JCLONLY

 /*------------------------------------------------------------*/
 /* Connect the Internal CA Keyring to its Certificate         */
 /*------------------------------------------------------------*/
 RACDCERT ID(&CAID.) -
    CONNECT(CERTAUTH -
    LABEL('&CALABL.') -
    RING(&CAKYRNG.))

 /*------------------------------------------------------------*/
 /* Connect the Server Keyring to its Certificate              */
 /*------------------------------------------------------------*/
 RACDCERT ID(&SRVID.) -
    CONNECT(ID(&SRVID.) -
    USAGE(PERSONAL) -
    DEFAULT -
    LABEL('&SRVLABL.') -
    RING(&SRVKYRNG.))

 /*------------------------------------------------------------*/
 /* Connect the Server Keyring to the Internal CA              */
 /*------------------------------------------------------------*/
 RACDCERT ID(&SRVID.) -
    CONNECT(CERTAUTH -
    USAGE(CERTAUTH) -
    LABEL('&CALABL.') -
    RING(&SRVKYRNG.))
/*
//*
//LSTCERT EXEC PGM=IKJEFT01
//SYSTSPRT  DD SYSOUT=*
//SYSTSIN   DD *,SYMBOLS=JCLONLY

 /*------------------------------------------------------------*/
 /* List the Keyring and Certificate set-up                    */
 /*------------------------------------------------------------*/
 RACDCERT ID(&SRVID.) -
    LISTRING(&SRVKYRNG.)
 RACDCERT ID(&CAID.) -
    LISTRING(&CAKYRNG.)
 RACDCERT CERTAUTH -
    LIST(LABEL('&CALABL.'))
 RACDCERT ID(&SRVID.) LIST
/*
//********************************************************************
//*                 Update server.xml (TOMSVXML)                     *
//********************************************************************
// INCLUDE MEMBER=TOMKXML
//*
