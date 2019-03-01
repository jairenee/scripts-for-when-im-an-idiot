aws apigateway create-deployment --profile btprod-terraform --region us-east-1 --rest-api-id 1a0eji1g36 --stage-name api
ccurl -h
ccurl --url https://arc-aegis.billtrust.com/authentication/v1/health --repeat 1000 --delay 2
deb
dev
cd envvars-db/
git pull
cd arc-template-service/
cd prod/
ls
e
e ..
pwd
cd ..
e
cd prod/
ti
proma
ta
cd ../../..
cd envvars-db/
gcm
dev
ls
cd aws-workspace-provisioning/
e
cd terraform/dev/
ti
effthis
mkdir lab
dev
cd email-service/terraform/prod/
e
ccurl --url https://arc-aegis.billtrust.com/authentication/v1/health --delay 2 --repeat 000
ccurl --url https://arc-aegis.billtrust.com/email/v1/health --delay 2 --repeat 1000 --name Email
ccurl https://arc-aegis.billtrust.com/auth/v1/health
ccurl --url https://arc-aegis.billtrust.com/auth/v1/health --delay 2 --repeat 200
ccurl --url https://arc-aegis.billtrust.com/authentication/v1/health --delay 2 --repeat 100
ccurl --url https://arc-aegis.billtrust.com/authentication/v1/health --delay 2 --repeat 100 --name Auth
ccurl --url https://arc-aegis.billtrust.com/authentication/v1/health --delay 2 --repeat 1000 --name Auth
dev
cd envvars
git pull
cd arc-email-service
cd prod/
ls
cd ..
e
cd prod/
ri
ti
ta
pwd
proma
pwd
cd ../../arc-email-service-worker/
ls
cd prod/
l
e ..
ti
ta
cd envvars/jenkins/dev
ti
ta
cd jenkins-aws
e
cd ../envvars
e
cd ../jenkins-aws/
w
e
cd ../
cd terraform
e
cd ..
ls
cd aws-lab-account/
e
cd envvars-db/
cd arc-email-service/
ls
cd ..
ls
cd arc-email-service/
cd prod/
code ..
ti
terraform plan
ta
dev
cd email-service
git pull
e
tfp
ti
proma
terraform plan
dfsg;kdfsjgl;kjdsfgjl
terraform plan
terraform apply
aws apigateway create-deployment --profile btprod-terraform --region us-east-1 --rest-api-id 1a0eji1g36 --stage-name api
terraform apply
cd ..
e
cd prod/
terraform plan
cd ../..
gcm
dev
cd lambda-email-service-webhook-node/
git pull
e
yes
yes no
tfp
cd ..
e
cd prod/
ti
ta
proma
terraform apply
aws logs --profile btprod-terraform tag-log-group --log-group-name /aws/lambda/arc-email-event-catcher-sls --tags SumoURL=https://endpoint2.collection.us2.sumologic.com/receiver/v1/http/ZaVnC4dhaV1dcHa53y4CvIcIo36JBRF1v17j1ZHrnzq4Pj49V3_v-3jj3MsAqpqEDWR98sXywHpFU_1n6o6Qrvlz5xkgi70-jqs5r4tFkC66rorjuwK-7Q==
aws logs --profile btprod-terraform put-subscription-filter --log-group-name /aws/lambda/arc-email-event-catcher-sls --filter-pattern "" --filter-name arc_to_sumo --destination-arn arn:aws:lambda:us-east-1:318722734627:function:cw-to-sumo-forwarder
aws logs --profile btprod-terraform list-tags-log-group --log-group-name /aws/lambda/arc-email-event-catcher-sls
dev
cd email-service-worker/
tfp
ti
proma
..
e
ebr
cd prod/
terraform plan
ti
ebr
sbp
cd email-service-worker/
tfp
tpl
ta
dev
cd aws-workspace-provisioning/
e
iam-docker-run -h
cat ~/.aws/config 
vim ~/.aws/config 
dev
cd template-service/
e
dev
cd envvars-db/arc-template-service/
e
cd stage/
tpl
ta
cd ../prod/
ta
cd ../
cd ../arc-email-service/
e
ls ..
cd stage/
ta
cd ../prod/
ta
cd ../..
gcm
dev
cd template-service/
e
dev
cd envvars-db/
code arc-email-service/ arc-template-service/
cd arc-email-service/
cd prod/
ta
cd ../../arc-template-service/prod
ta
...
gcm
gcp
e
cd aws-workspace-provisioning/
e
dev
cd template-service/
e
cd ../email-service-worker/
e
aws ssm start-session --target i-0829ae651ad882e31 --profile btdev-jwissner
aws ssm start-session --target i-052b42735fb7e82c5 --profile btdev-jwissner
dev
cd aws-workspace-provisioning/
aws ssm start-session --target i-052b42735fb7e82c5 --profile btdev-jwissner
mkdir seed-sla-runner
cd dead-letter-queue-worker/
e
cd ..
code seed-sla-runner/
dev
cd seed-ecs-dotnet-rest/
git pull
e
docker build -t billtrust/seed-ecs-dotnet-rest:dev -f Dockerfile.dev .
iam-docker-run     --image billtrust/seed-ecs-dotnet-rest:dev     --aws-role-name bt-role-seed-ecs-dotnet-rest-task     --host-source-path ./src     --container-source-path /app     -p 4430:443     --profile default \
iam-docker-run     --image billtrust/seed-ecs-dotnet-rest:dev     --aws-role-name bt-role-seed-ecs-dotnet-rest-task     --host-source-path ./src     --container-source-path /app     -p 4430:443     --profile btdev     --interactive
docker build --no-cache -t billtrust/seed-ecs-dotnet-rest:dev -f Dockerfile.dev .
iam-docker-run     --image billtrust/seed-ecs-dotnet-rest:dev     --aws-role-name bt-role-seed-ecs-dotnet-rest-task     --host-source-path ./src     --container-source-path /app     -p 4430:443     --profile btdev     --interactive
docker --version
dev
cd dead-letter-queue-worker/
e
cp terraform/ ../seed-sla-runner/terraform/
cp -r terraform/ ../seed-sla-runner/terraform/
dev
cd aws-lab-account/terraform/
e
cd ..
ls
git remote add origin git@ssnj-git01.billtrust.local:devops/terraform-lab-aws.git
git init
git remote add origin git@ssnj-git01.billtrust.local:devops/terraform-lab-aws.git
gcm
git add .
git status
git commit -m "Initial commit"
git push -u origin master
cd terraform/lab/
ti
terraform init
dev
cd terraform
e
cd ../
cd aws-lab-account/terraform/lab/
terraform init
terraform apply
cd /
df -h
rpm -qa --queryformat '%{name} %{size}\n' | sort -n -k 2
rpm remove thunderbird
docker images
docker rmi $(docker images | grep "^<none>" | awk "{print $3}")
docker images
docker rmi $(docker images | grep "^<none>" | awk "{print $3}")
docker rm $(docker ps -a -q)
docker rmi $(docker images | grep "^<none>" | awk "{print $3}")
docker images
sbp
cd sso-service-worker/
tfs
proma
cd sso-service
cd terraform/stage/
ti
cd ../dev/
ti
ta
cd ../stage/
proma
cd ../
cd ../..
cd sso-service-worker/
git pull
e
cd sso-service
git pull
e
cd ../aws-lab-account/
ls
ll
cd terraform/
ll
cd lab/
ll
cd ../../..
cd aws-lab-account/
vim .gitignore
git status
git add .
git statsu
git status
git commit -m "Is this how this works?"
git push
vim .gitignore
git status
git add .
git status
git commit -m "Nope. How about this?"
git push
git status
cd terraform/lab/
e
cd ..
..
gcm
cd terraform/lab/
ti
...
gcm
cd terraform/lab/
ll
cd terraform
git pull
git push
e
cd aws-lab-account/
git status
git remote get-url 
git remote get-url --all
git remote get-url origin
e
cd terraform/lab/
ta
dev
cd terraform
e
gcp
e
tfd
ti
ta
...
gcm
git pull
git commit -m "Vars"
git add .
git commit -m "Vars"
git pull
tfd
ta
...
gcm
dev
cd creditapp-reference-frontend/
git pull
git status
git -h
git status -h
git status --long
git status -v
cd terraform/
ls
ls stage/
cd ../pr
ls prod/
e
code ..
cd stage/
ti
proma
dev
cd terraform
ls
cd plugins/
ls
cd linux/
ls
cd ../windows/
ls
cd btq-api-docs/
e
tfp
ta
e
cd ../dev/
e
ta
ti
ta
cd ../stage/
proma
ta
cd ../prod/
proma
ta
e
ta
ssh aws-qalinux172.aws-dev.billtrustinternal.net
ssh -i ~/.ssh/btdev-ec2-keypair.pem ec2-user@aws-qalinux172.aws-dev.billtrustinternal.net
ssh -i ~/.ssh/btdev-ec2-keypair.pem centos@aws-qalinux172.aws-dev.billtrustinternal.net
cd terraform
gp
e
cd ..
ifconfig
cd btq-api-docs/
cd de
tfd
ta
code ../..
ta
cd ../stage/
ta
cd ../prod/
ta
pwd
dev
cd btq-swagger-ui/
tfd
ta
cd ../stage/
ta
cd ../prod/
ta
ssh -i ~/.ssh/btdev-ec2-keypair.pem centos@10.12.47.52
dev
cd seed-ecs-dotnet-rest/
e
git fetch
git pull
git branch -h
git branch --list
git branch --list -a
cd ..
gcp
git branch --list -a
git checkout feature/terraform_validate 
e
python validate_terraform.py 
python validate_terraform.py dev
aws ssm start-session --target i-052b42735fb7e82c5 --profile btdev-jwissner
cd btq-api-docs/
git pull
tfp
proma
e
ti
e
terraform apply
cd ..
gcm
dev
cd creditapp-reference-frontend/
cd terraform/stage/
proma
ti
ta
pwd
dev
cd btq-swagger-ui/
git pull
tfp
proma
ti
ta
e
cd ../dev/
code ..
ls
pwd
pip install --user terraform_validate
cd collections-ui
cd collection-ui
e
cd ../envvars
ls
e
dev
cd collection-ui/
tfs
git rm stage.auto.tfvars 
cd ../prod/
git rm prod.auto.tfvars 
ti
cd ..
git rm prod/prod.auto.tfvars 
pwd
ls prod/
cd stage/
ti
proma
ta
...
gcm
cd sla-runner/
git remote add origin git@ssnj-git01.billtrust.local:devops/sla-monitor-runner.git
git status
cd ../
mv sla-runner/ sla-monitor-runner
cd sla-monitor-runner/
git status
git add .
git commit -m "Initial commit. Skeleton created. Runs commands"
git push -u origin master
cd collection-services/
ls
e
cd account-service
e
dev
cd collection-ui/
git pull
e
tfp
ti
proma
ta
dev
cd seed-ecs-node-rest/
e
python validate_terraform.py 
python validate_terraform.py dev
python3 validate_terraform.py dev
dev
mkdir findtest
cd findtest/
mkdir one
touch one/test.sh
ll one/
touch test2.sh
touch testwhasjdj.SH
mkdir one/two
touch one/two/cobalt.sh
ll
ll one/
ll one/two/
chmod +x $(find . -iname *.sh)
ll
cd one/
ll
ll two/
cd ../..
cd findtest/
ls
ll
chmod -x test2.sh 
find . -iname *.sh
find ./ -iname *.sh
find ./** -iname *.sh
find ./** -name *.sh
find ./** -name '*.sh'
find ./** -iname '*.sh'
find . -iname '*.sh'
chmod +x $(find . -iname '*.sh')
ll
ll one/
ll one/two/
effthis
cd sla-monitor-runner/
ls
cd terraform/
ls
rm -rf prod/ stage/
ls
cd dev/
ls
rm dev-ssm.tf dev-variables.tf sqs.tf vars.tf ssm.tf 
ls
ti
rm -rf .
rm -rf *
ls
rmdir -f .terraform/
rm -rf .terraform/
;s
ls
pdev
cd terraform
e
ls
cd dev/
ls
cd dev-us-east-1/
ls
e dev-sns-alerts.tf 
ls
dev
cd account-
cd account-service
ls
dev
cd batch-service
git pull
e
git remote get-url origin
tfd
ta
ti
ta
cd ../stage/
ti
proma
dev
cd envvars
cd arc-document-batch-service/
e
dev
cd envvars/arc-document-batch-service/stage/
ti
ta
dev
cd batch-service
tfs
pdev
popd
pwd
ta
pdev
cd envvars/arc-document-batch-service/stage/
e
aws apigateway create-deployment --profile btstage-terraform --rest-api-id drg35ubxic --stage-name api
pwd
ta
curl http://foaas.com/awesome/Jaime
curl -h
curl -H "{Accept: application/json}" http://foaas.com/awesome/Jaime
curl -H "Accept: application/json" http://foaas.com/awesome/Jaime
curl -H "Accept: application/json" http://foaas.com/field/Celeste/Jaime/Your%20Mom
curl -H "Accept: application/json" http://foaas.com/field/Jaime/Celeste/Your%20Mom
curl -H "Accept: application/json" http://foaas.com/what/jai
curl -H "Accept: application/json" http://foaas.com/outside/Celeste/Jaime
cd collection-ui/
git pull
e
tfd
ti
ta
cd ../stage/
proma
dev
c
ls
ls seed-sla-runner/
mv seed-sla-runner/ sla-runner
cd sla-runner/
ls
e
cd ../reporting-service
e
cd ../sla-runner/
git status
docker run --rm -it python:3.7
docker run --rm -it python:3.7 /bin/bash
docker build -t sla-runner:test .
docker images
docker build -t sla-runner:test .
docker images
docker run --rm sla-runner:test
docker run --rm -it --entrypoint /bin/bash sla-runner:test
git status
python3
docker build -t sla-runner:test .
docker run --rm sla-runner:test sla-runner run --command "/bin/bash /app/test.sh"
docker build -t sla-runner:test .
docker run --rm sla-runner:test sla-runner run --command "/bin/bash /app/test.sh"
docker run --rm sla-runner:test "sla-runner run --command '/bin/bash /app/test.sh'"
docker run --rm sla-runner:test "sla-runner --command '/bin/bash /app/test.sh'"
docker build -t sla-runner:test .
docker run --rm sla-runner:test "sla-runner --command '/bin/bash /app/test.sh'"
docker build -t sla-runner:test .
docker run --rm sla-runner:test "sla-runner --command '/bin/bash /app/test.sh'"
docker run --rm sla-runner:test "sla-runner --command 'sudo /bin/bash /app/test.sh'"
docker build -t sla-runner:test .
docker run --rm sla-runner:test "sla-runner --command 'sudo /bin/bash /app/test.sh'"
docker run --rm sla-runner:test "sla-runner --command '/bin/bash /app/test.sh'"
docker run --rm sla-runner:test "sla-runner --command 'sudo /bin/bash /app/test.sh'"
docker build -t sla-runner:test .
docker run --rm sla-runner:test "sla-runner --command '/bin/bash /app/test.sh'"
docker run --rm sla-runner:test
docker build -t sla-runner:test .
docker run --rm sla-runner:test
docker build -t sla-runner:test .
docker run --rm sla-runner:test
docker build -t sla-runner:test .
docker run --rm sla-runner:test
docker build -t sla-runner:test .
docker run --rm sla-runner:test
docker build -t sla-runner:test .
docker run --rm sla-runner:test
docker build -t sla-runner:test .
docker run --rm sla-runner:test
docker run --rm sla-runner:test sla-runner --command /app/poop.sh
docker run --rm sla-runner:test --command /app/poop.sh
c
docker run --rm sla-runner:test
docker build -t sla-runner:test .
docker run --rm sla-runner:test
ls
cd ../sla-monitor-runner/
ls
mv src/ test_scripts
e
iam-docker-run -h
cd python-nodejs/
cd ..
mv python-nodejs/ node10-python3.6
ls
cd node10-python3.6/
LS
ls
cat Dockerfile 
git status
git init
git remote add origin https://github.com/jairenee/node10-python3.6.git
gcm
git add .
git commit -m "Initial commit"
git push -u origin master
cd env
cd envvars
git pull
cd biscuit-envelope-worker/
e
nslookup ssnj-prodq
telnet ssnj-prodq 5672
cd prod/
ta
...
gcm
cd biscuit-batch-stats-worker/
e
...
cd envvars
gcm
dev
cd envelope-worker/
dev 
cd envvars
cd biscuit-envelope-worker/
e
cd ../biscuit-batch-stats-worker/
e
...
cd envvars
gcm
cd biscuit-envelope-worker/prod/
ta
...
cd biscuit-batch-stats-worker/prod/
ta
pwd
cd ../../biscuit-envelope-worker/prod/
e
ta
telnet ssnj-prodq01 5672
e
ta
pwd
...
gcm
dev
cd envelope-worker/
e
cd ..
cd envvars/biscuit-envelope-worker/prod/
vim prod-ssm.tf 
telnet ssnj-prodq01 5672
curl ssnj-prodq01:15672
..
gcm
..
cd envelope-worker/
gcm
cd ../batch-stats-worker/
gcm
git@ssnj-git01.billtrust.local:billtrust/terraform-validator.git
gcp
e
docker build .
docker images
docker build -t terraformvalid .
ls
docker images
ebr
sbp
docker ps
docker images
dockclean
ls
docker images
docker images | less -S
docker rmi 318722734627.dkr.ecr.us-east-1.amazonaws.com/ar-central/account-service
docker rmi 318722734627.dkr.ecr.us-east-1.amazonaws.com/ar-central/account-service:latest-release
docker images
docker run --rm -it terraformvalid
git clone -b master https://github.com/leon-ai/leon.git leon
cd leon/
npm install
e
docker build -t leon .
docker run --rm -it leon /bin/bash
docker run --rm -it --entrypoint /bin/bash leon
docker build -t leon .
docker run --rm -it --entrypoint /bin/bash leon
cd ..
mcd python-nodejs
vim Dockerfile
docker build -t jairewiz/python-nodejs .
cd ../leon/
docker build -t leon .
docker run --rm leon
docker run --rm -p 80:1337 leon
docker run --rm -p 1337:1337 leon
docker run --rm -p 1337:1337 -p 8889:4242 leon
docker build -t leon .
docker run --rm -p 1337:1337 -p 8889:4242 leon
docker run --rm -p 1337:1337 -p 8889:4242 --entrypoint /bin/bash leon
docker run --rm -it -p 1337:1337 -p 8889:4242 --entrypoint /bin/sh leon
c
docker build -t leon . 
docker run --rm -it -p 1337:1337 -p 8889:4242 leon
docker ocker build -t leon . 
docker build -t leon . 
docker run --rm -it -p 1337:1337 -p 8889:4242 leon
docker run --rm -it -p 1337:1337 -p 8889:4242 --entrypoint /bin/bash leon
docker images
dockclean
docker images
docker run -it --rm jairewiz/python-nodejs
docker run -it --rm --entrypoint /bin/bash jairewiz/python-nodejs
docker build -t leon . 
docker run --rm -it -p 1337:1337 -p 8889:4242 leon
git status
git remote origin set-url https://github.com/jairenee/leon.git
git remote set-url origin https://github.com/jairenee/leon.git
git status
git add .
git commit -m "Upgraded to deepspeech 0.4.1. Created dockerfile."
git push
git checkout develop
git pull
git branch -l
docker pull jairewiz/node10-python3.6
docker images
dockclean
docker images
docker rmi jairewiz/python-nodejs:latest 
docker images
docker run --rm -it -p 1337:1337 -p 8889:4242 leon
ls
cat .env.docker 
vim .env.docker 
cat .env.sample 
cat Dockerfile 
vim Dockerfile 
gcm
c
dev
c
cd envvars
cd biscuit-envelope-worker/
ls
e
cd ../biscuit-batch-stats-worker/
e
cd ../biscuit-envelope-worker/
cd prod/
ti
terraform --version
ebr
ta
cd ../../biscuit-batch-stats-worker/
cd prod/
ti
ta
cd ../..
gcm
gcp
tfp
ti
proma
e
dev
gcp
tfp
ti
dev
cd envelope-worker/
tfp
ta
cd envelope-worker/
e
cd ..
cd batch-stats-worker/
e
tfp
ta
proma
ta
e
ta
dev
cd sla-runner/
ls
cd sla_runner/
ls
cd ..
cd sla-monitor-runner/
ls
gst
e
cd envvars
git status 
gcm
de 
dev
cd envelope-worker/
gs
git status
ebr
dev
cd batch-service
de
dev
cd envvars/arc-document-batch-service/
ls
cd prod/
ls
vim prod-ssm.tf 
code ..
ta
ti
ta
ebr
cd envvars
cd tfvars/
ls
python3
cd sla-monitor-runner/
docker build -t sla-monitor/sla-runner:latest .
iamx
pip install --user iam-starter
iamx
cd terraform/
ls
xdg-open .
export AWS_ENV=dev
AWS_DEFAULT_REGION="us-east-1" iam-starter     --profile $AWS_ENV     --command terraform init && terraform apply --auto-approve
AWS_DEFAULT_REGION="us-east-1" iam-starter     --profile btdev     --command terraform init && terraform apply --auto-approve
export AWS_ENV=btdev
AWS_DEFAULT_REGION="us-east-1" iam-starter     --profile $AWS_ENV     --command terraform init && terraform apply --auto-approve -var 'aws_env=$AWS_ENV'
export AWS_DEFAULT_REGION="us-east-1"
iam-starter     --profile $AWS_ENV     --command terraform init && terraform apply         --auto-approve         -var 'aws_env=$AWS_ENV'         -var 'aws_region=$AWS_DEFAULT_REGION'
iam-starter     --profile $AWS_ENV     --command terraform init && terraform apply         --auto-approve         -var "aws_env=$AWS_ENV"         -var "aws_region=$AWS_DEFAULT_REGION"
iam-starter     --profile $AWS_ENV     --command "terraform init && terraform apply \
        --auto-approve \
        -var \"aws_env=$AWS_ENV\" \
        -var \"aws_region=$AWS_DEFAULT_REGION\""
code ~/.aws/config 
export AWS_ENV="dev"
iam-docker-run --rm     -e "SLARUNNER_COMMAND='/bin/bash /src/test-scripts/run-tests.sh'"     -e "SLARUNNER_SERVICE=example-service"     -e "SLARUNNER_GROUPS='dev-team,critical'"     -e "SLARUNNER_DELAY=30"     -e "SLARUNNER_SNSTOPICARN='arn:aws:sns:us-east-1::bt-prod-sla-monitoring-worker-$AWS_ENV'"     -e "SLARUNNER_S3BUCKETNAME='arn:aws:s3:::bt-prod-sla-monitoring-logs-$AWS_ENV'"     --full-entrypoint "sla-runner"     --region us-east-1     --profile $AWS_ENV     --role sla-monitor-runner-role     --image sla-monitor/sla-runner:latest
iam-docker-run     -e "SLARUNNER_COMMAND='/bin/bash /src/test-scripts/run-tests.sh'"     -e "SLARUNNER_SERVICE=example-service"     -e "SLARUNNER_GROUPS='dev-team,critical'"     -e "SLARUNNER_DELAY=30"     -e "SLARUNNER_SNSTOPICARN='arn:aws:sns:us-east-1::bt-prod-sla-monitoring-worker-$AWS_ENV'"     -e "SLARUNNER_S3BUCKETNAME='arn:aws:s3:::bt-prod-sla-monitoring-logs-$AWS_ENV'"     --full-entrypoint "sla-runner"     --region us-east-1     --profile $AWS_ENV     --role sla-monitor-runner-role     --image sla-monitor/sla-runner:latest
iam-docker-run     -e "SLARUNNER_COMMAND='/bin/bash /src/test-scripts/run-tests.sh'"     -e "SLARUNNER_SERVICE=example-service"     -e "SLARUNNER_GROUPS='dev-team,critical'"     -e "SLARUNNER_DELAY=30"     -e "SLARUNNER_SNSTOPICARN='arn:aws:sns:us-east-1::bt-prod-sla-monitoring-worker-$AWS_ENV'"     -e "SLARUNNER_S3BUCKETNAME='arn:aws:s3:::bt-prod-sla-monitoring-logs-$AWS_ENV'"     --full-entrypoint "sla-runner"     --region us-east-1     --profile $AWS_ENV     --role sla-monitor-runner-role-$AWS_ENV     --image sla-monitor/sla-runner:latest
export AWS_ENV="dev"
export AWS_DEFAULT_REGION="us-east-1"
iam-starter     --profile $AWS_ENV     --command "terraform init && terraform apply \
        --auto-approve \
        -var \"aws_env=$AWS_ENV\" \
        -var \"aws_region=$AWS_DEFAULT_REGION\""
iam-docker-run     -e "SLARUNNER_COMMAND='/bin/bash /src/test-scripts/run-tests.sh'"     -e "SLARUNNER_SERVICE=example-service"     -e "SLARUNNER_GROUPS='dev-team,critical'"     -e "SLARUNNER_DELAY=30"     -e "SLARUNNER_SNSTOPICARN='arn:aws:sns:us-east-1::bt-prod-sla-monitoring-worker-$AWS_ENV'"     -e "SLARUNNER_S3BUCKETNAME='arn:aws:s3:::bt-prod-sla-monitoring-logs-$AWS_ENV'"     --full-entrypoint "sla-runner"     --region us-east-1     --profile $AWS_ENV     --role sla-monitor-runner-role-$AWS_ENV     --image sla-monitor/sla-runner:latest
iam-docker-run     -e "SLARUNNER_COMMAND='/bin/bash /src/test-scripts/run-tests.sh'"     -e "SLARUNNER_SERVICE=example-service"     -e "SLARUNNER_GROUPS='dev-team,critical'"     -e "SLARUNNER_DELAY=30"     -e "SLARUNNER_SNSTOPICARN='arn:aws:sns:us-east-1::sla-monitoring-worker-$AWS_ENV'"     -e "SLARUNNER_S3BUCKETNAME='arn:aws:s3:::sla-monitoring-logs-$AWS_ENV'"     --full-entrypoint "sla-runner"     --region us-east-1     --profile $AWS_ENV     --role sla-monitor-runner-role-$AWS_ENV     --image sla-monitor/sla-runner:latest
cd sla-monitor-runner/
e
dev
cd terraform
e
dev
cd jenkins-aws/
e
ls
cd envvars
ls
git pull
ls
cd biscuit-event-worker/
ls
e
dev
ll
ls | grep event-
gcp
e
tfd
ti
ta
dev
cd envvars
e
cd biscuit-event-worker/stage/
ti
ta
cd user-service-worker/
git status
cd terraform
e
gcp
tfd
ti
terraform init
vim ~/.aws/config 
terraform init
terraform apply
e
terraform apply
terraform destroy
terraform apply
