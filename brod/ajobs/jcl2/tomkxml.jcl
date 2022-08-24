//*********************************************************************
//*           Create temporary directory using BPXBATCH               *
//*********************************************************************
//CR8TEMP  EXEC PGM=BPXBATCH
//STDOUT   DD SYSOUT=*
//STDERR   DD SYSOUT=*
//STDPARM  DD *
SH mkdir -p -m 700 /tmp/CA_temp/CCS_tomcat
/*
//*
//*********************************************************************
//*          Create script in temp directory using BPXCOPY            *
//*********************************************************************
//*
//CR8SCRPT EXEC PGM=BPXCOPY,
//             PARM='ELEMENT(EDITXML) TYPE(TEXT) PATHMODE(0,7,0,0)'
//SYSTSPRT DD SYSOUT=*
//SYSIN    DD DUMMY
//SYSUT2   DD PATH='/tmp/CA_temp/CCS_tomcat'
//SYSUT1   DD *,SYMBOLS=JCLONLY,DLM=$$
set -x
# Assign variables
TEMP_DIR=/tmp/CA_temp/CCS_tomcat
TEMP_PATH="$TEMP_DIR"/TOMSVXML
WORK_PATH="$TEMP_PATH"_work
KRXML=TOMSVXML_keyring
BK_OPTV=CAW0OPTV_TOMSVXML.bk

TARG_HLQ=&CCSHLQ

DPLY_DIR=&DPLOYDIR
DPLY_CONF="$DPLY_DIR"/tomcat/conf

REGN_HLQ=&REGNHLQ
REGN_OPTV="$REGN_HLQ".TOMCAT.CAW0OPTV
REGN_DIR=&REGNDIR
REGN_CONF="$REGN_DIR"/tomcat/conf
REGN_BK_OPTV=${REGN_CONF}/${BK_OPTV}

KEYRING_OWNER=&SRVID;
KEYRING_NAME=&SRVKYRNG;

# Make temp directory if it doesn't exist
if [ ! -d $TEMP_DIR ]; then
  mkdir -p $TEMP_DIR
  if [ $? -eq 0 ]; then
    echo "$TEMP_DIR created"
  else
    echo "Error: Couldn't create $TEMP_DIR"
    exit 1
  fi
else
  echo "$TEMP_DIR already exists"
fi

# Copy server.xml from TARGET LIBRARY
cp "//'${TARG_HLQ}.CAW0OPTV(TOMSVXML)'" ${TEMP_PATH}
if [ $? -eq 0 ]; then
  echo "${TARG_HLQ}.CAW0OPTV(TOMSVXML) copied to ${TEMP_PATH}"
else
  echo "Error: Couldn't copy TOMSVXML from ${TARG_HLQ}.CAW0OPTV"
  exit 1
fi


########################
#    OLD  CONNECTOR    #
########################
echo "-- UPDATING OLD CONNECTOR --"
# Find the Connector we want to comment
inspt=$(sed -n '/keystorePass/=' ${TEMP_PATH})

# Get the line to start the comment (<!--)
lineNum1=$(expr $inspt - 3)
# Get the line to end   the comment ( -->)
lineNum2=$(expr $inspt + 9)

# Add comment start
sed "${lineNum1}s/.*/    <!--/g" "$TEMP_PATH" > "$WORK_PATH"
if [ $? -eq 0 ]; then
  echo "Added start of comment"
  mv "$WORK_PATH" "$TEMP_PATH"
  if [ $? -ne 0 ]; then
    echo "Error: Couldn't save changes, exiting..."
    exit 1
  fi
else
  "Error: Old Connector not commented out, exiting..."
  exit 1
fi

# Add comment end
sed "${lineNum2}s/.*/    -->/g" "$TEMP_PATH" > "$WORK_PATH"
if [ $? -eq 0 ]; then
  echo "Added end of comment"
  mv "$WORK_PATH" "$TEMP_PATH"
  if [ $? -ne 0 ]; then
    echo "Error: Couldn't save changes, exiting..."
    exit 1
  fi
else
  "Error: Old Connector not commented out, exiting..."
  exit 1
fi

# Get the line of SSLHostConfig comment start (<!--)
lineNum1=$(expr $inspt + 2)
# Get the line of SSLHostConfig comment end ( -->)
lineNum2=$(expr $inspt + 7)

# Edit the comment start
sed "${lineNum1}s/<!--/<!- /g" "$TEMP_PATH" > "$WORK_PATH"
if [ $? -eq 0 ]; then
  echo "Edited SSLHostConfig start of comment"
  mv "$WORK_PATH" "$TEMP_PATH"
  if [ $? -ne 0 ]; then
    echo "Error: Couldn't save changes, exiting..."
    exit 1
  fi
else
  "Error: Old Connector not commented out, exiting..."
  exit 1
fi

# Edit the comment end
sed "${lineNum2}s/-->/ ->/g" "$TEMP_PATH" > "$WORK_PATH"
if [ $? -eq 0 ]; then
  echo "Edited SSLHostConfig end of comment"
  mv "$WORK_PATH" "$TEMP_PATH"
  if [ $? -ne 0 ]; then
    echo "Error: Couldn't save changes, exiting..."
    exit 1
  fi
else
  "Error: Old Connector not commented out, exiting..."
  exit 1
fi

########################
# SAFKEYRING CONNECTOR #
########################
echo "-- UPDATING NEW CONNECTOR --"
# Find the Connector we want to uncomment
inspt=$(sed -n '/safkeyring/=' $TEMP_PATH)

# Update the keyring owner and name
original="safkeyring:\/\/KEY_RING_OWNER\/KEY_RING_NAME"
replace="safkeyring:\/\/$KEYRING_OWNER\/$KEYRING_NAME"

sed "s/${original}/${replace}/g" "$TEMP_PATH" > "$WORK_PATH"
if [ $? -eq 0 ]; then
  echo "Keyring Name and Owner updated"
  mv "$WORK_PATH" "$TEMP_PATH"
  if [ $? -ne 0 ]; then
    echo "Error: Couldn't save changes, exiting..."
    exit 1
  fi
else
  "Error: Keyring Name/Owner not updated, exiting..."
  exit 1
fi

# Get the line containing the start of comment (<!--)
lineNum1=$(expr $inspt - 10)
# Get the line containing the end   of comment ( -->)
lineNum2=$(expr $inspt + 2)

# Clear out the comment start
sed "${lineNum1}s/<!--/ /g" "$TEMP_PATH" > "$WORK_PATH"
if [ $? -eq 0 ]; then
  echo "Removed start of comment"
  mv "$WORK_PATH" "$TEMP_PATH"
  if [ $? -ne 0 ]; then
    echo "Error: Couldn't save changes, exiting..."
    exit 1
  fi
else
  "SAFKEYRING Connector not uncommented, exiting..."
  exit 1
fi

# Clear out the comment end
sed "${lineNum2}s/-->/ /g" "$TEMP_PATH" > "$WORK_PATH"
if [ $? -eq 0 ]; then
  echo "Removed end of comment"
  mv "$WORK_PATH" "$TEMP_PATH"
  if [ $? -ne 0 ]; then
    echo "Error: Couldn't save changes, exiting..."
    exit 1
  fi
else
  "Error: SAFKEYRING Connector not uncommented, exiting..."
  exit 1
fi

########################
# SAVE UPDATES/BACKUPS #
########################
echo "-- SAVING BACKUPS/UPDATES --"

# Determine if we should save in Deployment and/or Region dir

# If Deployment Directory specified
# AND file doesn't already exist
#    then we should save there
echo "-- Deployment --"
if [ -d "$DPLY_CONF" ]; then
  echo "$DPLY_CONF exists"
  if [ -e $DPLY_CONF/$KRXML ]; then
    echo "$KRXML exists, copying to ${KRXML}_bk before replacing"
    cp $DPLY_CONF/$KRXML $DPLY_CONF/${KRXML}_bk
    if [ $? -eq 0 ]; then
      echo "Saved backup $DPLY_CONF/${KRXML}_bk"
    else
      echo "Error: Couldn't save backup to $DPLY_CONF/${KRXML}_bk"
      exit 1
    fi
  else
    echo "No backup file needed. $KRXML doesn't exist"
  fi

  cp $TEMP_PATH $DPLY_CONF/$KRXML
  if [ $? -eq 0 ]; then
    echo "Saved updates to $DPLY_CONF/$KRXML"
  else
    echo "Error: Couldn't save $DPLY_CONF/$KRXML"
    exit 1
  fi
else
  echo "Not saving to Deployment dir. $DPLY_CONF doesn't exist"
fi


# If Region Directory specified
#    then we should save there
echo "--  Region  --"
if [ -d "$REGN_CONF" ]; then
  echo "$REGN_CONF exists"
  if [ -e $REGN_CONF/$KRXML ]; then
    echo "$KRXML exists, copying to ${KRXML}_bk before replacing"
    cp $REGN_CONF/$KRXML $REGN_CONF/${KRXML}_bk
    if [ $? -eq 0 ]; then
      echo "Saved backup $REGN_CONF/${KRXML}_bk"
    else
      echo "Error: Couldn't save backup to $REGN_CONF/${KRXML}_bk"
      exit 1
    fi
  else
    echo "No backup file needed. $KRXML doesn't exist"
  fi

  cp $TEMP_PATH $REGN_CONF/$KRXML
  if [ $? -eq 0 ]; then
    echo "Saved updates to $REGN_CONF/$KRXML"
  else
    echo "Error: Couldn't save $REGN_CONF/$KRXML"
    exit 1
  fi

  #Backup the current CAW0OPTV(TOMSVXML)
  cp "//'${REGN_OPTV}(TOMSVXML)'" $REGN_BK_OPTV
  if [ $? -eq 0 ]; then
    echo "$REGN_BK_OPTV backup created"
  else
    echo "Couldn't save backup for ${REGN_OPTV}(TOMSVXML)"
    echo "Updated TOMSVXML not saved to Region CAW0OPTV"
    exit 0
  fi

  cp -F crnl $REGN_BK_OPTV "//'${REGN_OPTV}(TOMSVBKP)'"
  if [ $? -eq 0 ]; then
    echo "Saved backup to ${REGN_OPTV}(TOMSVBKP)"
  else
    echo "Error: Couldn't save backup to ${REGN_OPTV}(TOMSVBKP)"
    echo "Updated TOMSVXML not saved to Region CAW0OPTV"
    exit 1
  fi

  # Save the new server_keyring.xml file to CAW0OPTV
  cp -F crnl $REGN_CONF/$KRXML "//'${REGN_OPTV}(TOMSVXML)'"
  if [ $? -eq 0 ]; then
    echo "Saved updates to ${REGN_OPTV}(TOMSVXML)"
  else
    echo "Error: Couldn't save ${REGN_OPTV}(TOMSVXML)"
    exit 1
  fi
else
  echo "Not saving to Region dir. $REGN_CONF doesn't exist"
fi

$$
//*
//*********************************************************************
//*                 Execute script using BPXBATCH                     *
//*********************************************************************
//RUNSCRPT EXEC PGM=BPXBATCH
//STDOUT   DD SYSOUT=*
//STDERR   DD SYSOUT=*
//STDPARM  DD *
SH /tmp/CA_temp/CCS_tomcat/EDITXML
/*
//*
//*********************************************************************
//*           Delete temporary directory using BPXBATCH               *
//*********************************************************************
//RMVTEMP  EXEC PGM=BPXBATCH
//STDOUT   DD SYSOUT=*
//STDERR   DD SYSOUT=*
//STDPARM  DD *
SH rm -r /tmp/CA_temp/CCS_tomcat
/*
//*
//*********************************************************************
