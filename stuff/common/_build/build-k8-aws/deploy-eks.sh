aws cloudformation create-stack  --stack-name startmyinstance
    --template-body file://home/ec2-user/templates/startmyinstance.json
    --parameters  ParameterKey=KeyPairName,ParameterValue=MyKey ParameterKey=InstanceType,ParameterValue=t1.micro