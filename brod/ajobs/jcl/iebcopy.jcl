//BRODSCO  JOB (13160000),CLASS=A,MSGCLASS=X
//*
//STEP1    EXEC  PGM=IEBCOPY
//SYSPRINT DD  SYSOUT=A
//SYSUT1   DD  DSNAME=PRODUCT.NDVR.MARBLES.MARBLES.D1.LOADLIB,
//             UNIT=3390,DISP=SHR
//SYSUT2   DD  DSNAME=CICS.TRAIN.MARBLES.LOADLIB,
//             UNIT=3390,DISP=SHR
//SYSIN    DD  *
     COPY INDD=SYSUT1,OUTDD=SYSUT2
     SELECT M=((MARBLE20,,R))
/*

//STEP1 DD DSNAME=adasdasd.asda,
//sdasda dd //StepName EXEC PGM=IDCAMS
//INPUT    DD   DSN=DataSetName,DISP=SHR,DCB=(DataControlBlock)
//SYSPRINT DD   SYSOUT=SYSOUT
//SYSIN    DD   *
    REPRO -
       INFILE (Input) -
       OUTDATASET (OutDataSet) -
       ERRORLIMIT (ErrorLimit)
/*
//StepName EXEC PGM=IDCAMS
//SYSPRINT DD   SYSOUT=SYSOUT
//SYSIN    DD   *
    DEFINE CLUSTER -
       (NAME (Name) -
       STORAGECLASS (StorageClass) -
       MANAGEMENTCLASS (ManagementClass) -
       DATACLASS (DataClass))
/*
