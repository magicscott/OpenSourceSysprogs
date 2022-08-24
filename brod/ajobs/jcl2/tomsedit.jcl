//*-------------------------------------------------------------------*
//* This member contains symbols that are used in the CCS Apache Tomcat
//* jobs listed below. Members listed in brackets are included as part
//* of other jobs and should not be submitted individually.
//*
//* Follow these steps:
//*
//* 1. This member should be copied to your deployed library location
//*    as per the documentation.
//*
//* 2. Customize the member according to your specifications.
//*
//*    Refer to your product's documentation to determine which jobs
//*    will need to be run.
//*
//* 3. Follow the instructions in each of the jobs to be run.
//*
//*-------------------------------------------------------------------*
//*
//* Below is a brief description of each variable:
//*
//* CCSHLQ   - the high level qualifier for the CA Common Services for
//*            z/OS installation
//*
//* SRCDIR   - the mount point for the CCS Apache Tomcat SMP/E Target
//*            zFS data set.
//*
//* DISKUNIT - the disk unit name
//*
//* VOLNAME  - the volume for the Deployment/Region zFS data sets.
//*            Specify this parameter if SMS is not active on the
//*            system.  If this keyword is specified, then SMS
//*            allocation parameter, STORCLAS, will not be used.  This
//*            parameter is disabled (commented out) by default.
//*
//* STORCLAS - the storage class for the Deployment/Region zFS data
//*            sets.  This parameter will not be used if VOLNAME is
//*            specified.
//*
//* DPLOYHLQ - the high level qualifier for the CCS Apache Tomcat
//*            Deployment zFS data set
//*
//* DPLOYDIR - the mount point for the CCS Apache Tomcat Deployment zFS
//*            data set
//*
//* REGNHLQ  - the high level qualifier for the CCS Apache Tomcat
//*            Region zFS data set
//*
//* REGNDIR  - the mount point for the CCS Apache Tomcat Region zFS
//*            data set
//*
//* JAVAHOME - the USS path where IBM Java has been installed
//*
//* PROCNAME - the name of the STC procedure that starts the CCS Apache
//*            Tomcat Region
//*
//* SSLPORT  - the port number on which the CCS Apache Tomcat Region
//*            will await incoming TCP connections
//*
//* SHUTPORT - the port number used to send a shutdown command to the
//*            CCS Apache Tomcat Region
//*
//* WARFROM  - the USS directory or MVS data set where the product
//*            WAR file is to be copied from
//*
//* WARFNAME - If WARFROM is a USS directory:
//*              the name of the WAR file being copied.  Wildcards
//*              (*.war) may be used to copy multiple WAR files.
//*          - If WARFROM is an MVS data set:
//*              the name of the target WAR file in the CCS Apache
//*              Tomcat Region. Wildcards (*) should not be used.
//*
//* WARMEMBR - the member name of the WAR file being copied.  This
//*            parameter is required if WARFROM is an MVS data set.
//*            Otherwise, this parameter is ignored WARFROM is a USS
//*            directory.
//*
//* ----------------- Tomcat Certificate Variables --------------------
//*
//* COMPANY  - Company name
//*
//* ORG      - Organization name
//*
//* COUNTRY  - Country name
//*
//* SRVID    - User ID associated with Server Certificate
//*
//* SRVCERT  - 8-byte Server Certificate name
//*
//* SRVLABL  - Server Certificate label
//*
//* SRVKYRNG - Key ring name for Server Certificate
//*
//* SRVCN    - Server Certificate common name
//*
//* SRVEXPDT - Server Certificate expire date
//*
//* SRVEXPTM - Server Certificate expire time
//*
//* CAID     - User ID associated with the Internal CA Certificate
//*
//* CACERT   - 8-byte CA Certificate name
//*
//* CALABL   - (ACF2/RACF only)
//*            Internal CA Certificate label
//*
//* CAKYRNG  - Key ring name for Internal CA Certificate
//*
//* CACN     - Internal CA Certificate common name
//*
//* CAEXPDT  - Internal CA Certificate expire date
//*
//* CAEXPTM  - Internal CA Certificate expire time
//*
//*====================================================================
//         EXPORT SYMLIST=(CCSHLQ,SRCDIR,DISKUNIT,VOLNAME,STORCLAS,
//             DPLOYHLQ,DPLOYDIR,REGNHLQ,REGNDIR,
//             JAVAHOME,PROCNAME,SSLPORT,SHUTPORT,
//             WARFROM,WARFNAME,WARMEMBR,
//             COMPANY,ORG,COUNTRY,
//             SRVID,SRVCERT,SRVLABL,SRVKYRNG,SRVCN,SRVEXPDT,SRVEXPTM,
//             CAID,CACERT,CALABL,CAKYRNG,CACN,CAEXPDT,CAEXPTM)
//*
//*********************************************************************
//* Edit the variables below by referring to this section in the      *
//* documentation:                                                    *
//*                                                                   *
//* "Deploy CCS Apache Tomcat to the CCS Apache Tomcat Deployment zFS"*
//*                                                                   *
//*********************************************************************
//*              CCS Apache Tomcat Installation Variables             *
//*                                                                   *
//*********************************************************************
//         SET CCSHLQ='CAI',
//             SRCDIR='/cai/CASoftware/CCS150/tpv',
//*
//*********************************************************************
//*              CCS Apache Tomcat Allocation Variables               *
//*                                                                   *
//*********************************************************************
//             DISKUNIT='3390',
//*            VOLNAME='TSO001',
//             STORCLAS='SC01',
//*
//*********************************************************************
//*              CCS Apache Tomcat Deployment Variables               *
//*                                                                   *
//*********************************************************************
//             DPLOYHLQ='CAI',
//             DPLOYDIR='/cai/CADeploy/CCS150/tpv',
//*
//*********************************************************************
//* Save this file and continue with the next step in the             *
//* documentation to prepare the TOMDPLOY JCL.                        *
//*                                                                   *
//*********************************************************************
//* Edit the variables below by referring to this section in the      *
//* documentation:                                                    *
//*                                                                   *
//* "Configure Security for the CCS Apache Tomcat Region"             *
//*                                                                   *
//*********************************************************************
//*              CCS Apache Tomcat Certificate Variables              *
//*                                                                   *
//*********************************************************************
//*            DPLOYDIR=(the value of DPLOYDIR is already specified)
//*                     above),
//             COMPANY='BROADCOM',   Company name
//             ORG='MAINFRAME',      Organization name
//             COUNTRY='US',         Country name
//*--------------------*
//* Server Certificate *
//*--------------------*
//             SRVID='TOMUSER',      User ID for Server Cert
//             SRVCERT='SRVCERT ',   8-byte Server Certificate name
//             SRVLABL='SRVLABEL',   Server Certificate label
//             SRVKYRNG='SRVKYRNG',  Key ring name for Server Cert
//             SRVCN='LPAR.CA.COM',  Server Cert common name
//             SRVEXPDT='mm/dd/yy',  Server Cert expiry date (ACF2,TSS)
//*            SRVEXPDT='yyyy-mm-dd', Server Cert expiry date (RACF)
//             SRVEXPTM='hh:mm:ss',  Server Cert expiry time
//*-------------------------*
//* Internal CA Certificate *
//*-------------------------*
//             CAID='ADMIN',         User ID for CA Cert
//             CACERT='CACERT  ',    8-byte CA Cert name
//             CAKYRNG='CAKYRNG',    Key ring name for CA Cert
//             CACN='LPAR.CA.COM',   CA Cert common name
//             CAEXPDT='mm/dd/yy',   CA Cert expiry date (ACF2,TSS)
//*            CAEXPDT='yyyy-mm-dd', CA Cert expiry date (RACF)
//             CAEXPTM='hh:mm:ss',   CA Cert expiry time
//* ----------  ACF2 or RACF only    -----------------------------
//             CALABL='CALABEL',     CA Cert label
//*
//*********************************************************************
//* Save this file and continue with the next step in the             *
//* documentation to prepare the job that creates the certificate     *
//* (TOMKACF2/TOMKTSS/TOMKRACF)                                       *
//*                                                                   *
//*********************************************************************
//* Edit the variables below by referring to this section in the      *
//* documentation:                                                    *
//*                                                                   *
//* "Configure a CCS Apache Tomcat Region"                            *
//*                                                                   *
//*********************************************************************
//*              CCS Apache Tomcat Region Variables                   *
//*                                                                   *
//*********************************************************************
//*            (The value of DISKUNIT, VOLNAME, STORCLAS,
//*            DPLOYHLQ, and DPLOYDIR are already specified above)
//             REGNHLQ='CAI.PRODUCT',
//             REGNDIR='/cai/CADeploy/productx',
//             JAVAHOME='/sys/java64bt/v8r0m0/usr/lpp/java/J8.0_64',
//             PROCNAME='TOMCATPR',
//             SSLPORT='8443',
//             SHUTPORT='8005',
//             WARFROM='/cai/CASoftware/product',
//             WARFNAME='warfile1.war'
//*,           WARMEMBR='WARFILE1'
//*
//*********************************************************************
//* Save this file and continue with the next step in the             *
//* documentation to prepare the TOMALLOC job.                        *
//*                                                                   *
//*********************************************************************
