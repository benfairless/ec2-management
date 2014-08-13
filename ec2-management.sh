#!/usr/bin/env bash


# Start instances for project $1
start-ec2(){
  PROJECT=$1
  INSTANCES=$(instance-discover off)
  if [[ $INSTANCES == "" ]]; then
    echo "No instances are currently stopped for project $PROJECT"
  else
    echo "Starting Amazon instances for project $PROJECT..."
    ec2-start-instances $INSTANCES
    echo -e "The following instances have been started:"
    instance-names $INSTANCES
  fi
}

# Stop instances for project $1
stop-ec2(){
  PROJECT=$1
  INSTANCES=$(instance-discover on)
  if [[ $INSTANCES == "" ]]; then
    echo "No instances are currently running for project $PROJECT"
  else
    echo "Stopping Amazon instances for project $PROJECT..."
    ec2-stop-instances $INSTANCES
    echo -e "The following instances have been stopped:"
    instance-names $INSTANCES
  fi
}

# Find all instances or those in a state of off/on
instance-discover(){
  case $1 in
    "off") ARGS='-F "instance-state-name=stopped"';;
     "on") ARGS='-F "instance-state-name=running,instance-state-name=pending"';;
        *)
  esac
  ec2-describe-instances $ARGS -F "tag:Project=$PROJECT" | grep INSTANCE | cut -f 2
}

# Find and display names for Amazon instances
instance-names(){
  for INSTANCE in $@; do
    NAME=$(ec2-describe-tags -F "key=Name" -F "resource-type=instance" -F "resource-id=$INSTANCE" | cut -f 5)
    echo "[$INSTANCE] $NAME"
  done
}

case $1 in
  "off") stop-ec2 $2 ;;
   "on") start-ec2 $2 ;;
      *) echo "Options are off/on"; exit 1 ;;
esac
