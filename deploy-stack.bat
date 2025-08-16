@echo off
REM ========================================================
REM Deploy CloudFormation stack for Serverless API
REM Prerequisites:
REM  - AWS CLI installed
REM  - AWS credentials configured (aws configure)
REM  - CloudFormation template saved as serverless-api.yml
REM ========================================================

SET STACK_NAME=MyServerlessApiStack
SET TEMPLATE_FILE=deploy_stack.yaml
SET REGION=us-east-1

echo Deploying CloudFormation stack: %STACK_NAME% in region %REGION%

aws cloudformation deploy ^
  --stack-name %STACK_NAME% ^
  --template-file %TEMPLATE_FILE% ^
  --capabilities CAPABILITY_IAM ^
  --region %REGION%

IF %ERRORLEVEL% NEQ 0 (
  echo Deployment failed!
  exit /b %ERRORLEVEL%
)

echo Deployment successful!
echo Getting API URL...

aws cloudformation describe-stacks ^
  --stack-name %STACK_NAME% ^
  --query "Stacks[0].Outputs[?OutputKey=='ApiUrl'].OutputValue" ^
  --output text ^
  --region %REGION%

pause
