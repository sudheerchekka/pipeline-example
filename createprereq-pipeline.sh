#!/bin/sh
oc new-project cicd
oc create -f pipeline.yml 

#development
oc new-project development
oc policy add-role-to-user edit system:serviceaccount:cicd:jenkins -n development

oc new-app nodejs~https://github.com/sudheerchekka/nodejs-welcome.git --name=welcome
oc expose svc welcome

#testing
oc new-project testing
oc policy add-role-to-user edit system:serviceaccount:cicd:jenkins -n testing
oc policy add-role-to-group system:image-puller system:serviceaccounts:testing -n development

#oc create deploymentconfig welcome --image="$1":5000/development/welcome:promoteToQA
#oc create dc welcome --image=welcome/promoteToQA
#oc expose dc welcome --port=8080
#oc expose svc welcome

