#!/bin/sh

#regions=(`aws-vault exec $1 -- aws rds describe-source-regions --query 'SourceRegions[].RegionName' --output text`)

regions=( us-east-1 \
us-east-2 \
us-west-1 \
us-west-2 \
ap-east-1 \
ap-south-1 \
ap-northeast-3 \
ap-northeast-2 \
ap-southeast-1 \
ap-southeast-2 \
ap-northeast-1 \
ca-central-1 \
eu-central-1 \
eu-west-1 \
eu-west-2 \
eu-west-3 \
eu-north-1 \
sa-east-1 \
)

for region in ${regions[@]}
do echo "[${region}]"
aws-vault exec $1 -- aws rds describe-db-instances --output table --region ${region} \
    --query 'DBInstances[*].[{
        ID:DBInstanceIdentifier,
        Class:DBInstanceClass,
        Engine:Engine
        }]'
echo "---------------------"
done