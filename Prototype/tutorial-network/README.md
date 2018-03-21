# Property Management System (Land resource powered by blockchain)

Before beginning this tutorial:

1. [Set up your development environment](https://github.com/thesachinmittal/KryptoNite/blob/master/Prototype/tutorial-network/Pre-requisities.md)
2. Install an editor e.g. VSCode or Atom
 
## Step One - Creating a business network structure

Business network definition (BND)- It defines the data model, transaction logic and access control rules for your blockchain solution. To create a BND, we need to create a suitable project structure on disk.

1. Create a skeleton business network using Yeoman. This command will require a business network name, description, author name, author email address, license selection and namespace.

        `yo hyperledger-composer:businessnetwork`
2. Enter `tutorial-network` for the network name, and desired information for description, author name, and author email.
3. Select `Apache-2.0` as the license.
4. Select `org.acme.biznet` as the namespace.

## Step Two: Defining a business network

A business network is made up of assets, participants, transactions, access control rules, and optionally events and queries. In the skeleton business network created in the previous steps, there is a model (.cto) file which will contain the class definitions for all assets, participants, and transactions in the business network. The skeleton business network also contains an access control (permissions.acl) document with basic access control rules, a script (logic.js) file containing transaction processor functions, and a package.json file containing business network metadata.
Modelling assets, participants, and transactions

The first document to update is the model (.cto) file. This file is written using the Hyperledger Composer Modelling Language. The model file contains the definitions of each class of asset, transaction, participant, and event. It implicitly extends the Hyperledger Composer System Model described in the modelling language documentation.

    Open the org.acme.biznet.cto model file.

    Replace the contents with the following:
    Copy

    /**
     * My commodity trading network
     */
    namespace org.acme.biznet
    asset Commodity identified by tradingSymbol {
        o String tradingSymbol
        o String description
        o String mainExchange
        o Double quantity
        --> Trader owner
    }
    participant Trader identified by tradeId {
        o String tradeId
        o String firstName
        o String lastName
    }
    transaction Trade {
        --> Commodity commodity
        --> Trader newOwner
    }

    Save your changes to org.acme.biznet.cto.

Adding JavaScript transaction logic

In the model file, a Trade transaction was defined, specifying a relationship to an asset, and a participant. The transaction processor function file contains the JavaScript logic to execute the transactions defined in the model file.

The Trade transaction is intended to simply accept the identifier of the Commodity asset which is being traded, and the identifier of the Trader participant to set as the new owner.

    Open the logic.js script file.

    Replace the contents with the following:
    Copy

    /**
     * Track the trade of a commodity from one trader to another
     * @param {org.acme.biznet.Trade} trade - the trade to be processed
     * @transaction
     */
    function tradeCommodity(trade) {
        trade.commodity.owner = trade.newOwner;
        return getAssetRegistry('org.acme.biznet.Commodity')
            .then(function (assetRegistry) {
                return assetRegistry.update(trade.commodity);
            });
    }

    Save your changes to logic.js.

Adding access control

    Create a permissions.acl file in the tutorial-network directory.

    Add the following access control rules to permissions.acl:
    Copy

    /**
     * Access control rules for tutorial-network
     */
    rule Default {
        description: "Allow all participants access to all resources"
        participant: "ANY"
        operation: ALL
        resource: "org.acme.biznet.*"
        action: ALLOW
    }

    rule SystemACL {
      description:  "System ACL to permit all access"
      participant: "ANY"
      operation: ALL
      resource: "org.hyperledger.composer.system.**"
      action: ALLOW
    }

    Save your changes to permissions.acl.

### Step Three: Generate a business network archive

Now that the business network has been defined, it must be packaged into a deployable business network archive (.bna) file.

    Using the command line, navigate to the tutorial-network directory.

    From the tutorial-network directory, run the following command:
    Copy

    composer archive create -t dir -n .

After the command has run, a business network archive file called tutorial-network@0.0.1.bna has been created in the tutorial-network directory.
Step Four: Deploying the business network

After creating the .bna file, the business network can be deployed to the instance of Hyperledger Fabric. Normally, information from the Fabric administrator is required to create a PeerAdmin identity, with privileges to deploy chaincode to the peer. However, as part of the development environment installation, a PeerAdmin identity has been created already.

After the runtime has been installed, a business network can be deployed to the peer. For best practice, a new identity should be created to administrate the business network after deployment. This identity is referred to as a network admin.
Retrieving the correct credentials

A PeerAdmin business network card with the correct credentials is already created as part of development environment installation.
Deploying the business network

Deploying a business network to the Hyperledger Fabric requires the Hyperledger Composer chaincode to be installed on the peer, then the business network archive (.bna) must be sent to the peer, and a new participant, identity, and associated card must be created to be the network administrator. Finally, the network administrator business network card must be imported for use, and the network can then be pinged to check it is responding.

    To install the composer runtime, run the following command:
    Copy

    composer runtime install --card PeerAdmin@hlfv1 --businessNetworkName tutorial-network

    The composer runtime install command requires a PeerAdmin business network card (in this case one has been created and imported in advance), and the name of the business network.

    To deploy the business network, from the tutorial-network directory, run the following command:
    Copy

    composer network start --card PeerAdmin@hlfv1 --networkAdmin admin --networkAdminEnrollSecret adminpw --archiveFile tutorial-network@0.0.1.bna --file networkadmin.card

    The composer network start command requires a business network card, as well as the name of the admin identity for the business network, the file path of the .bna and the name of the file to be created ready to import as a business network card.

    To import the network administrator identity as a usable business network card, run the following command:
    Copy

    composer card import --file networkadmin.card

    The composer card import command requires the filename specified in composer network start to create a card.

    To check that the business network has been deployed successfully, run the following command to ping the network:
    Copy

    composer network ping --card admin@tutorial-network

The composer network ping command requires a business network card to identify the network to ping.
### Step Five: Generating a REST server

Hyperledger Composer can generate a bespoke REST API based on a business network. For developing a web application, the REST API provides a useful layer of language-neutral abstraction.

    To create the REST API, navigate to the tutorial-network directory and run the following command:
    Copy

    composer-rest-server

    Enter admin@tutorial-network as the card name.

    Select never use namespaces when asked whether to use namespaces in the generated API.

    Select No when asked whether to secure the generated API.

    Select Yes when asked whether to enable event publication.

    Select No when asked whether to enable TLS security.

The generated API is connected to the deployed blockchain and business network.
       
