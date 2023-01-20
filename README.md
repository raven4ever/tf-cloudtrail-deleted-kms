# AWS CloudWatch Alarm for using invalid KMS keys

This project will create a CloudWatch Alarm based on CloudTrail events stored in an S3 bucket. The alarm will be triggered by the usage of a KMS key which is in "Pending deletion" state.

## How to test

- go to KMS and create a custom key
- go to KMS and schedule the deletion of the created key
- go to EC2 and try to create a new volume encrypted with the created KMS key
- go to CloudTrail and check if the KMS event was generated
- go to CloudWatch and check if the alarm is now in `In alarm` state

## Requirements

## Configuration
