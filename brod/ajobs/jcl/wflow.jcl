<?xml version="1.0" encoding="UTF-8"?>
<!--
/******************************************************************************/
/* Copyright Contributors to the zOS-Workflow Project.                        */
/* SPDX-License-Identifier: Apache-2.0                                        */
/******************************************************************************/
-->
<workflow xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                          xsi:noNamespaceSchemaLocation="../workflow/schemas/wor
 <!-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	 DB2 Checkout Wizard
	 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 <workflowInfo>
	<workflowID>IBM-MF-AUTO-DB2-DR-V1</workflowID>
	<workflowDescription>IBM-MF-AUTO-DB2-DR</workflowDescription>
	<workflowVersion>1.0</workflowVersion>
	<vendor>IBM-MF-AUTO</vendor>
	<Configuration>
		<productID>IBM-MF-AUTO-DB2-DR</productID>
		<productName>IBM MF Automation Workflow for DB2</productName>
		<productVersion>12</productVersion>
 	</Configuration>
</workflowInfo>

<!-- Declare a set of variables for use below -->
<variable name="db2-sys">
	<label>DB2 Subsystem Name</label>
	<abstract>Please enter the name of the DB2 Subsystem to be checked:</abstract>
	<description>This variable holds the DB2 Subsystem name to be checked</descript
	<category>DB2</category>
	<string>
	    <default>DSNP</default>
	</string>
</variable>

<variable name="db2-stc">
	<label>DB2 Started Task Name</label>
	<abstract>Please enter the name of the DB2 Started Task to be checked:</abstrac
	<description>This variable holds the DB2 Started Task to be checked</descriptio
	<category>DB2</category>
	<string>
	    <default>DSNPMSTR</default>
	</string>
</variable>

<variable name="db2-sdsnexit">
	<label>DB2 SDSNEXIT Load Libraries</label>
	<abstract>Please enter the DB2 Load Libraries:</abstract>
	<description>This variable holds the DB2 Subsystem Load Library.</description>
	<category>DB2</category>
	<string>
	   <default>DB2V11.LBI9.SDSNEXIT</default>
	</string>
</variable>

<variable name="db2-runlib">
	<label>DB2 RunLib load Libraries</label>
	<abstract>Please enter the DB2 Load Libraries:</abstract>
	<description>This variable holds the DB2 Subsystem Load Library.</description>
	<category>DB2</category>
	<string>
	   <default>DB2V11.LBI9.RUNLIB.LOAD</default>
	</string>
</variable>

<!-- Begin Steps -->
 <step name="checkout-check-db2">
        <title>Run DB2 Checkout Job</title>
        <description>In this step, you run the checkou for DR. This step involve
        <variableValue name="db2-sys" required="true"/>
		    <variableValue name="db2-stc" required="true"/>
        <variableValue name="db2-sdsnexit" required="true"/>
        <variableValue name="db2-runlib" required="true"/>
		<instructions substitution="true">Please review the variables defined in the l
		<br/>
		DB2-System   : $instance-db2-sys       <br/>
		DB2-STC      : $instance-db2-stc       <br/>
		DB2-SDSNEXIT : $instance-db2-sdsnexit  <br/>
		DB2-RUNLIB   : $instance-db2-runlib    <br/>
		</instructions>
        <weight>10</weight>
        <skills>DB2 System Programmer</skills>
        <template>
       		<inlineTemplate substitution="true">//JOBLIB   DD DSN=$instance-db2-sds
//         DD DSN=$instance-db2-runlib,DISP=SHR
//STEP01   EXEC PGM=IKJEFT01,DYNAMNBR=20
//SYSTSPRT DD SYSOUT=*
//SYSPRINT DD SYSOUT=*
//SYSUDUMP DD SYSOUT=*
//SYSOUT   DD SYSOUT=*
//SYSTSIN  DD *
DSN SYSTEM($instance-db2-sys)
RUN PROGRAM(DSNTEP2) PLAN(DSNTEP2)
-DIS UTIL(*)
-DIS DDF
-DIS THD(*)
-DIS DB(*) SPACE(*) LIMIT(*) RESTRICT
END
//SYSIN    DD *
select * from sysibm.systables where type = 'T'
         fetch first 10 rows only ;
/*
       		</inlineTemplate>
       		<submitAs>JCL</submitAs>
			<maxLrecl>80</maxLrecl>
       		<saveAsDataset substitution="true">${instance-db2-sys}.PRODUCTX.JOBS(MY
       	</template>
</step>
   <step name="checkout-check-stc" optional="false">
       <title>Run DB2 Checkout Exec</title>
       <description>In this step, you run the checkou for DR. This step involves
       <prereqStep name="checkout-check-db2"/>
       <instructions substitution="false">This step will execute the REXX exec t
       <weight>1</weight>
       <autoEnable>true</autoEnable>
       <canMarkAsFailed>false</canMarkAsFailed>
       <template>
             <inlineTemplate substitution="true">/* REXX */
Arg debug

rc=isfcalls('ON')

trace o

if debug&lt;&gt;"" then   /* If debug mode */
  verbose="VERBOSE"  /* .. use SDSF verbose mode */
else
  verbose=""

/*----------------------------------------------*/
/* Configure environment with special variables */
/*----------------------------------------------*/
isfprefix='$instance-db2-stc'    /* Corresponds to PREFIX command */
isfowner='*'      /* Corresponds to OWNER command */
isfsysname=''   /* Corresponds to SYSNAME command */

isfdest=' ' || ,    /* Dest name 1 */
        ' ' || ,    /* Dest name 2 */
        ' ' || ,    /* Dest name 3 */
        ' '         /* Dest name 4 */


/* Access the ST panel */
Address SDSF "ISFEXEC 'ST' (" verbose ")"
lrc=rc

if lrc&lt;&gt;0 then   /* If command failed */
  do
    Say "** ISFEXEC failed with rc="lrc"."
    exit 20
  end

isflinelim = 1000

/*--------------------*/
/* Loop for all lines */
/*--------------------*/
do until isfstartlinetoken=''

  /*--------------------------------------------------------------*/
  /* Issue ISFBROWSE for the row identified by the token variable */
  /*--------------------------------------------------------------*/
  Address SDSF "ISFBROWSE 'ST' TOKEN('"TOKEN.1"') (" verbose ")"
  lrc=rc

  if lrc&lt;&gt;0 then   /* If request failed */
    do
      Say "** ISFBROWSE failed with rc="lrc"."
      Exit 20
    end

  isfstartlinetoken=isfnextlinetoken  /* Set up for next request */

  /*---------------------*/
    /* List returned lines */
  /*---------------------*/
  do lineix=1 to isfline.0  /* Loop for all lines returned */
    if pos('DSNR002I',isfline.lineix) &gt; 0 then do
       say isfline.lineix
       exit 0
    end
  end
end

rc=isfcalls('OFF')

SAY "STRING NOT FOUND !!"

Exit 8
</inlineTemplate>
            <submitAs maxRc="0">TSO-REXX-JCL</submitAs>
        </template>
    </step>
</workflow>
