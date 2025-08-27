# Lab - Running ReactJS as the API frontend for StaycationX

In this lab, we will be setting up and running ReactJS as the API frontend for StaycationX application. We will also be integrating OneMap API to display static map images of hotels in Singapore.

## Instructions
The main tasks for this lab are as follows:
1. Create OneMap API account
2. Clone myReactApp Repo
3. Install NodeJS and React JS
4. Run the ReactJS app
5. Interact with the app for StaycationX API
6. Interact with the app for OneMap API

## Task 1: Create OneMap API account

1. Visit the [OneMap API Registration](https://www.onemap.gov.sg/apidocs/register) website.

2. Fill in all the necessary details and click **Register**.

3. Under the **Confirm your OneMap API account** page, please do the following:

    - Check your email inbox for the **Confirmation Code**.
    - Create your own password that fufills the criteria that is listed on the website.
    - Click **Register**.

4. You should get the **Registration Sucessful!** message.

   ![](images/lab1B/onemap-register-successful.png)


## Task 2: Clone myReactApp Repo

1. Open a **Terminal**.

2. Clone `myReactApp` repository.

    ```bash
    cd /home/ubuntu/
    git clone git@github.com:GIT_USERNAME/myReactApp
    ```

## Task 3: Install NodeJS and React JS

Open a terminal and follow the steps given.

1. Download and run the Node.js setup script.

    ```bash
    curl -sL https://deb.nodesource.com/setup_16.x -o nodesource_setup.sh
    chmod +x nodesource_setup.sh
    sudo ./nodesource_setup.sh
    rm -rf nodesource_setup.sh
    ```
2. Install Node.js.

    ```bash
    sudo apt install nodejs -y
    ```

3. You can verify the installation by checking the version of Node.js and npm.

    ```bash
    node -v
    npm -v
    ```

4. Navigate to the myReactApp directory.

    ```bash
    cd /home/ubuntu/myReactApp
    ```

5. Install package dependencies for application.

    ```bash
    npm install
    ```

## Task 4: Run the ReactJS app

1. To start myReactApp, run this command.

    ```bash
    npm start
    ```

2. The web browser will automatically open and navigate to `http://localhost:3000`.

   ![](images/lab1B/react-app.png)

## Task 5: Interact with the app for StaycationX API

**NOTE**: Before you start, please ensure that the StaycationX application is running.

1. On the home page, click on the **STX** button.

2. Enter the credential to access the StaycationX API.

   ![](images/lab1B/stx-login.png)

3. After logging in successfully, you will be able to view the listings of all packages.

   ![](images/lab1B/stx-show-packages.png)

## Task 6: Interact with the app for OneMap API

1. On the home page, click on the **OM** button.

2. Enter the credential that you have registered in Task 1 to access the OneMap API.

   ![](images/lab1B/om-login.png)

3. After logging in successfully, you will be able to search static map using OneMap API.

   ![](images/lab1B/om-search-map.png)

4. You can search for any hotel name in Singapore. For instance `Singapore Marriott Tang Plaza Hotel`.

   ![](images/lab1B/om-search-result.png)

---

**Congratulations!** You have completed the lab exercise.