pipeline {
    agent any
    tools {
        "org.jenkinsci.plugins.terraform.TerraformInstallation" "Terraform"
    }
    parameters {
        string(name: 'WORKSPACE', defaultValue: 'development', description:'setting up workspace for terraform')
    }
    environment {
        TF_HOME = tool('Terraform')
        TP_LOG = "WARN"
        PATH = "$TF_HOME:$PATH"
        ACCESS_KEY = credentials('AWS_ACCESS_KEY_ID')
        SECRET_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }
    stages {
            stage('TerraformInit'){
            steps {
                dir('jenkins-terraform-pipeline/ec2_pipeline/'){
                    bat "terraform init -backend-config='$ACCESS_KEY' -backend-config='secret_key=$SECRET_KEY'"
                    bat "echo \$PWD"
                    bat "whoami"
                }
            }
        }

        stage('TerraformFormat'){
            steps {
                dir('jenkins-terraform-pipeline/ec2_pipeline/'){
                    bat "terraform fmt -list=true -write=false -diff=true -check=true"
                }
            }
        }

        stage('TerraformValidate'){
            steps {
                dir('jenkins-terraform-pipeline/ec2_pipeline/'){
                    bat "terraform validate"
                }
            }
        }

        stage('TerraformPlan'){
            steps {
                dir('jenkins-terraform-pipeline/ec2_pipeline/'){
                    bat "terraform plan -var 'access_key=$ACCESS_KEY' -var 'secret_key=$SECRET_KEY' \
                    -out terraform.tfplan;echo \$? > status"
                    stabat name: "terraform-plan", includes: "terraform.tfplan"
                }
            }
        }
        
        stage('TerraformApply'){
            steps {
                script{
                    def apply = false
                    try {
                        input message: 'Can you please confirm the apply', ok: 'Ready to Apply the Config'
                        apply = true
                    } catch (err) {
                        apply = false
                         currentBuild.result = 'UNSTABLE'
                    }
                    if(apply){
                        dir('jenkins-terraform-pipeline/ec2_pipeline/'){
                            unstabat "terraform-plan"
                            bat 'terraform apply terraform.tfplan' 
                        }
                    }
                }
            }
        }
    }
}