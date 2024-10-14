# Lab - Automate provisioning virtual servers using Terraform

This lab will guide you through the process of downloading and installing Terraform in your development environment. After which, Terraform will be used to create an EC2 instance in the AWS Learner Lab automatically.

## Pre-requisites

* Your SSH key is generated and added on GitHub


## Instructions
The main tasks for this lab are as follows:
1. Download and install Terraform
2. Cloning the automation repository
3. Initialize Terraform
4. Retreive the AWS access key and secret key
5. Apply Terraform configuration to create Jenkins machine (delivery server)
6. Creating and assigning Elastic IP to your Jenkins EC2 machine

Please note that all the tasks in this lab is performed on the development machine.

## Task 1: Download and install Terraform

1. Open **WSL Terminal**.

2. Enter the following to download and install Terraform.
   ```bash
   wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
   echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
   sudo apt-get update && sudo apt install terraform -y
   ```

3. Verify the installation by entering the following:

   ```bash
   terraform -version
   ```

## Task 2: Cloning the automation repository

1.  Change to your home directory.

    ```bash
    cd /home/ubuntu
    ```
2.  Run the following to clone your own `automation` repository.

    ```bash
    git clone git@github.com:USERNAME/automation
    ```

    NOTE: If you have not clone the course automation repository, please refer to [Lab_0C exercise 7](LAB_0C.md#exercise-7-mirror-repositories-to-your-own-repository) to clone your own repository.

3.  Change the current working directory to the cloned automation directory.

    ```bash
    cd automation
    ```

## Task 3: Initialize Terraform

1. Navigate to the `terraform` directory, run the following to initialize a Terraform working directory.

    ```bash
    cd terraform
    terraform init
    ```

    ![](images/lab5A/terraform-init.png)

## Task 4: Retrieve the AWS access key and secret key

1. Go to the AWS Academy LMS.

2. Click on **AWS Details** at the top right hand corner of the header bar.

3. Click on the **Show** button to reveal the `Access Key` and `Secret Key` and `Session Token`.

   ![](images/lab5A/aws-cli-credentials.png)

4. Copy the `Access Key` and `Secret Key` and `Session Token` values and replace the placeholders in the **variables.tf** file respectively.

   A sample screenshot of the `variables.tf` file is shown below.

   ![](images/lab5A/variables-tf.png)

5. Save the changes to the file.


## Task 5: Apply Terraform configuration to create Jenkins machine (delivery server)

1. Run the following to apply the Terraform configuration.

    ```bash
    terraform apply
    ```

2. Enter **yes** to confirm the action.

   > **TIP**: You can use the command **terraform apply --auto-approve** to apply the changes defined in the Terraform configuration files to the infrastructure without requiring manual confirmation.

3. You should be able to see the output of your created EC2 machine.

   ![](images/lab5A/terraform-deployed.png)

---

Please take a moment to look at the Terraform source code that was used to provision the Delivery Virtual Server (Jenkins).

You can find the Terraform source code in the `automation` repository. Go to the terraform directory and open the file (`main.tf`) for viewing.

---

## Task 6: Creating and assigning Elastic IP to your Jenkins EC2 machine

To create an elastic IP address and associate with your EC2, please follow the steps below.

1. Open the [Amazon EC2 Console](https://console.aws.amazon.com/ec2/).

2. In the navigation pane, choose **Network & Security**.

3. Choose **Elastic IPs**.

4. Choose **Allocate Elastic IP address**.

5. Leave the settings as default.

6. Click **Allocate** button.

7. Select the Elastic IP address to asosociate and choose **Actions** followed by **Associate Elastic IP Address**.

8. For Resource type, leave it as Instance.

9. For the Instance field, just click on it and choose the EC2 machine with name `jenkins`.

10. Click **Associate**.

    A sample screenshot of the settings.

    ![](images/lab5A/associate-eip.png)

11. You will notice that your EC2 IP address is now associated with the elastic IP address.

    ![](images/lab5A/ec2-eip.png)


12. Please take note of the elastic IP address. It will be used in the subsequent labs to automatically configure the EC2 instance by using Ansible.

---

**Congratulations!** You have completed the lab exercise. Move on to the next exercise for configuring the EC2 instance using Ansible.