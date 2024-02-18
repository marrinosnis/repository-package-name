# repository-package-name
<p align="center">
<img src="images/graphQL_logo.png" alt="image" width="200px" height="100">
<img src="images/shell_script_logo.jpeg" alt="image" width="200px" height="auto"> &nbsp; &nbsp;
</p>

![bash-script-tests](https://github.com/marrinosnis/repository-package-name/actions/workflows/run-tests.yaml/badge.svg)
## Use GraphQL with Bash Script to find and store the Package name of a repository

### References
This script is used to retrieve the package name from a specific repository, using the GitHub's GraphQL API. More info about GitHub's graphQL 
in this link: [GraphQL API Documentation](https://docs.github.com/en/graphql). Also, there is the GitHub Explorer where you write and test 
your GraphQL queries to the GitHub. More information can be found at the following link: [GraphQL Explorer](https://docs.github.com/en/graphql/overview/explorer).

### Execution of the script

1) In order to use the script, simpy clone the current repo or download as `zip` file the code and extract the content. 
   Inside the folder <ins>**repository-package-name**</ins> there is the main shell script with
   the name `findRepoPackageName.sh`, and some other files.

2) The script takes `3 arguments` in order to work properly:\
 `pathToFolder`: which is the path to the project from the Github, from which you want to retrieve the name of package.\
 `owner`: which is the owner of the repository. It could be an organisation or personal account.\
 `inputToken`: a properly configured token from Github which has at least the scope of `write:packages`, otherwise the API call will not work.

 Below there is a board of the possible outcomes for using the `findRepoPackageName.sh`:

| **arguments**                          | **example**                                                                                   | **outcome**                                                                                                          |
|----------------------------------------|-----------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------|
| *none*                                 | ./findRepoPackageName                                                                         | You should provide the path, the owner of the repo and the token with the correct access rights                      |
| pathToProject ownerName                | ./findRepoPackageName <ins>pathToProject</ins> <ins>username</ins>                            | You should provide the token with the correct access rights as the third argument                                    |
| All arguments provided but not correct | ./findRepoPackageName <ins>pathToProject</ins> <ins>username</ins>  <ins>*wrongToken*</ins>   | The script will return an empty answer, as it couldn't find any packages with those credentials (the token is wrong) |
| All arguments are correct              | ./findRepoPackageName <ins>pathToProject</ins> <ins>username</ins>  <ins>*correctToken*</ins> | The script will return the package name that it is in the repo that was provided from the path previously            | 
    
### Execute tests locally

In case you want to run the tests locally make sure the `shunit2` tool is installed in your machine. To check if it is already installed you can open a new terminal window and execute 
   the following command:
```commandline
$ cat $(which shunit2) | grep "SHUNIT_VERSION"
```
If it is <ins>installed</ins> you will get the following message:
> command [ -n "${SHUNIT_VERSION:-}" ] && exit 0\
 SHUNIT_VERSION='2.1.8'

If it is <ins>not installed</ins> you will get the following message:
> shunit2 not found

In order to install it on Ubuntu or MacOS software environment, you may use the following command in a new terminal window:\
`Linux\Ubuntu`
```
$ sudo apt-get update
$ sudo apt-get -y install shunit2
```

`MacOS`

```
$ brew install shunit2
```
> [!IMPORTANT]  
> The tool `brew` is assumed that it is already installed in MacOS machine.

After the `shunit2` tool is properly installed in your machine, to run the tests follow the steps below:
1) From the root path of the current project execute the following command:
>./tests/test.sh . <ins>username</ins> <ins>githubToken</ins> <ins>com.test-package.using-java-maven</ins>

Replace the <ins>username</ins> with yours, and the <ins>githubToken</ins> with the one that you created and at least
has the `write:packages` scope.\
The <ins>com.test-package.using-java-maven</ins> is a package that was created for testing purposes, e.g. the script runs
successfully, finds and returns the proper package.
The package can be found [here](https://github.com/marrinosnis/repository-package-name/packages/2046596)
