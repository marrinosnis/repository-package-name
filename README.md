# repository-package-name
<p align="center">
<img src="images/graphQL_logo.png" alt="image" width="200px" height="100">
<img src="images/shell_script_logo.jpeg" alt="image" width="200px" height="auto"> &nbsp; &nbsp;
</p>

![bash-script-tests](https://github.com/marrinosnis/repository-package-name/actions/workflows/run-tests.yaml/badge.svg)
## Use graphQL with Bash Script to find and store the Package name of a repository

### References
This script is used to retrieve the package name from a specific repository, using the GitHub's GraphQL API. More info about GitHub's graphQL 
in this link: [GraphQL API Documentation](https://docs.github.com/en/graphql). Also, there is the GitHub Explorer where you write and test 
your GraphQL queries to the GitHub. More information can be found at the following link: [GraphQL Explorer](https://docs.github.com/en/graphql/overview/explorer).

### Set up - first steps - execution of the script
1) Make sure the `shunit2` is installed in your machine. To check if it is already installed you can open a new terminal winodw and execute 
the following command:
```commandline
$ cat $(which shunit2) | grep "SHUNIT_VERSION"
```
If it is <ins>installed</ins> you will get the following message:
> command [ -n "${SHUNIT_VERSION:-}" ] && exit 0
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
> [!NOTE]  
> The tool `brew` is assumed that it is already installed in MacOS machine.

2) After that the `shunit2` tool is installed in your machine, it is very easy and simple to use the script and retrieve the name of the package
    from the repository. You can clone the repo or download the `zip` file and extract the content. Inside the folder `repository-package-name` there
    is the main shell script with the name `findRepoPackageName.sh`. Also, there are some other files like the `LICENSE`, `README.md` and the `tests` folder.

3) The script in order to work properly takes 3 arguments:\
 `pathToFolder`: which is the path to the project from the Github from which you want to retrieve the name of package.\
 `owner`: which is the owner of the repository. It could be an organisation or personal account.\
 `inputToken`: a properly configured token from Github which has at least the scope of `write:packages`, otherwise the API call will not work.\

 Below there is a board of the possible outcomes for using the `findRepoPackageName.sh`:

| **arguments**                          | **example**                                                                                                     | **outcome**                                                                                                          |
|----------------------------------------|-----------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------|
| *none*                                 | ./findRepoPackageName                                                                                           | You should provide the owner of the repo and the token with the correct access rights                                |
| pathToProject ownerName                | ./findRepoPackageName <ins>/Users/Desktop/testProject</ins> <ins>username</ins>                                 | You should provide also the token as the second argument                                                             |
| All arguments provided but not correct | ./findRepoPackageName <ins>/Users/Desktop/testProject</ins> <ins>username</ins>  <ins>876gfr432wqasd7</ins>     | The script will return an empty answer, as it couldn't find any packages with those credentials (the token is wrong) |
| All arguments are correct              | ./findRepoPackageName <ins>/Users/Desktop/testProject</ins> <ins>username</ins>  <ins>ghp_876gfr432wqasd7</ins> | The script will return the package name that it is in the repo that was provided from the path previously            | 
    
    

