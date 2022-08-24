//BRODSCO  JOB (000),'SCOTT BROD',CLASS=A,MSGCLASS=D,                   00010000
//     MSGLEVEL=(1,1),NOTIFY=&SYSUID                                    00020000
//*.+....1....+....2....+....3....+....4....+....5....+....6....+....7..00030000
//JS010    EXEC PGM=IEFBR14                                             00040000
//SYSPRINT DD *
//STEP2    EXEC PGM=IEFBR14                                             00040000
//SYSPRINT DD *
//StepName EXEC PGM=IDCAMS
//SYSPRINT DD   SYSOUT=SYSOUT
//SYSIN    DD   *
    DEFINE CLUSTER -
       (NAME (Name) -
       STORAGECLASS (StorageClass) -
       MANAGEMENTCLASS (ManagementClass) -
       DATACLASS (DataClass))
/*
//StepName EXEC PGM=IDCAMS
//INPUT    DD   DSN=DataSetName,DISP=SHR,DCB=(DataControlBlock)
//SYSPRINT DD   SYSOUT=SYSOUT
//SYSIN    DD   *
    REPRO -
       INFILE (Input) -
       OUTDATASET (OutDataSet) -
       ERRORLIMIT (ErrorLimit)
/*
