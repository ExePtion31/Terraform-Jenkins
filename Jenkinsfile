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
                        bat "terraform init -backend-config='access_key=$ACCESS_KEY' -backend-config='secret_key=$SECRET_KEY'"
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

        stage('TerraformApply'){
            steps {
                dir('jenkins-terraform-pipeline/ec2_pipeline/'){
                    bat 'terraform apply' 
                }
            }
        }
    }
}