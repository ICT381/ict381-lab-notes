# Lab - GitHub

Please note that following:

* Task 1 to 5 are to be done using your own private repository.
* Task 6 is to learn the basic commands while interacting with Git
* Task 7 is used in your GBA assignment.
* Task 8 is to familiarize yourself with Git in VSCode.

## Task 1: Signing up for a new personal account

1. Navigate to [https://github.com/](https://github.com/)

2. Click **Sign Up**.

3. During sign up, you will be asked to provide your email address. Please register using your SUSS email account.

4. Follow on-screen prompts to create your personal account

## Task 2: Setting up username and email address in Git

1. Open a **Terminal**.

2. Set your Git username.

   ```bash
   git config --global user.name GIT_USERNAME
   ```

   > NOTE: Replace GIT_USERNAME with the real value of your git username.

3. Set your Git email.

   ```bash
   git config --global user.email EMAIL_ADDRESS
   ```

   > NOTE: Replace EMAIL_ADDRESS with the real value of your email address

4. To confirm that you have set your Git username and email correctly, enter the following command:

   ```bash
   git config --global --list
   ```

## Task 3: Create repository on Github

Learn how to create a new repository on Github website.

1. Visit GitHub and login to your own account.

2. In the upper-right corner of any page, select + , then click **New Repository**.

3. Enter a short memorable name for your repository.

4. Optionally, add a description for your repository.

5. For repository visibility, choose **Private**.

6. Click **Create repository**.

Using the above steps, please create **6** empty repositories with the following given names.

*  StaycationX
*  automation
*  myReactApp
*  OneMap-API
*  ReactTutorial
*  JS_NOTEBOOK

## Task 4: GitHub SSH Keys

SSH keys provides a secure and efficient means of accessing GitHub without providing your username and personal access token (PAT). You can generate a SSH key and add the public key to your Github account to establish a secure connection between your computer and Github.

1. In the terminal, please enter the following command to generate a pair of SSH keys.

   ```bash
   ssh-keygen -t rsa
   ```
   Please press **Enter** to accept defaults for the prompt.

### Add SSH keys to GitHub

1. Login to your GitHub account.

2. Click on your profile picture in the top right corner and select **Settings**.

3. In the **Access** section of the sidebar, click **SSH and GPG keys**.

4. Click **New SSH key**.

5. In the **Title** field, add a descriptive label for the new key.

6. For key type, select **Authentication Key**.

7. In the **Key** field, paste the contents of the public key. 

   > NOTE: The public key is stored in /home/ubuntu/.ssh folder. The file name for the public key is `id_rsa.pub`.
   

8. Click **Add SSH key**.

9. You should be able to view that your key is added successfully if there is no error.

Use `ssh-keyscan` command to scan SSH public host key of GitHub and append it to the `known_hosts` file located in your home .ssh directory. This file helps secure your SSH connections by verifying the identity of the server you are connecting to.

```bash
ssh-keyscan github.com > /home/ubuntu/.ssh/known_hosts
```

## Task 5: Mirror repositories to your own repository

To create a copy of the course repositories under your account with write access, here are the required steps.

1. In your terminal, enter the following commands:

   ```
   git clone --bare GIT_REPO
   cd REPO_DIR
   git push --mirror NEW_GIT_REPO
   cd ../
   rm -rf REPO_DIR
   ```

   For example to clone and mirror the StaycationX repository:

   ```bash
   git clone --bare git@github.com:ict381/StaycationX
   cd StaycationX.git
   git push --mirror git@github.com:GIT_USERNAME/StaycationX #(push to new repository created under Exercise 3)
   cd ../
   rm -rf StaycationX.git
   ```

   In order to save time, a script named `mirror-repo.sh` has been provided for your convenience. Before you run the script, please note that:

   * You need to insert your own Git user name on Line 11
   * On Line 20, the cloned directory is set to your home folder by default. If you want to use a different location, change the path there.

      ```bash
      # To run the script file
      git clone git@github.com:ict381/ict381-lab-notes
      cd ict381-lab-notes/scripts
      ./mirror-repo.sh
      ```

2. To access the mirror-ed repository, follow the steps:

   ```bash
   # Assuming the cloned directories is at the home folder

   cd /home/ubuntu/<MIRRORED_REPO> # For Ubuntu users
   cd /Users/USERNAME/<MIRRORED_REPO> # For MAC users
   ```

## Task 6: Basic Github Commands

To get started with Git, these are the most commonly used commands that you need to know.

* git init: Used to initialize a new git repository
 
* git add: Used to add files to the staging area for commit

* git commit -m "message": Used to commit staged changes

* git remote add <variable name><url>: Connects your local repository to the remote server.

* git push: Sends the committed changes from local to the remote repository.

* git pull: Fetch and merge changes from the remote repository to local repository.

* git log: List the version history for the current branch.

* git clone [url]: Retrieve an entire repository from a hosted location via URL

* git branch: List your branches.

* git switch -c [branch] / git checkout -b [branch]: Creates and switches to the new branch.

* git switch [branch] / git checkout [branch]: Switch to the specified branch.

* git merge [branch]: Merge the specified branch's history into the current one.


## Task 7: How to create Pull requests?

Pull requests allows you to share work you have done on a branch with your team mates, potentially gather feedback on the work and finally integrate that work into the project.

The pull request process can be broken into several steps.

1. Create a branch of the repository locally and add your work by making commits on the new branch.
2. Push the new branch to Github.
3. Create a pull request on Github.
4. Get the pull request reviewed by the assigned personnel and potentially get feedback.
5. Get the pull request approved.
6. Merge the pull request.
7. Delete the branch created from Step 1.
8. Pull the changes to sync your local repository with the remote repository.

To get started, you may create a dummy repository and use it as a starting point for this practice.

In this example, a repository named demo_pull is created on Github.

After which, please complete the first two steps.

A sample reference to start off for the first two steps.
```bash
git init -b main
echo 'Add Red' > rainbow.txt # add some dummy text
git add rainbow.txt # add file to staging area for commit 
git commit -m "first upload"
git remote add origin git@github.com:USERNAME/demo_pull.git
git push -u origin main 
git switch -c feature1 # create and switch to the new branch called feature1
echo 'Add Olive' > rainbow.txt
git add rainbow.txt
git commit -m "add color"
git push -u origin feature1 # push the changes to the feature1 branch

```
#### From Web (Github)

Assuming you have completed the first two steps. To open a pull request, follow the steps.

1. Click **Compare & pull request** to create a pull request for the associated branch.

   ![](images/lab0C/create-pull-request.png)

2. NOTE: Use the base branch dropdown menu to select the branch that you would like to merge your changes into, then use the compare branch drop-down menu to choose the branch where you made your changes in.
3. Enter a title and description for your pull request.
4. Under the **Reviewers** section, click on the gear icon and select from the list of reviewer(s) that you are asking to review the change.
5. To create a pull request that is ready for review, click **Create pull request**.

   ![](images/lab0C/open-pull-request.png)

6. You should see the message that review is required and merging is blocked.

---

Next, please get the reviewer to login to review the changes.

---
7. Click on the notification box icon (which is just beside the your profile logo).

   ![](images/lab0C/notification-box.png)

8. Click on the record that says review requested.
9. Click on **Add your review** button.

   ![](images/lab0C/add-review.png)

10. You can add your comments on a particular line by clicking on the blue + icon.
11. After you have completed your review, click on the **Review changes** button.
12. Write a review comment and click on the relevant button followed by clicking the **Submit review** button. In this example, select the `Approve` button.

    ![](images/lab0C/approve-pr.png)

13. Now, when the changes are approved. you can merge the pull request. Click on **Merge pull request** button.

    ![](images/lab0C/merge-pull-request.png)

14. Click **Confirm merge** to merge it.

15. Once successfully merged, you are presented the option to delete the branch.

16. Click **Delete branch** to delete the branch.

    ![](images/lab0C/delete-branch.png)

17. Remember to do the following back at your local repository.

    ```bash
    # switch back to main to pull the changes to synchronise the repositories
    git switch main
    git pull
    # to remove the deleted branch from your local repository that was deleted from remote repository
    git fetch -p
    # remove local branch from your repository
    git branch -d <local branch name>
    ```

## Task 8: Using Git in VSCode

VSCode has integrated source control management (SCM) and includes Git support out-of-the-box.

Refer to the documentation links provided to familiarize yourself on how to use Git in VSCode.

-  [SCM Overview](https://code.visualstudio.com/docs/sourcecontrol/overview)
-  [Introduction to Git](https://code.visualstudio.com/docs/sourcecontrol/intro-to-git)
-  [Collaborate on GitHub](https://code.visualstudio.com/docs/sourcecontrol/github)



--- 

### References:

1. [Learning Git by Anna Skoulikari](https://learning.oreilly.com/library/view/learning-git/9781098133900/)
2. [GitLab Cheatsheet](https://about.gitlab.com/images/press/git-cheat-sheet.pdf)

---

Congratulations! Hope these exercise will enhance your understanding of Git.