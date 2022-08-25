//BRODSCO  JOB (000),'SCOTT BROD',CLASS=A,MSGCLASS=D,                   00010000
//     MSGLEVEL=(1,1),NOTIFY=&SYSUID                                    00020000
//*.+....1....+....2....+....3....+....4....+....5....+....6....+....7..00030000
//********************************************************************
//* PROPRIETARY STATEMENT:                                           *
//*    Licensed Materials - Property of IBM                          *
//*    5650-ZOS                                                      *
//*    Copyright IBM Corp. 2014, 2019                                *
//*                                                                  *
//*    STATUS=HSMA240                                                *
//********************************************************************
//* DESCRIPTIVE NAME:                                                *
//*    The job IZUMKFS is intended to define, format, and            *
//*    temporarily mount the z/OSMF file system that contains        *
//*    configuration settings and persist data for z/OSMF.           *
//*                                                                  *
//********************************************************************
//* You must select a volume for the allocation. You should edit a   *
//* copy of this job (IZUMKFS) and replace "UV900F" with the actual  *
//* volume serial of the disk volume you will use.                   *
//*                                                                  *
//* If you choose to change the file system name, you will need      *
//* to change IZU.SIZUUSRD to the name you choose in three places.   *
//*                                                                  *
//* NOTE: The user ID used to run this job must either have access   *
//*       to the appropriate resource profiles in the UNIXPRIV       *
//*       class, access to the BPX.SUPERUSER resource profile in     *
//*       the FACILITY class, or UID(0).                             *
//*                                                                  *
//*       If you choose to use UNIXPRIV, the resources for which     *
//*       access is required are:                                    *
//*                                                                  *
//*        - SUPERUSER.FILESYS.CHANGEPERMS                           *
//*        - SUPERUSER.FILESYS.CHOWN                                 *
//*        - SUPERUSER.FILESYS.MOUNT                                 *
//*        - SUPERUSER.FILESYS.PFSCTL                                *
//*                                                                  *
//********************************************************************
//DEFINE   EXEC   PGM=IDCAMS
//SYSPRINT DD     SYSOUT=*
//SYSIN    DD     *
  DEFINE                -
    CLUSTER             -
    (NAME(IZU.SIZUUSRD) -
    VOLUMES(UV900F)     -
    LINEAR              -
    CYL(200 20)         -
    SHAREOPTIONS(3 3))
/*
//FORMATFS EXEC   PGM=IOEAGFMT,REGION=0M,COND=(0,NE,DEFINE),
// PARM=('-aggregate IZU.SIZUUSRD -compat')
//SYSPRINT DD     SYSOUT=*
//STDOUT   DD     SYSOUT=*
//STDERR   DD     SYSOUT=*
//*
//********************************************************************
//* Review the mountpoint below and change it if necessary for your  *
//* environment.  This file system should be mounted in a sysplex-   *
//* wide file system that is shared by all members of the same       *
//* autostart group.                                                 *
//*                                                                  *
//* This step:                                                       *
//* 1. Creates the z/OSMF data directory as /global/zosmf.           *
//* 2. Mounts the filesystem at mount point /global/zosmf.           *
//* 3. Creates the home directory for the z/OSMF started task.       *
//* 4. Changes the ownership and permissions of the directories      *
//*    and files in the z/OSMF data file system.                     *
//********************************************************************
//*
//MOUNT    EXEC PGM=IKJEFT1A,COND=((0,NE,DEFINE),(0,NE,FORMATFS))
//SYSTSPRT DD   SYSOUT=*
//SYSTSIN  DD   *
    BPXBATCH SH mkdir -p /global/zosmf
    MOUNT FILESYSTEM('IZU.SIZUUSRD') TYPE(ZFS) +
    MOUNTPOINT('/global/zosmf') MODE(RDWR) PARM('AGGRGROW') AUTOMOVE
    BPXBATCH SH mkdir -p /global/zosmf/data/home/izusvr
    BPXBATCH SH mkdir -p /global/zosmf/configuration/workflow
    BPXBATCH SH chown -R IZUSVR:IZUADMIN /global/zosmf
    BPXBATCH SH chmod -R 755 /global/zosmf
/*
//
