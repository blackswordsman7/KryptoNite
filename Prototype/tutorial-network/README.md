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
       
       
