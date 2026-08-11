# Azure Lab Services

This article will provide detailed information about Azure Lab Services.

## Prerequisites

Before you begin:

1. Check your inbox for an invitation email from Microsoft about Azure Lab Services.
2. Accept the invitation and click the link to redeem your virtual machine.
3. If you did not receive the invitation email, refer to the discussion forum on Canvas to register and get access.

## Accessing and starting your virtual machine

1. Login to [Azure Lab Services](https://labs.azure.com) to access your virtual machine.

2. Your assigned virtual machine will be displayed.

   ![](images/als/step1c.png)

3. Toggle the switch to start your virtual machine.

   ![](images/als/step1d.png)

4. Allow some time for the virtual machine to get started and running.

5. After the virtual machine is up and running, click the blue desktop icon. You'll see two options to connect to the virtual machine.

   ![](images/als/step1f.png)


## Connecting to the virtual machine via SSH

Connecting to the virtual machine via SSH does not require downloading any third-party software. Windows users can utilize the built-in Command Prompt or PowerShell, while MAC users can use the terminal to securely access the virtual machine.

SSH is used mainly for terminal access or for troubleshooting the virtual machine when GUI is not available.

1. Click on **Connect via SSH**.

2. You will presented with the sample information.

   ![](images/als/step2b.png)

3. Copy the SSH command shown in the box and paste it on PowerShell/Command Prompt/Terminal.

4. For the first time when you connect, you will encounter the message "authenticity of host can't be established", enter **yes** to continue connecting.

5. Enter the Ubuntu login credentials to continue.

6. If the login is successful, you will get the Ubuntu welcome screen.

## Connecting to the virtual machine via RDP (For Windows)

To connect to the virtual machine via RDP:

1. Click on **Connect via RDP**.

2. An RDP file will be downloaded to your computer.

3. Double click on the RDP file to open it.

4. On the Remote Desktop Connection prompt, click **Yes**.

   ![](images/als/step3d.png)

5. Please enter your login credentials for the virtual machine.

   ![](images/als/step3e.png)
   
   The default login credential for the virtual machine. <br>
   username: ubuntu <br>
   password: ICT381ubuntu

6. Upon successful login, the virtual machine desktop will be shown.

## Installing Microsoft Remote Desktop (For MAC)

MAC users should install the Windows App application, which is crucial for connecting to the remote virtual machine.

* Open App Store on your MAC and search for **Windows App**.

  > NOTE: Please take note of the compatability version of this application. It requires macOS 14.0 and above.

  [https://apps.apple.com/us/app/microsoft-remote-desktop/id1295203466](https://apps.apple.com/us/app/microsoft-remote-desktop/id1295203466)

  ![](images/als/step4a.png)

* Install Windows App application.

  ![](images/als/step4b.png)

## Connecting to your virtual machine via RDP (For MAC)

To connect to the virtual machine via RDP:

1. Double click on the downloaded RDP file to open it.

2. There will be a prompt message saying that the identity of the remote PC can't be verified. Click **Connect** to proceed.

   ![](images/als/step5b.png)

3. Please enter your login credentials for the virtual machine.

   ![](images/als/step3e.png)

   The default login credential for the virtual machine: <br>
   username: ubuntu <br>
   password: ICT381ubuntu

4. Upon successful login, the virtual machine desktop will be shown.

   ![](images/als/step5d.png)

## Stopping your virtual machine

Please return to Azure Lab Services page on Canvas and use the toggle button to shutdown the virtual machine. This is the only method to ensure the virtual machine is turned off, thereby conserving your quota hours.

* On ALS page in Canvas, toggle the button to turn off the running virtual machine.

  ![](images/als/step6a.png)

* Ensure the virtual machine is in a **Stopped** state before closing the web browser.

  ![](images/als/step6b.png)


## Viewing your quota hours

In the virtual machine details, you can view the following information:

* Total quota hours allocated
* Quota hours utilized
* Remaining quota hours

    ![](images/als/step8a.png)


## Login Credentials

Students are <font color="red"><u>**strongly advised**</u></font> to change their password upon the first login to prevent unauthorized access to their machine.

**Virtual Machine Login Details** <br>
<u>Azure Lab Services (Ubuntu-22.04)</u><br>
username: ubuntu <br>
password: ICT381ubuntu

Users can use the command `passwd` to change their password.

## Quota System

* Students will be assigned 20 hours per week for the first 6 weeks, followed by 30 hours per week for the remainder of the course. These hours will cover class sessions, virtual labs, independent practice and assignments.

* Quotas will be replenished progressively every Monday at 6pm.

* Unused hours will be forfeited at the end of each week.

* **Illustration**:
    * In Week 2, if student A uses 5 out of 20 hours. The remaining 15 hours will be forfeited. In Week 3, 20 hours will be added to the 5 hours used in Week 2, giving the student a total quota of 25 hours.

* Shutting down the Ubuntu virtual machine does not stop the user quota hours.
    * Students are reminded to turn off the virtual machine from the Azure page in Canvas to avoid continuing to incur user quotas.

* The virtual machine will be automatically shutdown once the user quotas are exhausted.

* For additional quota hours due to genuine needs (eg. extra practice/assignment):
    * Please send a request to your instructor, including the reasons and copy Administrator (hltoh@suss.edu.sg). Requests will reviewed on a case-by-case basis and additional hours will be granted if approved.

## Resizing RDP Virtual Desktop Screen (For Windows)

For Windows user, you can take advantage of automatic screen resizing by using Windows App, which is available for download in Microsoft Store. For MAC users, the Windows App already includes this feature.

After you have turned on the virtual machine, retrieve your connection information. You can do so by clicking on the 3 dots at the right-hand side of the virtual machine and click show RDP information.

![](images/als/resize-rdp-info.png)

You should get a screen that resembles this sample screenshot.

![](images/als/resize-rdp-info-box.png)

Press the copy button to copy the information. Next, open **Windows App** and choose **Add a remote PC** > **Add a device** > **Choose a resource to add**.

Follow the steps below:

*  Click **Additional Settings**.
*  Paste the information you retrieved into the PC name field.
*	In the Display Name field, you can consider entering the course code for easier identification of the machine.
*  On the left horizontal menu, click Display.
*	Ensure the buttons are toggled to turn on for these 2 options.
      *  Fit session to window
      *  Single display when in windowed mode
*  Click **Add & Connect**.

You will be prompted to login using your credential.

After logging in successfully, you should be able to see your virtual desktop.

You can adjust the screen sizing to your own preference by the following steps:

1. If you are in a full screen mode, move your mouse cursor to the top and click on the second button (Restore down button) on the top right-hand corner to exit full screen mode.
2. Once you have exited the full screen, you can click on the top bar and drag left or right. It should now be in a windowed mode.
3. You can then adjust the window by dragging its edges. The virtual desktop screen will automatically resize to match the window.

On the subsequent visit, you can just double click the virtual machine to connect to it directly. There is no need for you to add the virtual machine again.

## IT Support

If you have any questions or encounter any problems, please seek clarification through the discussion forum on Canvas. Alternatively, you may contact the administrator via email at hltoh@suss.edu.sg for further support.