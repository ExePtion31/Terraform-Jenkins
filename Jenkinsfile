pipeline {
    agent any

    parameters {
        string(name: 'environment', defaultValue: 'aws', description: 'Workspace/environment file to use for deployment')
        booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply after generating plan?')

    }


     environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }

    stages {
        stage('checkout') {
            steps {
                 script{
                        dir("terraform")
                        {
                            git "https://github.com/ExePtion31/Terraform-Jenkins"
                        }
                    }
                }
            }

        stage('Set Terraform Path'){
            steps {
                script {
                    def tfHome = tool name: 'Terraform'
                    env.PATH = "${tfHome}:${env.PATH}"
                }
            bat 'terraform --version'    
            }
        }

        stage('Provision infrastructure') {
            steps {
                dir('dev')
                {
                    bat 'terraform init'
                    /*sh 'pwd;cd terraform/Terraform-Jenkins ; terraform workspace new ${environment}'
                    sh 'pwd;cd terraform/Terraform-Jenkins ; terraform workspace select ${environment}'
                    sh "pwd;cd terraform/Terraform-Jenkins ;terraform plan -input=false -out tfplan "
                    sh 'pwd;cd terraform/Terraform-Jenkins ;terraform show -no-color tfplan > tfplan.txt'*/
                }
            }
        }
        stage('Approval') {
           when {
               not {
                   equals expected: true, actual: params.autoApprove
               }
           }

           steps {
               script {
                    def plan = readFile 'terraform/Terraform-Jenkins/tfplan.txt'
                    input message: "Do you want to apply the plan?",
                    parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
               }
           }
       }

        stage('Apply') {
            steps {
                sh "pwd;cd terraform/Terraform-Jenkins ; terraform apply -input=false tfplan"
            }
        }
    }

  }