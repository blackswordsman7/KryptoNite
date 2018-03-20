# Property Management System (Land resource powered by blockchain)

### Pre-requisities

### Step 1: Install the CLI tools

* Install the most essential core operation - `composer-cli`

       `   npm install -g composer-cli  `

* Utility - running a REST Server on your machine to expose your business networks as RESTful APIs - `generator-hyperledger-composer`

        `  npm install -g composer-rest-server `
* Utility - generating application assets - `composer-rest-server`

        ` npm install -g generator-hyperledger-composer `
* Utility - " Yeoman " Tool for generating applications - ` generator-hyperledger-composer`

        ` npm install -g yo `
        
### Step 2: Install Playground

"Playground" is a development machine available locally, giving you a UI for viewing and demonstrating the networks.

        ` npm install -g composer-playground `
### Step 3: Set up your IDE

We will be using `VSCode`, because a Composer extension is available.

1. Click here to Download - [`VScode`]( https://code.visualstudio.com/download)
2. Open `VSCode`, go to Extensions, then search for and install the `Hyperledger Composer extension` from the Marketplace.

### Step 4: Install Hyperledger Fabric

This step will help us to get a local Hyperledger Fabric runtime to deploy our business networks to.

1. In a directory of your choice (we will assume ~/Property), get the .zip file that contains the tools to install Hyperledger Fabric:
       ` mkdir ~/Property && cd ~/Property 

        curl -O https://raw.githubusercontent.com/hyperledger/composer-tools/master/packages/fabric-dev-servers/fabric-dev-servers.zip
    unzip fabric-dev-servers.zip`
    
2. A tar.gz is also available if you prefer: just replace the .zip file with fabric-dev-servers.tar.gz1 and the unzip command with a tar xvzf command in the above snippet.

    Use the scripts you just downloaded and extracted to download a local Hyperledger Fabric runtime:

     `
    cd ~/fabric-tools
    ./downloadFabric.sh`
    
**Congratulations, you've now installed everything required for the typical Developer Environment. Read on to learn some of the most common things you'll do with this environment to develop and test your Blockchain Business Networks. **   
   
If you face any problem - Follow this [link](https://hyperledger.github.io/composer/installing/development-tools.html).
