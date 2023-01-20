# AWS CloudWatch Alarm for using invalid KMS keys

This project will create a CloudWatch Alarm based on CloudTrail events stored in an S3 bucket. The alarm will be triggered by the usage of a KMS key which is in "Pending deletion" state.

## How to test

- go to KMS and create a custom key
- go to EC2 and create a new EC2 instance and use the previously created key to encrypt the root volume
- go to KMS and schedule the deletion of the previously created key
- go to EC2 and stop & start the the previously created instance
- go to CloudTrail and check if the KMS event was generated
- go to CloudWatch and check if the alarm is now in `Alarm` state

## Requirements

## Configuration
